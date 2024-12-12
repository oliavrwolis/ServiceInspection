ARG ARG IMAGE=intersystemsdc/irishealth-community
FROM $IMAGE as builder
USER ${ISC_PACKAGE_MGRUSER}
RUN python3 -m pip install --target /usr/irissys/mgr/python xlutils
RUN python3 -m pip install --target /usr/irissys/mgr/python xlrd
RUN python3 -m pip install --target /usr/irissys/mgr/python psutil
RUN python3 -m pip install --target /usr/irissys/mgr/python reportlab



WORKDIR /opt/ServiceInspection

COPY --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /src /opt/ServiceInspection/src
COPY --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} iris.script iris.script
COPY --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} user /usr/irissys/csp/user
RUN iris start IRIS \
    && iris session IRIS < iris.script \
    && iris stop IRIS quietly

