cat mypassword.txt | sudo podman login quay.io --username yosuaalvin90 --password-stdin
sudo podman tag localhost/acme/jboss-eap quay.io/yosuaalvin90/jboss-eap-6.4.0
sudo podman push quay.io/yosuaalvin90/jboss-eap-6.4.0
sudo podman pull quay.io/yosuaalvin90/jboss-eap-6.4.0
sudo podman run --name jboss-eap-dev -d quay.io/yosuaalvin90/jboss-eap-6.4.0 &
