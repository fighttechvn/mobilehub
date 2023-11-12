// ignore_for_file: cascade_invocations

import 'package:args/args.dart';

import 'src/obfuscation_package.dart';

void main(List<String> args) {
  final parser = ArgParser();
  parser.addOption(
    'path',
    callback: (path) => {obfuscationPackage(args: args)},
  );
  parser.parse(args);
}
