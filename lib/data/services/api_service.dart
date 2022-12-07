import 'package:digdes_ui/domain/repository/api_repository.dart';
import 'package:digdes_ui/internal/dependencies/repository_module.dart';

class ApiService {
  final ApiRepository _api = RepositoryModule.apiRepository();

  Future editProfile(
      String? username,
      String? firstName,
      String? lastName,
      String? bio,
      String? gender,
      String? phone,
      String? email,
      DateTime? birthDate,
      bool? isPrivate) async {
    await _api.editProfile(
        username: username,
        firstName: firstName,
        lastName: lastName,
        bio: bio,
        gender: gender,
        phone: phone,
        email: email,
        birthDate: birthDate,
        isPrivate: isPrivate);
  }
}
