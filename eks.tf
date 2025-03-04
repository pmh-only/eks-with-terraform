module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "project-cluster"
  cluster_version = "1.30"

  cluster_endpoint_public_access  = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  eks_managed_node_groups = {
    project-mng-addon = {
      ami_type       = "BOTTLEROCKET_ARM_64"
      instance_types = ["c6g.large"]

      min_size     = 3
      max_size     = 27
      desired_size = 3
      taints = [{
        key = "dedicated"
        value = "addon"
        effect = "NO_SCHEDULE"
      }]
    }
  }

  enable_cluster_creator_admin_permissions = true

  access_entries = {
    # One access entry with a policy associated
    example = {
      kubernetes_groups = []
      principal_arn = aws_iam_role.bastion.arn

      policy_associations = {
        example = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            namespaces = []
            type       = "cluster"
          }
        }
      }
    }
  }

  tags = {
    project="app"
  }
}
