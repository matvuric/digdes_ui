import 'package:flutter/material.dart';

class PostDetailsViewModel extends ChangeNotifier {
  BuildContext context;
  final String? postId;
  PostDetailsViewModel({required this.context, this.postId});
}
