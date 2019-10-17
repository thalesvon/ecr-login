# ECR login docker action

[![Actions Status](https://github.com/thalesvon/ecr-login/workflows/Test/badge.svg)](https://github.com/thalesvon/ecr-login/actions)

This action gets a login string to AWS ECR and returns as an output of the action.

This action is only intended to be used for the command `aws ecr get-login`. For other awscli commands, use [actions/aws/cli][1]

## Inputs

There are no inputs defined on `actions.yml`. Everything you write on `args:` is passed to the entrypoint.
It is mandatory to pass `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.
Configure both as [secrets][2]

## Outputs

### `login-string`

Docker Login string. 
It looks like this: 

```
docker login -u AWS -p <pass> <ecr-url>
```

## Example usage
```yaml
    - name: 'Get Login to AWS ECR'
      id: ecr-login
      uses: thalesvon/ecr-login@master
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_DEFAULT_OUTPUT: json
        AWS_REGION: us-east-1
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      with:
        args: 'get-login --no-include-email --region ${AWS_REGION}'
    - name: 'Docker Login'
      run: ${{ steps. ecr-login.outputs.login-string }}
```
[1]:https://github.com/actions/aws
[2]:https://help.github.com/en/articles/virtual-environments-for-github-actions#creating-and-using-secrets-encrypted-variables