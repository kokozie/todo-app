import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';

const List<String> completed = <String>[
  'Yes',
  'No',
];

class UpdateTodo extends StatefulWidget {
  final TodoModel updateTodo;
  const UpdateTodo({Key? key,required this.updateTodo}) : super(key: key);

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {

  var formKey = GlobalKey<FormState>();
  late final titleText =  TextEditingController(text: widget.updateTodo.title);
  late final detailsText =  TextEditingController(text: widget.updateTodo.details);
  String completedText = completed.first;


  @override
  void dispose(){
    titleText.dispose();
    detailsText.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add ToDo'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [

            const SizedBox(height: 20),
            TextFormField(
              controller: titleText,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Ex: Jogging',
                labelText: 'Title',
              ),
              validator: (name){
                return (name == '') ? 'Please enter Title' : null;
              },
            ),
            TextFormField(
              controller: detailsText,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Ex: 5AM at the street',
                labelText: 'Details',
              ),
              validator: (name){
                return (name == '') ? 'Please enter Details' : null;
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
                hint: const Text(' '),
                icon: const Icon(Icons.arrow_drop_down),
                value: completedText,
                onChanged: (String? value){
                  setState(() {
                    completedText = value!;
                  });
                },
                items: completed.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 20,
              child: ElevatedButton(
                onPressed: () async{
                  var validForm = formKey.currentState!.validate();
                  if (validForm) {
                    TodoModel newTodoItem = TodoModel(
                      id: widget.updateTodo.id,
                      title: titleText.text,
                      details: detailsText.text,
                      completed: completedText,
                    );
                    Navigator.pop(context,newTodoItem);
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
