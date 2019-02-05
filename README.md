# Unifi控制器
Unifi AP控制器,使用alpine制作最小镜像

## 端口说明

### L3&L2端口
|   端口    | 介绍              |
| :-------: | :---------------- |
|  80/tcp   | HTTP服务          |
|  443/tcp  | HTTPS服务         |
| 6789/tcp  | 控制器测速        |
| 63010/udp | STUN              |
| 63011/tcp | HTTP portal 服务  |
| 63012/tcp | HTTPS portal 服务 |

### L2端口
|   端口    | 介绍                                                                               |
| :-------: | :--------------------------------------------------------------------------------- |
| 10001/udp | Port used for AP discovery                                                         |
| 1900/udp  | Port used for "Make controller discoverable on L2 network" in controller settings. |

### 官方端口说明
[UniFi - Ports Used](https://help.ubnt.com/hc/en-us/articles/218506997-UniFi-Ports-Used)

## 使用

### 目录介绍
/unifi 主程序目录
/unifi/data 数据目录
/logs/server.log Unifi日志文件
/unifi/logs/mongod.log MongoDB日志文件

### 二层采用
```shell
docker run -itd --name unifi --network host angdo/unifi
```

### 三层采用
```shell
docker run -itd --name unifi \
    -p 80:80 -p 443:443 \
    -p 6789:6789 -p 63010:63010/udp \
    -p 63011:63011 -p 63012:63012 angdo/unifi
```
控制器inform地址 `http://ip/inform`

官方三层采用介绍 [UniFi - Device Adoption Methods for Remote UniFi Controllers](https://help.ubnt.com/hc/en-us/articles/204909754-UniFi-Device-Adoption-Methods-for-Remote-UniFi-Controllers)

## 反向代理
Caddy配置
```caddyfile
:80 {
  proxy /inform http://unifi_ip {
    transparent
  }
  redir 301 {
    if {path} not_match ^\/inform
    /  https://{host}{uri}
  }
  gzip
  log stdout
}

:443 {
  tls
  proxy / https://unifi_ip {
    insecure_skip_verify
    transparent
    websocket
  }
  gzip
  log stdout
}
```