# openEuler社区集成验证入口标准

社区集成验证入口标准对软件包或自研特性的引入、升降级、衰退等场景提出质量以及测试要求。使能社区新引入、升降级、衰退的软件包或自研特性具备基本的质量以及测试依据，提升社区的集成验证质量与测试效率。

## 1. 流程质量要求

软件包引入指导文档见[openEuler社区软件包引入&版本基线纳入或变更指导](https://gitee.com/openeuler/release-management/blob/master/openEuler社区软件包引入&版本基线纳入或者变更指导.md)

### 1.1. 软件包引入质量要求

#### 1.1.1. 合规性

引入的软件包需要上游社区活跃，无法务风险。黑名单License禁止直接引入，需要sig-Compliance给出评审结果后引入。

社区License黑白名单、兼容表等信息可以通过貂蝉平台进行查询：https://compliance.openeuler.org

sig-Compliance仓库地址：https://gitee.com/openeuler/compliance

#### 1.1.2. 软件包版本选择

除需求指定的版本要求外，还应注意官网发布的版本计划，引入的版本是否还在维护，优先选择已发布的稳定版本。

#### 1.1.3. spec格式要求

软件包命名规范及patch命名规范详见[openEuler packaging guidelines](https://gitee.com/openeuler/community/blob/master/zh/contributors/packaging.md#%E5%91%BD%E5%90%8D%E8%A7%84%E5%88%99)

#### 1.1.4. License合法性要求

请参阅本文**章节 1.1.1. 合规性**

#### 1.1.5. 软件包编译验证要求

1. 根据《社区软件包贡献指南》创建私人构建工程，在私人工程中创建新目录，然后将源码包解压至相应目录进行编译，最后给出构建结果相应的截图作为编译验证举证
   - 社区软件包贡献指南: https://openeuler.org/zh/community/contribution/detail.html#_3-3-3-贡献软件包
   - 当前仅有基于OBS的构建指导，未来将基于统一构建平台EBS刷新相关指南

1. 完成自编译测试，请参阅本文**章节 2.1.1.自编译验证**

#### 1.1.6. 软件包安装验证要求

1. 建议给出软件包构建后上层依赖本地安装卸载截图举证，保证上层依赖安装卸载功能正常
   - 通过dnf install/remove的方式安装卸载上层依赖包
2. 完成引入包的安装卸载测试，请参阅本文**章节 2.1.2.安装卸载验证**

### 1.2. 软件包升降级质量要求

#### 1.2.1. 差异分析

对于需要满足前向兼容的分支版本，建议在对应升降级issue中提供差异分析，对变更的接口、结构体、命令行和配置项进行列举，并确保上层调用软件不受影响

- 对比方法：通过对比源码包并查阅上游社区对应两个版本之间的提交记录的方式完成

#### 1.2.2. 升降级影响排查

1. 对于所有版本分支，建议在对应升降级issue中提供升降级影响范围排查（主工程+EPOL工程），确保上层依赖包无编译、安装问题。

根据《社区软件包引入流程》指导文档创建私人构建工程，在对应OBS工程下找到对应软件包点击Branch Package在私人工程生成同名工程。并同时查询当前软件包提供的接口，再查询依赖这些接口的软件包清单（即该软件包的上层依赖）。将上层依赖包加入同一私人工程进行构建，最后提供升降级版本编译成功且上层依赖构建安装均无影响的截图举证（包括软件包完成升降级的举证）

- 软件包提供的接口查询

  ```shell
  rpm -qp --provides xxx.rpm
  ```
- 挂载全量repo源

  除\[OS\]\[everything\]\[EPOL\]\[source\]\[update\]外，还需要配好EPOL/source和update/source
  以openEuler 22.03 LTS版本举例，/etc/yum.repos.d/openEuler.repo应配为

  ```ini
  [OS]
  name=OS
  baseurl=http://repo.openeuler.org/openEuler-22.03-LTS/OS/$basearch/
  enabled=1
  gpgcheck=1
  gpgkey=http://repo.openeuler.org/openEuler-22.03-LTS/OS/$basearch/RPM-GPG-KEY-openEuler
  
  [everything]
  name=everything
  baseurl=http://repo.openeuler.org/openEuler-22.03-LTS/everything/$basearch/
  enabled=1
  gpgcheck=1
  gpgkey=http://repo.openeuler.org/openEuler-22.03-LTS/everything/$basearch/RPM-GPG-KEY-openEuler
  
  [EPOL]
  name=EPOL
  baseurl=http://repo.openeuler.org/openEuler-22.03-LTS/EPOL/main/$basearch/
  enabled=1
  gpgcheck=1
  gpgkey=http://repo.openeuler.org/openEuler-22.03-LTS/OS/$basearch/RPM-GPG-KEY-openEuler
  
  [debuginfo]
  name=debuginfo
  baseurl=http://repo.openeuler.org/openEuler-22.03-LTS/debuginfo/$basearch/
  enabled=1
  gpgcheck=1
  gpgkey=http://repo.openeuler.org/openEuler-22.03-LTS/debuginfo/$basearch/RPM-GPG-KEY-openEuler
  
  [source]
  name=source
  baseurl=http://repo.openeuler.org/openEuler-22.03-LTS/source/
  enabled=1
  gpgcheck=1
  gpgkey=http://repo.openeuler.org/openEuler-22.03-LTS/source/RPM-GPG-KEY-openEuler
  
  [update]
  name=update
  baseurl=http://repo.openeuler.org/openEuler-22.03-LTS/update/$basearch/
  enabled=1
  gpgcheck=1
  gpgkey=http://repo.openeuler.org/openEuler-22.03-LTS/OS/$basearch/RPM-GPG-KEY-openEuler
  
  [update-source]
  name=update
  baseurl=http://repo.openeuler.org/openEuler-22.03-LTS/update/source/
  enabled=1
  gpgcheck=0
  
  [EPOL-source]
  name=update
  baseurl=http://repo.openeuler.org/openEuler-22.03-LTS/EPOL/main/source/
  enabled=1
  gpgcheck=0
  ```

- 依赖所提供接口的软件包查询

  ```shell
  dnf repoquery --whatrequires 'xxx'
  ```

2. 完成安装卸载/自编译测试，请参阅本文**章节 2.1.1.自编译验证**以及**章节 2.1.2.安装卸载验证**

### 1.3. 软件包衰退质量要求

#### 1.3.1. 提供衰退影响排查

1. 对于所有软件包退出的关联分支，必须在对应衰退issue中提供软件包退出影响范围排查（主工程+EPOL工程），确保上层依赖包无编译、安装问题。

   排查方式请参阅**章节 1.2.2.升降级影响排查**

2. 完成安装卸载/自编译测试，请参阅本文**章节 2.1.1.自编译验证**以及**章节 2.1.2.安装卸载验证**

### 1.4. openEuler社区孵化特性质量要求



## 2. 测试要求

对于上述流程的任意环节，软件包都需要满足下述测试要求

### 2.1. 软件包测试要求

#### 2.1.1. 自编译验证

1. 切换到对应软件包src.rpm文件所在目录

2. 执行命令进行安装

   ```shell
   rpm -ivh xxx.src.rpm
   ```

3. 进入安装目录，安装依赖，并执行编译

   ```shell
   cd WORK_DIR/rpmbuild/SPECS/
   dnf install dnf-plugins-core rpmdevtools -y
   dnf builddep xxx.spec
   rpmbuild -ba xxx.spec
   ```


4. 根据结果输出自编译测试报告

#### 2.1.2. 安装卸载验证

1. 切换到**章节 2.1.1.自编译**验证中，执行rpmbuild后默认存放的目录

   ```shell
   cd WORK_DIR/rpmbuild/RPMS/xxx/
   ```

2. 安装RPM包

   ```shell
   rpm -i xxx.rpm
   ```

3. 卸载RPM包

   ```shell
   rpm -e xxx
   ```

4. 根据结果输出安装卸载测试报告

#### 2.1.2. 命令验证

1. 利用rpm -qpl xx.rpm查看有哪些命令（/usr/bin/下即为新增命令）可以使用命令行运行
2. 通过man或命令的--help/-h参数找到所有可执行参数
3. 根据命令参数清单输出测试报告

#### 2.1.3. 服务验证

1. 安装源码包中的所有二进制包

2. 使用命令查找所有服务

   ```shell
   rpm -ql xxx | grep "service\|socket\|target"
   ```

3. 完成服务启动、停止、重载、启用、禁用测试

   ```shell
   systemctl start/stop/reload/enable/disable servicename
   ```

   一般start/stop可以直接执行，但如果服务启动前需要进行配置，建议先根据报错进行分析，最后可以参考软件包执行文档

4. 根据服务清单输出测试报告



### 2.2. openEuler社区孵化特性测试要求

#### 2.2.1. 软件包清单

提供特性所涉及的软件包列表，与每个涉及软件包的功能说明

 #### 2.2.2. 产品质量属性目标（DFx）

依据自研特性设计文档，分类列举特性对应的产品质量属性目标，涵盖下述7项内容

##### 2.2.2.1. 性能规格

##### 2.2.2.2. 可靠性

##### 2.2.2.3. 安全性

##### 2.2.2.4. 兼容性

##### 2.2.2.5. 可服务性（漏洞可服务性）

##### 2.2.2.6. 可测试性

##### 2.2.2.7. 生命周期