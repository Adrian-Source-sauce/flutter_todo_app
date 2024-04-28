// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todolistwithsqllite/data/dataSources/local_datasource.dart';
import 'package:todolistwithsqllite/pages/home_page.dart';
import 'package:todolistwithsqllite/data/models/note.dart';

class EditPage extends StatefulWidget {
  const EditPage({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.note.title;
    contentController.text = widget.note.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Task',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    labelText: 'Title', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: contentController,
                decoration: InputDecoration(
                    labelText: 'Content', border: OutlineInputBorder()),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Note note = Note(
                  id: widget.note.id,
                  title: titleController.text,
                  content: contentController.text,
                  date: DateTime.now());
              LocalDatasource().update(note);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return  HomePage();
              }));
            }
          },
          child: const Icon(Icons.save),
        ));
  }
}
