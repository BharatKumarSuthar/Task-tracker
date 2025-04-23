import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_tracker/dashboard/task_model.dart';
import 'package:task_tracker/utils/const.dart';

Future<List<TaskModel>> getTasks() async {
  final response = await Supabase.instance.client.from(TABLE).select();
  List<TaskModel> tasks =
      (response as List)
          .map((item) => TaskModel.fromJson(item as Map<String, dynamic>))
          .toList();
  return tasks;
}
