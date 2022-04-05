/*地域*/
variable "rg-location" {}

/*リソースグループ*/
variable "rg-name-01" {}
variable "rg-name-02" {}
variable "rg-name-hub" {}

/*仮想ネットワーク*/
variable "vnet-name-01" {}
variable "vnet-name-02" {}
variable "vnet-name-hub" {}

/*仮想ネットワークゲートウェイ*/
variable "vgw-hub" {}

/*ER*/
variable "erc-hub" {}

/*Azure Firewall*/
variable "fw-hub" {}

/*NetworkWatcher*/
variable "nw-01" {}

/*ルートテーブル*/
variable "routetable-name-01" {}
variable "routetable-name-02" {}
variable "routetable-name-hub" {}
variable "routetable-name-fw" {}

/*共通基盤*/
variable "storage-name-base" {}
variable "LA-name-base" {}
variable "EH-name-base" {}

/*仮想マシン*/
variable "vm-name-01" {}
variable "vm-name-02" {}
variable "admin-username" {}
variable "admin-password" {}