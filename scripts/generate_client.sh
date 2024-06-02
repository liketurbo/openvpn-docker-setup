#!/bin/bash

source ./scripts/common.sh

echo -e "${INFO} ${YELLOW}Welcome to the OpenVPN client configuration script.${NC}"

read -p "Please enter a name for the client (e.g., client1): " CLIENTNAME

if [ -z "$CLIENTNAME" ]; then
  echo -e "${INFO} ${YELLOW}No client name provided. Using default: client1${NC}"
  CLIENTNAME="client1"
fi

mkdir -p $OVPN_CLIENTS_DIR

echo -e "${INFO} ${YELLOW}Generating client certificate for $CLIENTNAME...${NC}"
docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full $CLIENTNAME nopass
if [ $? -eq 0 ]; then
  echo -e "${CHECK_MARK} ${GREEN}Client certificate for $CLIENTNAME generated successfully.${NC}"
else
  echo -e "${CROSS_MARK} ${RED}Failed to generate client certificate for $CLIENTNAME.${NC}"
  exit 1
fi

# Retrieve the client configuration
echo -e "${INFO} ${YELLOW}Retrieving the client configuration for $CLIENTNAME...${NC}"
docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient $CLIENTNAME > $OVPN_CLIENTS_DIR/$CLIENTNAME.ovpn
if [ $? -eq 0 ]; then
  echo -e "${CHECK_MARK} ${GREEN}Client configuration file for $CLIENTNAME has been saved as $OVPN_CLIENTS_DIR/$CLIENTNAME.ovpn.${NC}"
else
  echo -e "${CROSS_MARK} ${RED}Failed to retrieve client configuration for $CLIENTNAME.${NC}"
  exit 1
fi
