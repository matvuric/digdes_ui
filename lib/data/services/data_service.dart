import 'package:digdes_ui/data/services/database.dart';
import 'package:digdes_ui/domain/db_model.dart';
import 'package:digdes_ui/domain/models/post.dart';
import 'package:digdes_ui/domain/models/post_attachment.dart';
import 'package:digdes_ui/domain/models/post_model.dart';
import 'package:digdes_ui/domain/models/user.dart';

class DataService {
  Future createUpdateUser(User user) async {
    await DB.instance.createUpdate(user);
  }

  Future rangeUpdateEntities<T extends DbModel>(Iterable<T> elems) async {
    await DB.instance.createUpdateRange(elems);
  }

  Future<List<PostModel>> getPosts() async {
    var res = <PostModel>[];
    var posts = await DB.instance.getAll<Post>();

    for (var post in posts) {
      var author = await DB.instance.get<User>(post.authorId);
      var attachments = (await DB.instance
              .getAll<PostAttachment>(whereMap: {"postId": post.id}))
          .toList();

      if (author != null) {
        res.add(PostModel(
            id: post.id,
            author: author,
            caption: post.caption,
            createdDate: post.createdDate,
            postAttachments: attachments));
      }
    }

    return res;
  }
}
