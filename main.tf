# Copyright (c) 2023 VEXXHOST, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

module "query" {
  #checkov:skip=CKV_TF_1

  source  = "vexxhost/mysql-query/kubernetes"
  version = "0.1.0"

  image                     = var.image
  job_name                  = "${var.username}-mysql-user-init"
  job_namespace             = var.job_namespace
  hostname                  = var.hostname
  root_password_secret_name = var.root_password_secret_name

  query = <<-EOT
    CREATE USER IF NOT EXISTS '$DATABASE_USERNAME'@'%' IDENTIFIED BY '$DATABASE_PASSWORD';
    ALTER USER '$DATABASE_USERNAME'@'%' IDENTIFIED BY '$DATABASE_PASSWORD';
  EOT
  env = {
    DATABASE_USERNAME = var.username
    DATABASE_PASSWORD = var.password
  }
}
