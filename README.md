[![Build Status](https://travis-ci.com/IBM/wazi-codeready-workspaces-sidecars.svg?branch=main)](https://travis-ci.com/IBM/wazi-codeready-workspaces-sidecars)
[![Release](https://img.shields.io/github/release/IBM/wazi-codeready-workspaces-sidecars.svg)](../../releases/latest)
[![License](https://img.shields.io/github/license/IBM/wazi-codeready-workspaces-sidecars)](LICENSE)
[![DockerHub](https://img.shields.io/badge/DockerHub-CodeReady-blue?color=3498db)](https://hub.docker.com/repository/docker/ibmcom/wazi-code-codeready)
[![Documentation](https://img.shields.io/badge/Documentation-blue?color=1f618d)](https://ibm.biz/wazi-crw-doc)
    
## What's inside?
  
The IBM Wazi Developer for Workspaces sidecar image packages Java, Node, Zowe, and other tools necessary for starting a workspace. When a user creates and starts a workspace using the Wazi Developer for Workspaces stack, the sidecar container provides a user runtime environment.
  
## IBM Wazi Developer for Workspaces

IBM Wazi Developer for Workspaces is a component shipped with either IBM Wazi Developer for Red Hat CodeReady Workspaces (Wazi Developer for Workspaces) or IBM Developer for z/OS Enterprise Edition (IDzEE).

IBM Wazi Developer for Workspaces provides a modern experience for mainframe software developers working with z/OS applications in the cloud. Powered by the open source projects Zowe and Red Hat CodeReady Workspaces, IBM Wazi Developer for Workspaces offers an easy, streamlined onboarding process to provide mainframe developers the tools they need. Using container technology, IBM Wazi Developer for Workspaces brings the necessary tools to the task at hand.

For more benefits of IBM Wazi Developer for Workspaces, see the [IBM Wazi Developer product page](https://www.ibm.com/products/wazi-developer) or [IDzEE product page](https://www.ibm.com/products/developer-for-zos).

## Details

IBM Wazi Developer for Workspaces provides a custom stack with the all-in-one mainframe development package that enables mainframe developers to:

- Use a modern mainframe editor with rich language support for COBOL, JCL, Assembler (HLASM), and PL/I, which provides language-specific features such as syntax highlighting, outline view, declaration hovering, code completion, snippets, a preview of copybooks, copybook navigation, and basic refactoring using IBM Z Open Editor, a component of IBM Wazi Developer for VS Code
- Integrate with any flavor of Git source code management (SCM)
- Perform a user build with IBM Dependency Based Build for any flavor of Git
- Work with z/OS resources such as MVS, UNIX files, and JES jobs
- Connect to the Z host with z/OSMF or IBM Remote System Explorer (RSE) API, using Zowe Explorer plus IBM Z Open Editor for a graphical user interface and Zowe CLI plus the RSE API plug-in for Zowe CLI for command line access
- Debug COBOL and PL/I applications using IBM Z Open Debug
- Use a mainframe development package with a custom plug-in and devfile registry support from the [IBM Wazi Developer stack](https://github.com/IBM/wazi-codeready-workspaces)

## Documentation

For details of the features for IBM Wazi Developer for Workspaces, see its [official documentation](https://ibm.biz/wazi-crw-doc).

| Repository | Description |
| --- | --- |
| [IBM Wazi Developer for Workspaces](https://github.com/ibm/wazi-codeready-workspaces) |  The devfile and plug-in registries |
| [IBM Wazi Developer for Workspaces Sidecars](https://github.com/ibm/wazi-codeready-workspaces-sidecars) | Supporting resources for the Wazi Developer plug-ins |
| [IBM Wazi Developer for Workspaces Operator](https://github.com/ibm/wazi-codeready-workspaces-operator) | Deployment using the Operator Lifecycle Manager |

## Feedback
  
We would love to hear feedback from you about IBM Wazi Developer for Workspaces.  
File an issue or provide feedback here: [IBM Wazi Developer for Workspaces Issues](https://github.com/IBM/wazi-codeready-workspaces/issues)
