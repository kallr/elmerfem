# cmake script for finding MUMPS sparse direct solver
CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

MESSAGE(STATUS "Finding Mumps")

# Find root directory
IF (MUMPSROOT)
   SET(MUMPSLIB ${MUMPSROOT}/lib)
   SET(MUMPSINCLUDE ${MUMPSROOT}/include)
ELSEIF (DEFINED ENV{MUMPSROOT})
   SET(MUMPSLIB $ENV{MUMPSROOT}/lib)
   SET(MUMPSINCLUDE $ENV{MUMPSROOT}/include)
ELSE()
   SET(MUMPSLIB ${CMAKE_SOURCE_DIR}/mumps/lib)
   SET(MUMPSINCLUDE ${CMAKE_SOURCE_DIR}/mumps/include)
ENDIF()
 
# MESSAGE(STATUS "MUMPSINCLUDE set to ${MUMPSINCLUDE}")
# MESSAGE(STATUS "MUMPSLIB set to ${MUMPSLIB}")

# Try to find Mumps (real arithmetic version)
FIND_PATH(MUMPS_INCLUDE_PATH dmumps_struc.h HINTS ${MUMPSINCLUDE})
FIND_LIBRARY(MUMPS_D_LIB dmumps HINTS ${MUMPSLIB})
FIND_LIBRARY(MUMPS_COMMON_LIB mumps_common HINTS ${MUMPSLIB})
FIND_LIBRARY(MUMPS_PORD_LIB pord HINTS ${MUMPSLIB})

IF (MUMPS_INCLUDE_PATH AND MUMPS_D_LIB AND MUMPS_COMMON_LIB AND MUMPS_PORD_LIB) 
   SET(MUMPS_FOUND TRUE)
   SET(MUMPS_LIBRARIES ${MUMPS_D_LIB} ${MUMPS_COMMON_LIB} ${MUMPS_PORD_LIB})
ENDIF()
   
IF (MUMPS_FOUND)
   IF (NOT MUMPS_FIND_QUIETLY)
      MESSAGE(STATUS "A library with Mumps API found.")
      MESSAGE(STATUS "Mumps include dir: ${MUMPS_INCLUDE_PATH}")
      MESSAGE(STATUS "Mumps libraries: ${MUMPS_LIBRARIES}")
   ENDIF()
ELSE()
   IF (MUMPS_FIND_REQUIRED)
      MESSAGE(FATAL_ERROR "Mumps libraries not found.")
   ENDIF()
ENDIF()

MARK_AS_ADVANCED(MUMPS_INCLUDE_PATH MUMPS_LIBRARIES 
                 MUMPS_COMMON_LIB MUMPS_D_LIB MUMPS_PORD_LIB)