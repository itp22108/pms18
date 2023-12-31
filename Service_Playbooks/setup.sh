#!/bin/bash

influx <<EOF
CREATE DATABASE influx;
CREATE USER telegraf WITH PASSWORD 'pms18project';
EOF

sudo rm /etc/telegraf/telegraf.conf

sudo dd of=/etc/telegraf/telegraf.conf << CONF
[global_tags]
[agent]
  interval = "10s"
  round_interval = true
  metric_batch_size = 1000
  metric_buffer_limit = 10000
  collection_jitter = "0s"
  flush_interval = "10s"
  flush_jitter = "0s"
  precision = ""
  hostname = ""  
  omit_hostname = false

[[outputs.influxdb]]
   urls = ["http://127.0.0.1:8086"]
   database = "influx"
   timeout = "5s"
   username = "telegraf"
   password = "pms18project"

[[outputs.prometheus_client]]
    listen = ":9273"
    metric_version = 2

[[inputs.cpu]]  
  percpu = true  
  totalcpu = true  
  collect_cpu_time = false  
  report_active = false

[[inputs.disk]]
  ignore_fs = ["tmpfs", "devtmpfs", "devfs", "iso9660", "overlay", "aufs", "squashfs"]

[[inputs.diskio]]
[[inputs.kernel]]
[[inputs.mem]]
[[inputs.processes]]
[[inputs.swap]]
[[inputs.system]]

 [[inputs.exec]]
   commands = ["/top_script.sh"]
   timeout = "5s"
   name_override = "linux_top"   
   data_format = "value"   
   data_type = "string"

 [[inputs.net]]
      interfaces = ["enp0s3"]
CONF

sudo systemctl restart telegraf
