# Community Test System

openEuler is a free open source Linux distribution. In the openEuler community, global developers join hands to build an open, diversified, and architecture-inclusive software innovation ecosystem. As openEuler releases thousands of software packages, how to ensure the overall quality of the system has become a key challenge.

This document describes the test and quality assurance methods of the openEuler community at the package and version levels.

## Package Tests

### Introduction

Packages released by the openEuler community include upstream community software and openEuler original software. The quality of a software package is assured through the following methods:

- Quality gate check 
- Developer testing 
- Community crowdtesting 

#### Quality Gate Check

When a developer submits the modification to a software package in a PR, the quality gate check of the continuous integration (CI) project is triggered. After the quality gate check is passed, the compilation and building of the software package is started. Currently, the quality gate check planned by the openEuler community includes check items for licenses, basic information, interface changes, and sensitive information. The maintainers of each project need to review the quality gate check results.

#### Developer Testing

If test code is added to the source code of the software package in the upstream community, the Open Build Service (OBS) will perform the test cases based on the `make check` command specified in the SPEC file when building the binary package. This ensures that modification to the source code does not impact the basic interfaces or functions of the software package.

The quality assurance of this aspect depends on developers' contribution of test code. When submitting a patch, you can supplement or modify the test cases in the source code to enrich the basic verification capabilities for interfaces and functions of the software. As a patch submitter, you can also create a task issue in the corresponding project and describe the function of the patch so that other developers can understand the changes and contribute test cases. 

The openEuler community complies with the Upstream First principle. You are advised to contribute patches and test cases to the upstream community because changes in the upstream community will be synchronized to openEuler. Directly contributing patches and test cases to the openEuler community is also appreciated.

#### Community Crowdtesting

As an open and innovative Linux community, openEuler welcomes all developers in the industry to participate in various community activities. Community crowdtesting requires more developers to participate in the quality assurance activities. You are welcome to perform tests, verification, and quality assurance on software packages that are imported or modified due to new features and upgraded packages that are heavily modified.

## Version Tests

### Introduction

See the [release management SIG repository](https://gitee.com/openeuler/release-management) for the release plan of the openEuler community edition. The QA SIG is responsible for quality assurance of the planned versions. The openEuler community edition builds include:

- Daily build 
- Beta build 
- Release build 

#### Daily Build

The CI project pulls the corresponding packages from the project repositories, compiles the packages, and then integrates and builds an ISO image of the daily build. After the build is successful, a smoke test of the daily build is automatically triggered. The test items include:

- Installation and deployment 
- Software package installation and uninstallation  
- Component tests (kernel/virtualization/container/compiler) 
- System integration 
- System services (login/firewall/partitioning/service statuses/logs/kdump)

#### Beta Build

Based on the daily build, beta build integrates new requirements and features planned in the official release and is provided for community users as a preview version. This build meets the basic requirements of community users and the build quality is stable. Before a beta build is released, the QA team performs and organizes more comprehensive tests, including the following items:

- Smoke testing 
- Function verification for new requirements or features 
- Performance testing 
- Upgrades 
- Community crowdtesting 

#### Release Build

Release builds in the community release plan include LTS versions released every two years and innovative versions released every 6 months. A release build is an official version released by the community and has higher quality requirements. The release build test items include:

- Beta build testing    
- Stress testing 
- Security testing
- Compatibility testing 
- Document testing
