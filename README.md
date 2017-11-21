# 3 node Quorum environment

## Introduction

This sample environment provides a 3 node Quorum environment deployed onto a Ubuntu virtual machine on Microsoft Azure.

Full transaction privacy between nodes is supported.


## Usage

If you're using the [Azure VM Image](), this will configure and start both the Quorum network:

```bash
cd ~/quorum-vm-template
./init.sh
```

Alternatively, if you have an fresh Ubuntu host (username must be *ubuntu*):

```bash
cd $HOME
git clone https://github.com/fullprofile/quorum-vm-template.git
cd quorum-vm-template
sudo ./bootstrap.sh
./init.sh
```

You will be able to access the following endpoints for interacting with 
the network (please substitute hostnames for your own):

* http://quorum-poc.australiaeast.cloudapp.azure.com:8080/swagger-ui.html
* http://quorum-poc.australiaeast.cloudapp.azure.com:8081/swagger-ui.html
* http://quorum-poc.australiaeast.cloudapp.azure.com:8082/swagger-ui.html

Should you wish to manage the individual environments, you can use the following scripts.

Quorum:

```bash
cd ~/3nodes-quorum
./raft-start.sh
# or
./stop.sh
```

## Quorum node configuration

To facilitate the sending of private transactions between any combination of nodes.

| Node | Address                                    | Enclave Key                                  | Quorum Node Port | Raft Port |
|------|--------------------------------------------|----------------------------------------------|------------------|-----------|
| 1    | 0xed9d02e382b34818e88b88a309c7fe71e65f419d | BULeR8JyUWhiuuCMU/HLA0Q5pzkYT+cHII3ZKBey3Bo= | 22000            | 50401     |
| 2    | 0xca843569e3427144cead5e4d5999a3d0ccf92b8e | QfeDAys9MPDs2XHExtc84jKGHxZg/aj52DTh0vtA3Xc= | 22001            | 50402     |
| 3    | 0x0fbdc686b912d7722dc86510934589e0aaf3b55a | 1iTZde/ndBHvzhcl7V68x44Vx7pl8nwx9LqnM/AfJUg= | 22002            | 50403     |

The *privateFor* HTTP request header should be used for specifying the nodes that a transaction is private between parties.

## Azure VM

## Azure VM setup

Should you wish to setup this environment from scratch in the Azure Cloud, 
detailed instructions are below.


Install Azure command line tools:

```bash
curl -L https://aka.ms/InstallAzureCli | bash
```

*Note:* If issues with urllib see https://github.com/Azure/azure-cli/issues/3498 to resolve

Login to Azure:

```bash
az login
```
Create a resource group (use `az account list-locations` to see available locations):

```bash
az group create -n "Quorum-PoC" -l australiaeast
```

Create ssh keys:

```bash
ssh-keygen -t rsa -b 2048 
```

You can specify a different filename to save the key. eg `~/.ssh/azure_rsa`

Create an Azure VM:

```bash
az vm create -n quorum-poc-vm -g Quorum-PoC --image UbuntuLTS --size Standard_DS1_v2 --public-ip-address-dns-name quorum-poc --admin-username ubuntu --ssh-key-value ~/.ssh/azure_rsa.pub
```

*Note:* Operation may report failure, but in fact succeed

## VM installation

```bash
git clone https://github.com/fullprofile/quorum-vm-template.git
cd quorum-vm-template
sudo ./bootstrap.sh
```

## Troubleshooting

I get the following message after running *init.sh*:

```bash
[*] Starting Constellation nodes
[*] Starting node 1
[*] Starting node 2
[*] Starting node 3
[*] Waiting for nodes to start
[*] Sending test transaction against each node
Fatal: Unable to attach to remote geth: dial unix qdata/dd1/geth.ipc: connect: no such file or directory
```

Occasionally startup fails, please try re-running *init.sh*.

