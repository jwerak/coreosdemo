# WRITE/READ values from etcd
etcdctl set /test test
etcdctl get /test

# Run container
docker run -it -p 5000:5000 -v /etc/ip:/etc/ip -v /usr/bin/etcdctl:/usr/bin/etcdctl python /bin/bash

# In container - Install app
pip install flask && curl https://gist.githubusercontent.com/veverjak/b8607526f071f296bd8c/raw/52dd97718f1f7e46c5f7d04888ca02c74bea7225/get_file_content.py -o /app.py

# Read value from within container
etcdctl --peers `cat /etc/ip`:4001 get /test > /test && python /app.py /test


# React on changes in etcd
cat << EOF > /run.sh
#!/bin/bash
while true; do
  etcdctl --peers `cat /etc/ip`:4001 get /test > /test
  if [[ -n \$PID ]];
    then kill -9 \$PID;
  fi
  python /app.py /test &
  PID=\`echo \$!\`
  etcdctl --peers `cat /etc/ip`:4001 watch /test
done
EOF
