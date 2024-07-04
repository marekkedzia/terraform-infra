# AWS ECS ALB Module

## Overview
This Terraform module provisions an Application Load Balancer (ALB) designed specifically for Amazon ECS services, facilitating efficient load balancing of incoming traffic across ECS containers. The module includes configurations for ALB, listeners, and target groups that are optimized for container-based applications.

## Resources

### aws_lb ecs_alb
- **Name**: Generates a unique name using a dynamic suffix, ensuring that multiple instances of this resource can coexist without naming conflicts.
- **Internal**: Configured as `false`, this setting indicates the ALB is internet-facing, allowing it to receive traffic from the internet, which is essential for web-facing applications.
- **Load Balancer Type**: Set as 'application', this type is optimized for HTTP and HTTPS traffic, supporting advanced routing capabilities, which is crucial for complex application architectures.
- **Security Groups**: Integrates with specified security group IDs provided via `var.security_groups_ids`, ensuring the ALB adheres to the organization's security protocols by controlling access based on IP, port, and protocol.
- **Subnets**: Deployed across the provided subnet IDs `var.subnets_ids`, which allows the ALB to span multiple Availability Zones, enhancing availability and fault tolerance.
- **Tags**: Includes tagging with a key of `Name` and a value of 'ecs-alb', helping with resource identification and cost allocation in AWS billing.

### aws_lb_listener ecs_alb_listener
- **Description**: Establishes a listener on the ALB to check for incoming connections. Listeners check for requests on the specified protocol and port and then route the traffic according to the defined rules.
- **Load Balancer ARN**: Utilizes the ARN from `aws_lb.ecs_alb`, ensuring the listener is associated with the correct ALB.
- **Port and Protocol**: Listener settings are dynamically set to listen on the port and protocol defined in `var.lb_config["port"]` and `var.lb_config["protocol"]`, which can be customized to meet different application needs.
- **Default Action**: Configures the default action for the listener to forward traffic to a specific target group ARN, which is critical for directing traffic to the appropriate container group based on the load balancer rules.

### aws_lb_target_group ecs_tg
- **Description**: Manages a target group for routing requests to one or more registered targets, such as ECS tasks, ensuring efficient traffic distribution.
- **Name**: 'ecsTargetGroup' clearly identifies the group of targets related to ECS tasks, facilitating easier management and diagnostics.
- **Port and Protocol**: The target group listens on the port and protocol specified in `var.tg_config["port"]` and `var.tg_config["protocol"]`, designed to match the service requirements.
- **Target Type**: Configured as 'ip', which uses the IP addresses of the tasks directly rather than instance-based targeting, offering more flexibility and reliability in dynamic environments like ECS.
- **VPC ID**: Ensures the target group is associated with the correct VPC, provided via `var.vpc_id`, to maintain network isolation and security.
- **Health Check**: Critical for maintaining service availability, it monitors the health of the ECS tasks using paths and ports specified in `var.health_check_config`, automatically rerouting traffic away from unhealthy tasks.

