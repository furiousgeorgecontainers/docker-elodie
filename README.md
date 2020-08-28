# elodie-docker

![Build Status](https://github.com/furiousgeorgecontainers/docker-elodie/workflows/CI/badge.svg)

## Description

An implementation of [elodie](https://github.com/jmathai/elodie) in a docker container.

This container is meant to be run at the command-line - there is no need/benefit to run it detatched (in the unRAID docker tab, for example).

The Elodie repository does have the start of a docker container but I could not get it to work.  I created this container to use elodie in my own environment.  If the Elodie repository releases an official docker image I may retire this repository.

## Directories

This docker container makes use of 3 directories:

* ```/config``` - The location of Elodie's configuration files
* ```/input```  - The location of your incoming images
* ```/output``` - The location Elodie will place processed images

These directories can be mounted to the corresponding directories on your host.  The sample wrapper script (see the next section for information) will map these directories for you.

**Note**: It could be ideal to mount the input directory as read only to prevent elodie from modifying input files, however, at the current time, elodie will fail if it is unable to write to the input directory.  If elodie is changed in the future to not require 

## Wrapper script

A sample wrapper script is also provided to assist you in running elodie in the docker container.  As long as you have docker running on your system, you should not need to install anything else - simply download the wrapper script (or create something like it) and it will pull the elodie-docker container for you if it does not exist and run the container.

The wrapper script is located [here](https://github.com/furiousgeorgecontainers/elodie-docker/raw/master/elodie.sh)

There is no need to clone this repository - all of the files (except the wrapper script) are only used to build the docker image - they are not needed to run the container.

### Getting the Wrapper Script

**NOTE: YOU SHOULD NOT BLINDLY DOWNLOAD A SCRIPT AND EXECUTE IT ON YOUR SYSTEM.  PLEASE VERIFY THE SCRIPT IS NOT DOING ANYTHING EVIL BEFORE FOLLOWING THESE INSTRUCTIONS.**  

The safer way would be to write your own wrapper script, but if you have inspected the script and wish to use it, do something like this:

```
wget -O elodie.sh https://github.com/furiousgeorgecontainers/elodie-docker/raw/master/elodie.sh
chmod +x ./elodie.sh
```

If you do not have wget and would like to use curl:

```
curl -L -o elodie.sh https://github.com/furiousgeorgecontainers/elodie-docker/raw/master/elodie.sh
chmod +x ./elodie.sh
```

### Wrapper Script Configuration

Configure the variables at the top of the script before running to set the locations of your directories (config, input, output).

### Wrapper Script Execution

To run elodie in the docker container, just run the wrapper script and give it the arguments to pass to elodie in the container.

### Example wrapper script run

It is important to remember that the /input and /output directories in the container will be mapped to different directories on your host.  The arguments you give elodie in the running container should have the directories relative to the container: /input and /output.  You should not give the path to the directories on your host as arguments to this wrapper script.  If you want to change which directories the container is mapped to, see the Wrapper Script section above.

For full documentation on elodie's usage, see the [Usage section](https://github.com/jmathai/elodie#usage-instructions) in the Elodie repository.

Below are some quick examples of how to run the wrapper script to execute elodie in the docker container.

##### Usage

*Running the wrapper script without arguments will cause elodie in the docker container to display its help screen.*

```
./elodie.sh
```

##### Import

```
./elodie.sh import --debug --source=/input --destination=/output
```

## Development

If you would like to build the docker image yourself, run the following commands:

```
git clone https://github.com/furiousgeorgecontainers/docker-elodie.git
cd elodie
docker build -t furiousgeorge/elodie .
```
