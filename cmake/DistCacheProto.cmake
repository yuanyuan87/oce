
SET( XNS_PROTO_LIB_NAME "DistCacheProto")
SET( DISTCACHEPROTO_SRC_DIR "${XNS_ROOT_DIR}/DistCache/distributedcache/protobuf")
SET( DISTCACHEPROTO_CC_DIR "${XNS_BUILD_DIR}/tmp/${XNS_PROTO_LIB_NAME}/cc")
FILE( MAKE_DIRECTORY ${DISTCACHEPROTO_CC_DIR} )
#
# Proto
#
FILE( GLOB proto_source RELATIVE ${DISTCACHEPROTO_SRC_DIR} "${DISTCACHEPROTO_SRC_DIR}/*.proto" )
SET ( XNS_DISTCACHEPROTO_SOURCE_FILES ${proto_source} CACHE INTERNAL "DistCacheProto proto files" FORCE)


#
# Cc
#
MESSAGE( STATUS "Planning to build cc version of Proto interfaces ${XNS_PROTO_LIB_NAME}." )

INCLUDE( ${XNS_CMAKE_DIR}/protobuf_rules.cmake )

GENERATE_PROTOC_RULES( ${DISTCACHEPROTO_SRC_DIR} ${DISTCACHEPROTO_CC_DIR} proto_generated_sources
proto_generated_headers ${XNS_DISTCACHEPROTO_SOURCE_FILES} )
ADD_LIBRARY(DistCacheProto ${proto_generated_sources})
#SET_TARGET_PROPERTIES( OceProto PROPERTIES LINKER_LANGUAGE C )
#TARGET_LINK_LIBRARIES(OceProto ${PROTOBUF_LIBRARY})
