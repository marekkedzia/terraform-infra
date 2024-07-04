## AWS ECS Resources Description

### Resource: aws_ecs_cluster
- **name**: Sets the name of the ECS cluster.
    - **Value**: `var.cluster_name` dynamically sets the cluster name based on input variables.

### Resource: aws_cloudwatch_log_group
- **name**: Specifies the name of the CloudWatch log group.
    - **Value**: `"/ecs/fargate-${var.name_suffix}"` creates a log group with a name that includes a suffix to identify the group easily.

### Resource: aws_cloudwatch_log_stream
- **log_group_name**: Connects the log stream to an existing log group.
    - **Value**: `aws_cloudwatch_log_group.logs.name` links the stream to the log group created above.
- **name**: Names the log stream, which holds the logs for the ECS tasks.
    - **Value**: `"ecs/fargate-${var.name_suffix}"` uses the same suffix to match the log group.

### Resource: aws_ecs_task_definition
- **family**: Names the family of tasks that share the same task definition.
    - **Value**: `"ecs-task-${var.name_suffix}"`
- **network_mode**: Network mode configuration for the tasks.
    - **Value**: `"awsvpc"` to ensure that each task gets its own network interface.
- **execution_role_arn** and **task_role_arn**: Specify the AWS IAM roles used by the ECS tasks.
    - **Value**: `var.ecs_instance_role_arn` and `var.ecs_iam_task_role`
- **cpu** and **memory**: Resource allocation for the tasks.
    - **Value**: `var.ecs_resources_config.cpu` and `var.ecs_resources_config.memory`
- **requires_compatibilities**: The launch type required by the tasks.
    - **Value**: `["FARGATE"]` to use AWS Fargate for managing the underlying server infrastructure.
- **runtime_platform**: Specifies the operating system and CPU architecture for the task.
    - **Value**: OS set to `"LINUX"` and CPU to `"X86_64"`.
- **container_definitions**: Defines the containers that form the task.
    - Includes settings such as container image, resource allocation, essential status, environment variables, port mappings, and log configuration.

### Resource: aws_ecs_service
- **name**: Sets the name of the ECS service.
    - **Value**: `"ecs-service-${var.name_suffix}"`
- **cluster**: Links the service to the specified ECS cluster.
    - **Value**: `aws_ecs_cluster.ecs_cluster.id`
- **task_definition**: Specifies the task definition to use with this service.
    - **Value**: `aws_ecs_task_definition.ecs_task_definition.arn`
- **desired_count**: The number of instantiations of the task to run.
    - **Value**: `var.capacity.desired`
- **launch_type**: Specifies the launch type for the service.
    - **Value**: `"FARGATE"`
- **network_configuration**: Configures the networking for the ECS tasks.
    - Subnet IDs and security group IDs are specified here, along with a setting for assigning public IPs.
- **force_new_deployment**: Forces a new deployment of the service.
    - **Value**: `true`
- **load_balancer**: Configures the service to use a load balancer.
    - Settings include the target group ARN, container name, and container port.
