import 'package:digdes_ui/ui/widgets/tab_post_create/post_creator_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostCreator extends StatelessWidget {
  const PostCreator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<PostCreatorViewModel>();
    bool shouldPop = false;

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: WillPopScope(
            onWillPop: () async {
              if (viewModel.checkFields()) {
                await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text(
                              'If you continue your changes will not be saved.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                viewModel.asyncInit();
                                Navigator.of(context).pop();
                                shouldPop = true;
                              },
                              child: const Text('Continue',
                                  selectionColor: Colors.grey),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                shouldPop = false;
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        ));
              } else {
                return true;
              }
              return shouldPop;
            },
            child: Scaffold(
                appBar: AppBar(
                  title: const Text("New Post"),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        viewModel.confirm();
                        FocusScope.of(context).unfocus();
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.done),
                    ),
                  ],
                ),
                body: Column(children: [
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
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: viewModel.caption,
                      minLines: 5,
                      maxLines: 5,
                      decoration:
                          const InputDecoration.collapsed(hintText: 'Caption'),
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
                ]))));
  }

  static create() {
    return ChangeNotifierProvider(
        create: (context) => PostCreatorViewModel(context: context),
        child: const PostCreator());
  }
}
