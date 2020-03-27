# Jupyterhub on DigitalOcean to serve notebooks for a course

Many of us use jupyter notebooks to teach classes and we often serve them through `mybinder.org` because all of our students experience the same environment no matter what platform they use. The only problem with binder is that any changes the students make to their notebooks are not recorded if their session times out - the student session on binder is *not persistent* across sessions. 

Persistence does introduce some complications - every user has to be identified so that their session can be restored. Someone has to provide secure access and long-lived storage on top of the required computational environment.   

This is an attempt to provide a template to build a cheap-and-cheerful jupyter-notebook server that can handle the needs of a medium sized class. Following this template means that the class coordinator can focus on the content rather than the setup. 

## Description

This repository can build itself into a digital ocean droplet that runs (the littlest) jupyterhub with the underlying dependencies that you specify in a conda environment `yml` file. The configuration of the droplet
is stored in the repository secret variables. Github actions are configured to monitor the repository and update
the content of the server when changes to the configuration are pushed. The actions also check to see if the server
is alive and well. 

This template repository contains sample content that runs on a dedicated droplet ... the status of that droplet
is autoatically monitored:
 
![Health check](https://github.com/ANU-RSES-Education/droplet-template/workflows/Health%20check/badge.svg)


## How to use this template

The full set of instructions is given in the [Documentation](Documentation) folder. The steps are:

  - Create a suitable server ([instructions are for a Digital Ocean droplet](Documentation/DigitalOcean.md))
  - Make a clone of this template repository (See [Github.md](Documentation/Github.md))
  - Update the cloned repository with information about the server that you have set up
  - Commit the updates on Github to trigger the build / rebuild of the content of the server
  - Create links for `nbgitpuller` for users of the server and test them (See [nbgitpuller.md](Documentation/nbgitpuller.md )) 
  - Add your users to the `jupyterhub` ([ManagingUsers.md](Documentation/ManagingUsers.md))


## Try out the Nbgitpuller

To make a "binder-like" link to a repository on a droplet that you have set up, you can do this:
You can launch this example to try it out by clicking on this link. Your work is persistent. 

http://128.199.153.60/hub/user-redirect/git-pull?repo=https%3A%2F%2Fgithub.com%2FANU-RSES-Education%2Fdroplet-template&urlpath=tree%2Fdroplet-template%2FStartHere.ipynb&branch=master
