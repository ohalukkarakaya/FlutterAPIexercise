import 'package:api_app/repo/todo_repo.dart';
import 'package:flutter/material.dart';

import '../controller/todo_controller.dart';
import '../models/todo.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // dependenciy set
    var todoController = TodoController(Todorepo());

    return Scaffold(
      appBar: AppBar(
        title: Text("API Exercise"),
      ),
      body: FutureBuilder(
        future: todoController.fetchTodoList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error",
              ),
            );
          }

          return buildBodyContent(snapshot, todoController);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Todo todo = Todo(userId: 3, title: "post", completed: false);
          todoController.postTodo(todo);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  SafeArea buildBodyContent(AsyncSnapshot<dynamic> snapshot, TodoController todoController) {
    return SafeArea(
          child: ListView.separated(
            itemBuilder: (context, index) {
              var todo = snapshot.data?[index];
              return Container(
                height: 100.0,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: Text('${todo?.id}'),
                  ),
                  Expanded(flex: 3, child: Text('${todo?.title}')),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              todoController
                                  .updatePatchComplated(todo!)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "$value",
                                    ),
                                  ),
                                );
                              });
                            },
                            child: contBuilder(
                              "Patch",
                              Colors.grey,
                            ),
                          ),

                          // call put
                          InkWell(
                            onTap: () {
                              todoController.updatePutComplated(todo!);
                            },
                            child: contBuilder(
                              "Put",
                              Colors.grey,
                            ),
                          ),
                          //call delete
                          InkWell(
                            onTap: () {
                              todoController
                                .deleteTodo(todo!)
                                .then((value){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "$value",
                                    ),
                                  ),
                                );
                              });
                            },
                            child: contBuilder(
                              "Del",
                              Colors.red,
                            ),
                          ),
                        ],
                      )),
                ]),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 0.5,
                height: 0.5,
              );
            },
            itemCount: snapshot.data?.length ?? 0,
          ),
        );
  }

  Container contBuilder(String title, Color color) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          "$title",
        ),
      ),
    );
  }
}
