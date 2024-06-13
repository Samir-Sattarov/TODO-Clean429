// ignore_for_file: must_be_immutable

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ErrorFlushBar extends Flushbar {
  final String msg;

  ErrorFlushBar(this.msg, {Key? key}) : super(key: key);

  @override
  String? get message => msg;

  @override
  Widget get messageText => Text(
        msg,
        style: const TextStyle(
          color: Colors.white,
        ),
      );

  @override
  FlushbarPosition get flushbarPosition => FlushbarPosition.BOTTOM;

  @override
  Duration? get duration => const Duration(seconds: 2);

  @override
  BorderRadius? get borderRadius => BorderRadius.circular(10);

  @override
  Color? get leftBarIndicatorColor => Colors.red;

  @override
  Widget? get icon => const Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.red,
      );

  @override
  EdgeInsets get margin => const EdgeInsets.all(8);

// @override
// BorderRadius? get borderRadius => BorderRadius.circular(8);
}
