import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_tracker/dashboard/task_model.dart';
import 'package:task_tracker/utils/const.dart';

Future<void> addTask(TaskModel model) async {
  await Supabase.instance.client.from(TABLE).insert({
    TITLE: model.title,
    STATUS: model.status,
  });
}
