## Synopsis
This project contains a Vagrantfile and a salt state directory that performs the following:
 - starts up a virtualbox VM using the hashicorp centos/7 box
 - does minor configuration/updates to the host using vagrant inline scripts to prep it for salt
 - runs the salt tree (locally, can also be configured to use a master quite easily)

## Installation
clone the repository down and run vagrant up
```bash
git clone https://github.com/gwojtak/exercise
cd exercise
vagrant up
```

The image also launches a web server to view Hadoop related service pages and can be reached at
```
http://localhost:8080/hadoop-services.html
```
