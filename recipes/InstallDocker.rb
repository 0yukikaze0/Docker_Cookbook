#
# Cookbook:: Docker_Cookbook
# Description : Installs Docker V1.13 into centos/RHEL
# Recipe:: InstallDocker
# Author : Ashfaq Ahmed Shaik
#
# Copyright:: 2017, The Authors, All Rights Reserved.
packages = ['docker', 'docker-selinux']
rpm_files = ['docker-engine-selinux-1.13.1-1.el7.centos.noarch.rpm', 'docker-engine-1.13.1-1.el7.centos.x86_64.rpm']

#
# Some version of RHEL may contain an outadated docker engine
# Uninstall these outdated packages
#
packages.each do |package|
  yum_package package do
    action :remove
  end
end

#
# Copy RPM files from local files directory
#
rpm_files.each do |rpm_file|
  cookbook_file '/tmp/' + rpm_file do
    source rpm_file
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
end

#
# Start installing docker packages from rpm's
#
rpm_files.each do |rpm_file|
  execute 'Installing ' + rpm_file do
    command 'yum install -y /tmp/' + rpm_file
    action :run
  end
end
