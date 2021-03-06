MACRO (ADD_CWF_SERVICE directoryname libraryname)
	AUX_SOURCE_DIRECTORY("${XNS_ROOT_DIR}/${directoryname}" BUILD_${directoryname}_SRC_CPP_SOURCE)
	ADD_LIBRARY(${libraryname} SHARED EXCLUDE_FROM_ALL ${BUILD_${directoryname}_SRC_CPP_SOURCE})
	TARGET_LINK_LIBRARIES(${libraryname} ${ARGN} libmemcached.so libprotobuf.a libzookeeper_mt.a libboost_system-gcc41-mt-1_38.so)
ENDMACRO (ADD_CWF_SERVICE)

MACRO (ADD_CWF_SERVICE_EXEC directoryname libraryname)
	MESSAGE(STATUS "DEBUG: ${ARGN}")
	AUX_SOURCE_DIRECTORY("${XNS_ROOT_DIR}/${directoryname}" BUILD_${directoryname}_SRC_CPP_SOURCE)
	ADD_EXECUTABLE(${libraryname} EXCLUDE_FROM_ALL ${BUILD_${directoryname}_SRC_CPP_SOURCE}) 
	TARGET_LINK_LIBRARIES(${libraryname} ${ARGN} libmemcached.so libprotobuf.a libzookeeper_mt.a libboost_system-gcc41-mt-1_38.so)
ENDMACRO (ADD_CWF_SERVICE_EXEC)

MACRO ( ADD_STATIC_LIB directoryname libraryname )
	AUX_SOURCE_DIRECTORY("${XNS_ROOT_DIR}/${directoryname}" BUILD_${libraryname}_SRC_CPP_SOURCE )
	ADD_LIBRARY( ${libraryname} STATIC EXCLUDE_FROM_ALL ${BUILD_${libraryname}_SRC_CPP_SOURCE})
	TARGET_LINK_LIBRARIES( ${libraryname} ${ARGN} )
ENDMACRO ( ADD_STATIC_LIB )

ADD_SERVICE("socialgraph/IPRecord/src/" "IPRecord" ReplicaCluster OceSliceIPRecord OceSlicePresence OceSliceTalkCommon OceSliceReplicaCluster OceSliceSubjectObserver OceSliceXceStorm DbCxxPool IceExt UtilCxx UtilSlice)
ADD_SERVICE("socialgraph/FriendFinderReplica/src" "FriendFinderReplica" OceCxxAdapterFriendFinderAdapter OceCxxAdapterBuddyCoreAdapter OceCxxAdapterBuddyByIdReplicaAdapter OceCxxAdapterFriendFinderByCommonReplicaAdapter ReplicaCluster OceSliceFriendFinder OceSliceBuddyCore OceSliceBuddyByIdCache OceSliceFriendFinderByCommon OceSliceReplicaCluster OceSliceSubjectObserver IceExt OceSliceXceStorm DbCxxPool OceSlice UtilCxx UtilSlice )
ADD_SERVICE("socialgraph/FriendFinderByIP/src/" "FriendFinderByIP" OceCxxAdapterIPRecordReplicaAdapter ReplicaCluster OceSliceIPRecord OceSliceFriendFinderByIP OceSliceReplicaCluster OceSliceSubjectObserver OceSliceXceStorm DbCxxPool IceExt UtilCxx UtilSlice)
ADD_SERVICE("socialgraph/FriendFinderByMSN/src/" "FriendFinderByMSN" OceCxxAdapterBuddyCoreAdapter ReplicaCluster OceSliceBuddyCore OceSliceFriendFinderByMSN OceSliceReplicaCluster OceSliceSubjectObserver OceSliceXceStorm DbCxxPool IceExt UtilCxx UtilSlice)
ADD_SERVICE("socialgraph/FriendFinderByCommon/src/" "FriendFinderByCommon" OceCxxAdapterBuddyByIdReplicaAdapter OceCxxAdapterFriendFinderReplicaAdapter ReplicaCluster OceSliceBuddyByIdCache OceSliceFriendFinder OceSliceFriendFinderByCommon OceSliceReplicaCluster OceSliceSubjectObserver OceSliceXceStorm DbCxxPool IceExt UtilCxx UtilSlice)
ADD_SERVICE_EXEC("socialgraph/IPCollector/src/" "IPCollector" OceCxxAdapterIPRecordReplicaAdapter OceCxxAdapterFriendFinderByIPReplicaAdapter ReplicaCluster OceSliceIPRecord OceSliceFriendFinderByIP OceSliceReplicaCluster OceSliceSubjectObserver OceSliceXceStorm DbCxxPool IceExt UtilCxx UtilSlice)
ADD_SERVICE_EXEC("socialgraph/UnivLinkFriends/src/" "UnivLinkFriends" OceCxxAdapterBuddyByAddTimeReplicaAdapter ReplicaCluster OceSliceBuddyByAddTimeCache OceSliceReplicaCluster OceSliceSubjectObserver OceSliceXceStorm DbCxxPool IceExt UtilCxx UtilSlice)
ADD_SERVICE("socialgraph/OfferFriends/cachen" "OfferFriendsCacheN" OfferCacheData OceCxxAdapterFriendFinderInfoCacheReplicaAdapter OceSliceFriendFinderInfoCache OceCxxAdapterIPRecordReplicaAdapter OceCxxAdapterFriendFinderByIPReplicaAdapter OceCxxAdapterBuddyByIdReplicaAdapter OceCxxAdapterFriendFinderReplicaAdapter OceCxxAdapterPhotoStateFilterAdapter OceCxxAdapterOfferFriendsAdapter OceCxxAdapterOnlineStateFilterAdapter OceCxxAdapterStatusCacheAdapter OceCxxAdapterUserStateFilterAdapter OceCxxAdapterFriendCountCacheReplicaAdapter ReplicaCluster OceSliceIPRecord OceSliceFriendFinderByIP OceSliceBuddyByIdCache OceSliceFriendFinder OceSlicePhotoStateFilter OceSliceOnlineStateFilter OceSliceStatusCache OceSliceUserStateFilter OceSliceOfferFriends OceSliceFriendCountCache OceSliceReplicaCluster OceSliceSubjectObserver OceSliceXceStorm IceExt UtilCxx UtilSlice DbCxxPool )
ADD_SERVICE("socialgraph/OfferFriends/loadern" "OfferFriendsLoaderN" OfferCacheData OceCxxAdapterFriendFinderInfoCacheReplicaAdapter OceSliceFriendFinderInfoCache OceCxxAdapterIPRecordReplicaAdapter OceCxxAdapterFriendFinderByIPReplicaAdapter OceCxxAdapterBuddyByIdReplicaAdapter OceCxxAdapterFriendFinderReplicaAdapter OceCxxAdapterPhotoStateFilterAdapter OceCxxAdapterOfferFriendsAdapter OceCxxAdapterOnlineStateFilterAdapter OceCxxAdapterStatusCacheAdapter OceCxxAdapterUserStateFilterAdapter OceCxxAdapterFriendCountCacheReplicaAdapter ReplicaCluster OceSliceIPRecord OceSliceFriendFinderByIP OceSliceBuddyByIdCache OceSliceFriendFinder OceSlicePhotoStateFilter OceSliceOnlineStateFilter OceSliceStatusCache OceSliceUserStateFilter OceSliceOfferFriends OceSliceFriendCountCache OceSliceReplicaCluster OceSliceSubjectObserver IceExt OceSliceXceStorm DbCxxPool UtilCxx UtilSlice uuid)
ADD_SERVICE_EXEC("socialgraph/friendfindernewcomerworker/collector" "FriendFinderNewComerCollector" OceCxxAdapterFriendFinderNewComerWorkerAdapter OceSliceSocialGraphWorker OceSliceSocialGraphMessage ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver DbCxxPool IceExt UtilCxx UtilSlice DbCxxPool OceSliceXceStorm )
ADD_SERVICE("socialgraph/friendfindernewcomerworker/src" "FriendFinderNewComerWorker" SocialGraphUtil SocialGraphProto OceCxxAdapterUserNetworkAdapter OceCxxAdapterFriendFinderInfoCacheReplicaAdapter OceSliceFriendFinderInfoCache OceCxxAdapterIPRecordReplicaAdapter OceCxxAdapterFriendFinderByIPReplicaAdapter OceCxxAdapterBuddyByIdReplicaAdapter OceCxxAdapterPhotoStateFilterAdapter OceCxxAdapterOnlineStateFilterAdapter OceCxxAdapterStatusCacheAdapter OceCxxAdapterUserStateFilterAdapter OceCxxAdapterFriendCountCacheReplicaAdapter ReplicaCluster OceSliceSocialGraphWorker OceSliceSocialGraphMessage OceSliceUserNetwork OceSliceIPRecord OceSliceFriendFinderByIP OceSliceBuddyByIdCache OceSlicePhotoStateFilter OceSliceOnlineStateFilter OceSliceStatusCache OceSliceUserStateFilter OceSliceFriendFinderNewComer OceSliceFriendCountCache IceExt OceSliceXceStorm DbCxxPool UtilCxx UtilSlice uuid Base libprotobuf.so libmemcached.so libzookeeper_mt.so libzookeeper_st.so libboost_system-gcc41-mt-1_38.so)

ADD_CWF_SERVICE("socialgraph/socialgraphlogic/src" "SocialGraphLogic" SocialGraphUtil Base OceCxxAdapterSocialGraphWorkerAdapter OceSliceSocialGraphLogic ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver IceExt DbCxxPool IceGrid UtilCxx UtilSlice OceSlice)

ADD_SERVICE("socialgraph/OfferFriends/preloader" "OfferFriendsPreloader" OfferCacheData ReplicaCluster OceSliceOfferFriends OceSliceReplicaCluster OceSliceSubjectObserver DbCxxPool IceExt UtilCxx UtilSlice DbCxxPool OceSliceXceStorm )
ADD_SERVICE_EXEC("socialgraph/OfferFriends/test" "OfferFriendsTest" OceCxxAdapterOfferFriendsAdapter ReplicaCluster OfferCacheData OceSliceOfferFriends OceSliceReplicaCluster OceSliceSubjectObserver DbCxxPool IceExt UtilCxx UtilSlice DbCxxPool OceSliceXceStorm )
ADD_SERVICE("socialgraph/FriendFinderInfoCache/FriendFinderInfoCache/src/" "FriendFinderInfoCacheReplica" OceCxxAdapterFriendFinderInfoWorkerReplicaAdapter OceSliceFriendFinderInfoWorker OceCxxAdapterBuddyByIdReplicaAdapter OceCxxAdapterFriendFinderByCommonReplicaAdapter ReplicaCluster OceSliceBuddyByIdCache OceSliceFriendFinderByCommon OceSliceFriendFinderInfoCache OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver IceExt IceGrid UtilCxx DbCxxPool UtilSlice OceSlice)
ADD_SERVICE("socialgraph/FriendFinderInfoCache/FriendFinderInfoWorker/src/" "FriendFinderInfoWorkerReplica" OceSliceFriendFinderInfoWorker OceCxxAdapterFriendFinderInfoCacheReplicaAdapter OceSliceFriendFinderInfoCache ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver IceExt DbCxxPool IceGrid UtilCxx UtilSlice OceSlice)
ADD_SERVICE_EXEC("socialgraph/FriendFinderInfoCache/FriendFinderInfoUpdater/src/" "FriendFinderInfoUpdater" OceCxxAdapterFriendFinderInfoWorkerReplicaAdapter OceSliceFriendFinderInfoWorker ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver IceExt DbCxxPool IceGrid UtilCxx UtilSlice OceSlice)
ADD_SERVICE("socialgraph/FriendFinderByActiveUser/FriendFinderByActiveUserWorker/src/" "FriendFinderByActiveUserWorker" OceCxxAdapterFriendFinderByActiveUserAdapter OceSliceFriendFinderByActiveUser OceSliceFriendFinderByActiveUserWorker ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver IceExt DbCxxPool IceGrid UtilCxx UtilSlice OceSlice)
ADD_SERVICE("socialgraph/FriendFinderByActiveUser/FriendFinderByActiveUser/src/" "FriendFinderByActiveUser" OceCxxAdapterHotFeedRecommendCacheAdapter OceCxxAdapterFriendRankCacheAdapter OceCxxAdapterFriendFinderInfoCacheReplicaAdapter OceCxxAdapterBuddyByIdReplicaAdapter OceSliceFriendFinderInfoCache OceSliceFriendFinderByActiveUser OceSliceBuddyByIdCache ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver IceExt DbCxxPool IceGrid UtilCxx UtilSlice OceSlice)
ADD_SERVICE_EXEC("socialgraph/FriendFinderByActiveUser/FriendFinderByActiveUpdater/src" "FriendFinderByActiveUpdater" OceCxxAdapterFriendFinderByActiveUserAdapter OceSliceFriendFinderByActiveUser OceCxxAdapterFriendFinderByActiveUserWorkerAdapter OceSliceFriendFinderByActiveUserWorker ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver IceExt DbCxxPool IceGrid UtilCxx UtilSlice OceSlice)
ADD_SERVICE("socialgraph/SocialFeed/SocialFeedCache/src" "SocialFeedCache" OceSliceSocialFeedCache ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver IceExt DbCxxPool IceGrid UtilCxx UtilSlice OceSlice)
ADD_SERVICE_EXEC("socialgraph/BirthdayRecommend/BirthdayRecommendUpdate/src" "BirthdayRecommendUpdate" OceCxxAdapterFriendRankCacheAdapter OceCxxAdapterBirthdayRecommendCacheAdapter OceCxxAdapterBuddyByIdReplicaAdapter OceSliceBirthdayRecommendCache OceSliceBuddyByIdCache ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver DbCxxPool IceExt IceGrid UtilCxx UtilSlice OceSlice)
ADD_SERVICE("socialgraph/BirthdayRecommend/BirthdayRecommendCache/src" "BirthdayRecommendCache" OceSliceBirthdayRecommendCache ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver DbCxxPool IceExt IceGrid UtilCxx UtilSlice OceSlice)

ADD_SERVICE("socialgraph/HotFeedRecommend/HotFeedRecommendCache/src" "HotFeedRecommendCache" OceSliceHotFeedRecommendCache ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver DbCxxPool IceExt IceGrid UtilCxx UtilSlice OceSlice)
ADD_SERVICE_EXEC("socialgraph/HotFeedRecommend/GetUgcFromDB/src" "GetUgcFromDB" OceCxxAdapterFriendRankCacheAdapter OceCxxAdapterBuddyByIdReplicaAdapter ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver DbCxxPool IceExt IceGrid UtilCxx UtilSlice OceSlice)
ADD_SERVICE_EXEC("socialgraph/HotFeedRecommend/create_recommend_list/src" "CreateRecommendList" Base OceCxxAdapterFriendRankCacheAdapter OceCxxAdapterBuddyByIdReplicaAdapter ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver DbCxxPool IceExt IceGrid UtilCxx UtilSlice OceSlice)
ADD_SERVICE_EXEC("socialgraph/HotFeedRecommend/add_visit_record/src" "AddVisitRecord" OceCxxAdapterFriendRankCacheAdapter OceCxxAdapterBuddyByIdReplicaAdapter ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver DbCxxPool IceExt IceGrid UtilCxx UtilSlice OceSlice)
ADD_SERVICE_EXEC("socialgraph/HotFeedRecommend/add_user_interests/src" "AddUserInterests" OceCxxAdapterFriendRankCacheAdapter OceCxxAdapterBuddyByIdReplicaAdapter ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver DbCxxPool IceExt IceGrid UtilCxx UtilSlice OceSlice)
ADD_SERVICE_EXEC("socialgraph/HotFeedRecommend/feed_recommend_update/src" "FeedRecommendUpdateWithInterest" OceCxxAdapterHotFeedRecommendCacheAdapter OceCxxAdapterFriendRankCacheAdapter OceCxxAdapterBuddyByIdReplicaAdapter ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver DbCxxPool IceExt IceGrid UtilCxx UtilSlice OceSlice)

ADD_SERVICE("socialgraph/PUKFeed/PUKFeedCache/src" "PUKFeedCache" OceSlicePUKFeedCache ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver DbCxxPool IceExt IceGrid UtilCxx UtilSlice OceSlice)
ADD_SERVICE_EXEC("socialgraph/PUKFeed/PUKFeedUpdate/src" "PUKFeedUpdate" OceCxxAdapterPUKFeedCacheAdapter OceCxxAdapterFriendRankCacheAdapter OceCxxAdapterBuddyByIdReplicaAdapter ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver DbCxxPool IceExt IceGrid UtilCxx UtilSlice OceSlice)
ADD_SERVICE("socialgraph/NegtiveList/NegtiveListCache/src" "NegtiveListCache" OceSliceNegtiveListCache ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver IceExt DbCxxPool IceGrid UtilCxx UtilSlice OceSlice)
ADD_SERVICE_EXEC("socialgraph/NegtiveList/NegtiveListUpdate/src" "NegtiveListUpdate" OceCxxAdapterNegtiveListCacheAdapter OceCxxAdapterHotFeedRecommendCacheAdapter OceCxxAdapterFriendRankCacheAdapter OceCxxAdapterBuddyByIdReplicaAdapter ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver DbCxxPool IceExt IceGrid UtilCxx UtilSlice OceSlice)
ADD_SERVICE_EXEC("socialgraph/SocialFeed/SocialFeedUpdate/src" "SocialFeedUpdate"
		OceCxxAdapterSocialFeedCacheAdapter OceSliceSocialFeedCache
		ReplicaCluster OceSlice UtilSlice DbCxxPool
		IceGrid Ice DbCxxPool IceExt UtilCxx UtilSlice)
ADD_SERVICE_EXEC("socialgraph/FriendRank/tool/PrintFriendRank" "PrintFriendRank"
		OceCxxAdapterFriendRankCacheAdapter OceCxxAdapterBuddyByIdReplicaAdapter
		OceCxxAdapterUserBasicAdapter OceSliceUserBase
		ReplicaCluster OceSlice IceExt UtilCxx UtilSlice DbCxxPool Ice)
ADD_SERVICE_EXEC("socialgraph/FriendRank/tool/StressTest" "StressTest"
		OceCxxAdapterFriendRankCacheAdapter OceCxxAdapterBuddyByIdReplicaAdapter
		ReplicaCluster OceSlice IceExt UtilCxx UtilSlice DbCxxPool Ice)
ADD_SERVICE_EXEC("socialgraph/FriendRank/tool/ReloadFriendRank" "ReloadFriendRank"
		OceCxxAdapterFriendRankLoaderAdapter
		ReplicaCluster OceSlice IceExt UtilCxx UtilSlice DbCxxPool Ice)
ADD_SERVICE("socialgraph/FriendRank/cache" "FriendRankCache"
		OceSliceFriendRank
		OceCxxAdapterFriendRankLoaderAdapter
		ReplicaCluster OceSliceXceStorm OceSliceSubjectObserver OceSliceReplicaCluster
		OceSlice DbCxxPool IceExt UtilCxx UtilSlice IceGrid Ice)
ADD_SERVICE("socialgraph/FriendRank/loader" "FriendRankLoader"
		OceCxxAdapterFriendRankCacheAdapter OceCxxAdapterBuddyByIdReplicaAdapter
		ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver OceSliceFriendRank
		OceSliceXceStorm IceExt OceSlice DbCxxPool UtilCxx UtilSlice IceGrid Ice)

ADD_STATIC_LIB("socialgraph/FriendRank/update/common" "FriendRankCommon")
ADD_STATIC_LIB("socialgraph/FriendRank/update/UserModelCreator" "FriendRankUserModelCreator")
ADD_STATIC_LIB("socialgraph/FriendRank/update/SessionSpliter" "FriendRankUserSessionSpliter")
ADD_STATIC_LIB("socialgraph/FriendRank/update/ActiveRankUpdater" "FriendRankUserActiveRankUpdater")
ADD_STATIC_LIB("socialgraph/FriendRank/update/StaticRankUpdater" "FriendRankUserStaticRankUpdater")
ADD_STATIC_LIB("socialgraph/FriendRank/update/FriendRankCreator" "FriendRankUserFriendRankCreator")
ADD_STATIC_LIB("socialgraph/FriendRank/update/FriendRankWriter" "FriendRankUserFriendRankWriter")
ADD_SERVICE("socialgraph/FriendRank/update" "FriendRankUpdate"
			OceCxxAdapterFriendRankLoaderAdapter OceCxxAdapterFriendRankCacheAdapter
			OceCxxAdapterStatusCacheAdapter
			OceCxxAdapterBuddyByIdReplicaAdapter
			OceCxxAdapterUserBasicAdapter
			FriendRankUserFriendRankWriter FriendRankUserFriendRankCreator
			FriendRankUserStaticRankUpdater
			FriendRankUserActiveRankUpdater FriendRankUserSessionSpliter
			FriendRankUserModelCreator FriendRankCommon
			OceSliceFriendRankUpdate
			ReplicaCluster OceSliceSubjectObserver OceSliceReplicaCluster
			OceSlice IceExt OceSliceXceStorm
			IceGrid Ice DbCxxPool UtilCxx UtilSlice)
ADD_SERVICE_EXEC("socialgraph/FriendRank/tool/Trigger" "FriendRankTrigger"
			OceCxxAdapterFriendRankUpdateAdapter
			ReplicaCluster OceSlice IceExt UtilCxx UtilSlice DbCxxPool Ice)

ADD_STATIC_LIB("socialgraph/autogroup/algorithm" "AGBase")
ADD_STATIC_LIB("socialgraph/autogroup/algorithm/util" "AGUtil")
ADD_STATIC_LIB("socialgraph/autogroup/algorithm/method" "AGMethod")
ADD_STATIC_LIB("socialgraph/autogroup/algorithm/method/impl" "AGImpl")
ADD_CWF_SERVICE("socialgraph/autogroup/server" "AutoGroupWorker" AGBase AGUtil AGImpl AGMethod SocialGraphProto SocialGraphUtil Base OceCxxAdapterBuddyByIdReplicaAdapter OceCxxAdapterUserNameAdapter OceCxxAdapterBuddyGroupAdapter OceCxxAdapterUserBasicAdapter OceCxxAdapterUserNetworkAdapter OceCxxAdapterUserBaseAdapter OceSliceBuddyCore OceSliceBuddyByIdCache ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver IceExt DbCxxPool IceGrid UtilCxx UtilSlice OceSlice)
ADD_CWF_SERVICE("socialgraph/autogroup/server2" "AutoGroup" AGBase AGUtil AGImpl AGMethod SocialGraphProto SocialGraphUtil Base OceCxxAdapterBuddyByIdReplicaAdapter OceCxxAdapterUserNameAdapter OceCxxAdapterBuddyGroupAdapter OceCxxAdapterUserBasicAdapter OceCxxAdapterUserNetworkAdapter OceCxxAdapterUserBaseAdapter OceSliceBuddyCore OceSliceBuddyByIdCache ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver IceExt DbCxxPool IceGrid UtilCxx UtilSlice OceSlice)

ADD_STATIC_LIB("socialgraph/friendfinderworker/algorithm/method" "FFMethod")
ADD_STATIC_LIB("socialgraph/friendfinderworker/algorithm/method/impl" "FFImpl")
ADD_STATIC_LIB("socialgraph/friendfinderworker/algorithm" "FFExecuter")
ADD_CWF_SERVICE_EXEC("socialgraph/friendfinderworker/exe" "CommonFriends" FFExecuter FFImpl FFMethod AGUtil SocialGraphProto SocialGraphUtil Base OceCxxAdapterBuddyByIdReplicaAdapter OceCxxAdapterUserNameAdapter OceCxxAdapterBuddyGroupAdapter OceCxxAdapterUserBasicAdapter OceCxxAdapterUserNetworkAdapter OceCxxAdapterUserBaseAdapter OceSliceBuddyCore OceSliceBuddyByIdCache ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver IceExt DbCxxPool IceGrid UtilCxx UtilSlice OceSlice)
ADD_CWF_SERVICE("socialgraph/friendfinderworker/server" "FriendFinderWorker" FFExecuter FFImpl FFMethod AGUtil SocialGraphProto SocialGraphUtil Base OceCxxAdapterBuddyCoreAdapter OceCxxAdapterBuddyByIdReplicaAdapter OceSliceBuddyCore OceSliceBuddyByIdCache ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver IceExt DbCxxPool IceGrid UtilCxx UtilSlice OceSlice)

ADD_CWF_SERVICE("socialgraph/homereconnect/writereconnect/server" "WriteReconnectWorker" SocialGraphProto SocialGraphUtil Base OceCxxAdapterBuddyCoreAdapter OceCxxAdapterBuddyByIdReplicaAdapter OceSliceBuddyCore OceSliceBuddyByIdCache ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver IceExt DbCxxPool IceGrid UtilCxx UtilSlice OceSlice)
ADD_CWF_SERVICE_EXEC("socialgraph/homereconnect/writereconnect/update" "WriteReconnect" SocialGraphProto SocialGraphUtil Base OceCxxAdapterFriendRankCacheAdapter OceCxxAdapterBuddyByIdReplicaAdapter ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver DbCxxPool IceExt IceGrid UtilCxx UtilSlice OceSlice)

ADD_CWF_SERVICE_EXEC("socialgraph/buddyrelationdb" "BuddyRelationDb" SocialGraphUtil Base ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver DbCxxPool IceExt IceGrid UtilCxx UtilSlice OceSlice)

ADD_SERVICE("socialgraph/friendcluster/worker/src" "FriendClusterWorker" SocialGraphProto SocialGraphUtil Base OceCxxAdapterBuddyCoreAdapter OceCxxAdapterBuddyByIdReplicaAdapter OceSliceBuddyCore OceSliceBuddyByIdCache ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver IceExt DbCxxPool IceGrid UtilCxx UtilSlice OceSlice libprotobuf.so libmemcached.so libzookeeper_mt.so libzookeeper_st.so libboost_system-gcc41-mt-1_38.so)  

ADD_SERVICE("socialgraph/friendcluster/cache" "FriendClusterCache" Base ReplicaCluster OceSliceXceStorm OceSliceReplicaCluster OceSliceSubjectObserver IceExt DbCxxPool IceGrid UtilCxx UtilSlice OceSlice libprotobuf.so libboost_system-gcc41-mt-1_38.so)  

