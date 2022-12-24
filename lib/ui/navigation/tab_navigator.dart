import 'package:digdes_ui/domain/enums/tab_item.dart';
import 'package:digdes_ui/ui/widgets/tab_home/post_details.dart';
import 'package:flutter/material.dart';

class TabNavigatorRoutes {
  static const String root = '/app/';
  static const String postDetails = '/app/postDetails';
}

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItemEnum item;
  const TabNavigator({Key? key, required this.navigatorKey, required this.item})
      : super(key: key);

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
          {Object? arg}) =>
      {
        TabNavigatorRoutes.root: (context) =>
            TabEnums.tabRoots[item] ?? SafeArea(child: Text(item.name)),
        TabNavigatorRoutes.postDetails: (context) => PostDetails.create(arg)
      };

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (settings) {
        var rb = _routeBuilders(context, arg: settings.arguments);
        if (rb.containsKey(settings.name)) {
          return MaterialPageRoute(
              builder: (context) => rb[settings.name]!(context));
        }
        return null;
      },
    );
  }
}
