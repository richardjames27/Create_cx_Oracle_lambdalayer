# Create a cx_Oracle Lambda Layer

This script will build a working cx_Oracle AWS Lambda Layer bundled with the Oracle instant client for python version 3.9.10 - you can build it in Cloud9 or wherever. The layer won't work if built on a Mac M1 as it's not x86 architecture.

You can adjust for other Python versions (3.6 and above). 

Also note:

1) You need to add an environment variable to your lambda: 
  LD_LIBRARY_PATH = /var/lang/lib:/lib64:/usr/lib64:/var/runtime:/var/runtime/lib:/var/task:/var/task/lib:/opt/lib:/opt/python
2) You need to update your lambda's PATH variable to include ["/opt/python","/opt/lib"]
3) And of course your lambda will need to be launched in the appropriate VPC, security group and subnets.
