#bin/sh

read -p "Masukkanlah jumlah variasi published jboss= " publish
x=""
for i in `seq 1 $publish`
do
IFS=: read -p "Masukkan hostip$i:hostport$i:containerport$i= " -ra varians
x="-p ${varians[0]}:${varians[1]}:${varians[2]} "
done
sudo podman run --name=jboss-eap localhost/acme/jboss-eap -d $x &
