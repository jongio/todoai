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

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

Happy Coding!