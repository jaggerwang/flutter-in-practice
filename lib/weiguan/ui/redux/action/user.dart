import 'package:meta/meta.dart';

import '../../../entity/entity.dart';
import '../../ui.dart';

class UserLoggedAction extends BaseAction {
  final UserEntity user;

  UserLoggedAction({
    @required this.user,
  });
}
