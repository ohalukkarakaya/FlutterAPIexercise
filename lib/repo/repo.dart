import '../models/todo.dart';

abstract class Repo {
  //get
  Future<List<Todo>> getTodoList();
  
  //patch
  Future<String> patchComplated(Todo todo);

  //put
  Future<String> putComplated(Todo todo);

  //delete
  Future<String> deletedTodo(Todo todo);

  //post
  Future<String> postTodo(Todo todo);
}