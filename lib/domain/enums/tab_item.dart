import 'package:digdes_ui/ui/widgets/tab_home/home.dart';
import 'package:digdes_ui/ui/widgets/tab_profile/post_creator/post_creator.dart';
import 'package:digdes_ui/ui/widgets/tab_profile/profile.dart';
import 'package:flutter/material.dart';

enum TabItemEnum {
  home,
  search,
  newPost,
  favs,
  profile,
}

class TabEnums {
  static const TabItemEnum defTab = TabItemEnum.home;

  static Map<TabItemEnum, IconData> tabIcon = {
    TabItemEnum.home: Icons.home_outlined,
    TabItemEnum.search: Icons.search_rounded,
    TabItemEnum.newPost: Icons.post_add_outlined,
    TabItemEnum.favs: Icons.favorite_outline,
    TabItemEnum.profile: Icons.person_outline_outlined,
  };

  static Map<TabItemEnum, Widget> tabRoots = {
    TabItemEnum.home: Home.create(),
    TabItemEnum.newPost: PostCreator.create(),
    TabItemEnum.profile: Profile.create(),
  };
}
