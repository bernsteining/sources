---
author: "bernstein"
title: "Homemade file sharing with ngrok"
slug: "homemade_filesharing_en"
date: 2020-01-28
status: "original"
repo: "no repo"
description: "Let's learn a handy tip with ngrok to share files temporarily"
---

# Homemade file sharing

Quite often, I want share files without having an account on the hosting platform I'm using, and I don't want my files to be persistant on the platform. I just want to share files temporarly and quickly to a friend using an URL.

An easy way to do so, is to use a ngrok tunnel, coupled with a simple HTTP server with Python.  
## ngrok, whatzdat?

[ngrok](https://ngrok.com/product) is a light software that allows us to create a tunnel for free between your computer and the Internet, without configuring your box's ports.
It allows us to expose temporarly a service, it's very handy to do tests or to demo an app. We can even choose the port on which ngrok will work, and the premium version has password & encryption features. It works on most of the distros (Windows / Mac OS / Linux).

### NB: 

For some distros, Python isn't installed by default, so you gotta install it : [https://www.python.org/downloads/](https://www.python.org/downloads/).
We're using Python here, but I'm sure there's a way to do so using other languages (Golang, Ruby ...) You can check by yourself

Add Python to your PATH variable, in order to to call it from anywhere.
## Sharing your directory 

First, download ngrok on the official website [sur le site officiel](https://ngrok.com/download), and uncompress the archive.

In the directory where ngrok is located, launch this command:

Linux & Mac OS: `./ngrok http <port\`
Windows: `ngrok.exe http <port>`

This should output something similar to:
ngrok.png
In the same directory, launch this command:
`python -m SimpleHTTPServer <port>`

Now, anyone having the URL has access (thanks to HTTP protocol) to the files in the directory.

directory.png

One has to click on the file to download it, we can even access to subfolders.

## Points positifs

A handy fact in comparison to filesharing services such as mega.nz, is that the URLs allows to download the files instantly, without any user interaction required. Thus, we're able to download the files using wget, curl, or any software using the HTTP protocol.

Also, ngrok has a monitoring dashboard hosts locally on [http://localhost:4040/](http://localhost:4040/) when ngrok is launched. It allows us to log the requests done on our URL.

Aussi, ngrok offre une interface web afin de monitorer son activité, hébergée localement sur [http://localhost:4040/](http://localhost:4040/) lorsque le service tourne. Elle permet notamment de logger les requêtes faites sur son URL ... 

## Going further

At the moment, we just coupled Python to ngrok with 1 command. But, as we said before, we could do way more complex things by having a server a bit more elaborated (which would handled HTTP POST requests for example) ... 

It can be very handy to expose a service other than filesharing !

## Bonus

Here's a small bash script automatizing the whole procedure ... ;)


    #!/usr/bin/env bash
    
    echo  "Downloading ngrok ..."
    wget -q https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
        
    echo  "Decompressing archive ..."
    unzip -q ngrok-stable-linux-amd64.zip    
    
    echo  "Launching ngrok ..."
    ./ngrok http 8000 | cat &
    
    echo  "Launching Python Server ..."
    python -m SimpleHTTPServer 8000 | cat &
   
    echo  "SUCCESS! Directory shared @:"
    echo  $(wget -qO- stdout http://127.0.0.1:4040/api/tunnels | jq -r '.tunnels[0].public_url')
     
    echo  "$(ps aux | grep ngrok | sed -n '1p')"
    
    echo  "$(ps aux | grep SimpleHTTPServer | sed -n '1p')"




 











