import '../models/todo.dart';
import '../repo/repo.dart';

class TodoController {
  final Repo _repo;

  TodoController(this._repo);

  //get
  Future<List<Todo>> fetchTodoList() async {
    return _repo.getTodoList();
  }

  //patch
  Future<String> updatePatchComplated(Todo todo) async {
    return _repo.patchComplated(todo);
  }

  //put
  Future<String> updatePutComplated(Todo todo) async {
    return _repo.putComplated(todo);
  }

  //delete
  Future<String> deleteTodo(Todo todo) async {
    return _repo.deletedTodo(todo);
  }

  //post
  Future<String> postTodo(Todo todo) async {
    return _repo.postTodo(todo);
  }
}