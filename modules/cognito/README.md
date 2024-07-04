## Resource: aws_cognito_user_pool
### name
- **Description**: Sets the name for the user pool.
- **Value**: Uses `var.pool_name` to dynamically set the name based on input variable.

### mfa_configuration
- **Description**: Configures Multi-Factor Authentication (MFA) settings for the user pool.
- **Value**: 'OFF' indicates that MFA is disabled for this user pool.

### password_policy
- **Description**: Defines the policy rules for user passwords in the user pool.
    - **minimum_length**: Specifies the minimum number of characters that the password must contain.
        - **Value**: Uses `var.password_length` to set this value dynamically.
    - **temporary_password_validity_days**: Sets how many days a temporary password remains valid.
        - **Value**: Set to 3 days, meaning temporary passwords expire after this duration.

### schema
- **Description**: Describes an attribute schema for the user pool.
    - **name**: The name of the attribute.
        - **Value**: 'userId' defines an attribute named userId.
    - **attribute_data_type**: Specifies the data type of the attribute.
        - **Value**: 'String' indicates that the attribute is of string type.
    - **mutable**: Determines if the attribute's value can be modified.
        - **Value**: `false` means the attribute value cannot be changed once set.
    - **required**: Indicates if the attribute is required for user registration.
        - **Value**: `false` shows that this attribute is optional.
    - **string_attribute_constraints**: Constraints for the string type attribute.
        - **min_length**: Minimum length of the attribute value.
            - **Value**: 1 character.
        - **max_length**: Maximum length of the attribute value.
            - **Value**: 256 characters.

## Resource: aws_cognito_user_pool_client
### name
- **Description**: Sets the name of the user pool client.
- **Value**: Uses `var.pool_client_name` to dynamically set the client name.

### user_pool_id
- **Description**: Associates the client with a specific user pool.
- **Value**: `aws_cognito_user_pool.pool.id` links this client to the previously defined user pool.

