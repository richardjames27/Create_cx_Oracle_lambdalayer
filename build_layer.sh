# in your amazonlinux environment

sudo yum -y groupinstall "Development Tools"
sudo yum -y install gcc openssl-devel bzip2-devel libffi-devel wget tar gzip which make zip
sudo mkdir /src

# build version 3.9.10 as an alternate python install:
sudo cd /src && sudo wget https://www.python.org/ftp/python/3.9.10/Python-3.9.10.tgz && sudo tar xzf Python-3.9.10.tgz
sudo cd /src/Python-*/
./configure --enable-optimizations
sudo make altinstall

sudo rm -f /src/Python-3.9.10.tgz

# create virtual environment from python 3.9.10
cd /usr/local/bin
virtualenv -p /usr/local/bin/python3.9 ~/venv
cd ~/
source venv/bin/activate
python -m pip install pip --upgrade

# install cx_Oracle to separate directory
python -m pip install cx_Oracle -t python

# download and install oracle instant client
wget https://download.oracle.com/otn_software/linux/instantclient/193000/instantclient-basic-linux.x64-19.3.0.0.0dbru.zip -O oracle.zip
unzip -j oracle.zip -d lib/
cp /lib64/libaio.so.1 lib/libaio.so.1

# zip the layer and push to s3
zip -r -y cx_oracle_py39.zip python/ lib/
aws s3 cp cx_oracle_py39.zip s3://<your_bucket_name>/lambda-layers/cx_oracle_py39.zip

# optional -- build your layer from here:
#aws lambda publish-layer-version --layer-name test_cx_oracle --description "My cx_Oracle layer" --content S3Bucket=<your_bucket_name>,S3Key=lambda-layers/cx_oracle_py39.zip --compatible-runtimes python3.9 --region <your_aws_region>

