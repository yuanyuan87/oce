#ifndef LOADPEERTHREAD_H_
#define LOADPEERTHREAD_H_

#include <Ice/Ice.h>
#include <IceUtil/IceUtil.h>

#include "socialgraph/FriendFinderInfoCache/FriendFinderInfoCache/src/dbhelper.h"

namespace xce {
namespace socialgraph {

static const std::string BEIJING = "110000000000";  //北京市
static const std::string TIANJIN = "120000000000";  //天津市
static const std::string CHONGQING = "500000000000";	//重庆市
static const std::string SHANGHAI = "310000000000";  //上海市

//为保证插入数据成功，缩短data length
static const size_t MEMCACHE_VALUE_THRESHOLD = 1000;  //因为memcache的value不能超过1MB，所以限制id数量不超过20万

//-----------------------------------------------------------------------

struct Md5Info {
	Md5Info() {
		md5 = 0;	
	}
	MyUtil::StrSeq condition;
	long md5;
};
typedef std::vector<Md5Info> InfoSeq;

struct Network {
	InfoSeq univInfoSeq;
	InfoSeq highschoolInfoSeq;
	InfoSeq juniorschoolInfoSeq;
	InfoSeq elementaryschoolInfoSeq;
};

//fuck!!!! i wanna refactor!!!
struct SchoolArea {
	Md5Info highschool;  		//高中 //所在区县+入学年
	Md5Info juniorschool;   	//初中
	Md5Info college;				//中专
};

//-----------------------------------------------------------------------
struct People {
	People() {
		uid_ = 0;
		gender_ = 0;
	}
	int uid_;
	int gender_;
};

//-----------------------------------------------------------------------

class HighSchoolPeerHelper {
public:
	/* @brief 根据学校id获取学校对应的区县编码
   * @param sourc 数据源
   * @param school_info_collector 学校信息
   * @param school_code_collector 学校编码信息
   */
	static void GetSchoolMap(const std::string& source,
													 const std::map<int, SchoolInfo>& school_info_collector,
													 std::map<int, SchoolCode>& school_code_collector);

	/* @brief 根据区县编码获取对应的区县名字
   * @param school_code_collector 学校编码信息
   * @param china_area_collector 学校名字信息
   */
	static void GetChinaAreaMap(const std::map<int, SchoolCode>& school_code_collector,
											 				std::map<std::string, std::string>& china_area_collector);

	/* @brief 获取用户年龄信息
   * @param school_info_collector 学校信息
   * @param id_gender 用户年龄信息
   */
	static void GetUserGenderMap(const std::map<int, SchoolInfo>& school_info_map,
															 std::map<int, int>& id_gender);


	/* @brief 向容器school_peer_map中插入存储数据
   * @param school_info_collector 学校信息
   * @param school_code_collector 学校编码信息
   * @param china_area_collector 学校名字信息
   * @param Info 存储数据容器
   */
	static void InserSchoolArea(const std::map<int, SchoolInfo>& school_info_collector,
														  const std::map<int, SchoolCode>& school_code_collector,
														  const std::map<std::string, std::string>& china_area_collector,
														  Md5Info& info);
	/* @brief 转化school_peer_map为proto信息
   * @param school_peer_map 存储数据容器
   */
	static void LoadProtoData(const std::map<long, std::list<People> >& school_peer_map);

	/* @brief 向distcache中插入数据 因为是md5所以，可以直接插入distcache中
   * @param key
   * @param data
   */
	static bool SetDistcache(long key, const std::vector<unsigned char>& data);

	/* @brief 向distcache中取出数据 因为是md5所以，可以直接插入distcache中
   * @param key
   * @param data
   */
	static bool GetDistcache(long key, std::vector<unsigned char>& data);
};

//-----------------------------------------------------------------------

/*@brief load high_school_info */
class LoadHighSchoolPeerThread : virtual public IceUtil::Thread {
public:
	LoadHighSchoolPeerThread(int uid, Md5Info& info):
		uid_(uid), info_(info) {}
	virtual void run();

private:
	int uid_;
	Md5Info& info_;
};

//-----------------------------------------------------------------------

/*@brief load junior_high_school_info */
class LoadJuniorHighSchoolPeerThread : virtual public IceUtil::Thread {
public:
	LoadJuniorHighSchoolPeerThread(int uid, Md5Info& info): 
		uid_(uid), info_(info) {}

	virtual void run();

private:
	int uid_;
	Md5Info& info_;
};

//-----------------------------------------------------------------------

/*@brief load special_school_info */
class LoadSpecialSchoolPeerThread : virtual public IceUtil::Thread {
public:
	LoadSpecialSchoolPeerThread(int uid, Md5Info& info): 
		uid_(uid), info_(info) {}

	virtual void run();

private:
	int uid_;
	Md5Info& info_;
};

}
}

#endif