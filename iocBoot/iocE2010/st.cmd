#!../../bin/linux-x86_64/E2010

#- You may have to change E2010 to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/E2010.dbd"
E2010_registerRecordDeviceDriver pdbbase

## Load record instances
epicsEnvSet ("STREAM_PROTOCOL_PATH", "${TOP}/E2010App/Db")
epicsEnvSet ("PREFIX", "SLAC:E2010:")
epicsEnvSet ("PORT", "serial1")
epicsEnvSet ("M", "zirox1:")
#- Set this to see messages from mySub
#var mySubDebug 1
drvAsynIPPortConfigure("serial1", "192.168.0.35:4002<192.168.0.35:4002/> COM", 0, 0, 0)
#drvAsynSerialPortConfigure("serial1","/dev/ttyUSB0",0,0,0)
asynOctetSetInputEos("serial1",0,"\r")
asynOctetSetOutputEos("serial1",0,"\r")
asynSetOption("serial1",0,"baud","9600")
asynSetOption("serial1",0,"bits","8")
asynSetOption("serial1",0,"stop","1")
asynSetOption("serial1",0,"parity","none")
#asynSetOption("serial1",0,"clocal","Y")
asynSetOption("serial1",0,"crtscts","N")


#- Run this to trace the stages of iocInit
#traceIocInit

dbLoadRecords("${TOP}/E2010App/Db/ZIROXE2010.db","P=$(PREFIX),M=$(M),PORT=serial1")
dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db", "P=SLAC:E2010:")
dbLoadRecords("$(ASYN)/db/asynRecord.db", "P=$(PREFIX),R=asyn1,PORT=serial1,ADDR=0,IMAX=80,OMAX=80")


cd "${TOP}/iocBoot/${IOC}"
iocInit

