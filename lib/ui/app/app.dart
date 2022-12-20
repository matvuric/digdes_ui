import 'package:digdes_ui/internal/config/app_config.dart';
import 'package:digdes_ui/ui/app/app_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO : add localization
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<AppViewModel>();
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text("NastyGram"),
          actions: [
            Material(
              elevation: 8,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () => viewModel.toProfile(context),
                child: Ink.image(
                  image: viewModel.avatar != null
                      ? viewModel.avatar!.image
                      : const AssetImage("assets/images/noavatar.png"),
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.goUp,
          child: const Icon(Icons.arrow_upward_outlined),
        ),
        body: Container(
            child: viewModel.posts == null
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                          child: ListView.separated(
                              controller: viewModel.listViewController,
                              itemBuilder: (listContext, listIndex) {
                                Widget res;
                                var posts = viewModel.posts;

                                if (posts != null) {
                                  var post = posts[listIndex];
                                  res = SizedBox(
                                    height: screenSize.width,
                                    child: Column(children: [
                                      Expanded(
                                        child: PageView.builder(
                                          itemBuilder:
                                              ((pageContext, pageIndex) =>
                                                  Image(
                                                      image: NetworkImage(
                                                    "$baseUrl2${post.postAttachments[pageIndex].attachmentLink}",
                                                  ))),
                                          itemCount:
                                              post.postAttachments.length,
                                          onPageChanged: (value) => viewModel
                                              .onPageChanged(listIndex, value),
                                        ),
                                      ),
                                      PageIndicator(
                                        count: post.postAttachments.length,
                                        current: viewModel.pager[listIndex],
                                      ),
                                      Text(post.caption ?? "")
                                    ]),
                                  );
                                } else {
                                  res = const SizedBox.shrink();
                                }

                                return res;
                              },
                              separatorBuilder: ((context, index) =>
                                  const Divider()),
                              itemCount: viewModel.posts?.length ?? 0)),
                      if (viewModel.isLoading) const CircularProgressIndicator()
                    ],
                  )));
  }

  static Widget create() {
    return ChangeNotifierProvider(
        create: (BuildContext context) => AppViewModel(context: context),
        child: const App());
  }
}

class PageIndicator extends StatelessWidget {
  final int count;
  final int? current;
  final double width;
  const PageIndicator(
      {Key? key, required this.count, required this.current, this.width = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];
    if (count > 1) {
      for (var i = 0; i < count; i++) {
        widgets.add(Icon(Icons.circle,
            size: width,
            color:
                i == (current ?? 0) ? const Color(0xff6750a4) : Colors.grey));
      }
    }
    return Wrap(
      children: widgets,
    );
  }
}
