# docker-mapnik

![GitHub license](https://img.shields.io/github/license/justb4/docker-mapnik)
![GitHub release](https://img.shields.io/github/release/justb4/docker-mapnik.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/justb4/mapnik.svg)

Debian Docker image with Mapnik, including Mapnik Python bindings, PostGIS backend support, 
and mapping API support via FastAPI. All via apt-installs.

Docker Images are available at: https://hub.docker.com/repository/docker/justb4/mapnik/
# Image Tags and Versions

Image tag convention: `<mapnik-version>-<buildnr>`, for example

* `justb4/mapnik:3.1.0-1`
* `justb4/mapnik:3.1.0-2` etc

Initially developed in the context of the [map5topo.nl](https://map5topo.nl) map development project
to directly test Mapnik rendering.

This image can be used in various ways: using Python Mapnik 
programs or even map services like WMS emulation via web (FastAPI).

By: Just van den Broecke - justb4@gmail.com - 2024 - GPL v3 licensed
