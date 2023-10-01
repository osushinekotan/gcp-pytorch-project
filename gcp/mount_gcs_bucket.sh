MOUNT_DIR="./data"
PROJECT_ID=""
BUCKET_NAME="gcp-pytorch-project"

gcloud config set project $PROJECT_ID
gcloud auth login

# バケットがなければ「作成する
if ! gsutil ls gs://$BUCKET_NAME; then
  gcloud storage buckets create gs://$BUCKET_NAME --location=us-central1
fi

# install gcsfuse 
export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s`
echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y fuse gcsfuse

sudo gcsfuse -o allow_other -file-mode=777 -dir-mode=777 $BUCKET_NAME $MOUNT_DIR
