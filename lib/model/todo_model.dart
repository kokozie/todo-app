class TodoModel{
  int? id;
  String title;
  String details;
  String completed;

  TodoModel({
    this.id,
    required this.title,
    required this.details,
    required this.completed});

  factory TodoModel.fromMap(Map<String, dynamic>json) => TodoModel(
      id: json['id'],
      title: json['title'],
      details: json['details'],
      completed: json['completed']);

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'title':title,
      'details':details,
      'completed': completed,
    };
  }
}