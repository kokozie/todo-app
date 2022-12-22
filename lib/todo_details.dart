import 'package:flutter/material.dart';

class TodoDetails extends StatefulWidget {

  final dynamic todos;
  const TodoDetails({required this.todos,Key? key}) : super(key: key);

  @override
  State<TodoDetails> createState() => _TodoDetailsState();
}

class _TodoDetailsState extends State<TodoDetails> {


  Widget rowItem(String title, dynamic value) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child:
          Text(title,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold)
          )
        ),
        const SizedBox(width: 5),
        Flexible(child: Text(value.toString(),
        textAlign: TextAlign.justify,
        style: const TextStyle(fontSize: 20))
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Details'),
      ),
      body:  ListView(
        padding: const EdgeInsets.all(15),
        children: [
          rowItem("Title:",(widget.todos.title)),
          const SizedBox(height: 10),
          rowItem("Details:", widget.todos.details),
          const SizedBox(height: 10),
          rowItem("Completed:", widget.todos.completed)
        ],
      ),
    );
  }
}