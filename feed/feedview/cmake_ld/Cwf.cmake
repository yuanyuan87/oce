FILE( GLOB BUILD_SRC_CPP_SOURCE "${XNS_ROOT_DIR}/cwf/*.cc" )

ADD_LIBRARY( "Cwf" ${BUILD_SRC_CPP_SOURCE})
