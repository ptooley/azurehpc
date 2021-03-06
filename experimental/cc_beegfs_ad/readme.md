# Building the infrastructure
Here we will explain how to deploy a full system with a VNET, JUMPBOX, Active Directory, CYCLESERVER and BEEGFS by using building blocks. These blocks are stored into the experimental/blocks directory.

## Step 1 - install azhpc
after cloning azhpc, source the install.sh script

## Step 2 - Initialize the configuration files
Create a working directory from where you will do the deployment and configuration update. Don't work directly from the cloned repo.

```
$ mkdir cluster
$ cd cluster
```

Then copy the init.sh and variables.json from experimental/cc_beegfs_ad to your working directory.

```
$ cp $azhpc_dir/experimental/cc_beegfs_ad/init.sh .
$ cp $azhpc_dir/experimental/cc_beegfs_ad/variables.json .
```

Edit the variables.json to match your environment. Leave the projectstore empty as it will be filled up with a random value by the init script. An existing keyvault should be referenced as it won't be created for you.

```json
{
    "resource_group": "my resource group",
    "location": "westeurope",
    "key_vault": "my key vault",
    "projectstore": ""
  }
```

Run the init.sh script which will copy all the config files of the building blocks and initialize the variables by using the variables.json updated above.

```
$ ./init.sh
```

## Step 2 - Build the system

```
$ azhpc-build -c vnet.json
$ azhpc-build --no-vnet -c jumpbox.json
$ azhpc-build --no-vnet -c ad.json
$ azhpc-build --no-vnet -c cycle-prereqs-managed-identity.json
$ azhpc-build --no-vnet -c cycle-install-server-managed-identity.json
```

## Step 3 - Connect to CycleServer UI
Retrieve the CycleServer DNS name from the azure portal and browse to it with https.
Retrieve the Cycle admin password from the logs 

```
$ grep password azhpc_install_cycle-install-server-managed-identity/install/*.log
```

Connect to the Cycle UI with hpcadmin user and the password retrieved above.

## Step 4 - Deploy the Cycle CLI
Deploy the Cycle CLI locally and on the jumpbox

```
$ azhpc-build --no-vnet -c cycle-cli-local.json
$ azhpc-build --no-vnet -c cycle-cli-jumpbox.json
```

## Step 5 - Now deploy the BeeGFS cluster
```
$ azhpc-build --no-vnet -c beegfs-cluster.json
```

## Step 6 - Create the PBS cluster in CycleCloud

```
$ azhpc ccbuild -c pbscycle.json
```

## Step 7 - Connect to the Active Directory to create users

```
$ azhpc-connect -c ad.json adnode
```
