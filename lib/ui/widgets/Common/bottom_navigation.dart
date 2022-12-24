import 'package:digdes_ui/domain/enums/tab_item.dart';
import 'package:digdes_ui/ui/widgets/roots/app_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  final TabItemEnum currentTab;
  final ValueChanged<TabItemEnum> onSelectTab;
  const BottomNavigation(
      {Key? key, required this.currentTab, required this.onSelectTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appModel = context.watch<AppViewModel>();

    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      currentIndex: TabItemEnum.values.indexOf(currentTab),
      items: TabItemEnum.values.map((e) => _buildItem(e, appModel)).toList(),
      onTap: (value) {
        FocusScope.of(context).unfocus();
        onSelectTab(TabItemEnum.values[value]);
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItemEnum item, AppViewModel model) {
    var isCurrent = currentTab == item;
    double size = isCurrent ? 30 : 25;
    Widget icon = Icon(
      TabEnums.tabIcon[item],
      size: size,
    );

    if (item == TabItemEnum.profile) {
      icon = CircleAvatar(
        maxRadius: isCurrent ? 15 : 12,
        backgroundImage: model.avatar?.image,
      );
    }

    return BottomNavigationBarItem(label: '', icon: icon);
  }
}
