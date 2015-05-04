# Destroy vagrant
vagrant destroy -f

# Copy user-data
mv user-data user-data.old
cp user-data.app user-data

# Update etcd endpoint
curl https://discovery.etcd.io/new

# Start cluster
vagrant up
