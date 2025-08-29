resource "aws_elasticache_subnet_group" "pafw_redis" {
  count      = var.deploy_pan ? 1 : 0
  name       = "pafw-redis-subnet-group"
  subnet_ids = [aws_subnet.appliance_subnet_az_0.id, aws_subnet.appliance_subnet_az_1.id]
  tags       = merge(local.tags, { Name = "${local.name}-redis-subnet-group" })
}

resource "aws_security_group" "pafw_redis_sg" {
  count       = var.deploy_pan ? 1 : 0
  name        = "pafw-redis-sg"
  description = "Redis access from PAN"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = var.redis_port
    to_port     = var.redis_port
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, { Name = "${local.name}-redis-sg" })
}

resource "aws_elasticache_replication_group" "pafw_redis" {
  count                         = var.deploy_pan ? 1 : 0
  replication_group_id          = "pafw-redis-rg"
  description                   = "Redis for PAN"
  engine                        = "redis"
  engine_version                = "7.1"
  node_type                     = "cache.t3.micro"
  num_node_groups               = 1
  replicas_per_node_group       = 1
  automatic_failover_enabled    = true
  at_rest_encryption_enabled    = true
  transit_encryption_enabled    = true
  auth_token                    = var.redis_auth_token != "" ? var.redis_auth_token : null
  port                          = var.redis_port
  subnet_group_name             = aws_elasticache_subnet_group.pafw_redis[0].name
  security_group_ids            = [aws_security_group.pafw_redis_sg[0].id]
  apply_immediately             = true
  tags                          = merge(local.tags, { Name = "${local.name}-redis" })
}
