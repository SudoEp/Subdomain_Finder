#!/bin/bash

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check domain input
if [ -z "$1" ]; then
  echo -e "${RED}[!] Usage: $0 <domain>${NC}"
  exit 1
fi

DOMAIN="$1"
OUTPUT_FILE="subdomains_$DOMAIN.txt"

# Progress tracking
progress() {
  echo -e "${BLUE}[$(date +'%H:%M:%S')] ${GREEN}➜${NC} $1"
}

# Error handling
fail() {
  echo -e "${RED}[!] Error: $1${NC}"
  exit 1
}

# Validate required tools
check_tool() {
  if ! command -v "$1" &> /dev/null; then
    fail "$1 not installed"
  fi
}

progress "Checking dependencies..."
check_tool subfinder
check_tool assetfinder

# Temporary file
TEMP_FILE=$(mktemp) || fail "Failed to create temp file"

progress "Starting subdomain discovery for ${YELLOW}$DOMAIN${NC}"

# Run subdomain tools sequentially
progress "Running ${YELLOW}Subfinder${NC}..."
subfinder -d "$DOMAIN" -silent > "$TEMP_FILE" 2>/dev/null || fail "Subfinder failed"

progress "Running ${YELLOW}Assetfinder${NC}..."
assetfinder --subs-only "$DOMAIN" >> "$TEMP_FILE" 2>/dev/null || fail "Assetfinder failed"

# Process results
progress "Processing results..."
sort -u "$TEMP_FILE" | grep -v "^\*" > "$OUTPUT_FILE"
total_subs=$(wc -l < "$OUTPUT_FILE")

if [ "$total_subs" -eq 0 ]; then
  fail "No subdomains found"
fi

# Cleanup
rm -f "$TEMP_FILE"

echo -e "\n${GREEN}[+] Found ${YELLOW}$total_subs${GREEN} subdomains:${NC} $OUTPUT_FILE"