resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

tags = {
  Name = "tp-${var.env}-net-${lookup(var.vpc_region_shortname, var.vpc_region)}-igw"
  }
}


