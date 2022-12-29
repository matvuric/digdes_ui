import 'package:digdes_ui/ui/widgets/tab_home/home.dart';
import 'package:digdes_ui/ui/widgets/tab_profile/profile.dart';
import 'package:flutter/material.dart';

enum TabItemEnum {
  home,
  search,
  reels,
  favs,
  profile,
}

class TabEnums {
  static const TabItemEnum defTab = TabItemEnum.home;

  static Map<TabItemEnum, IconData> tabIcon = {
    TabItemEnum.home: Icons.home_outlined,
    TabItemEnum.search: Icons.search_rounded,
    TabItemEnum.reels: Icons.video_collection_outlined,
    TabItemEnum.favs: Icons.favorite_outline,
    TabItemEnum.profile: Icons.person_outline_outlined,
  };

  static Map<TabItemEnum, Widget> tabRoots = {
    TabItemEnum.home: Home.create(),
    TabItemEnum.profile: Profile.create(),
  };
}
