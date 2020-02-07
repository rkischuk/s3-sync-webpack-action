# GitHub Action to run Webpack and Sync S3 Bucket

This is a customized version of the s3-sync-action that uses the [vanilla AWS CLI](https://docs.aws.amazon.com/cli/index.html) to sync a directory (either from your repository or generated during your workflow) with a remote S3 bucket.  It also runs the command: npx webpack --mode development to build the main.js file for deployment.

## Usage

### `main.yml` Example

Place in a `.yml` file such as this one in your `.github/workflows` folder. [Refer to the documentation on workflow YAML syntax here.](https://help.github.com/en/articles/workflow-syntax-for-github-actions)

```yaml
name: CI
on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: turnerlabs/s3-sync-webpack-action@master
      env:
        SOURCE_DIR: ${{ github.workspace }}
        DIST_DIR: ${{ github.workspace }}/dist/
        AWS_DEFAULT_REGION: 'us-east-1'
        AWS_S3_BUCKET: ${{ secrets.AWS_S3_BUCKET }}
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```