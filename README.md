# README

* Ruby version 2.5.1p57

* Rails version 5.2.0

* Database initialization
You need to create your own config/database.yml or copy sample(config/database.yml.sample) default db for development is sqlite3
You can also use seeds for creating fake information with Faker

* How to run the test suite
Just type "rspec" in folder with project

* How to index search
rake ts:index

* Deployment instructions
<br/>
[Ubuntu 16.04]<br/>
Buy hosting, connect to them with ssh
# create new_user
adduser user_name<br/>
# give user a sudo previlege with
visudo<br/>
# change ssh port
nano /etc/ssh/sshd_config<br/>
and change port value

exit

// login with new user<br/>

// create ssh-key<br/>
ssh-keygen<br/>

// send them to server
<br/>
cat ~/.ssh/id_rsa.pub | ssh -p server_ssh_port user_name@server_ip 'cat /home/user_name/.ssh/authorized_keys'

// then upgrade system<br/>
sudo apt-get update<br/>
sudo apt-get upgrade<br/>

#configure time zone
sudo dpkg-reconfigure tzdata

# swap creation(optional)
sudo dd if=/dev/zero of=/swap bs=1M count=1024<br/>
sudo mkswap /swap<br/>
sudo swapon /swap<br/>


# instalation packages
sudo apt-get install curl<br/>
curl -L get.rvm.io | bash -s stable<br/>
source /home/web/.rvm/scripts/rvm<br/>
rvm requirements<br/>
rvm install nedded_ruby_version<br/>
rvm use nedded_ruby_version --default<br/>
sudo apt-get install postgresql postgresql-contrib postgresql-server-dev-9.5<br/>
sudo -u postgres psql
// change postgres password<br/>
alter user postgres with password postgres_password;<br/>
sudo apt-get install git-core<br/>
// install passenger-nginx<br/>
gem install passenger<br/>
sudo apt-get install libcurl4-openssl-dev<br/>
rvmsudo passenger-install-nginx-module<br/>

// then edit nginx conf<br/>
sudo nano /opt/nginx/conf/nginx.conf<br/>
// here enter sever name(server_ip or domain)<br/>
// and root for your app<br/>
root /home/web/stackoverflow/current/public; // example<br/>

// and add passenger enabling <br/>
passenger_enabled on;<br/>

// nginx controll<br/>
git clone https://github.com/vkurennov/rails-nginx-passenger-ubuntu.git<br/>
sudo cp rails-nginx-passenger-ubuntu/nginx/nginx /etc/init.d/<br/>
sudo chmod +x /etc/init.d/nginx<br/>
sudo rm -r -f rails-nginx-passenger-ubuntu

// for nginx manipalating
sudo /etc/init.d/nginx [start, stop, status ...]<br/>
sudo apt-get install redis-server<br/>
sudo cp /etc/redis/redis.conf /etc/redis/redis.conf.default<br/>
sudo service redis-server restart<br/>
sudo apt-get install sphinxsearch<br/>
sudo apt-get install 

// mailer<br/>
sudo apt-get install exim4-daemon-light mailutils<br/>
sudo dpkg-reconfigure exim4-config 0
