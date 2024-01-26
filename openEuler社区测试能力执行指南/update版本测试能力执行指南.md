# update版本测试指导文档<br />
**前言**

update版本通常是指软件的更新版本，主要目的是修复软件中的bugfix和CVE。通常包括对软件的修复、优化和增强，以提高软件的性能、稳定性和安全性。

update版本主要修补了部分包的CVE和bugfix，所以测试执行对象主要针对单个软件包；update版本测试用例主要在mugen仓库，所以执行update任务前，请先阅读[mugen测试框架的使用介绍](https://gitee.com/openeuler/mugen#mugen)；执行用例前要添加update测试repo源，通常在转测邮件中会有repo源链接，文档最后会附加22.03-LTS-update20240110版本aarch64架构的repo源。
## 冒烟<br />
Update版本冒烟测试用例的执行主要是最基本的功能测试，保证基本的功能和流程都能走通，运行冒烟测试用例的步骤如下：

注：冒烟用例都保存在mugen测试框架下的smoke-test目录下
### 1.下载mugen测试框架<br />
```
git clone https://gitee.com/openeuler/mugen.git
```
### 2.进入mugen目录中，配置环境<br />
```
bash dep_install.sh
bash mugen.sh -c --ip $ip --password $passwd --user $user --port $port
```
### 3.执行冒烟用例<br />
```
bash mugen.sh -f AT -x
```
### 4.执行完成后，可以查看result目录，会保存失败用例的名称;详细日志保存在logs目录中;<br />
## 单包服务<br />
单包服务主要是为了验证单个软件包的安装、卸载等基本功能，运行单包服务测试用例的步骤如下：
### 1.服务自动化测试脚本路径：
```
mugen/testcases/system-test/service-test/
```
### 2.检查环境上selinux状态是否开启，如未开启，打开selinux开关<br />
### 3.下载mugen测试框架<br />
```
git clone https://gitee.com/openeuler/mugen.git
```
### 4.进入mugen目录中，配置环境<br />
```
bash dep_install.sh
bash mugen.sh -c --ip $ip --password $passwd --user $user --port $port
```
### 5.执行服务自动化测试脚本<br />
```
bash mugen.sh -f service-test  -x
```
### 6.执行完成后，分析日志<br />
#### 6.1 执行完脚本后，mugen/testcases/system-test/service-test/目录下:<br />
adapted_service中为mugen中已实现自动化的服务<br />
new_service未实现自动化的新增服务<br />
install_log中为本次转测软件包的安装日志<br />
#### 6.2 mugen中已实现自动化的服务失败用例分析：<br />
失败用例记录在mugen/failed_case下<br />
失败用例详细日志在mugen/logs/目录下<br />
#### 6.3 mugen中未实现自动化的服务失败用例分析：<br />
具体执行日志在mugen/logs/service-test/下<br />
## 单包命令参数覆盖（EPOL软件包不进行测试）<br />
对于存在命令的软件包，进行命令参数覆盖的方式进行基本功能验证，并对此类软件包进行基本的安装、卸载、依赖关系验证。
### 1.下载mugen测试框架，配置mugen环境<br />
```
git clone https://gitee.com/openeuler/mugen.git
bash mugen/dep_install.sh
bash mugen/mugen.sh -c --ip $ip --password $passwd --user $user --port $port
```
### 2.获取所有已实现自动化用例的软件包列表<br />
```
ls mugen/testcases/cli-test >./cli_list
```
### 3.获取转测repo源的二进制包列表（以update_20240110为例）<br />
```
dnf list --available --repo="update_20240110" | grep "arch\|x86_64" | awk '{print $1}' | awk -F. 'OFS="."{$NF="";print}' | awk '{print substr($0, 1, length($0)-1)}' >update_list
```
### 4.安装软件包<br />
```
yum install $(cat update_list) -y
```
### 5.依次查询存在命令的二进制包cmd_pkg
```
cat >get_cmd_pkg.sh<<EOF
while read pkg; do
    if rpm -ql \$pkg | grep -E "^/usr/bin/|^/usr/sbin/" | grep -v ".sh";then
        echo \$pkg >>cmd_pkg
    fi
done <update_list
EOF
chmod +x get_cmd_pkg.sh
bash get_cmd_pkg.sh
```
### 6.反向查询存在命令的二进制包对应的源码包cmd_src<br />
### 7.获取转测源中已实现自动化用例的软件包<br />
```
cat cmd_src cli_list | sort | uniq -d >auto_cmd_src
```
### 8.针对已实现自动化用例的软件包，依次执行验证<br />
```
bash mugen.sh -f $src -x
```
备注：<br />
A\源码包名src可能跟测试套mugen/suite2cases中的json文件名不一致（有些存在版本区分），找到对应的版本执行即可;<br />
B\执行完成后，可以查看result目录，会保存失败用例的名称;详细日志保存在logs目录中;<br />

### 9.针对未实现自动化用例的软件包，手工验证命令参数，并实现自动化，上传mugen仓库<br />
## 软件包管理<br />
软件包管理测试验证的目的是确保软件包管理系统（如yum、apt等）能够正确地安装、升级、卸载软件包，并且能够正确地解决软件包之间的依赖关系。

两种执行方案：１.准备两个环境，一个本地机器，一个远程机器，按下述步骤执行；2.准备四个环境，两个本地机器，两个远程机器，按下述步骤执行。<br />
### 1.本地机器下载mugen测试框架<br />
```
git clone https://gitee.com/openeuler/mugen.git
```
### 2.本地机器进入mugen目录中，配置环境<br />
```
bash dep_install.sh
bash mugen.sh -c --ip $ip_local --password $passwd --user $user --port $port
bash mugen.sh -c --ip $ip_remote --password $passwd --user $user --port $port
```
### 3.本地机器执行冒烟用例<br />
（第一种方案）<br />
```
bash mugen.sh -f pkgmanager-test -x
```
（第二种方案）<br />
第一个本地机器上执行：<br />
```
bash mugen.sh -f pkgmanager-test -r oe_test_pkg_manager01 -x
```
第二个本地机器上执行：<br />
```
bash mugen.sh -f pkgmanager-test -r oe_test_pkg_manager02 -x
```
### 4.执行完成后，可以查看result目录，会保存失败用例的名称;详细日志保存在logs目录中;<br />
## 内核<br />
内核作为系统中最重要的一部分，其产生的后果和影响性也是最严重的，每次迭代版本之前需要针对内核进行基本功能验证。
### 1.安装转测repo源里面的最新版本的kernel软件包，装完后重启机器生效<br />
```
dnf install -y kernel
reboot
```
### 2.下载mugen测试框架<br />
```
git clone https://gitee.com/openeuler/mugen.git
```
### 3.进入mugen目录中，配置环境<br />
```
bash dep_install.sh
bash mugen.sh -c --ip $ip --password $passwd --user $user --port $port
```
### 4.执行冒烟用例<br />
```
bash mugen.sh -f ltp-test -x
```
### 5.‘执行完成后，可以查看result目录，会保存失败用例的名称;详细日志保存在logs目录中;<br />
## ****docker****容器<br />
### 1.在本地机器安装docker镜像，以update_20240103为例<br />
```
version=$(grep PRETTY_NAME /etc/os-release | awk -F '"' '{print $2}' | sed 's/[()]//g;s/ /-/g')
update_ver="update_20240103"
docker_name="openEuler_test"
docker_img=http://121.36.84.172/repo.openeuler.org/${version}/docker_img/${update_ver}/$(uname -i)/openEuler-docker.$(uname -i).tar.xz<br />
dnf install -y docker
echo "download img ${version}"
wget ${docker_img}
img=$(docker load -i openEuler-docker.$(uname -i).tar.xz)
img_name=$(echo ${img} | awk '{print $3}')
systemctl start docker
```
### 2.在本地机器启动docker容器<br />
```
echo "create docker"
docker run -itd --name ${docker_name} --privileged  -u root ${img_name} /bin/b.sh
```
### 3.在本地机器配置docker环境中的update repo源<br />
先确定本地环境update源已配置，参考本文第七章节<br />
```
docker cp /etc/yum.repos.d/*.repo ${docker_name}:/etc/yum.repos.d
docker exec -it -u root ${docker_name} /bin/bash -c "mv /etc/yum.repos.d/openEuler.repo /root"

docker exec -it -u root ${docker_name} /bin/bash -c "dnf install -y sudo passwd systemd openssh git iproute bind-utils traceroute mtr wget setools-console selinux-policy selinux-policy-targeted openvswitch"
docker exec -it -u root ${docker_name} /bin/bash -c "sed -i  's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config"
```

### 4.在本地机器更新docker容器密码<br />
```
docker exec -it -u root ${docker_name} /bin/bash -c "cat > updatepwd <<EOF
openEuler12#$
openEuler12#$
EOF
passwd < updatepwd"
```
### 5.在本地机器进行容器配置<br />
```
container_id=$(docker ps -a | grep ${docker_name} | awk '{print $1}')
container_path=$(ls /var/lib/docker/containers | grep ${container_id})
docker stop ${docker_name}
systemctl stop docker
sed -i 's#/bin/bash#/sbin/init#g' /var/lib/docker/containers/${container_path}/config.v2.json
systemctl start docker
docker start ${docker_name}
dnf install git vim -y
git clone https://gitee.com/openeuler/mugen.git
docker cp ./mugen ${docker_name}:/home
docker exec -it -u root ${docker_name} /bin/bash -c "systemctl start sshd"
docker exec -it -u root ${docker_name} /bin/bash -c "cd /home/mugen/;bash dep_install.sh;bash mugen.sh -c --ip 172.17.0.2 --password openEuler12#$ --user root"
docker exec -it -u root ${docker_name} /bin/bash -c "getenforce;sysctl -w net.ipv6.conf.all.disable_ipv6=0;sysctl -a | grep disable_ipv6"
```
### 6.登录docker环境，执行冒烟用例<br />
```
docker exec -it -u root ${docker_name} /bin/bash -c "cd /home/mugen;bash mugen.sh -f AT -x"
```
### 7.执行完成后，可以在docker环境中查看result目录，会保存失败用例的名称;详细日志保存在logs目录中;<br />
## repo源
以22.03－LTS-update20240110版本aarch64架构为例<br />
```
[openEuler-22.03-LTS_OS]
name=openEuler-22.03-LTS_OS
baseurl=https://repo.openeuler.org//openEuler-22.03-LTS/OS/aarch64/
enabled=1
gpgcheck=1
gpgkey=https://repo.openeuler.org//openEuler-22.03-LTS/OS/aarch64/RPM-GPG-KEY-openEuler

[openEuler-22.03-LTS_everything]
name=openEuler-22.03-LTS_everything
baseurl=https://repo.openeuler.org//openEuler-22.03-LTS/everything/aarch64/
enabled=1
gpgcheck=1
gpgkey=https://repo.openeuler.org//openEuler-22.03-LTS/everything/aarch64/RPM-GPG-KEY-openEuler

[openEuler-22.03-LTS_source]
name=openEuler-22.03-LTS_source
baseurl=https://repo.openeuler.org//openEuler-22.03-LTS/source/
enabled=1
gpgcheck=1
gpgkey=https://repo.openeuler.org//openEuler-22.03-LTS/source/RPM-GPG-KEY-openEuler

[openEuler-22.03-LTS_update]
name=openEuler-22.03-LTS_update
baseurl=https://repo.openeuler.org//openEuler-22.03-LTS/update/aarch64/
enabled=1
gpgcheck=1
gpgkey=https://repo.openeuler.org//openEuler-22.03-LTS/OS/aarch64/RPM-GPG-KEY-openEuler

[openEuler-22.03-LTS_update_source]
name=openEuler-22.03-LTS_update_source
baseurl=https://repo.openeuler.org//openEuler-22.03-LTS/update/source/
enabled=1
gpgcheck=1
gpgkey=https://repo.openeuler.org//openEuler-22.03-LTS/OS/aarch64/RPM-GPG-KEY-openEuler

[openEuler-22.03-LTS_EPOL]
name=openEuler-22.03-LTS_EPOL
baseurl=https://repo.openeuler.org//openEuler-22.03-LTS/EPOL/main/aarch64/
enabled=1
gpgcheck=1
gpgkey=https://repo.openeuler.org//openEuler-22.03-LTS/OS/aarch64/RPM-GPG-KEY-openEuler

[openEuler-22.03-LTS_EPOL_source]
name=openEuler-22.03-LTS_EPOL_source
baseurl=https://repo.openeuler.org//openEuler-22.03-LTS/EPOL/main/source/
enabled=1
gpgcheck=1
gpgkey=https://repo.openeuler.org//openEuler-22.03-LTS/OS/aarch64/RPM-GPG-KEY-openEuler

[openEuler-22.03-LTS_EPOL_update]
name=openEuler-22.03-LTS_EPOL_update
baseurl=https://repo.openeuler.org//openEuler-22.03-LTS/EPOL/update/main/aarch64/
enabled=1
gpgcheck=1
gpgkey=https://repo.openeuler.org//openEuler-22.03-LTS/OS/aarch64/RPM-GPG-KEY-openEuler

[openEuler-22.03-LTS_EPOL_update_source]
name=openEuler-22.03-LTS_EPOL_update_source
baseurl=https://repo.openeuler.org//openEuler-22.03-LTS/EPOL/update/main/source/
enabled=1
gpgcheck=1
gpgkey=https://repo.openeuler.org//openEuler-22.03-LTS/OS/aarch64/RPM-GPG-KEY-openEuler

[openEuler-22.03-LTS_update_20240110]
name=openEuler-22.03-LTS_update_20240110
baseurl=http://121.36.84.172/repo.openeuler.org/openEuler-22.03-LTS/update_20240110/aarch64/
enabled=1
gpgcheck=1
gpgkey=http://repo.openeuler.org/openEuler-22.03-LTS/OS/aarch64/RPM-GPG-KEY-openEuler
priority=1

[openEuler-22.03-LTS_source_update_20240110]
name=openEuler-22.03-LTS_source_update_20240110
baseurl=http://121.36.84.172/repo.openeuler.org/openEuler-22.03-LTS/update_20240110/source/
enabled=1
gpgcheck=1
gpgkey=http://repo.openeuler.org/openEuler-22.03-LTS/OS/aarch64/RPM-GPG-KEY-openEuler
priority=1

[openEuler-22.03-LTS_EPOL_update_20240110]
name=openEuler-22.03-LTS_EPOL_update_20240110
baseurl=http://121.36.84.172/repo.openeuler.org/openEuler-22.03-LTS/EPOL/update_20240110/main/aarch64/
enabled=1
gpgcheck=1
gpgkey=http://repo.openeuler.org/openEuler-22.03-LTS/OS/aarch64/RPM-GPG-KEY-openEuler
priority=1

[openEuler-22.03-LTS_EPOL_source_update_20240110]
name=openEuler-22.03-LTS_EPOL_source_update_20240110
baseurl=http://121.36.84.172/repo.openeuler.org/openEuler-22.03-LTS/EPOL/update_20240110/main/source/
enabled=1
gpgcheck=1
gpgkey=http://repo.openeuler.org/openEuler-22.03-LTS/OS/aarch64/RPM-GPG-KEY-openEuler
priority=1
```
