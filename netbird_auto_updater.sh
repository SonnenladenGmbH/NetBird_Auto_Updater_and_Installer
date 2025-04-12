#!/bin/bash
# NetBird Auto Installer & Updater Script
# This script installs or updates NetBird on a Debian-based system using the latest GitHub release.
# It handles architecture detection, dependency installation, and package downloading.
# All settings are preserved — no peer re-authentication is needed.

set -e  # Exit immediately if a command exits with a non-zero status

# GitHub API endpoint for NetBird releases
GITHUB_API="https://api.github.com/repos/netbirdio/netbird/releases"

# Helper function to catch errors and exit with a message
function check_error() {
  if [ $? -ne 0 ]; then
    echo "$1"
    exit 1
  fi
}

# Install required packages
function install_pkgs() {
  apt update && apt install -y jq curl wget
}

# Detect system architecture (amd64 or arm64)
function get_arch() {
  arch=$(uname -m)
  if [ "$arch" == "x86_64" ]; then
    echo "amd64"
  elif [ "$arch" == "aarch64" ]; then
    echo "arm64"
  else
    echo "null"
  fi
}

# Download and install the latest NetBird release for the detected architecture
function install() {
  arch=$(get_arch)
  echo "Detected architecture: ${arch}"

  # Fetch the latest release data from GitHub
  release_data=$(curl -s "${GITHUB_API}")

  # Extract the download URL for the .deb package matching the architecture
  download_url=$(echo "$release_data" | jq -r --arg arch "$arch" '
    .[0].assets[] |
    select(.name | test("netbird_.*_linux_" + $arch + "\\.deb$")) |
    .browser_download_url
  ')

  if [ -z "$download_url" ]; then
    echo "Download URL not found."
    exit 1
  else
    echo "Downloading .deb package from: ${download_url}"
    wget -O netbird.deb "${download_url}"
    dpkg -i netbird.deb || apt-get install -f -y
    rm -f netbird.deb
  fi
}
# Main execution flow
function main() {
  install_pkgs
  install
}

# Start the script
main
