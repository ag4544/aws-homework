variable "token" {
  type = string
}

variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "zone" {
  type = string
  default = "ru-central1-c"
}

variable "ssh_public_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDH5CMZWHy43hE5oThNglwAIBM0poJHfTR1SJZuago0R/T+ph+RvSegQb8vMUBq1bLu884pzfrLnHzYZof8ZQxYKEEmkSRxlVtUkHyT0vbzY794wa8ZVsY4MbjoUMf0cJjBB/bAkeHKzZq+J+A542AMN9QF11Z8jkJTRHbGEhQVY2qmklAt4xSVnJ5DEu0h4vYc52D9i6liQcTATvyJ4EkH8dxIEmwQDqU41G3QJyXCczboZcfHVVACPQyLeew/A6dhzKkJwfQjMLUNhhGDI0pP63g81Tt++qynsevnUNAprRJaqBLdNIgNLtZ7pIZrzWG5kfdCE/04AtdKAO9mwKm1"
}