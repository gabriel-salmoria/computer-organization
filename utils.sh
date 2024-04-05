#!/bin/bash

# Function to add an alias to the appropriate config file
add_alias() {
  local alias_name="$1"
  local alias_command="$2"

  # Check if we're using Zsh
  if [[ -n $ZSH_VERSION ]]; then 
    echo "alias $alias_name='$alias_command'" >> ~/.zshrc
  else
    echo "alias $alias_name='$alias_command'" >> ~/.bashrc 
  fi
}

# Add the 'asm' alias
add_alias "asm" "java -jar ../mars.jar"

# Add the 'mars' alias
add_alias "mars" "java -jar mars.jar"

# Restart the shell to apply changes
source ~/.zshrc  # Source .zshrc for Zsh
source ~/.bashrc  # Source .bashrc for Bash
