# OpenVPN Docker Setup

This repository provides scripts to automate the setup and management of an OpenVPN server and SOCKS5 proxy using Docker.

## Prerequisites

Ensure you have Docker installed on your machine. You can download the relevant installer from [here](https://www.docker.com/get-started/).

## Getting Started

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/liketurbo/openvpn-docker-setup.git
   ```

2. Navigate to the project directory:

   ```bash
   cd openvpn-docker-setup
   ```

3. Create a `.env` file and configure your environment variables. You can use the provided `.env.example` as a template. Fill in the variables with appropriate values:

   ```bash
   cp .env.example .env
   ```

   Example with filled variables:

   ```bash
   OVPN_DATA=ovpn-data-example
   OVPN_CLIENTS_DIR=client-certs
   OVPN_SERVER_NAME=10.10.10.10
   SOCKS5_USER=your_user
   SOCKS5_PASSWORD=your_pass
   ```

4. Run the setup script to initialize OpenVPN:

   ```bash
   ./scripts/setup_openvpn.sh
   ```

5. Generate client configurations:

   ```bash
   ./scripts/generate_client.sh
   ```

6. Start the OpenVPN and SOCKS5 services:

   ```bash
   ./scripts/manage_services.sh start
   ```

## Usage

- **Setup OpenVPN**: Run `./scripts/setup_openvpn.sh` to create the OpenVPN server configuration and initialize the PKI.

- **Generate Client Configurations**: Run `./scripts/generate_client.sh` to generate client certificates and retrieve client configuration files.

- **Manage Services**: Run `./scripts/manage_services.sh start` to start the OpenVPN and SOCKS5 services. Use `./scripts/manage_services.sh stop` to stop them, and `./scripts/manage_services.sh restart` to restart them.
