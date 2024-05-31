#!/bin/bash

# Load environment variables
source ../.env

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Emojis
CHECK_MARK="\xE2\x9C\x94"
CROSS_MARK="\xE2\x9D\x8C"
INFO="\xE2\x84\xB9"

# Check if all required environment variables are set
function check_env_variables {
  local missing=0

  while IFS= read -r line; do
    local var_name=$(echo "$line" | cut -d'=' -f1)
    local var_value="${!var_name}"

    if [[ -z "$var_value" ]]; then
      echo -e "${CROSS_MARK} ${RED}Error: $var_name is not set.${NC}"
      missing=1
    fi
  done < ../env.example

  if [ $missing -eq 1 ]; then
    echo -e "${INFO} ${YELLOW}Please make sure to set all required environment variables in the .env file.${NC}"
    exit 1
  fi

  echo -e "${CHECK_MARK} ${GREEN}All required environment variables are set.${NC}"
}

check_env_variables