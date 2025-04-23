import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_tracker/utils/const.dart';

Future<void> deleteTask({required String value}) async {
  await Supabase.instance.client.from(TABLE).delete().eq(TITLE, value);
}
