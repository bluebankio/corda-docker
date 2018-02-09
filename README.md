# corda-docker
Based on Ubuntu 16.04, non-root user and tested in Kubernetes and OpenShift.

## Usage
Certificates, plugins and node.conf should be added to child images or mounted as volumes on container.

## Supported tags and respective `Dockerfile` links

* `1.0` [_(1.0/Dockerfile)_](https://github.com/bluebankio/corda-docker/tree/1.0)
* `2.0`, `latest` [_(2.0/Dockerfile)_](https://github.com/bluebankio/corda-docker/tree/2.0)

## Quick reference
Documentation: [Corda Docs v1.0](https://docs.corda.net/releases/release-V1.0/) or [Corda Doc v2.0](https://docs.corda.net/releases/release-V2.0/)

Where to get help: [Corda Community Slack](https://slack.corda.net/), [Corda Discourse Forum](https://discourse.corda.net/)

Where to file issues: [Github Issues page](https://github.com/corda/corda-docker/issues?q=is%3Aopen+is%3Aissue)

Maintained by: bluebank.io

## What is Corda?
A distributed ledger made up of mutually distrusting nodes would
allow for a single global database that records the state of deals and obligations
between institutions and people. This would eliminate much of
the manual, time consuming effort currently required to keep disparate
ledgers synchronised with each other. It would also allow for greater levels
of code sharing than presently used in the financial industry, reducing
the cost of financial services for everyone

https://docs.corda.net/

![](https://camo.githubusercontent.com/a7b7d659d6e01a9e49ff2d9919f7a66d84aac66e/68747470733a2f2f7777772e636f7264612e6e65742f77702d636f6e74656e742f75706c6f6164732f323031362f31312f66673030355f636f7264615f622e706e67)

## Using this image
### Starting up the image
* `docker build -t corda . ` - this will create a base image called "corda"
* `docker run -it --rm --name corda corda ` - this will start up an interactive container using the base image you built

## Child images
If you want to do more with this base image, you will need to add the required corda files. The image expects `/opt/corda/plugins`, `/opt/corda/certificates`, `/opt/corda/logs`, `/opt/corda/corda.jar` and `opt/corda/node.conf`. There are two ways you can reference these files and folders in your image.

### Copying files directly
You can copy the required files across directly into the image from a local directory - see below.

```
FROM bluebankio/corda-docker

# Copying required folders
COPY /plugins/ /opt/corda/plugins
COPY /certificates/ /opt/corda/certificates
COPY /logs/ /opt/corda/logs

# Copying required files
COPY /corda.jar /opt/corda
COPY /node.conf /opt/corda
```
### Mounting a volme
You could also mount a volume that uses a fixed location for the files to be referenced to. For this you will need to state where the volumes will stay, and then reference that location on start - see below.

```
docker build -t corda . 
docker run -it --rm --name corda corda -v plugins:/opt/corda/plugins -v certificates:/opt/corda/certificates -v logs:/opt/corda/logs -v corda.jar:/opt/corda -v node.conf:/opt/corda
```


## Image Variants
### corda: {version} (latest)
This is the default image, enough to get you started. If you want to do more than what is in this image, please use the steps mentioned above.

### corda:v1.0
This image is using corda v1.0 as the base. Please see [here](https://docs.corda.net/releases/release-V1.0/) for further information on v1.0 of corda.

### corda:v2.0
This image is using corda v1.0 as the base. Please see [here](https://docs.corda.net/releases/release-V2.0/) for further information on v2.0 of corda.

## Acknowledgments and Authors
This project acknowledges the contributions provided by
- [Wawrzek Niewodniczanski](https://github.com/wawrzek)
- [Ben Abineri](https://github.com/benabineri)
- [przemolb](https://github.com/przemolb)
- [Gary Rowe](https://github.com/gary-rowe)
- [Ben Wyeth](https://github.com/nimmaj)
- [Fuzz Pezeshkpour](https://github.com/dazraf)
- [Mark Simpson](https://github.com/Bartman250)
- [Richard Crook](https://github.com/pinkgrass)
- [Ramiz Amad](https://github.com/ramiz99)
- [Sal Badakhchani](https://github.com/sbadakhc)

## License

View [license information](https://github.com/bluebankio/corda-docker/) for the software contained in this image.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
