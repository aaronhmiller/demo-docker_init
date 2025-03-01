# Exploring the Power of Docker Init

Thanks to [this article](https://livingdevops.com/devops/docker-init-to-write-dockerfile-docker-compose/) I was inspired to explore having someone (something?) 
else write my Dockerfile and compose.yaml files. And I was not disappointed
(granted I needed to make liberal use of [claude.ai](https://claude.ai) to help me write the basic 
'hello world' webapps in the various languages and frameworks) but it was a
great way to explore the power of the Docker's init command that greatly 
simplifies the containerization of an assumed pre-existing webapp project.

## What is here

As of early 2025, the following templates were available and I ran through each
one:

- dotnet
- go
- java
- node
- php
- python
- rust
  
manually added
- deno

I then tested locally and built containers for both ARM and AMD CPU
architectures and loaded them into [Docker Hub](https://hub.docker.com/u/aaronhmiller).

## Use cases

It's always instructive to have specific examples of the technical stacks
available because subtle differences exist and being able to quickly fiddle with
the settings to learn about the cause and effect relationships between the
various components is the best way to building trustworthy, reliable software.

## Next steps

~~Add Deno (my personal favorite right now)~~ 

Let's see what happens!
