## AWS IAM Resources Description

### Data Source: aws_iam_policy_document
- **Description**: Generates an IAM policy document that specifies permissions.
- **Dynamic Statement**:
    - **for_each**: Iterates over a list of statements provided by `var.statements`.
    - **actions**: Specifies the actions that the policy allows or denies.
        - **Value**: `statement.value.actions` fetches actions from each statement in the variable.
    - **resources**: Defines which resources the actions apply to.
        - **Value**: `statement.value.resources` fetches resources from each statement in the variable.

### Resource: aws_iam_role
- **name**: Specifies the name of the IAM role.
    - **Value**: `var.role_name` sets the role's name dynamically based on input.
- **assume_role_policy**: Defines the policy that allows an entity to assume the role.
    - **JSON Configuration**:
        - **Version**: Indicates the policy language version, set to "2012-10-17".
        - **Statement**: Contains one or more policy statements.
            - **Action**: `"sts:AssumeRole"` permits actions that allow entities to assume the role.
            - **Principal**: Specifies AWS service principals that can assume this role, configured via `${var.service}`.
            - **Effect**: `"Allow"` grants permissions in the statement.
            - **Sid**: An optional identifier; left empty in this configuration.

### Resource: aws_iam_role_policy
- **name**: Sets the name of the IAM role policy.
    - **Value**: `"${var.role_name}_policy"` constructs the policy name by appending `_policy` to the role name.
- **policy**: The IAM policy document that defines permissions for the role.
    - **Value**: `data.aws_iam_policy_document.policy_document.json` references the generated JSON policy document.
- **role**: Associates the policy with a specific IAM role.
    - **Value**: `aws_iam_role.role.id` links the policy to the IAM role created above.
