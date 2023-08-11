import 'package:live_score/src/features/auth/data/models/user_model.dart';
import 'package:live_score/src/features/auth/domain/entities/user.dart';

extension UserModelExtension on UserModel {
  User toDomain() => User(id: id, email: email, name: name);
}
