import 'package:digdes_ui/ui/widgets/tab_profile/post_creator/post_creator_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostCreator extends StatelessWidget {
  const PostCreator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<PostCreatorViewModel>();

    return Scaffold(
        appBar: AppBar(
          title: const Text("New Post"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                viewModel.confirm();
                Navigator.of(context).pop();
                // TODO : add warning ( acc creator too)
              },
              icon: const Icon(Icons.done),
            ),
          ],
        ),
        body: (viewModel.user != null)
            ? Column(children: [
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    itemBuilder: ((pageContext, pageIndex) => Container(
                          color: Colors.black,
                          child: Image(
                              image: FileImage(viewModel.imgList[pageIndex])),
                        )),
                    itemCount: viewModel.imgList.length,
                    onPageChanged: (value) => viewModel.onPageChanged(value),
                  ),
                  // Image(
                  //   image: viewModel.imgList.isNotEmpty
                  //       ? FileImage(viewModel.img!)
                  //       : NetworkImage("$baseUrl2${viewModel.user!.avatarLink}")
                  //           as ImageProvider,
                  // ),
                ),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: viewModel.caption,
                    minLines: 5,
                    maxLines: 5,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: viewModel.pickImages,
                              child: const Text("Add from Gallery"),
                            )),
                        const SizedBox(width: 16),
                        Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: viewModel.takePhoto,
                              child: const Text("Add by Camera"),
                            )),
                      ],
                    ))
              ])
            : null);
  }

  static create() {
    return ChangeNotifierProvider(
        create: (context) => PostCreatorViewModel(context: context),
        child: const PostCreator());
  }
}
