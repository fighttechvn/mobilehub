const enableLogVideoDebug = false;

extension StringCheat on String {
  String get cloudinaryWorkaround =>
      replaceAll('http://res.cloudinary.com', 'https://res.cloudinary.com');
}

typedef ItemMediaInfo = Map;

const kPackageMedia = 'easy_video';

class VideoIconConstants {
  ///modules/plugins/easy_video/assets/icons/play02.svg
  static const String play = 'assets/icons/play02.svg';
  static const String icForward10 = 'assets/icons/ic_forward_10.png';
  static const String icReplay10 = 'assets/icons/ic_replay_10.png';
  static const String mute = 'assets/icons/mute.svg';
  static const String icVolume = 'assets/icons/ic_volume.svg';
}
