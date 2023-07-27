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
  kind: 'app,linux'
  properties: {
    serverFarmId: plan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|7.0'
      appSettings: [
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
        {
          name: 'ALLOWED_ORIGINS'
          value: 'https://${webApp.properties.defaultHostName}'
        }
      ]
    }
  }
}

// Create a Web App for the front-end
resource webApp 'Microsoft.Web/sites@2021-01-01' = {
  name: '${appName}-${environment}-web'
  location: location
  kind: 'app,linux'
  properties: {
    serverFarmId: plan.id
    siteConfig: {
      linuxFxVersion: 'NODE|18-lts'
      appCommandLine: 'npm install -g serve && serve'
      appSettings: [
        {
          name: 'SCM_DO_BUILD_DURING_DEPLOYMENT'
          value: 'false'
        }
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
      ]
    }
  }
}
