#!/bin/sh

usage() {
    echo "Usage: $0 [-s <subscription_id>] [-l <location>] [-g <resource_group_name>] [-a <app_name>] [-e <environment>]"
    exit 1
}

while getopts ":s:l:g:a:e:" opt; do
    case ${opt} in
        s)
            subscription_id=$OPTARG
            ;;
        l)
            location=$OPTARG
            ;;
        g)
            resource_group_name=$OPTARG
            ;;
        a)
            app_name=$OPTARG
            ;;
        e)
            environment=$OPTARG
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND -1))

az login

if [ -z "${subscription_id}" ]
then
    echo "Listing Azure subscriptions:"
    az account list --query "[].{name:name, id:id}"
    read -p "Enter Subscription ID: " subscription_id
fi

az account set --subscription $subscription_id

if [ -z "${location}" ]
then
    read -p "Enter Location (default: West US 2): " location
    location=${location:-'West US 2'}
fi

if [ -z "${resource_group_name}" ]
then
    read -p "Enter Resource Group Name (default: MyResourceGroup): " resource_group_name
    resource_group_name=${resource_group_name:-'MyResourceGroup'}
fi

if [ -z "${app_name}" ]
then
    read -p "Enter App Name (default: MyAppName): " app_name
    app_name=${app_name:-'MyAppName'}
fi

if [ -z "${environment}" ]
then
    read -p "Enter Environment (default: dev): " environment
    environment=${environment:-'dev'}
fi

az deployment sub create --location $location --template-file infra/main.bicep --parameters resourceGroupName=$resource_group_name appName=$app_name environment=$environment
