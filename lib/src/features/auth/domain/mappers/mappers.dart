import 'package:odd_sprat/src/features/auth/data/models/user_model.dart';
import 'package:odd_sprat/src/features/auth/domain/entities/user.dart';

extension UserModelExtension on UserModel {
  User toDomain() => User(id: id, email: email, username: username);
}
