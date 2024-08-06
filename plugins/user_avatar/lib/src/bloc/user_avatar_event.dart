part of 'user_avatar_bloc.dart';

abstract class UserAvatarEvent {
  const UserAvatarEvent();
}

class LoadInitAvatarEvent extends UserAvatarEvent {
  final String? avatar;

  const LoadInitAvatarEvent(this.avatar);
}

class UploadAvatarEvent<P> extends UserAvatarEvent {
  final String avatar;
  final P? param;

  const UploadAvatarEvent(this.avatar, {this.param});
}
