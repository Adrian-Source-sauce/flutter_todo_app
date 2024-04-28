import 'package:flutter/material.dart';
import 'package:todolistwithsqllite/data/dataSources/local_datasource.dart';
import 'package:todolistwithsqllite/data/models/note.dart';
import 'package:todolistwithsqllite/pages/home_page.dart';


class Tambah extends StatefulWidget {
  const Tambah({super.key});

  @override
  State<Tambah> createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Task',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        
      ),
      body: Form(
        key: _formKey,
        child: ListView (
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter content';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Note note = Note(
                  title: titleController.text,
                  content: contentController.text,
                  date: DateTime.now(),
                );

                LocalDatasource().insert(note);
                titleController.clear();
                contentController.clear();
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Rencana berhasil ditambahkan'),
                    backgroundColor: Colors.green,
                  ),
                );
                 Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const HomePage();
          }));
                }
              },
              child: const Text('Save'),
            ),
          ],
        )),
    );
  }
}