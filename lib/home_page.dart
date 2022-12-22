import 'package:flutter/material.dart';
import 'package:todo_app/todo_details.dart';
import 'package:todo_app/add_todo.dart';
import 'package:todo_app/update_todo.dart';
import 'db/database_helper.dart';
import 'model/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List todos = <dynamic>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        elevation: 4,
        backgroundColor: Colors.black38,
      ),
      body: Center(
        child: FutureBuilder<List<TodoModel>>(
          future: DatabaseHelper.instance.getTodoModel(),
          builder: (context, AsyncSnapshot<List<TodoModel>> snapshot){
            if(snapshot.hasData){
              todos = snapshot.data!;
              return ListView.builder(
                itemCount: todos.length,
                  itemBuilder: (context,index){
                  final todo = todos[index];
                  return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction){
                      setState(() {
                        todos.removeAt(index);
                        DatabaseHelper.instance.remove(todo.id);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Todo Deleted')));
                      },
                      child: Card(
                        child:ListTile(
                          title: Text(todo.title),
                          tileColor: Colors.white10,
                          subtitle: Text('Done todo: ${todo.completed}'),
                          trailing: ElevatedButton(
                              onPressed: ()async{
                                var updateTodo = await Navigator.push(
                                    context, MaterialPageRoute(builder: (context) =>
                                    UpdateTodo(updateTodo:todo)));
                                await DatabaseHelper.instance.update(updateTodo);
                                setState(() {todos[index] = updateTodo;});
                                },
                              child: const Text('Update')),
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    TodoDetails(todos: todo)));
                            },
                        ),
                      )
                  );
                }
              );
            }
            return const Center(child: Icon(Icons.close));
            },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: ()async{
          var result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTodo())
          );
          setState(() {
            todos.add(result);
          });
          },
      ),
    );
  }
}