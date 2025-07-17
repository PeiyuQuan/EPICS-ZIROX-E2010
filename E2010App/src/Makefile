TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += E2010Support

# Compile and add code to the support library
E2010Support_SRCS += xxxRecord.c
E2010Support_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
E2010Support_SRCS += dbSubExample.c
E2010Support_SRCS += devE2010Version.c
E2010Support_SRCS += E2010Hello.c
E2010Support_SRCS += initTrace.c

E2010Support_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = E2010Version.h
# Macro name
GENVERSIONMACRO = E2010VERSION

# Build the IOC application
PROD_IOC = E2010

# E2010.dbd will be created and installed
DBD += E2010.dbd

# E2010.dbd will include these files:
E2010_DBD += base.dbd
E2010_DBD += xxxSupport.dbd
E2010_DBD += dbSubExample.dbd
E2010_DBD += devE2010Version.dbd
E2010_DBD += E2010Hello.dbd
E2010_DBD += initTrace.dbd
E2010_DBD += asyn.dbd
E2010_DBD += drvAsynSerialPort.dbd
E2010_DBD += drvAsynIPPort.dbd
E2010_DBD += calc.dbd
E2010_DBD += stream-scalcout.dbd
E2010_DBD += stream.dbd
E2010_DBD += asSupport.dbd
# E2010_registerRecordDeviceDriver.cpp derives from E2010.dbd
E2010_SRCS += E2010_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
E2010_SRCS_DEFAULT += E2010Main.cpp
E2010_SRCS_vxWorks += -nil-

# Link in the code from our support library
E2010_LIBS += E2010Support
E2010_LIBS += asyn
E2010_LIBS += calc
E2010_LIBS += autosave
E2010_LIBS += stream

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into E2010Support
    sncExample_SNCFLAGS += +r
    E2010_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    E2010Support_SRCS += sncExample.stt
    E2010Support_LIBS += seq pv
    E2010_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    E2010_LIBS += qsrv
    E2010_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    E2010_DBD += PVAServerRegister.dbd
    E2010_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
E2010_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devE2010Version$(DEP): $(COMMON_DIR)/$(GENVERSION)
