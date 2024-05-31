#!/bin/bash

source $(dirname "$0")/common.sh

COMPOSE_FILE="../docker-compose.yml"

function start_services {
  echo -e "${INFO} ${YELLOW}Starting OpenVPN and SOCKS5 services...${NC}"
  docker-compose -f $COMPOSE_FILE up -d
  if [ $? -eq 0 ]; then
    echo -e "${CHECK_MARK} ${GREEN}Services started successfully.${NC}"
  else
    echo -e "${CROSS_MARK} ${RED}Failed to start services.${NC}"
    exit 1
  fi
}

function stop_services {
  echo -e "${INFO} ${YELLOW}Stopping OpenVPN and SOCKS5 services...${NC}"
  docker-compose -f $COMPOSE_FILE down
  if [ $? -eq 0 ]; then
    echo -e "${CHECK_MARK} ${GREEN}Services stopped successfully.${NC}"
  else
    echo -e "${CROSS_MARK} ${RED}Failed to stop services.${NC}"
    exit 1
  fi
}

case $1 in
  start)
    start_services
    ;;
  stop)
    stop_services
    ;;
  restart)
    stop_services
    start_services
    ;;
  *)
    echo -e "${INFO} ${YELLOW}Usage: $0 {start|stop|restart}${NC}"
    exit 1
    ;;
esac
