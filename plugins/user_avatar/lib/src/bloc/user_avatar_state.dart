part of 'user_avatar_bloc.dart';

@immutable
abstract class UserAvatarState {
  const UserAvatarState({this.avatar});

  final String? avatar;
}

class UserAvatarInitial extends UserAvatarState {
  const UserAvatarInitial({super.avatar});
}

class UploadingAvatar extends UserAvatarState {
  const UploadingAvatar({super.avatar});
}

class UploadAvatarSuccess extends UserAvatarState {
  const UploadAvatarSuccess({super.avatar});
}

class UploadAvatarFailed extends UserAvatarState {
  final String message;
  final dynamic error;

  const UploadAvatarFailed(
    this.message,
    this.error, {
    super.avatar,
  });
}
