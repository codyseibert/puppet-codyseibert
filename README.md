
yum install ruby
gem install r10k
yum install git

r10k puppetfile install -v

puppet apply --modulepath=/home/modules -e "include codyseibert::profile::prod"
