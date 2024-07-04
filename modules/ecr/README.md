## Resource: aws_ecr_repository
### name
- **Description**: Specifies the name of the Elastic Container Registry (ECR) repository.
- **Value**: Set dynamically using `var.repository_name`, which allows for naming flexibility based on input variables.

### image_tag_mutability
- **Description**: Determines whether images within the repository can have their tags mutated after initial tagging.
- **Value**: Configured through `var.image_tag_mutability`. This can be set to either `MUTABLE` or `IMMUTABLE` based on requirements, controlling if image tags can be overwritten.

### image_scanning_configuration
- **Description**: Configures the scanning of images on push to the repository.
    - **scan_on_push**: When set to true, enables the scanning of images for vulnerabilities as soon as they are pushed to the repository.
        - **Value**: True, which ensures that all pushed images are automatically scanned, enhancing security by identifying potential vulnerabilities early in the deployment process.
