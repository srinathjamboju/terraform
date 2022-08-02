eks_cluster_node_groups_defaults = {
  ami_release_version = "1.21.5-20211117"
  capacity_type       = "ON_DEMAND"
  desired_size        = 0
  disk_size           = 300
  min_size            = 0
  block_device_mappings = {
    xvda = {
      device_name = "/dev/xvda"
      ebs = {
        delete_on_termination = true
        encrypted             = false
        volume_size           = 300
        volume_type           = "gp2"
      }
    }
  }
}

eks_cluster_node_groups = {
  management = {
    instance_types   = ["m5.2xlarge", "m5.4xlarge", "m5a.2xlarge", "m4.2xlarge"]
    max_capacity     = 6
    labels = {
      "node.workload.type" = "management"
    }
  }
  compute-small = {
    max_capacity   = 3
    instance_types = ["t3.2xlarge", "t3a.2xlarge", "t3.xlarge", "t2.2xlarge"]
    labels = {
      "node.workload.capacity" = "small"
      "node.workload.type"     = "compute"
    }
  }
  persist-small = {
    max_capacity   = 10
    instance_types = ["t3.2xlarge", "t3a.2xlarge", "t3.xlarge", "t2.2xlarge"]
    labels = {
      "node.workload.capacity" = "small"
      "node.workload.type"     = "persist"
    }
  }
  compute-medium = {
    max_capacity   = 14
    instance_types = ["r5.4xlarge", "r5a.4xlarge", "r5.2xlarge", "r4.4xlarge"]
    labels = {
      "node.workload.capacity" = "medium"
      "node.workload.type"     = "compute"
    }
  }
  persist-medium = {
    max_capacity   = 12
    instance_types = ["r5.4xlarge", "r5a.4xlarge", "r5.2xlarge", "r4.4xlarge"]
    labels = {
      "node.workload.capacity" = "medium"
      "node.workload.type"     = "persist"
    }
  }
  cog-compute-medium = {
    instance_types = ["m5.4xlarge", "m5a.4xlarge", "m5.2xlarge", "m4.4xlarge"]
    max_capacity   = 8
    labels = {
      "node.workload.capacity" = "medium"
      "node.workload.type"     = "cognition-compute"
    }
  }
  cog-persist-medium = {
    instance_types = ["m5.4xlarge", "m5a.4xlarge", "m5.2xlarge", "m4.4xlarge"]
    max_capacity   = 5
    labels = {
      "node.workload.capacity" = "medium"
      "node.workload.type"     = "cognition-persist"
    }
  }
  gpu-small = {
    max_size       = 10
    ami_type       = "AL2_x86_64_GPU"
    instance_types = ["g4dn.2xlarge", "g4ad.2xlarge", "g4dn.xlarge", "g4ad.xlarge"]
    labels = {
      "node.workload.capacity" = "small"
      "node.workload.type"     = "gpu"
    }
  }
}

cognition_buckets = {
  archive   = "sre-test-infra-aws-poc-internal-archive"
}
