import 'package:digdes_ui/data/services/data_service.dart';
import 'package:digdes_ui/domain/models/post.dart';
import 'package:digdes_ui/internal/dependencies/repository_module.dart';

class SyncService {
  final _api = RepositoryModule.apiRepository();
  final _dataService = DataService();

  Future syncPosts() async {
    var postModels = await _api.getPosts(0, 100);
    var authors = postModels.map((e) => e.author).toSet();
    var postAttachments = postModels
        .expand((x) => x.postAttachments.map((e) => e.copyWith(postId: x.id)))
        .toList();
    var posts = postModels
        .map((e) => Post.fromJson(e.toJson()).copyWith(authorId: e.author.id))
        .toList();

    // await _dataService.rangeUpdateEntities(authors);
    await _dataService.rangeUpdateEntities(posts);
    await _dataService.rangeUpdateEntities(postAttachments);
  }
}
