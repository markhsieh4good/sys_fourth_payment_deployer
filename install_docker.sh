#!/bin/bash

function docker_install() {
    echo "update env. "
    sudo yum install -y yum-utils
    sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

    echo "you can use below command, if you need to choice the newest docker-ce version"
    echo "yum list docker-ce --showduplicates | sort -r"
    echo "example :"
    echo "docker-ce.x86_64            3:18.09.9-3.el7                    @docker-ce-stable
docker-ce.x86_64            3:18.09.8-3.el7                    docker-ce-stable
docker-ce.x86_64            3:18.09.7-3.el7                    docker-ce-stable"
    echo "choice [x86_64, 3:**, docker-ce-stable] ..."
    echo "3:18.09.9-3.el7 --> version 18.09.9"
    echo ""

    echo "install docker ce ... we choice 18.09.1 (might be updated by system.)"
    sudo yum install -y yum-utils
    sudo yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce-18.09.1 docker-ce-cli-18.09.1 containerd.io
    sleep 1

    sudo systemctl stop docker
    if [ ! -e "/etc/docker/" ];
        sudo mkdir -p /etc/docker
    fi
    if [ ! -e "/home/docker/imgs/" ];
        sudo mkdir -p /home/docker/imgs
    fi
    sudo cp ./docker_configs/* /etc/docker/
    sleep 1

    sudo systemctl start docker
    sudo systemctl enable docker
}

function docker_uninstall() {
    echo "stop & remove running docker container ..."
    sudo docker stop $(sudo docker ps -a -q)
    sudo docker rm $(sudo docker ps -a -q)
    sleep 1
    sudo service stop docker
    sleep 1
    echo "uninstall old version ... "
    sudo yum remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
    
}

function docker_remove_ce() {
    echo "uninstall docker ce ... ?"
    sudo yum remove -y docker-ce-18.09.1 docker-ce-cli-18.09.1 containerd.io
    if [ $? -eq 1 ]; then
        echo "fail to remove docker-ce 18.09.1 ... just remove default choice tag ..."
        sudo yum remove -y docker-ce docker-ce-cli containerd.io
    fi
}

function docker_compose_install() {
    if [ -e "/usr/local/bin/docker-compose" ]; then
        echo "I find the exist one! rename for update!"
        _DCV=`/usr/local/bin/docker-compose --version`
        sudo mv /usr/local/bin/docker-compose /usr/local/bin/docker-compose_"$_DCV"
        ls /usr/local/bin/docker-compose* -al
        echo ""
    fi
    echo "version time tag: 2021/4/24 "
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    docker-compose --version
    echo ""
}

echo -n "your current docker server/client version is:"
sudo docker version
if [ $? -gt 0 ]; then
    echo "system cannot find any running docker server! Did it not been installed or service not running?"
    echo ""
fi
echo "Our company recommends using more than version 18.x.x "
read -p "Do you accept to install docker server (18.09.1)? yes, re-install, update(uninstall old one), or No! (y/r/u/N): " answer
if [ "$answer" == 'y' ] || [ "$answer" == 'Y' ]; then

    docker_install
    docker_compose_install
elif [ "$answer" == 'r' ] || [ "$answer" == 'R' ]; then
    docker_remove_ce
    docker_install
    docker_compose_install
elif [ "$answer" == 'u' ] || [ "$answer" == 'U' ]; then
    docker_uninstall
    docker_install
    docker_compose_install
else
    echo "ok ... let it go."
fi

echo "finish ... leave "

