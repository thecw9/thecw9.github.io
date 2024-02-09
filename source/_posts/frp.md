---
title: "frp内网穿透"
top: true
summary: "管理密码"
---

Frp（Fast Reverse Proxy）是一种用于将本地服务暴露到公共网络的工具，通常用于实现内网穿透。以下是使用frp的基本步骤：

## frps.toml(客户端配置)

创建frps.toml文件，写入下面的内容：

```toml
bindPort = 7000
```

如果你想要访问Dashboard监控面板，添加下面的内容：

```toml
webServer.addr = "0.0.0.0"
webServer.port = 7500
webServer.user = "admin"
webServer.password = "admin"
```

在服务器上运行frp服务端：

```bash
sudo docker run --restart=always --network host -d -v ./frps.toml:/etc/frp/frps.toml --name frps snowdreamtech/frps
```

## frpc.toml(客户端配置)

创建frpc.toml文件，写入下面的内容：

```
serverAddr = "118.25.99.119"
serverPort = 7000

[[proxies]]
name = "ssh"
type = "tcp"
localIP = "127.0.0.1"
localPort = 22
remotePort = 6000

[[proxies]]
name = "vite-dev"
type = "tcp"
localIP = "127.0.0.1"
localPort = 5173
remotePort = 5173
```

在客户端运行frp客户端：

```bash
sudo docker run --restart=always --network host -d -v ./frpc.toml:/etc/frp/frpc.toml --name frpc snowdreamtech/frpc
```

上面的示例配置将本地的22和5173端口映射到frp服务器的6000和5173端口。你需要替换server_addr为你自己的服务器地址。

22端口是ssh服务默认端口，当客户端程序运行起来后，你可以通过以下命令ssh到客户端：

```bash
ssh -o Post=6000 <client-user>@<server-ip>
```

例如：

```bash
ssh -o Post=6000 thecw@118.25.99.119
```

还有一些客户端示例配置，你可以添加到配置文件中去：

```toml
[[proxies]]
name = "nginx"
type = "tcp"
localIP = "127.0.0.1"
localPort = 80
remotePort = 80

[[proxies]]
name = "fastapi"
type = "tcp"
localIP = "127.0.0.1"
localPort = 8000
remotePort = 8000
```
