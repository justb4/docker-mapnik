FROM python:3.11-slim-bookworm

# A basic Mapnik Docker Image with
# - some extra fonts
# - PostGIS support
# - Mapnik Python bindings
# - FastAPI with Uvicorn support to build e.g. a WMS or other Map server
# Initially developed in the context of the map5topo.nl map project.

# By: Just van den Broecke - justb4@gmail.com - 2024 - GPL v3 licensed
# This image can be used in various ways: using Python Mapnik programs or even map services via web (FastAPI).

LABEL maintainer="Just van den Broecke <justb4@gmail.com>"

ARG TIMEZONE="Europe/Amsterdam"
ARG LOCALE="en_US.UTF-8"
# If you need to extend with extra packages
ARG ADD_DEB_PACKAGES=""

ENV TZ=${TIMEZONE} \
    DEBIAN_FRONTEND="noninteractive" \
    DEB_BUILD_DEPS="unzip curl fontconfig"  \
    DEB_PACKAGES="locales libmapnik-dev mapnik-utils python3-mapnik python3-pyproj python3-psycopg2 python3-yaml python3-fastapi python3-uvicorn"  \
	PROJ_DATA="/usr/share/proj" \
	PYTHONPATH="/usr/lib/python3/dist-packages" \
    FONT_PACKAGES="fonts-lato fonts-roboto fonts-roboto-slab" \
    FONT_TTF_DIR="/usr/share/fonts/truetype" \
    FONT_MUKTA="Mukta.Font.Family" \
    FONT_MUKTA_VERSION="2.538" \
	LANG=${LOCALE} \
	CHARSET="UTF-8" \
	LC_TIME="C.UTF-8"

RUN \
	apt update \
	&& apt install --no-install-recommends -y ${DEB_PACKAGES} ${FONT_PACKAGES} ${DEB_BUILD_DEPS} ${ADD_DEB_PACKAGES} \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
	&& echo "${LANG} ${CHARSET}" > /etc/locale.gen && locale-gen \
    && curl -L -k -v https://github.com/EkType/Mukta/releases/download/${FONT_MUKTA_VERSION}/${FONT_MUKTA}.${FONT_MUKTA_VERSION}.zip > /${FONT_MUKTA}.${FONT_MUKTA_VERSION}.zip \
    && unzip /${FONT_MUKTA}.${FONT_MUKTA_VERSION}.zip -d ${FONT_TTF_DIR}/  \
    && /bin/rm  /${FONT_MUKTA}.${FONT_MUKTA_VERSION}.zip && fc-cache \
    && apt-get remove --purge ${DEB_BUILD_DEPS} -y \
    && apt autoremove -y  \
	&& rm -rf /var/lib/apt/lists/* \
	&& echo "For ${TZ} date=`date`" && echo "Locale=`locale`"
