#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Cookbook Name:: 7-zip
# Recipe:: default
#
# Copyright 2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

windows_package node['7-zip']['package_name'] do
  source node['7-zip']['url']
  checksum node['7-zip']['checksum']
  version "9.20.00.0"
  options "/quiet INSTALLDIR=\"#{node['7-zip']['home']}\""
  notifies :run, "windows_batch[associate 7zip]"
  Chef::Log.info("Installing #{node['7-zip']['package_name']} #{node['7-zip']['package_name']} ")
  action :install
end


# update path
windows_path node['7-zip']['home'] do
  action :add
end

cookbook_file "#{Chef::Config[:cookbook_path]}/7-zip/7z.reg" do
    source "7z.reg"
    mode "0644"
    action :create_if_missing
end

windows_batch "associate 7zip" do
  code <<-EOH
for /d %%A in (7z,arj,bz2,bzip2,cab,cpio,deb,dmg,gz,gzip,hfs,iso,lha,lzh,lzma,rar,rpm,split,swm,tar,taz,tbz,tbz2,tgz,tpz,wim,xar,z,zip) do assoc .%%A=7-zip.%%A
reg import #{Chef::Config[:cookbook_path]}/7-zip/7z.reg
    EOH
    action :nothing
end