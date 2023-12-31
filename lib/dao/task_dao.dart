import '../models/task.dart';

abstract class TaskDAO {
  Future<int> insertTask(Task task);
  Future<Task> getTask(int id);
  Future<List<Task>> getAllTasks();
  Future<int> deleteTask(int id);
  Future<bool> updateStatus(int id, int status);
}