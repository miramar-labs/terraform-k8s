FORGET IAM OAuth



To generate the creds:

1. goto 'Service credentials' for COS instance
   create new
   specify {"HMAC":true} in the JSON box at the bottom


   it will generate creds like:


   {
  "apikey": "ZbTdUWqRmjZiWdZCDgWYz19N6GlUD5nJGGiz_jLjIJFL",
  "cos_hmac_keys": {
    "access_key_id": "fa08d6d8595940c5ad2bcf50fc21df6a",
    "secret_access_key": "002c846fa1c1b851c5679bbd596d6dcde91471d84d04956b"
  },
  "endpoints": "https://cos-service.bluemix.net/endpoints",
  "iam_apikey_description": "Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloud-object-storage:global:a/706155f46b5045a4aa1cdfe1c0bb6166:226a3808-abd7-403f-9d86-760012b69683::",
  "iam_apikey_name": "auto-generated-apikey-fa08d6d8-5959-40c5-ad2b-cf50fc21df6a",
  "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
  "iam_serviceid_crn": "crn:v1:bluemix:public:iam-identity::a/706155f46b5045a4aa1cdfe1c0bb6166::serviceid:ServiceId-ef4ef194-29ea-4995-be07-e22b35e87990",
  "resource_instance_id": "crn:v1:bluemix:public:cloud-object-storage:global:a/706155f46b5045a4aa1cdfe1c0bb6166:226a3808-abd7-403f-9d86-760012b69683::"
    }

2. in the acody-ibmc-trial-secret.yml file:

echo -n "fa08d6d8595940c5ad2bcf50fc21df6a" | base64 --> access-key
echo -n "002c846fa1c1b851c5679bbd596d6dcde91471d84d04956b" | base64 --> secret-key

3. import the secret

can test creds using the CLI:

AWS_ACCESS_KEY_ID="fa08d6d8595940c5ad2bcf50fc21df6a" AWS_SECRET_ACCESS_KEY="002c846fa1c1b851c5679bbd596d6dcde91471d84d04956b" aws s3 ls --endpoint-url https://s3-api.us-geo.objectstorage.softlayer.net s3://<bucket_name>

(remember buckets are in a global namespace so prefix with unique string)


3. test s3fs directly on worker node:
https://developer.ibm.com/recipes/tutorials/mounting-a-cos-bucket-with-s3fs/

echo fa08d6d8595940c5ad2bcf50fc21df6a:002c846fa1c1b851c5679bbd596d6dcde91471d84d04956b >  ~/.passwd-s3fs
chmod 600  ~/.passwd-s3fs

mount existing bucket:

sudo mkdir -p /mnt/test
sudo /usr/local/bin/s3fs aaron-bucket1 /mnt/test -o passwd_file=~/.passwd-s3fs -o cipher_suites=AESGCM -o sigv2 -o use_path_request_style -o url=https://s3.us-south.objectstorage.softlayer.net -o dbglevel=info -f -o curldbg


enable debugging:
sudo /usr/local/bin/s3fs aaron-bucket1 /mnt/test -o passwd_file=~/.passwd-s3fs -o sigv2 -o use_path_request_style -o url=https://s3.us-south.objectstorage.softlayer.net -o dbglevel=info -f -o curldbg

4. plugin logs:
`/var/log/ibmc-s3fs.log`
