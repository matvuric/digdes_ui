import 'package:digdes_ui/data/services/database.dart';
import 'package:digdes_ui/domain/models/user.dart';

class DataService {
  Future createUpdateUser(User user) async {
    await DB.instance.createUpdate(user);
  }
}
