#!/bin/zsh

# import libs
source "printf.sh"
source "os.sh"

install_ubuntu() {
    sudo add-apt-repository ppa:jonathonf/python-3.6
    sudo apt-get update
    sudo apt-get install python3.6
}

install_centos() {
    sudo yum -y update
    sudo yum -y install yum-utils
    sudo yum -y groupinstall development

    sudo yum -y install https://centos7.iuscommunity.org/ius-release.rpm
    sudo yum -y install python36u
}

install_completed() {
    printf_green "install completed, congratulations!"
    python3.6 -V
}

printf_green "your os is: $OS"

case $OS in
    ubuntu)
        install_ubuntu && install_completed
        ;;
    centos)
        install_centos && install_completed
        ;;
    *)
        printf_red "Not support your system($OS) for now"
        exit 2
        ;;
esac
