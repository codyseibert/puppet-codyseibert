#!/bin/bash
curl -sL https://rpm.nodesource.com/setup_5.x | bash -
rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
yum install -y nodejs git ruby puppet vim
npm install -g pm2
gem install r10k
