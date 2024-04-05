#!/bin/bash

# Add the alias to .bashrc
echo "alias asm='java -jar ../mars.jar'" >> ~/.bashrc
echo "alias mars='java -jar mars.jar'" >> ~/.bashrc

# Restart the shell
source ~/.bashrc
