#!/bin/bash

# Variables
db="wordpress"
user="wordpress"
droot="/var/www/wordpress/"
d=$(date +%Y%m%d_%H%M%S)
s3_bucket_name="blez-state-file"
profile="new"

# creating backup directory"

mkdir /root/$d

cd $droot

# Take DB backup
mysqldump -u $user -p $db > $d-db.sql

# take full backup
tar -cvzf /root/$d/wordpress-$d.tar.gz $droot

#backup file copy to S3 bucket
aws s3 cp   /root/$d/wordpress-$d.tar.gz   s3://$s3_bucket_name  --profile=$profile

#Delete th backup file from local 
rm -rf /root/$d
