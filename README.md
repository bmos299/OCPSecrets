Pre-req:
https://github.com/bmos299/CertificateGenerator

This is meant to be used when you are generating secrets and applying to your ocp cluster. This script will generate the required
.yaml files, generate the secret and apply to the cluster. So make sure you are logged into your OCP cluster already.

To use this put create_secret .sh and all_secrets.sh in the root where all the directories were created from certgenerator
From there do a chmod +X on the 2 files
Run the following command ./all_secrets.sh
