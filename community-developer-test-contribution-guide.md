# Community Developer Test Contribution Guide

As an open and innovative platform, the openEuler community is built upon contributions made by developers. The quality assurance system of the community also requires a joint effort from developers.

You need to sign a [Contributor License Agreement](https://clasign.osinfra.cn/sign/Z2l0ZWUlMkZvcGVuZXVsZXI=) (CLA) before making contributions.

As a developer, you can contribute to the openEuler community by helping with test assurance at the package, version, and tool levels. This document describes the details of the tests.

## Package Test Contribution

### Introduction

The quality assurance of a software package includes:

- Developer testing 
- Community crowdtesting 

#### Developer Testing

You can contribute test code to the upstream community of the software package. The Open Build Service (OBS) will perform the test cases based on the `make check` command specified in the SPEC file when building the binary package. You can also directly contribute code to the corresponding project of the openEuler community.

- If test code is available in the upstream community, perform the test based on the contribution rules of the upstream community. 
- If test code is not available in the upstream community, discuss the contribution rules with the maintainer of the upstream community and make contributions. 

#### Community Crowdtesting

##### Tests on New Requests or Features to be Released by openEuler

   As a community of integration, the openEuler community welcomes all developers in the industry to construct, share, and govern the community together. You are welcome to contribute to the community development by referring to the [Contribution Guide](https://gitee.com/openeuler/community/tree/master/en/contributors). Currently, the requirements of the community edition are managed by the release management SIG. The SIGs of the community are responsible for the corresponding requirements submitted by the release management SIG. The maintainers and developers of the SIGs provide assurance for the contributions, such as code submission, issue resolution, CVE fixes, and testing delivery. The QA SIG is the quality assurance team of the community, which manages testing of the community edition. The maintainers of the QA SIG are responsible for composing and reviewing the overall test policy to guide the testing activities for subsequent version iterations.

- Requirement analysis 

  To participate in requirement analysis, see the feature lists and the release plans in the [release management SIG repository](https://gitee.com/openeuler/release-management). For details about the implementation of a specific requirement, click the link in the comment area of the corresponding issue or view the associated repository.

- Test scheme design 

  After understanding feature implementation details, you can participate in test scheme design by referring to the [Test Scheme Design Template](https://gitee.com/openeuler/package-reinforce-test/blob/master/单软件包加固测试设计方案参考.mmap). After the QA SIG reviews the test design scheme, submit it to the archive directory of the corresponding version in the [QA SIG repository](https://gitee.com/openeuler/QA) through a PR.

- Test code writing 

  The [mugen test framework](https://gitee.com/openeuler/test-tools/tree/master/mugen) is now available in the openEuler community. Write test code and perform local debugging based on the discussed test scheme in compliance with [Test Case Naming and Coding Specifications](https://gitee.com/openeuler/package-reinforce-test/blob/master/test-case-naming-and-coding-specifications.md).

- Code submission 

  After coding and debugging, submit code to the [code repository](https://gitee.com/openeuler/integration-test) and manage directories based on feature names through PRs.

- Test report compilation
  
  The community edition tests are performed based on features. Each SIG is responsible for the corresponding feature tests. After the tests are completed based on a given test scheme, the SIG test maintainer compiles the feature test report based on the [Feature Test Report Template](Test_Delivery_Templates%5CopenEuler%20%7Bversion%7D%20%7Bfeature%7D%20Feature%20Test%20Report%20Template.md). After being reviewed by the QA SIG, the feature is submitted in a PR and archived in the corresponding version test result directory.

##### Package Reinforcement Tests on Software Packages Released by openEuler

For details, see [Package Reinforcement Test](https://gitee.com/openeuler/package-reinforce-test).

### Note

- Stay tuned for the virtualization component package test contribution guide.
- Stay tuned for the container component package test contribution guide.

## Version Test Contribution

See the [release management SIG repository](https://gitee.com/openeuler/release-management) for the release plan of the openEuler community edition. You can make contributions as a developer by performing version tests in the [Community Test System](community-test-system.md). For details about the repositories, see the list of repositories in the [QA SIG repository](https://gitee.com/openeuler/QA) and [repository description](https://gitee.com/openeuler/community/tree/master/sig/README-en.md).

## Tool Contribution

The ecosystem construction and quality assurance in the openEuler community depends on efficient and convenient tools. You can contribute various tools to the [tool repository](https://gitee.com/openeuler/test-tools) as a developer, including but not limited to:

- Tools that integrate advanced test concepts and capabilities 
- Efficient test frameworks 
- Tools for improving coding efficiency
