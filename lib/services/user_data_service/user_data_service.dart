import 'package:despesas_app/common/data/data_result.dart';
import 'package:despesas_app/common/models/models.dart';

abstract class UserDataService {
  DataResult<UserModel> getUserData();
}
