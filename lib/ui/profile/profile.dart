import 'package:digdes_ui/ui/app_navigator.dart';
import 'package:digdes_ui/ui/profile/profile_vm.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<ProfileViewModel>();
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            viewModel.user == null ? "Hi" : viewModel.user!.username,
          ),
          actions: [
            const IconButton(
              onPressed: AppNavigator.toProfileEditor,
              icon: Icon(Icons.settings),
            ),
            IconButton(
              onPressed: viewModel.logOut,
              icon: const Icon(Icons.exit_to_app_outlined),
            ),
          ],
        ),
        body: (viewModel.user != null)
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Material(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: const CircleBorder(),
                            child: InkWell(
                              onTap: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                      'How do you want to choose photo?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        viewModel
                                            .pickImage(ImageSource.gallery);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('From Gallery'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        viewModel.pickImage(ImageSource.camera);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('By Camera'),
                                    ),
                                  ],
                                ),
                              ),
                              child: Ink.image(
                                image: viewModel.avatar != null
                                    ? viewModel.avatar!.image
                                    : const AssetImage(
                                        "assets/images/noavatar.png"),
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: SizedBox(
                                  width: screenSize.width * 0.25,
                                  height: 100,
                                  child: Center(
                                      child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text:
                                                "${viewModel.user!.postsCount}\n",
                                            style:
                                                const TextStyle(fontSize: 20)),
                                        const TextSpan(
                                            text: "Posts",
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  )))),
                          Expanded(
                              flex: 1,
                              child: SizedBox(
                                  width: screenSize.width * 0.25,
                                  height: 100,
                                  child: Center(
                                      child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text:
                                                "${viewModel.user!.followersCount}\n",
                                            style:
                                                const TextStyle(fontSize: 20)),
                                        const TextSpan(
                                            text: "Followers",
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  )))),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                                // TODO : followers page / following page
                                // TODO : delete avatar
                                width: screenSize.width * 0.25,
                                height: 100,
                                child: Center(
                                    child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text:
                                              "${viewModel.user!.followingsCount}\n",
                                          style: const TextStyle(fontSize: 20)),
                                      const TextSpan(
                                          text: "Following",
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ))),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text.rich(TextSpan(
                            text: viewModel.user!.bio,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                      ),
                    ]))
            : null);
  }

  static create(BuildContext bc) {
    return ChangeNotifierProvider(
        create: (context) => ProfileViewModel(context: bc),
        child: const Profile());
  }
}
