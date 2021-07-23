#!/bin/bash
currentVersion=$1
echo "increasing version from ${currentVersion}"

echo "old path: ${PATH}"
export PATH=/var/jenkins_home/.local/bin:${PATH}
echo "new path: ${PATH}"
bump2version --verbose --current-version ${currentVersion} patch setup.py
echo "version update completed"