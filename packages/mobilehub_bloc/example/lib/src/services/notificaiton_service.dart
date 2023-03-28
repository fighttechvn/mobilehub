import '../helper.dart';
import '../entities/notificaiton_info.dart';

class NotificationUsecase {
  Future<List<NotificationInfo>> getListNotification(
      int offset, int limit) async {
    final List<NotificationInfo> result = 10
        .toListIndexObject<NotificationInfo>((i) => NotificationInfo(i, '$i'));

    return result;
  }
}
