import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_tracker/utils/const.dart';

Future<void> updateStatus({required String title}) async {
  await Supabase.instance.client
      .from(TABLE)
      .update({STATUS: "Completed"})
      .eq(TITLE, title);
}
