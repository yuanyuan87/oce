
FILE( GLOB BUILD_DISTCACHE_SRC_CPP_SOURCE "${XNS_ROOT_DIR}/DistCache/distributedcache/src/main/cpp/*.cpp" )

GENERATE_ARCHIVE_EACH( DistCacheCxxAdapter "${BUILD_DISTCACHE_SRC_CPP_SOURCE}")
#ADD_LIBRARY( DistCacheCxxAdapter ${BUILD_DISTCACHE_SRC_CPP_SOURCE})
