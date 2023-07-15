/// Task model to store the task details
// ignore_for_file: constant_identifier_names

class Task {
  /// id of the task
  /// It is generated automatically
  int id;

  /// name of the task
  String name;

  /// description of the task
  String description;

  /// status of the task
  /// It can be one of the following values: 0 -> pending 1 -> completed 2 -> cancelled
  int status;

  /// constructor
  Task({required this.id, required  this.name, required this.description, this.status = 0});

  int getID() {
    return id;
  }

  String getName() {
    return name;
  }

  String getDescription() {
    return description;
  }

  int getStatus() {
    return status;
  }

  void setName(String name) {
    this.name = name;
  }

  void setDescription(String description) {
    this.description = description;
  }

  /// toggle the status of the task between pending, completed and cancelled
  void toggleStatus(int status) {
    if (status < 0 || status > 2) {
      throw Exception('Invalid status');
    }
    this.status = status;
  }

  factory Task.fromJSON(Map<String, dynamic> json) => Task(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    status: json['status'],
  );

  Map<String, dynamic> toJSON() => {
    'id': id,
    'name': name,
    'description': description,
    'status': status,
  };

  @override
  String toString() {
    return 'Task{id: $id, name: $name, description: $description, status: $status}';
  }
}

class TaskStatus {
  static const int PENDING = 0;
  static const int COMPLETED = 1;
  static const int CANCELLED = 2;
}