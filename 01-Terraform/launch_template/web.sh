#! /bin/bash
cat > index.html << EOF
<H1> Hello,world </H1>
EOF

nohup busybox httpd -f -p ${server_port} &
