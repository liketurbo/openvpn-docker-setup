#!/bin/bash

source $(dirname "$0")/common.sh

echo -e "${INFO} ${YELLOW}Welcome to the OpenVPN setup script.${NC}"

# Create the Docker volume for OpenVPN
echo -e "${INFO} ${YELLOW}Creating Docker volume: $OVPN_DATA...${NC}"
docker volume create --name $OVPN_DATA
if [ $? -eq 0 ]; then
  echo -e "${CHECK_MARK} ${GREEN}Docker volume $OVPN_DATA created successfully.${NC}"
else
  echo -e "${CROSS_MARK} ${RED}Failed to create Docker volume $OVPN_DATA.${NC}"
  exit 1
fi

# Generate the OpenVPN server configuration
echo -e "${INFO} ${YELLOW}Generating OpenVPN server configuration...${NC}"
docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://$SERVERNAME
if [ $? -eq 0 ]; then
  echo -e "${CHECK_MARK} ${GREEN}OpenVPN server configuration generated successfully.${NC}"
else
  echo -e "${CROSS_MARK} ${RED}Failed to generate OpenVPN server configuration.${NC}"
  exit 1
fi

# Initialize the OpenVPN Public Key Infrastructure (PKI)
echo -e "${INFO} ${YELLOW}Initializing the PKI. You will be prompted to enter a passphrase.${NC}"
docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki
if [ $? -eq 0 ]; then
  echo -e "${CHECK_MARK} ${GREEN}PKI initialized successfully.${NC}"
else
  echo -e "${CROSS_MARK} ${RED}Failed to initialize the PKI.${NC}"
  exit 1
fi

echo -e "${CHECK_MARK} ${GREEN}OpenVPN setup is complete. You can now generate client configurations and start the OpenVPN server.${NC}"
