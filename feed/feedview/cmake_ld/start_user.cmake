ADD_SERVICE("user/UserLogic/src" "UserLogic"
	OceCxxAdapterCardInfoCacheAdapter
	OceCxxAdapterCardImportCacheAdapter
	OceCxxAdapterFriendOfFriendIndexerAdapter OceSliceFriendOfFriendIndexer
	OceCxxAdapterPresenceMsgHandlerAdapter
	OceCxxAdapterUserAdsCacheLoaderAdapter
	OceCxxAdapterUserCountAdapter OceSliceUserCount
	OceCxxAdapterCompleteUserInfoAdapter OceSliceCompleteUserInfo
  OceCxxAdapterTalkCacheLoaderAdapter OceSliceTalkCacheLoader
	OceCxxAdapterTalkRightAdapter OceSliceTalkRight
	OceCxxAdapterCharityAdapter OceSliceCharity OceSliceUserBase
	OceCxxAdapterPresenceMsgHandlerAdapter OceCxxAdapterIqMsgHandlerAdapter OceSliceTalkLogic
	OceCxxAdapterBuddyByIdReplicaAdapter OceSliceBuddyByIdCache
	OceCxxAdapterBuddyGroupAdapter OceSliceBuddyGroup
	OceCxxAdapterStatusCacheAdapter OceSliceStatusCache
	OceCxxAdapterBuddyByNameReplicaAdapter OceSliceBuddyByNameCache
	OceCxxAdapterPhotoStateFilterAdapter OceSlicePhotoStateFilter
	OceCxxAdapterUserStateFilterAdapter OceSliceUserStateFilter
	OceCxxAdapterHighSchoolFilterAdapter OceSliceHighSchoolFilter
	OceCxxAdapterInviteRewardAdapter OceSliceInviteReward
	OceCxxAdapterUserCacheReloaderAdapter
	OceCxxAdapterDistUserCacheReloaderAdapter
	OceCxxAdapterDistSearchLogicAdapter
	OceCxxAdapterDistUserApiCacheReloaderAdapter
	OceCxxAdapterUserApiCacheLoaderAdapter
	OceCxxAdapterScoreCacheAdapter OceSliceScoreCache
	OceCxxAdapterFriendFinderNewComerWorkerAdapter OceSliceSocialGraphWorker OceSliceSocialGraphMessage
	OceCxxAdapterSearchLogicAdapter OceSliceSearchCache OceSliceUserCache
	ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver
	IceExt OceSliceXceStorm DbCxxPool OceSlice UtilCxx UtilSlice)
ADD_SERVICE("user/UserApiCount/src" "UserApiCount" ReplicaCluster OceCxxAdapterBatchUpdaterUserApiCountReplicaAdapter OceSliceBatchUpdater OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserApiCount IceExt OceSliceXceStorm DbCxxPool UtilCxx UtilSlice)
ADD_SERVICE_EXEC("user/UserActive/src" "UserActive" ReplicaCluster OceCxxAdapterUserStateAdapter OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserBase DbCxxPool IceExt OceSliceXceStorm  UtilCxx UtilSlice)
ADD_SERVICE("user/UserCount/src" "UserCount" OceCxxAdapterBatchUpdaterNotifyCountAdapter OceCxxAdapterBatchUpdaterUserCountReplicaAdapter ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver OceSliceBatchUpdater OceSliceUserCount IceExt OceSliceXceStorm DbCxxPool UtilCxx UtilSlice)
ADD_SERVICE("user/UserBase/src" "UserBase" OceCxxAdapterUserLogicAdapter ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver OceCxxAdapterBatchUpdaterAdapter OceSliceUserBase OceSliceUserLogic OceSliceBatchUpdater IceExt OceSliceXceStorm DbCxxPool UtilCxx UtilSlice mysqlpp)
ADD_SERVICE("user/UserBase/agent" "UserBaseAgent" ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver OceCxxAdapterUserPassportAdapter OceCxxAdapterUserBasicAdapter OceCxxAdapterUserRightAdapter OceCxxAdapterUserStateAdapter OceCxxAdapterUserNameAdapter OceCxxAdapterUserStageAdapter OceCxxAdapterUserUrlAdapter OceCxxAdapterUserBornAdapter OceCxxAdapterUserDoingAdapter OceCxxAdapterUserBaseAdapter OceSliceUserBase OceSliceBatchUpdater IceExt OceSliceXceStorm DbCxxPool UtilCxx UtilSlice mysqlpp)
ADD_SERVICE("user/UserDesc/src" "UserDesc" OceCxxAdapterUserLogicAdapter ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserLogic OceSliceUserDesc IceExt OceSlice OceSliceXceStorm DbCxxPool UtilCxx UtilSlice OceCommon mysqlpp)
ADD_SERVICE("user/UserDanger/src" "UserDanger" OceCxxAdapterUserLogicAdapter OceCxxAdapterRceMonitorDispatcherAdapter ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserLogic OceSliceUserDanger IceExt OceSlice OceSliceXceStorm DbCxxPool UtilCxx UtilSlice OceCommon mysqlpp)
#ADD_DC_SERVICE_EXEC("user/UserCache/dist/check" "checkDistUserCache" OceProto ReplicaCluster OceCxxAdapterWapOnlineAdapter OceCxxAdapterPresenceAdapter OceCxxAdapterUserCacheAdapter OceCxxAdapterDistUserCacheReloaderAdapter OceCxxAdapterStatusCacheAdapter ReplicaCluster OceCxxAdapterDistUserCacheReloaderAdapter OceCxxAdapterUserCacheReloaderAdapter OceCxxAdapterUserBaseAdapter OceSliceUserCache OceSliceWapOnline OceSlicePresence OceSliceUserBase OceSliceReplicaCluster OceSliceSubjectObserver OceSlicePresence OceSliceTalkCommon OceSliceStatusCache IceExt OceSliceXceStorm DbCxxPool OceSliceUserCache TalkUtil UtilCxx UtilSlice )
ADD_DC_SERVICE("user/UserCache/dist/reloader" "DistUserCacheReloader" OceProto ReplicaCluster OceCxxAdapterStatusCacheAdapter OceCxxAdapterWapOnlineAdapter OceCxxAdapterUserBaseAdapter OceCxxAdapterOnlineBitmapAdapter OceSliceStatusCache ReplicaCluster OceSliceUserCache OceSliceWapOnline OceSliceReplicaCluster OceSliceSubjectObserver OceSlicePresence OceSliceTalkCommon OceSliceUserBase IceExt OceSliceXceStorm DbCxxPool OceSliceUserCache TalkUtil UtilCxx UtilSlice )
ADD_DC_SERVICE("user/UserApiCache/dist/reloader" "DistUserApiCacheReloader" OceProto ReplicaCluster ReplicaCluster OceSliceUserApiCache OceSliceReplicaCluster OceSliceSubjectObserver IceExt OceSliceXceStorm DbCxxPool TalkUtil UtilCxx UtilSlice )
ADD_SERVICE("user/UserCache/src" "UserCache" OceCxxAdapterUserCacheReloaderAdapter ReplicaCluster OceCxxAdapterPresenceAdapter OceSliceReplicaCluster OceSliceSubjectObserver OceSlicePresence OceSliceTalkCommon IceExt OceSliceXceStorm DbCxxPool OceSliceUserCache TalkUtil UtilCxx UtilSlice)
ADD_DC_SERVICE("user/UserCache/agent" "UserCacheAgent" OceCxxAdapterUserCacheAdapter OceCxxAdapterDistUserCacheReloaderAdapter ReplicaCluster OceCxxAdapterPresenceAdapter OceSliceReplicaCluster OceSliceSubjectObserver OceSlicePresence OceSliceTalkCommon IceExt OceSliceXceStorm DbCxxPool OceSliceUserCache TalkUtil UtilCxx UtilSlice)
ADD_DC_SERVICE("user/UserCache/reloader" "UserCacheReloader" OceCxxAdapterWapOnlineAdapter OceCxxAdapterUserBaseAdapter OceCxxAdapterPresenceAdapter OceCxxAdapterUserCacheAdapter OceCxxAdapterDistUserCacheReloaderAdapter ReplicaCluster OceSliceWapOnline OceSliceUserBase OceSliceReplicaCluster OceSliceSubjectObserver OceSlicePresence OceSliceUserBase OceSliceTalkCommon IceExt OceSliceXceStorm DbCxxPool OceSliceUserCache TalkUtil UtilCxx UtilSlice)
ADD_SERVICE("user/UserCache/preloader" "UserCachePreloader" OceCxxAdapterPresenceAdapter ReplicaCluster  OceSliceReplicaCluster OceSliceSubjectObserver OceSlicePresence OceSliceUserCache OceSliceTalkCommon IceExt OceSliceXceStorm DbCxxPool TalkUtil UtilCxx UtilSlice)
ADD_SERVICE("user/UserAdsCache/src" "UserAdsCache" ReplicaCluster OceCxxAdapterPresenceAdapter OceCxxAdapterUserAdsCacheLoaderAdapter OceSliceReplicaCluster OceSliceSubjectObserver OceSlicePresence OceSliceTalkCommon IceExt OceSliceXceStorm DbCxxPool OceSliceUserAdsCache TalkUtil UtilCxx UtilSlice)
ADD_SERVICE_EXEC("user/UserAdsCache/data" "testUserAdsCache" ReplicaCluster OceCxxAdapterUserAdsCacheAdapter OceSliceReplicaCluster OceSliceSubjectObserver OceSlicePresence OceSliceTalkCommon IceExt OceSliceXceStorm DbCxxPool OceSliceUserAdsCache TalkUtil UtilCxx UtilSlice)
ADD_SERVICE("user/UserApiCache/src" "UserApiCache" OceCxxAdapterUserApiCacheReloaderAdapter ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver IceExt OceSliceXceStorm DbCxxPool OceSliceUserApiCache UtilCxx UtilSlice)
ADD_SERVICE("user/UserApiCache/reloader" "UserApiCacheReloader" OceCxxAdapterUserApiCacheAdapter ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver IceExt OceSliceXceStorm DbCxxPool OceSliceUserApiCache UtilCxx UtilSlice)
ADD_SERVICE("user/UserConfig/src" "UserConfig" ReplicaCluster OceCxxAdapterUserLogicAdapter OceSliceUserLogic OceSliceReplicaCluster OceSliceSubjectObserver IceExt OceSliceXceStorm DbCxxPool OceCommonUserConfigCommon OceSliceUserConfig UtilCxx UtilSlice)
ADD_SERVICE("user/UserNetwork/serialize" "UserNetworkSE" ReplicaCluster OceCxxAdapterUserLogicAdapter OceSliceReplicaCluster OceSliceSubjectObserver IceExt OceSliceXceStorm DbCxxPool OceSliceUserLogic OceSliceUserNetwork UtilCxx UtilSlice)
ADD_SERVICE("user/UserNetwork/preloader" "UserNetworkPreloader" ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver IceExt OceSliceXceStorm DbCxxPool OceSlice  OceSliceUserNetwork UtilCxx UtilSlice)
ADD_SERVICE("user/UserAdsCache/data" "UserAdsCacheData" OceCxxAdapterPresenceAdapter OceCxxAdapterUserAdsCacheAdapter OceCxxAdapterUserAdsCacheLoaderAdapter ReplicaCluster OceSliceReplicaCluster OceSliceSubjectObserver OceSlicePresence OceSliceTalkCommon IceExt OceSliceXceStorm DbCxxPool OceSliceUserAdsCache TalkUtil UtilCxx UtilSlice)
ADD_SERVICE("user/UserAdsCache/loader" "UserAdsCacheLoader" ReplicaCluster  OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserAdsCache IceExt OceSliceXceStorm DbCxxPool TalkUtil UtilCxx UtilSlice)
ADD_SERVICE("user/UserApiCache/loader" "UserApiCacheLoader" ReplicaCluster  OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserApiCache IceExt OceSliceXceStorm DbCxxPool TalkUtil UtilCxx UtilSlice)
ADD_SERVICE("user/UserConfig/preloader/" "UserConfigPreloader" ReplicaCluster  OceSliceReplicaCluster OceSliceSubjectObserver OceCommonUserConfigCommon OceSliceUserConfig OceSliceUser IceExt OceSliceXceStorm DbCxxPool UtilCxx UtilSlice)
ADD_SERVICE("user/UserAdsCache/preloader" "UserAdsCachePreloader" ReplicaCluster  OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserAdsCache IceExt OceSliceXceStorm DbCxxPool TalkUtil UtilCxx UtilSlice)
ADD_SERVICE("user/UserApiCache/preloader" "UserApiCachePreloader" ReplicaCluster  OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserApiCache IceExt OceSliceXceStorm DbCxxPool TalkUtil UtilCxx UtilSlice)
ADD_SERVICE("user/UserBase/preloader/UserBornPreloader" "UserBornPreloader" ReplicaCluster  OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserBase IceExt OceSliceXceStorm DbCxxPool TalkUtil UtilCxx UtilSlice)
ADD_SERVICE("user/UserBase/preloader/UserStagePreloader" "UserStagePreloader" ReplicaCluster  OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserBase IceExt OceSliceXceStorm DbCxxPool TalkUtil UtilCxx UtilSlice)
ADD_SERVICE("user/UserBase/preloader/UserDoingPreloader" "UserDoingPreloader" ReplicaCluster  OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserBase IceExt OceSliceXceStorm DbCxxPool TalkUtil UtilCxx UtilSlice)
ADD_SERVICE("user/UserBase/preloader/UserNamePreloader" "UserNamePreloader" ReplicaCluster  OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserBase IceExt OceSliceXceStorm DbCxxPool TalkUtil UtilCxx UtilSlice)
ADD_SERVICE("user/UserBase/preloader/UserPassportPreloader" "UserPassportPreloader" ReplicaCluster  OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserBase IceExt OceSliceXceStorm DbCxxPool TalkUtil UtilCxx UtilSlice)
ADD_SERVICE("user/UserBase/preloader/UserStatePreloader" "UserStatePreloader" ReplicaCluster  OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserBase IceExt OceSliceXceStorm DbCxxPool TalkUtil UtilCxx UtilSlice)
ADD_SERVICE("user/UserBase/preloader/UserLoginCountPreloader" "UserLoginCountPreloader" ReplicaCluster  OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserBase IceExt OceSliceXceStorm DbCxxPool TalkUtil UtilCxx UtilSlice)
ADD_SERVICE("user/UserBase/preloader/UserRightPreloader" "UserRightPreloader" ReplicaCluster  OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserBase IceExt OceSliceXceStorm DbCxxPool TalkUtil UtilCxx UtilSlice)
ADD_SERVICE("user/UserBase/preloader/UserUrlPreloader" "UserUrlPreloader" ReplicaCluster  OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserBase IceExt OceSliceXceStorm DbCxxPool TalkUtil UtilCxx UtilSlice)
ADD_SERVICE("user/UserDesc/preloader/UserTimePreloader" "UserTimePreloader" ReplicaCluster  OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserDesc IceExt OceSliceXceStorm DbCxxPool TalkUtil UtilCxx UtilSlice)
ADD_SERVICE("user/UserDesc/preloader/UserContactPreloader" "UserContactPreloader" ReplicaCluster  OceSliceReplicaCluster OceSliceSubjectObserver OceSliceUserDesc IceExt OceSliceXceStorm DbCxxPool TalkUtil UtilCxx UtilSlice)

#add by shangmin
ADD_SERVICE("user/CompleteUserInfo/src" "CompleteUserInfo" ReplicaCluster OceCxxAdapterUserDescAdapter OceCxxAdapterUserContactAdapter OceCxxAdapterUserNameAdapter OceCxxAdapterUserBornAdapter OceCxxAdapterUserStageAdapter OceCxxAdapterUserUrlAdapter OceCxxAdapterUserStateAdapter OceCxxAdapterUserRightAdapter OceCxxAdapterUserPassportAdapter OceCxxAdapterUserLoginCountAdapter OceCxxAdapterUserTimeAdapter OceCxxAdapterUserConfigAdapter OceCxxAdapterUserDoingAdapter OceSliceReplicaCluster OceSliceSubjectObserver OceSliceCompleteUserInfo OceSliceUserDesc OceSliceUserBase OceSliceUserConfig IceExt OceSliceXceStorm DbCxxPool UtilCxx UtilSlice)

#add by shangmin
#ADD_SERVICE_EXEC("user/CompleteUserInfo/test" "CompleteUserInfoTest" OceCxxAdapterCompleteUserInfoAdapter OceCxxAdapterUserDescAdapter OceCxxAdapterUserContactAdapter OceCxxAdapterUserNameAdapter OceCxxAdapterUserBornAdapter OceCxxAdapterUserStageAdapter OceCxxAdapterUserUrlAdapter OceCxxAdapterUserStateAdapter OceCxxAdapterUserRightAdapter OceCxxAdapterUserPassportAdapter OceCxxAdapterUserLoginCountAdapter OceCxxAdapterUserTimeAdapter OceCxxAdapterUserConfigAdapter OceCxxAdapterUserDoingAdapter ReplicaCluster OceSliceUserDesc OceSliceUserBase OceSliceUserConfig OceSliceReplicaCluster OceSliceSubjectObserver IceExt OceSliceXceStorm DbCxxPool OceSlice UtilCxx UtilSlice)
