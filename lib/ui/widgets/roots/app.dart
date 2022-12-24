import 'package:digdes_ui/domain/enums/tab_item.dart';
import 'package:digdes_ui/ui/navigation/tab_navigator.dart';
import 'package:digdes_ui/ui/widgets/Common/bottom_navigation.dart';
import 'package:digdes_ui/ui/widgets/roots/app_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO : add localization
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<AppViewModel>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          var isFirst = !await viewModel
              .navigationKeys[viewModel.currentTab]!.currentState!
              .maybePop();
          if (isFirst) {
            if (viewModel.currentTab != TabEnums.defTab) {
              viewModel.selectTab(TabEnums.defTab);
            }
            return false;
          }
          return isFirst;
        },
        child: Scaffold(
          bottomNavigationBar: BottomNavigation(
            currentTab: viewModel.currentTab,
            onSelectTab: viewModel.selectTab,
          ),
          body: Stack(
            children: TabItemEnum.values
                .map((e) => _buildOffStageGenerator(context, e))
                .toList(),
          ),
        ),
      ),
    );
  }

  static Widget create() {
    return ChangeNotifierProvider(
        create: (BuildContext context) => AppViewModel(context: context),
        child: const App());
  }

  Widget _buildOffStageGenerator(BuildContext context, TabItemEnum item) {
    var viewModel = context.watch<AppViewModel>();
    return Offstage(
      offstage: viewModel.currentTab != item,
      child: TabNavigator(
        navigatorKey: viewModel.navigationKeys[item]!,
        item: item,
      ),
    );
  }
}
