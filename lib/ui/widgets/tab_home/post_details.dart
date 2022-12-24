import 'package:digdes_ui/ui/widgets/tab_home/post_details_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<PostDetailsViewModel>();
    return Scaffold(appBar: AppBar(), body: Text(viewModel.postId ?? "empty"));
  }

  static Widget create(Object? arg) {
    String? postId;

    if (arg != null && arg is String) {
      postId = arg;
    }

    return ChangeNotifierProvider(
        create: (BuildContext context) =>
            PostDetailsViewModel(context: context, postId: postId),
        child: const PostDetails());
  }
}
