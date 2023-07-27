targetScope = 'subscription'

param location string = 'westus2'
param resourceGroupName string
param appName string
param environment string = 'dev'

// Create a Resource Group
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

// Create App Service resources
module appServices './resources.bicep' = {
  name: '${appName}-${environment}-services'
  scope: rg
  params: {
    appName: appName
    environment: environment
    location: location
  }
}
