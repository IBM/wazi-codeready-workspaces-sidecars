[![Build Status](https://travis-ci.com/IBM/wazi-codeready-workspaces-sidecars.svg?branch=main)](https://travis-ci.com/IBM/wazi-codeready-workspaces-sidecars)
[![Release](https://img.shields.io/github/release/IBM/wazi-codeready-workspaces-sidecars.svg)](../../releases/latest)
[![License](https://img.shields.io/github/license/IBM/wazi-codeready-workspaces-sidecars)](LICENSE)
[![DockerHub](https://img.shields.io/badge/DockerHub-CodeReady-blue?color=3498db)](https://hub.docker.com/repository/docker/ibmcom/wazi-code-codeready)
[![Knowledge Center](https://img.shields.io/badge/Knowledge%20Center-blue?color=1f618d)](http://ibm.biz/ibmwazidoc)
    
# IBM&reg; Wazi for Red Hat&reg; CodeReady Workspaces

IBM&reg; Wazi for Red Hat&reg; CodeReady Workspaces (IBM&reg; Wazi Development Client), delivers cloud-native developer experience, enabling development and testing of IBM z/OS application components in containerized, z/OS sandbox environment on Red Hat OpenShift Container Platform running on x86 hardware, and providing capability to deploy applications into production on native z/OS running on IBM Z hardware. IBM&reg; Wazi Development Client is a development environment that provides an in-browser IDE with a single-click developer workspace with the capabilities to code, edit, build, and debug.  
  
## What's inside?
  
A Docker image that packages all the enviroment dependencies for a stack and is necessary when a workspace is started.
This sidecar provides Java, Node, Zowe, and other tools necessary to successfully run a workspace with Wazi Development Client stack. When a user creates and starts a workspace using Wazi Development Client stack, Wazi CodeReady Workspaces Sidecar container runs as a sidecar for Wazi Development Client plugin and user runtime for Wazi Development Client Stack in the workapce pod.
  
## Customization
  
Documentation can be found here for [Customizing IBM&reg; Wazi Development Client](https://www.ibm.com/support/knowledgecenter/SSCH39_1.0.0/com.ibm.wazi.development.codeready.doc/customize-devfile-plugin-registry.html)  
  
* The [IBM&reg; Wazi CodeReady Workspaces](https://github.com/ibm/wazi-codeready-workspaces) repository - provides the devfile and plug-in registries for the Red Hat&reg; CodeReady Workspaces.
* The [IBM&reg; Wazi CodeReady Workspaces Sidecars](https://github.com/ibm/wazi-codeready-workspaces-sidecars) repository - provides the supporting resources for the devfile and plug-in registries.
* The [IBM&reg; Wazi CodeReady Workspaces Operator](https://github.com/ibm/wazi-codeready-workspaces-operator) repository - provides the Operator Lifecycle Manager to deploy the IBM&reg; Wazi Development Client.
  
## Feadback
  
We would love to hear feedback from you about IBM&reg; Wazi for Red Hat&reg; CodeReady Workspaces.  
File an issue or provide feedback here: [IBM&reg; Wazi Development Client Issues](https://github.com/IBM/wazi-codeready-workspaces/issues)
  
## What is IBM&reg; Wazi Development Client?
IBM&reg; Wazi Development Client is built on the Red Hat&reg; CodeReady Workspaces project. The core functionality for Red Hat&reg; CodeReady Workspaces is provided by an open-source project called Eclipse Che. IBM Wazi Development Client uses Kubernetes and containers to provide your team with a consistent, secure, and zero-configuration development environment that interacts with your IBM Z&reg; platform.  
  
IBM&reg; Wazi Development Client provides a modern experience for mainframe software developers working with z/OS applications in the cloud. Powered by the open-source projects Zowe&trade; and Red Hat CodeReady Workspaces, IBM&reg; Wazi Development Client offers an easy, streamlined on-boarding process to provide mainframe developers the tools they need. Using container technology and stacks, IBM&reg; Wazi Development Client brings the necessary technology to the task at hand.
