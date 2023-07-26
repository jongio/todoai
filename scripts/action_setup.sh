#!/bin/sh

while getopts g:a:w:s: flag
do
    case "${flag}" in
        g) resourceGroup=${OPTARG};;
        a) apiAppName=${OPTARG};;
        w) webAppName=${OPTARG};;
        s) subscription=${OPTARG};;
    esac
done

# Prompt user for Azure login
az login

# Prompt user for GitHub login
gh auth login

# Set Azure subscription
az account set --subscription "$subscription"

# Get API App publish profile
apiPublishProfile=$(az webapp deployment list-publishing-profiles --name $apiAppName --resource-group $resourceGroup --xml --output tsv)

# Write API App publish profile to file
mkdir -p .publish
echo $apiPublishProfile > .publish/api_publish_profile.PublishSettings

# Set API App publish profile as GitHub secret
gh secret set AZURE_WEBAPP_PUBLISH_PROFILE_API -b"$(cat .publish/api_publish_profile.PublishSettings)"

# Set API App name as GitHub variable
gh variable set AZURE_WEBAPP_NAME_API --body "$apiAppName"

# Get Web App publish profile
webPublishProfile=$(az webapp deployment list-publishing-profiles --name $webAppName --resource-group $resourceGroup --xml --output tsv)

# Write Web App publish profile to file
echo $webPublishProfile > .publish/web_publish_profile.PublishSettings

# Set Web App publish profile as GitHub secret
gh secret set AZURE_WEBAPP_PUBLISH_PROFILE_WEB -b"$(cat .publish/web_publish_profile.PublishSettings)"

# Set Web App name as GitHub variable
gh variable set AZURE_WEBAPP_NAME_WEB --body "$webAppName"
