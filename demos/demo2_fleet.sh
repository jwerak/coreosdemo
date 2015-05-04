# add ssh-key
ssh-add ~/.vagrant.d/insecure_private_key

# Show fleet run script
curl https://gist.githubusercontent.com/veverjak/f28db0b93120a96ba8d0/raw/8d3660642e1b67aee5ac7aa4474cfec7a2965804/run_app.sh

# List machines in cluster
fleetctl --strict-host-key-checking=false --tunnel=172.17.8.101 list-machines

# Submit/Start units
fleetctl --strict-host-key-checking=false --tunnel=172.17.8.101 submit units/app@.service
fleetctl --strict-host-key-checking=false --tunnel=172.17.8.101 start app@1.service
fleetctl --strict-host-key-checking=false --tunnel=172.17.8.101 journal -f app@1.service

# Change key to demonstrate that app is working
etcdctl set /test test

# Start more units
for i in {2..4}; do fleetctl --strict-host-key-checking=false --tunnel=172.17.8.101 start app@$i.service; done

# Global unit
fleetctl --strict-host-key-checking=false --tunnel=172.17.8.101 submit units/globalapp.service
fleetctl --strict-host-key-checking=false --tunnel=172.17.8.101 start globalapp.service

# Add host
