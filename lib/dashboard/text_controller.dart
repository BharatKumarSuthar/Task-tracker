import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var textProvider = StateProvider<String>((ref) {
  return "";
});
var title = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});

var status = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController(text: ref.watch(textProvider));
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
