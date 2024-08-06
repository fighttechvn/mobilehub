import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_avatar_event.dart';
part 'user_avatar_state.dart';

typedef UpdateAvatarUsecase<P> = Future<String?> Function(String, P?);

class UserAvatarBloc<P> extends Bloc<UserAvatarEvent, UserAvatarState> {
  final UpdateAvatarUsecase<P> _usecase;

  UserAvatarBloc(
    this._usecase, {
    String? avartar,
  }) : super(UserAvatarInitial(avatar: avartar)) {
    on<UploadAvatarEvent<P>>(_onMapUploadAvatarEvent);
    on<LoadInitAvatarEvent>(_onMapLoadInitAvatarEvent);
  }

  FutureOr<void> _onMapUploadAvatarEvent(
    UploadAvatarEvent<P> event,
    Emitter<UserAvatarState> emit,
  ) async {
    try {
      emit(UploadingAvatar(avatar: state.avatar));

      final image = await _usecase(event.avatar, event.param);

      if (image?.isNotEmpty ?? false) {
        emit(UploadAvatarSuccess(avatar: image));
      } else {
        throw Exception('Error upload avatar');
      }
    } catch (e) {
      emit(UploadAvatarFailed(e.toString(), e, avatar: state.avatar));
    }
  }

  FutureOr<void> _onMapLoadInitAvatarEvent(
    LoadInitAvatarEvent event,
    Emitter<UserAvatarState> emit,
  ) {
    emit(UploadAvatarSuccess(avatar: event.avatar));
  }
}
