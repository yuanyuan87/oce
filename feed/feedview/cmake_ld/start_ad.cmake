
ADD_SERVICE("AdUserCache/loader" "AdUserCacheLoader" ReplicaCluster FeedMemcClient OceSliceReplicaCluster OceSliceSubjectObserver IceExt OceSliceXceStorm DbCxxPool OceSlice TalkUtil OceSliceAdUserCache UtilCxx UtilSlice protobuf memcached OceProto)

ADD_DC_SERVICE("AdHot/notify" "AdNotify" OceSliceBuddyByIdCache OceSliceUserCount OceSliceAdNotify ReplicaCluster FeedMemcClient OceCxxAdapterBuddyByIdReplicaAdapter OceCxxAdapterUserCountAdapter IceExt OceSliceReplicaCluster OceProto OceSliceSubjectObserver OceSliceXceStorm DbCxxPool UtilCxx UtilSlice memcached protobuf)
ADD_DC_SERVICE("AdHot/gate" "AdHotGate" OceSliceUserCache OceSliceAdHot OceSliceUserCount OceSliceAdNotify OceCxxAdapterUserCacheAdapter OceCxxAdapterUserCountAdapter OceCxxAdapterAdNotifyAdapter OceCxxAdapterDistUserCacheReloaderAdapter OceCxxAdapterPassportAdapter FeedMemcClient NotifyUtil IceExt ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver OceSliceXceStorm DbCxxPool UtilCxx UtilSlice fcgi ctemplate boost_system protobuf)
ADD_SERVICE("AdHot/admin" "AdHotAdmin" OceSliceAdHot OceSliceAdNotify OceCxxAdapterAdNotifyAdapter OceCxxAdapterAdHotGateAdapter OceCxxAdapterPassportAdapter NotifyUtil IceExt ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver OceSliceXceStorm DbCxxPool UtilCxx UtilSlice fcgi ctemplate)

ADD_SERVICE("AdUnion/gate" "AdUnionGate" OceSliceAdUnion OceCxxAdapterPassportAdapter fcgi ctemplate NotifyUtil IceExt ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver OceSliceXceStorm DbCxxPool UtilCxx UtilSlice)
ADD_SERVICE("AdUnion/admin" "AdUnionAdmin" OceSliceAdUnion OceCxxAdapterAdUnionGateAdapter OceCxxAdapterPassportAdapter fcgi ctemplate NotifyUtil IceExt ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver OceSliceXceStorm DbCxxPool UtilCxx UtilSlice)

# 使用 FeedMemcClient
ADD_SERVICE("AdGate/src" "AdGate" OceSliceAdGate OceSliceAdUserCache OceSliceAdMatch OceCxxAdapterAdTwAdapter OceCxxAdapterAdMatchAdapter OceCxxAdapterAdUserCacheLoaderAdapter OceCxxAdapterPassportAdapter fcgi ctemplate NotifyUtil IceExt ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver FeedMemcClient OceSliceXceStorm DbCxxPool UtilCxx UtilSlice OceProto boost_system)

ADD_SERVICE("AdGateN/src" "AdGateN" OceSliceAdGate OceSliceAdUserCache OceSliceAdMatchN OceCxxAdapterAdMatchNAdapter OceCxxAdapterAdUserCacheLoaderAdapter OceCxxAdapterPassportAdapter fcgi ctemplate NotifyUtil IceExt ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver FeedMemcClient OceSliceXceStorm DbCxxPool UtilCxx UtilSlice boost_system)

#ADD_SERVICE("AdMatchN/src" "AdMatchN" OceCxxAdapterAdMatchNAdapter OceCxxAdapterAdLogAdapter OceCxxAdapterAdAnalysisAdapter ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver MemcClient IceExt OceSliceXceStorm DbCxxPool OceSlice TalkUtil UtilCxx UtilSlice breakpad)

ADD_SERVICE("ad/engine/src" "AdEngineS" OceCxxAdapterAdLogSAdapter ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver FeedMemcClient IceExt OceSliceXceStorm DbCxxPool OceSlice TalkUtil UtilCxx UtilSlice breakpad)

ADD_SERVICE("AdAnalysis/src" "AdAnalysis" OceCxxAdapterAdMatchAdapter OceCxxAdapterAdGateAdapter OceCxxAdapterAdAnalysisAdapter ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver FeedMemcClient IceExt OceSliceXceStorm DbCxxPool OceSlice TalkUtil OceSliceAdAnalysis OceCxxAdapterAdAnalysisAdapter UtilCxx UtilSlice protobuf memcached)

ADD_SERVICE("ad/gate/src" "AdGateS" ctemplate OceSliceAdGate OceSliceAdUserCache OceSliceAdEngine OceCxxAdapterAdTwSAdapter OceCxxAdapterAdEngineSAdapter OceCxxAdapterAdUserCacheLoaderAdapter OceCxxAdapterPassportAdapter fcgi NotifyUtil IceExt ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver FeedMemcClient OceSliceXceStorm DbCxxPool UtilCxx UtilSlice boost_system)

#ADD_SERVICE("ad/ip_test" "IpTest" ctemplate OceSliceAdGate OceSliceRFeed OceCxxAdapterFeedMiniAdapter OceSliceRFeed OceCxxAdapterFeedMiniAdapter OceSliceAdUserCache OceSliceAdEngine OceSliceFeedEdmSender OceCxxAdapterFeedEdmSenderAdapter OceCxxAdapterAdTwSAdapter OceCxxAdapterAdEngineSAdapter OceCxxAdapterAdUserCacheLoaderAdapter OceCxxAdapterPassportAdapter fcgi NotifyUtil IceExt ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver FeedMemcClient OceSliceXceStorm DbCxxPool UtilCxx UtilSlice boost_system)

TARGET_LINK_LIBRARIES(AdGateN "/opt/google-breakpad/src/client/linux/libbreakpad.a" )
TARGET_LINK_LIBRARIES(AdGateS "/opt/google-breakpad/src/client/linux/libbreakpad.a" )
#TARGET_LINK_LIBRARIES(IpTest "/opt/google-breakpad/src/client/linux/libbreakpad.a" )
