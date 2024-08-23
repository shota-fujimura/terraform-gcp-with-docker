#!/bin/bash
echo -e '\n\n//===========================================';
echo -e '// START_[$ terraform init(prod)]';
echo -e '//===========================================';
cd /terraform/src/environment/prod
terraform init
cd ../../../..

echo -e '\n\n//===========================================';
echo -e '// START_[$ terraform init(staging)]';
echo -e '//===========================================';
cd /terraform/src/environment/staging
terraform init
cd ../../../..

echo -e '\n\n//===========================================';
echo -e '// START_[$ terraform init(dev)]';
echo -e '//===========================================';
cd /terraform/src/environment/dev
terraform init
cd ../../../..

echo -e '\n\n//===========================================';
echo -e '// SHOW_environment';
echo -e '//===========================================';
echo '$GOOGLE_APPLICATION_CREDENTIALS=' $GOOGLE_APPLICATION_CREDENTIALS

tail -f /dev/null