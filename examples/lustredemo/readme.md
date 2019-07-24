# Lustre Cluster

This is a full set up with all the lustre features available.

Resources:

* Head node (headnode)
* Compute nodes (compute)
* Lustre
  * Management/Meta-data server (lfsmds)
  * Object storage servers (lfsoss)
  * Hierarchical storage management nodes (lfshsm)

> Note: The Hb nodes are used for the cluster.  To get best performance nodes with accelerated networking should be used.

The configuration file requires the following variables to be set:

| Variable                | Description                                  |
|-------------------------|----------------------------------------------|
| resource_group          | The resource group for the project           |
| storage_account         | The storage account for HSM                  |
| storage_key             | The storage key for HSM                      |
| storage_container       | The container to use for HSM                 |
| log_analytics_lfs_name  | The lustre filesystem name for Log Analytics |
| log_analytics_workspace | The log analytics workspace to use           |
| log_analytics_key       | The log analytics key                        |

> Note: you can remove log anaytics and/or HSM from the config file if not required.

> Note: Key Vault should be used for the keys to keep them out of the config files.