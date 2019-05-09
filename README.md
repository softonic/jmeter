# Description
Images to be used with [kubernauts/jmeter-operator](https://github.com/kubernauts/jmeter-operator). This images includes
the plugin manager to allow slaves and master to have the plugins that you need. 

# How to build the base image
## Without plugins
```
docker build -t softonic/jmeter-plugin-manager-base:${VERSION} .
```
## With plugins
```
docker build --build-arg PLUGINS="<plugin-id-1> <plugin-id-2>..." -t softonic/jmeter-plugin-manager-base:${VERSION} .
``` 

# How to build master and slave with the plugins from the image base
```
docker build -t softonic/jmeter-plugin-manager-slave:${VERSION} ./slave
docker build -t softonic/jmeter-plugin-manager-master:${VERSION} ./master
```
