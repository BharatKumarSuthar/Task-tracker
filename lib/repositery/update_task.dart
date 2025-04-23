import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_tracker/dashboard/task_model.dart';
import 'package:task_tracker/utils/const.dart';

Future<void> editTask(TaskModel model, String title) async {
  await Supabase.instance.client
      .from(TABLE)
      .update({TITLE: model.title, STATUS: model.status})
      .eq(TITLE, title);
}
