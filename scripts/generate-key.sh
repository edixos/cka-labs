#!/bin/bash

set -euo pipefail

KEY_NAME="lab3_key"
KEY_PATH="$HOME/.ssh/$KEY_NAME"

# Check if the key already exists
if [[ -f "${KEY_PATH}" || -f "${KEY_PATH}.pub" ]]; then
  echo "❌ SSH key pair already exists at ${KEY_PATH}. Aborting to avoid overwriting."
  exit 1
fi

# Generate the SSH key (ED25519 is modern and secure)
ssh-keygen -t ed25519 -C "trainee-lab3" -f "$KEY_PATH" -N ""

# Display the public key
echo -e "\n✅ SSH key pair generated successfully!"
echo "🔐 Public key (share this with your instructor):"
echo "--------------------------------------------------"
cat "${KEY_PATH}.pub"
echo "--------------------------------------------------"