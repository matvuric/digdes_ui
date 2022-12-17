import 'dart:io';

import 'package:digdes_ui/internal/config/app_config.dart';
import 'package:digdes_ui/ui/app_navigator.dart';
import 'package:digdes_ui/ui/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<ProfileViewModel>();
    ImageProvider img;
    var screenSize = MediaQuery.of(context).size;

    if (viewModel.user != null &&
        viewModel.headers != null &&
        viewModel.user!.avatarLink != null) {
      img = NetworkImage("$baseUrl2 ${viewModel.user!.avatarLink}",
          headers: viewModel.headers);
    } else {
      img = const AssetImage("assets/images/noavatar.png");
    }

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
                              onTap: viewModel.changeAvatar,
                              child: Ink.image(
                                image: (viewModel.imagePath != null
                                    ? FileImage(File(viewModel.imagePath!))
                                    : img),
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

  static create() {
    return ChangeNotifierProvider(
        create: (context) => ProfileViewModel(context: context),
        child: const ProfileWidget());
  }
}
