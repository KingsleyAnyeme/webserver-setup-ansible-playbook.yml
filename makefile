1. luanch the 3 ubuntu servers
   - we luanch 1 ubuntu server as our CONTROLLER
   - we launch 2 ubuntu servers as our Nodes
   - we allocate our keypair
   - we set a SG for our servers with SSH
   - optional; add a ping protocol to our permissions
2. On our servers
   - Rename servers for identification
   - ssh into first our CONTROLLER
3. Setting up our CONTROLLER
   - sudo yum install python3 and python
   - renaming hostname with cmmd "sudo hostnamectl set-hostname ANSIBLE_CONTROLLER" and exit for name to take effect.
4. install ansible on our CONTROLLER
https://aws.amazon.com/premiumsupport/knowledge-center/ec2-enable-epel/
   sudo yum update
   sudo amazon-linux-extras install epel -y
   sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
   sudo yum install ansible
   ansible --version

   - $ sudo apt update
   - $ sudo apt install software-properties-common
   - $ sudo add-apt-repository --yes --update ppa:ansible/ansible
   - $ sudo apt install ansible
   - ansible --version
5. generating key-pair
   - sudo -i (switching to root user)
   - ssh-keygen -t rsa (generating keypair on ubuntu)
   - cd .ssh
   ls -l
   > we want ot save the key on (/root/.ssh/id_rsa)
   - "cd /root/.ssh/" as "root" to see the keys 
6. we copy the generated public key to the clients/Nodes
   - ssh into the each clients as ec2-user
   - "sudo hostnamectl set-hostname ANSIBLE-CLIENT1"
   - "exit" for the change to take effect
   - ssh again. call back the commands.
   - we "cat id_rsa.pub" on the controller at "/root/.ssh/ and copy pub key
   - we chane to "sudo -i"
   - "cd .ssh" on first Nodes
   - "cat authorized_keys" - we see fingerprint of other keys
   - "vi authorized_keys". follow steps to insert, paste, save and quite. "esc, :wq
   - we do same for the other Nodes
7. Modify the inventory of our host (ansible-controller)
   - "ansible --version" and copy the path of the config file "/etc/ansible/
   - "cd /etc/ansible/
   - ls -l
   - "cat hosts"
   - "vi hosts"
   - copy the priv ip of our nodes and add them to the inventory of the ansible controller.
8. Test connectivity "root-user"
   - "ifconfig" on the node to grap the private ip 
   - "ssh root@priv.ip" on the ansible controller. our prompt changes to the of the node.
   - "exit" to come back to the ansible-controller from the ssh
   - "ansible -m ping all" we ping to test connectivity in linux
   - "ansible -m ping ubuntu-nodes" to ping a group of inventory resources.
   cd ../--
   cd  : to get to root

9. ANSIBLE PLAYBOOK ANATOMY
   - user-data for apache
     yum update -y
     yum install -y httpd
     systemctl start httpd
     systemctl enable httpd
     echo "Hello Class, Do Not Be like the Finnish Weather" > /var/www/html/index.html 

   - user-data for ubuntu 
     apt update -y 
     apt install -y httpd 
     systemctl start httpd
     systemctl enable httpd
     echo "Hello Class, Do Not Be like the Finnish Weather" > /var/www/html/index.html

To echo, we use "copy builtin" module from the ansible docs.
For src: "mkdir web-os " at "root" on "controller"
- In dir "web-os", create a file : "echo ___ > index.html
- We update our src path as it is on our controller on our play.
- In dir "web-os", vi __ PLAYBOOK____.yml

10. run our PLAYBOOK
    - ansible-playbook __filename__.yml 

11. Using ansible variables.
> '{{ apache_package }}', 

12. Using ansible-conditions
- docs.ansible.com/ansible/latest/playbook_guide/playbooks_conditionals.html

13. Handlers; Handlers are piece of module that only runs when notified. only run when there is a change. 
> Handlers are specific to the play. 
> look at : ansible builtin service for "restart httpd"
- create section "handler: " and paste the repeated mudle under it.
- to call handler; we need to get notify. maKE SURE IT ALIGNS WITH TASK.
- we asdd "notify: as part of a task.
- example; notify:
             - restart httpd

13. Roles
- Role is a framework to organise your ansible playbook.
- roles are re-usable module
- role is way of structuring your code

   

