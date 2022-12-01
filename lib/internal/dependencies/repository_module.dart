import 'package:digdes_ui/data/repository/api_data_repository.dart';
import 'package:digdes_ui/domain/repository/api_repository.dart';
import 'package:digdes_ui/internal/dependencies/api_module.dart';

class RepositoryModule {
  static ApiRepository? _apiRepository;

  static ApiRepository apiRepository() =>
      _apiRepository ??
      ApiDataRepository(
        ApiModule.auth(),
      );
}
