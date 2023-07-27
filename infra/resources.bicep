param appName string
param environment string
param location string

// Create an App Service Plan
resource plan 'Microsoft.Web/serverfarms@2021-01-01' = {
  name: '${appName}-${environment}-plan'
  location: location
  properties: {
    reserved: true // This indicates a Linux app service plan.
  }
  sku: {
    tier: 'Basic'
    name: 'B1'
  }
}

// Create a Web App for the API
resource apiApp 'Microsoft.Web/sites@2021-01-01' = {
  name: '${appName}-${environment}-api'
  location: location
  properties: {
    serverFarmId: plan.id
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
      ]
    }
  }
}

// Create a Web App for the front-end
resource webApp 'Microsoft.Web/sites@2021-01-01' = {
  name: '${appName}-${environment}-web'
  location: location
  properties: {
    serverFarmId: plan.id
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
      ]
    }
  }
}
