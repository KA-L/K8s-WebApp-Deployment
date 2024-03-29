$script_master = <<-SCRIPT
sudo apt-get update

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl

sudo swapoff -a
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

echo "192.168.50.10 k8s-master" >> /etc/hosts
echo "192.168.50.11 k8s-worker1" >> /etc/hosts

sudo sysctl net.bridge.bridge-nf-call-iptables=1
sudo sysctl net.ipv4.ip_forward=1

sudo systemctl mask swap.img.swap


curl -LJO https://github.com/KA-L/K8s-WebApp-Deployment/archive/main.zip

sudo apt-get install -y unzip
unzip K8s-WebApp-Deployment-main.zip

cd K8s-WebApp-Deployment-main
sudo chmod +x ./initialize_master.sh

SCRIPT


$script = <<-SCRIPT
sudo apt-get update

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl

sudo swapoff -a
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

echo "192.168.50.10 k8s-master" >> /etc/hosts
echo "192.168.50.11 k8s-worker1" >> /etc/hosts

sudo sysctl net.bridge.bridge-nf-call-iptables=1
sudo sysctl net.ipv4.ip_forward=1

sudo systemctl mask swap.img.swap

SCRIPT






Vagrant.configure("2") do |config|

  # Configuration du master
  config.vm.provision "shell", inline: $script_master
  config.vm.define "master" do |master|
    master.vm.box = "bento/ubuntu-20.04"
    master.vm.hostname = "k8s-master"
    master.vm.network "private_network", ip: "192.168.50.10"
    master.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
      vb.name = "master"
    end
  end

  # Configuration du worker
  config.vm.provision "shell", inline: $script
  config.vm.define "worker" do |worker|
    worker.vm.box = "bento/ubuntu-20.04"
    worker.vm.hostname = "k8s-worker"
    worker.vm.network "private_network", ip: "192.168.50.11"
    worker.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
      vb.name = "worker"
    end
  end
end
