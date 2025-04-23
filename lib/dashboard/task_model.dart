class TaskModel {
  String title = "";
  String status = "";
  TaskModel({required this.title, required this.status});
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(title: json['title'] ?? '', status: json['status'] ?? '');
  }
  TaskModel copyWith({String? title, String? status}) {
    return TaskModel(title: title ?? this.title, status: status ?? this.status);
  }
}
