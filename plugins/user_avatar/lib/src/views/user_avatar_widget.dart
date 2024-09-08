import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagewidget/imagewidget.dart';

import '../bloc/user_avatar_bloc.dart';

class UserAvatarWidget<P> extends StatelessWidget {
  const UserAvatarWidget({
    super.key,
    this.borderRadius,
    required this.size,
    required this.enableUpdate,
    this.onTapUpdate,
    this.avatar,
    this.iconCamera,
    this.paramUpdate,
    this.onUpdateSuccess,
    this.linkFormatBackend,
  });

  final double? borderRadius;
  final double size;
  final bool enableUpdate;
  final Future<String?> Function()? onTapUpdate;
  final String? avatar;
  final Widget? iconCamera;
  final P? paramUpdate;
  final void Function(String)? onUpdateSuccess;
  final String Function(String url)? linkFormatBackend;

  @override
  Widget build(BuildContext context) {
    return _UserAvatarWidget(
      size: size,
      onUpdateSuccess: onUpdateSuccess,
      borderRadius: borderRadius,
      enableUpdate: enableUpdate,
      onTapUpdate: onTapUpdate,
      avatar: avatar,
      iconCamera: iconCamera,
      paramUpdate: paramUpdate,
      linkFormatBackend: linkFormatBackend,
    );
  }
}

class _UserAvatarWidget<P> extends StatefulWidget {
  final double? borderRadius;
  final double size;
  final bool enableUpdate;
  final Future<String?> Function()? onTapUpdate;
  final String? avatar;
  final Widget? iconCamera;
  final P? paramUpdate;
  final void Function(String)? onUpdateSuccess;
  final String Function(String url)? linkFormatBackend;

  const _UserAvatarWidget({
    Key? key,
    this.size = 48,
    this.borderRadius,
    this.enableUpdate = false,
    this.onTapUpdate,
    this.avatar,
    this.iconCamera,
    this.paramUpdate,
    this.onUpdateSuccess,
    this.linkFormatBackend,
  }) : super(key: key);

  @override
  State<_UserAvatarWidget<P>> createState() => _UserAvatarWidgetState<P>();
}

class _UserAvatarWidgetState<P> extends State<_UserAvatarWidget<P>> {
  void _onListenerUserAvatarBloc(BuildContext context, UserAvatarState state) {
    if (state is UploadAvatarSuccess && (state.avatar?.isNotEmpty ?? false)) {
      widget.onUpdateSuccess?.call(state.avatar!);
    }
  }

  void _onTapUpdate() {
    widget.onTapUpdate?.call().then((value) {
      if (value?.isNotEmpty ?? false) {
        if (mounted) {
          context
              .read<UserAvatarBloc>()
              .add(UploadAvatarEvent<P>(value!, param: widget.paramUpdate));
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<UserAvatarBloc>().add(LoadInitAvatarEvent(widget.avatar));
  }

  @override
  void didUpdateWidget(covariant _UserAvatarWidget<P> oldWidget) {
    if (oldWidget.avatar != widget.avatar) {
      context.read<UserAvatarBloc>().add(LoadInitAvatarEvent(widget.avatar));
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final radius = (widget.borderRadius ?? widget.size) + 10;

    return BlocConsumer<UserAvatarBloc, UserAvatarState>(
      listener: _onListenerUserAvatarBloc,
      builder: (context, state) {
        return Stack(
          children: [
            if (state is UploadingAvatar)
              const Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: CircularProgressIndicator(),
              ),
            UserAvatarUI(
              size: widget.size,
              radius: radius,
              avatar: state.avatar,
            ),
            if (widget.enableUpdate)
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _onTapUpdate,
                  child:
                      widget.iconCamera ?? const Icon(Icons.camera_alt_rounded),
                ),
              ),
          ],
        );
      },
    );
  }
}

class UserAvatarUI extends StatelessWidget {
  final double size;
  final String? avatar;
  final double radius;

  const UserAvatarUI({
    super.key,
    required this.size,
    this.avatar,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: (avatar?.isEmpty ?? true)
          ? Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: Theme.of(context).primaryColor.withOpacity(0.9),
              ),
              child: Icon(
                Icons.person,
                size: size - 10,
              ),
            )
          : SizedBox(
              width: size,
              height: size,
              child: ImageWidget(
                avatar!,
                width: size,
                height: size,
                borderRadius: radius,
              ),
            ),
    );
  }
}
