terraform {
<<<<<<< HEAD
  required_version = ">= 1.3.0"
=======
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.39"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2, >= 1.2.22"
    }
  }
>>>>>>> b1b7f352d1a813b3aee03a72a16d8f387a14e16e
}
