import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';
import 'db/database_helper.dart';


const List<String> completed = <String>[
  'Not yet',
  'Yes',
];
class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  var formKey = GlobalKey<FormState>();
  final titleText =  TextEditingController();
  final detailsText =  TextEditingController();
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
        title: const Text('Add Todo'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(

              controller: titleText,
              style: const TextStyle(fontWeight: FontWeight.bold),
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ex: Jogging',
                labelText: 'Title',
              ),
              validator: (name){
                return (name == '') ? 'Please enter Title' : null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: detailsText,
              keyboardType: TextInputType.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ex: 5AM at the street',
                labelText: 'Details',

              ),
              validator: (name){
                return (name == '') ? 'Please enter Details' : null;
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Done Todo?',
                ),
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
              height: 50,
              child: ElevatedButton(
                onPressed: () async{
                  var validForm = formKey.currentState!.validate();
                  if (validForm) {
                    TodoModel newTodo = TodoModel(
                      title: titleText.text,
                      details:  detailsText.text,
                      completed: completedText,
                    );
                    await DatabaseHelper.instance.add(newTodo);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context,newTodo);
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