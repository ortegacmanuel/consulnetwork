# Consulnetwork

Mini proyecto realizado para el Hackathon de la conferencia [ConsulCon](http://ciudades-democraticas.cc/consulcon/) 2017.

# Objetivo

El objetivo de este proyecto es animar un debate sobre la creación de herramientas
para visualizar la red de ciudades que utilizan la herramienta de participación ciudadana
[Consul](http://consulproject.org/en/).

Este mini proyecto visualiza en su página principal un listado compuesto por la última
propuesta publicada en cada una de las instalaciones de la red de ciudades que actualmente están usando [Consul](https://github.com/consul/consul).

Puedes ver el proyecto funcionando en está [url](https://consulnetwork.herokuapp.com/). Recuerda que es una instalación de prueba y puede ser un poco lento ;)

# Configuration for development and run this app locally

Prerequisites: install git, Ruby 2.4.1 and bundler gem

```
git clone git@github.com:ortegacmanuel/consulnetwork.git
cd consulnetwork
bundle
rackup
open http://localhost:9292 to check the project on your browser
```
