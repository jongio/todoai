# TodoAI

TodoAI is a simple, yet effective project for managing to-do tasks. It leverages the power of .NET 7 and React to provide a seamless user experience. The API is built with .NET 7, while the frontend is built with React. Together, they work to make task management easy and efficient.

## Project Structure

The project is structured as follows:

```
TodoAI/
├── .devcontainer
│   └── devcontainer.json
├── src
│   ├── api
│   │   ├── Program.cs
│   │   └── TodoStore.cs
│   └── web
│       ├── package.json
│       ├── src
│       └── public
└── README.md
```

## Getting Started with DevContainer

VS Code's DevContainers feature is used for setting up the development environment for this project. Follow the steps below to get the project up and running in a DevContainer.

1. Install [Visual Studio Code](https://code.visualstudio.com/).
2. Install [Docker Desktop](https://www.docker.com/products/docker-desktop).
3. Inside Visual Studio Code, install the [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension.
4. Clone this repository to your local machine.
5. Open the cloned repository folder in VS Code.
6. When prompted to "Reopen in Container", click the "Reopen in Container" button. This will start the process of building your dev container. This process can take a few minutes to complete. If you were not prompted, use the Command Palette (F1) and run "Remote-Containers: Reopen Folder in Container".

The devcontainer.json file in the .devcontainer folder configures the settings for our DevContainer environment. It specifies the Dockerfile for the project and any extensions that should be installed.

## Running the Application

After you have successfully opened the project in a DevContainer, you can start both the API and the web frontend.

### Start the API
To start the API, open a terminal in VS Code (which will default to the context of the DevContainer) and run the following command:

```bash
dotnet watch run --project src/api
```

This will start the API on port 5000/5001 and it will automatically reload if you make changes to the API source code.

### Start the Web Frontend

Open a **new** terminal in VS Code (still in the DevContainer context) and run the following commands to navigate to the web project folder and start the React application:

```bash
cd src/web
npm install
npm start
```

This will start the React app on port 3000. It should automatically open in your default web browser, but if it doesn't, you can manually navigate to `http://localhost:3000`. The app will also automatically reload if you make changes to the source code.

### Provisioning Azure Resources

To provision Azure resources required for this project, run the provision.sh script located in the /scripts folder. You can specify named parameters or the script will prompt you for these values:

1. `-l` or `--location`: The Azure region where resources will be deployed (default: West US 2)
2. `-g` or `--resource-group`: The name of the Azure resource group (default: MyResourceGroup)
3. `-a` or `--app-name`: The base name for the web apps that will be created (default: MyAppName)
4. `-e` or `--environment`: The environment for the web apps (default: dev)
5. `-s` or `--subscription-id`: The subscription id where the resources will be deployed.

Before running the script, make sure you are logged into Azure. The script will run `az login` to initiate the login process if you are not already logged in. It will also list the available subscriptions and prompt for a subscription ID if it was not provided as a parameter.

The command can be executed from the root of the project as follows:

```bash
./scripts/provision.sh -l <location> -g <resource-group-name> -a <app-name> -e <environment> -s <subscription-id>
```

If you want to know more details about how to use the script, you can use the `-h` or `--help` option:

```bash
./scripts/provision.sh --help
```

## Setting Up GitHub Actions

To set up GitHub Actions for deploying your application to Azure, you need to retrieve the publish profile from your Azure resources and set them up as GitHub Secrets and Variables. These will be used in your GitHub Actions workflow to securely deploy your application. 

Follow these steps:

1. **Run the `action_setup.sh` script.** This script retrieves the publish profiles from Azure, stores them in your local `.publish` directory, and creates GitHub Secrets and Variables for them. You can call the script with the `-s`, `-g`, `-a`, and `-w` parameters to specify your subscription ID, resource group name, API app name, and web app name, respectively:

    ```bash
    ./scripts/action_setup.sh -s <subscription_id> -g <resource_group_name> -a <api_app_name> -w <web_app_name>
    ```

    Replace `<subscription_id>`, `<resource_group_name>`, `<api_app_name>`, and `<web_app_name>` with your actual values. If you do not provide these parameters, the script will prompt you for them.

2. **Push your changes to your GitHub repository.** Once you've successfully run the `action_setup.sh` script and set up your secrets and variables, push your changes to your GitHub repository:

    ```bash
    git add .
    git commit -m "Set up GitHub Actions"
    git push
    ```

3. **Trigger the GitHub Actions workflow.** With the secrets and variables in place, the GitHub Actions workflow can now successfully deploy your application. The workflow is set to run automatically when you push to the main branch. If you want to manually trigger the workflow, you can do so in the "Actions" tab of your GitHub repository.

And that's it! Your application is now set up to automatically deploy through GitHub Actions.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

Happy Coding!