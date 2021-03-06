#include "SomeMemberHandler.h"
#include "AdMatchManagerI.h"
#include "AdConfig.h"
using namespace std;

namespace xce {
namespace ad {

// const double kMaxPriceRandDiscount = 0.15; // 按最高出价的最大折扣率

double MAdItemList::FilterCompete(int uid, AdGroupPtr selected, set<Ice::Long> * evaluated_ids) {
  // typedef ItemContainer::nth_index<0>::type GidIndex;
  double filtered_score = 0.0;
  GidIndex & gid_index = items_.get<0>();
  // 按member过滤
  GidIndex::iterator it = gid_index.begin();

  vector<Ice::Long> compete_campaigns_seq = CompeteRef::instance().Get(selected->campaign_id());
  set<Ice::Long> compete_campaigns;
  compete_campaigns.insert(compete_campaigns_seq.begin(), compete_campaigns_seq.end());

  for(; it != gid_index.end(); ++it) {
    if (evaluated_ids->find((*it)->group_id_) != evaluated_ids->end()) {
      continue;
    }
    if (selected->group_id() == (*it)->group_id_) {
      continue;
    }
    AdGroupPtr g = AdGroupPool::instance().GetAdGroup((*it)->group_id_);
    if (g) {
      if (selected->member_id() == g->member_id()) {
        evaluated_ids->insert((*it)->group_id_);
        filtered_score += (*it)->score_;
        // MCE_DEBUG("uid " << uid << " rm ad " << selected->group_id() << " member compete " << (*it)->group_id_);
        continue;
      }
    } else {
      evaluated_ids->insert((*it)->group_id_);
      filtered_score += (*it)->score_;
      // MCE_DEBUG("uid " << uid << " rm ad " << selected->group_id() << " null compete " << (*it)->group_id_);
      continue;
    }

    if (compete_campaigns.find(g->campaign_id()) != compete_campaigns.end()) {
      evaluated_ids->insert((*it)->group_id_);
      filtered_score += (*it)->score_;
      // MCE_DEBUG("uid " << uid << " rm ad " << selected->group_id() << " compete " << (*it)->group_id_);
    }
  }

  return filtered_score;
}

SelectedAdGroupSeq MAdItemList::Select(int uid, int count) {
  SelectedAdGroupSeq result;
/*  ScoreIndex & score_index = items_.get<1>();
  PriceIndex & price_idx = items_.get<2>();
  double total_score = TotalScore();
  set<Ice::Long> evaluated_ids;
  set<AdGroupPtr> selected_groups;
  int loop_count = 0;
  int inner_loop = 0;
  float cost_discount = 0.85;
  int rand_seed = 1500;
  cost_discount = EngineConfig::instance().GetCostDiscount();
  rand_seed = EngineConfig::instance().GetRandSeed();

  while(selected_groups.size() < count && evaluated_ids.size() < score_index.size()) {
    double random = (((double) (rand() % 10000)) / (10000.0)) * total_score;
    double left = 0.0, right = 0.0;
    inner_loop = 0;
    ScoreIndex::iterator score_it = score_index.begin();
    for( ; score_it != score_index.end(); ++score_it) {
      if (evaluated_ids.end() != evaluated_ids.find((*score_it)->group_id_)) {
        continue;
      }
      ++loop_count;
      ++inner_loop;

      right = left + (*score_it)->score_;

      if (left <= random && random <= right) {
        AdGroupPtr group = AdGroupPool::instance().GetAdGroup((*score_it)->group_id_);
        if (group) {
          SelectedAdGroupPtr selected = new SelectedAdGroup(group); 

          // cost 计算
          PriceIndex::iterator price_it = items_.project<2>(score_it);
          if (price_it == price_idx.begin()) { // 出价最低的
            selected->cost_ = group->max_price();
          } else {
            PriceIndex::iterator price_it_current = price_it;
            --price_it;
            double cost = sqrt(1.0 * (*price_it)->max_price_ * (*price_it_current)->max_price_);
           // selected->cost_ = (int)std::max((0.85 + rand() % 1500 / 10000.0) * (*price_it_current)->max_price_, nearbyint(cost));
            selected->cost_ = (int)std::max((cost_discount + rand() % rand_seed / 10000.0) * (*price_it_current)->max_price_, nearbyint(cost));
            if (selected->cost_ < EngineConfig::instance().sys_min_price()) {
              selected->cost_ = EngineConfig::instance().sys_min_price();
            } 
            if (selected->cost_ > (*price_it_current)->max_price_) {
              selected->cost_ = (*price_it_current)->max_price_;
            }
          }

          MCE_DEBUG("SomeMember Select mid=" << group->member_id() << "gid=" << group->group_id() << ",score="<<(*score_it)->score_ << ",cost="<< selected->cost_);
          SomeMemberPool::instance().IncPv(group->member_id());
          result.push_back(selected);
          selected_groups.insert(group);
          double filtered_score = FilterCompete(uid, group, &evaluated_ids);
          total_score -= filtered_score; 
        } else {
          MCE_DEBUG("SomeMember Select gid=" << (*score_it)->group_id_ << " not found");
        }
        evaluated_ids.insert((*score_it)->group_id_);
        total_score -= (*score_it)->score_; 
        break;
      } else {
        left = right;
      }
    }
    if (total_score <= 0.0) {
      break;
    }
  }
  if (loop_count > 3000) {
    MCE_INFO("SomeMember user " << uid << " total loop count " << loop_count);
  }*/
  return result;
}

void MAdItemList::InitScoreByThreshosld(const UserProfile & user_profile, const set<AdGroupPtr> & groups) {
  map<Ice::Long, int> ad_count;
/*  for(set<AdGroupPtr>::const_iterator it = groups.begin(); it != groups.end();it++) {
    AdGroupPtr group = *it;
    //MCE_DEBUG("SomeMember mid " << group->member_id() << ",gid " << group->group_id());
    if (group && SomeMemberPool::instance().IsAvailable(group->member_id())) {
      ad_count[group->member_id()]++;
    }
  }
  for(set<AdGroupPtr>::const_iterator it = groups.begin(); it != groups.end(); ++it) {
    AdGroupPtr group = *it;
    if (group && SomeMemberPool::instance().IsAvailable(group->member_id())) {
      int count = ad_count[group->member_id()];
      double score = 0.0;
      if (count > 0) {
        score = SomeMemberPool::instance().GetPvLimit(group->member_id()) / (double) ad_count[group->member_id()];
      }
      if (user_profile.id() == 1244171572) {
        MCE_INFO("SomeMember gid=" << group->group_id() << ",mid=" << group->member_id() << ",score=" << score);
      }
      MAdItemPtr item = new MAdItem(group->group_id(), group->max_price(), score);
      items_.insert(item);
    }
  }*/
}

SelectedAdGroupSeq MUserIndex::GetZoneGroups(const UserProfile & user_profile, long adzone, int count) {
  MAdItemListPtr ad_list_ptr;
  {
    IceUtil::Mutex::Lock lock(user_mutex_);
    map<long, MAdItemListPtr>::const_iterator it = user_zone_items_.find(adzone);
    if (it != user_zone_items_.end()) {
      ad_list_ptr = it->second;
      MCE_DEBUG("SomeMember uid " << user_profile.id() << " cache hit" );
    }
  }
  if (!ad_list_ptr || ad_list_ptr->IsStale()) {
    set<AdGroupPtr> groups;
    {
      ostringstream oss;
      oss << "Get index uid=" << user_profile.id();
      StatFunc stat(oss.str());
      groups = MUserAdMatcher::instance().GetAds(const_cast<UserProfile&>(user_profile), adzone);
    }
    MCE_INFO("SomeMember user " << user_profile.id() << " zone " << adzone << " matched ad count " << groups.size());
    if (!groups.empty()) {
      ad_list_ptr = new MAdItemList(user_profile, adzone, groups);
      user_zone_items_[adzone] = ad_list_ptr;
    }
  }

  SelectedAdGroupSeq result;
  if (ad_list_ptr) {
    ostringstream oss;
    oss << "Select ad uid=" << user_profile.id();
    StatFunc stat(oss.str());
    result = ad_list_ptr->Select(user_profile.id(), count);
  } else {
    MCE_DEBUG("SomeMember user " << uid_ << " adzone " << adzone << " no matched ads");
  }
  return result;
}

bool SomeMemberHandler::handle(MatchHandlerParamter& para, AdResultMap& result) {
  int uid = para.userProfile_.id();
  //if (uid % 10 != 5 ) {
  //  return true;
  //}
  int random = (rand() % 1000);
  int pick_count = para.PickCount();
  if (random >= 800 || pick_count <=0) {
    return true;
  }

  TimeStat ts;

  MUserIndexPtr user_index = MUserIndexCache::instance().GetMUserIndex(uid);
  long zone_id = para.adzone_->id();
  SelectedAdGroupSeq selected = user_index->GetZoneGroups(para.userProfile_, zone_id, pick_count);
  
  if (!selected.empty()) {
    for(SelectedAdGroupSeq::const_iterator it = selected.begin(); it != selected.end(); ++it) {
      para.zone_selected_groups_.insert(*it);
      (*it)->pos_ = para.zone_selected_groups_.size();
    }
    para.total_selected_groups_.insert(para.zone_selected_groups_.begin(), para.zone_selected_groups_.end());
  }
  MCE_INFO("SomeMember user " << uid << " zone " << zone_id << " selected size " << selected.size() << "/" << pick_count);
  return true;
}

set<AdGroupPtr> MUserAdMatcher::GetAds(UserProfile& profile, Ice::Long adzone) {
  try {
    set<AdGroupPtr> result;
    AdInvertedIndex::instance().Get(profile, adzone, result);
    return result;
  } catch(Ice::Exception& e) {
    MCE_WARN("MUserAdMatcher::GetAds error : " << e);
  } catch(std::exception& e) {
    MCE_WARN("MUserAdMatcher::GetAds std::exception error : " << e.what());
  } catch(...) {
    MCE_WARN("MUserAdMatcher::GetAds unknown error.");
  }
  return set<AdGroupPtr>();
}

}
}
