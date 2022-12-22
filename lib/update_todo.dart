import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';

const List<String> completed = <String>[
  'Not yet',
  'Yes',
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
        title: const Text('Update Todo'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 20),
            TextFormField(
              style: const TextStyle(fontWeight: FontWeight.bold),
              controller: titleText,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ex: Jogging',
                labelText: 'Title'
              ),
              validator: (name){
                return (name == '') ? 'Please enter Title' : null;
                },
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: const TextStyle(fontWeight: FontWeight.bold),
              controller: detailsText,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ex: 5AM at the street',
                labelText: 'Details',
              ),
              validator: (name){
                return (name == '') ? 'Please enter Details' : null;}
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                    labelText: 'Done Todo?'
                ),
                icon: const Icon(Icons.arrow_drop_down),
                value: completedText,
                onChanged: (String? value){
                  setState(() {completedText = value!;});
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
                    TodoModel newTodoItem = TodoModel(
                      id: widget.updateTodo.id,
                      title: titleText.text,
                      details: detailsText.text,
                      completed: completedText);
                    Navigator.pop(context,newTodoItem);
                  }},
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
