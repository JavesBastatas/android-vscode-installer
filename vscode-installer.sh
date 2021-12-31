#!/bin/bash
#
# VSCode Installer v1.0
# A simple batch script that installs and runs VSCode in your non-rooted Android phone in Termux
# 
# Git: https://github.com/JavesBastatas/android-vscode-installer
readonly args=("$@")
readonly args_len=("$#")
readonly rand=$RANDOM
readonly version="v1.0"
readonly github_api_url="api.github.com"
readonly codeserver_repo_uri="cdr/code-server"
readonly codeserver_release_url="https://${github_api_url}/repos/$codeserver_repo_uri/releases/latest"
codeserver_version="3.10.2"
codeserver_download_url=""
codeserver_install_path="./"

timestamp (){
  echo $(date +"%s")
}

vscode_exists (){
  if [ -L "code-server" ]; then
    if [-e "code-server" ]; then
      echo true
    else
      echo false
    fi
  else
    echo false
  fi
}

get_latest_version (){
  local VERSION=$(curl -sL ${codeserver_release_url} | grep -Po '"tag_name": "\K.*?(?=")')
  VERSION=${VERSION:1}
  echo $VERSION
}

parse_codeserver_download_url (){
  local VERSION=$1
  echo "https://github.com/${codeserver_repo_uri}/releases/download/v${VERSION}/code-server-${VERSION}-linux-arm64.tar.gz"
}


download_codeserver (){
  local begin=$(timestamp)
  local end=""
  local time_taken=""
  echo "Downloading code-server ..."
  echo $1
  wget -cO - $1 > ${codeserver_install_path}${rand}-code-server-$2-linux-arm64.tar.gz 
  end=$(timestamp)
  time_taken="$(($end - $begin))"
  echo "Downloading done in ${time_taken} sec/s"
  
}

unpack_codeserver (){
  local begin=$(timestamp)
  local end=""
  local time_taken=""
  echo "Unpacking code-server ..."
  local path="${codeserver_install_path}${rand}-code-server-$1-linux-arm64"
  mkdir $path
  $(tar -xf "${path}.tar.gz" -C $path --strip-components=1)
  unlink /usr/bin/code-server
  ln -s ${path}/bin/code-server /usr/bin/code-server
  end=$(timestamp)
  time_taken="$(($end - $begin))"
  echo "Unpacking done in ${time_taken} sec/s"
}

install_codeserver(){
  
  if [ $(vscode_exists) == true ]; then
    echo "ERROR: code-server already installed! Uninstall it first before installing new one"
    exit;
  fi


  #echo "Finding latest release..."
  
 # codeserver_version=$(get_latest_version)
  codeserver_download_url=$(parse_codeserver_download_url $codeserver_version)
  
  download_codeserver $codeserver_download_url $codeserver_version
  unpack_codeserver $codeserver_version
  
  echo "VSCode aka code-server is now fully installed. Run the command 'code-server' to try it out"
}

intro (){
  printf "VSCode Installer $version \n"
}

intro
install_codeserver
