import 'dart:convert';

import 'package:api_app/models/todo.dart';
import 'package:api_app/repo/repo.dart';
import 'package:http/http.dart' as http;

class Todorepo implements Repo {
  // Use http
  String dataUrl = "https://jsonplaceholder.typicode.com";
  @override
  Future<String> deletedTodo(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    var result = 'false';
    await http.delete(url).then((value) {
      print(value.body);

      return result = 'true';
    });
    return result;
  }

  //get
  @override
  Future<List<Todo>> getTodoList() async {
    List<Todo> todoList = [];
    var url = Uri.parse('$dataUrl/todos');
    var response = await http.get(url);

    print('status code: ${response.statusCode}');
    var body = json.decode(response.body);

    //parse
    for (var i = 0; i < body.length; i++) {
      todoList.add(Todo.fromJson(body[i]));
    }
    return todoList;
  }

  //patch
  @override
  Future<String> patchComplated(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    //call data
    String resData = '';

    await http.patch(
    url,
    body: {
      'completed': (!todo.completed!).toString(),
    },
    headers: {'Authorization' : 'your_token'},
    ).then((response){
      Map<String, dynamic> result = json.decode(response.body);
      return resData = result['completed'];
      //call
    });

    return resData;
  }

  @override
  Future<String> putComplated(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    //call data
    String resData = '';

    await http.put(
    url,
    body: {
      'completed': (!todo.completed!).toString(),
    },
    headers: {'Authorization' : 'your_token'},
    ).then((response){
      Map<String, dynamic> result = json.decode(response.body);
      print(result);
      return resData = result['completed'];
      //call
    });

    return resData;
  }

  @override
  Future<String> postTodo(Todo todo) async {
    print('${todo.toJson()}');
    var url = Uri.parse('$dataUrl/todos/');
    var result = '';
    var response = await http.post(url, body: todo.toJson());
    //Fake server => get return type != post type
    print(response.statusCode);
    print(response.body);
    return 'true';
  }
}
