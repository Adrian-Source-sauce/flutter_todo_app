// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todolistwithsqllite/data/models/note.dart';
import 'edit_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.note,
  }) : super(key: key);


  final Note note;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Detail Task',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children:  [
          Text(widget.note.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(widget.note.content,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditPage(note: widget.note,);
          }));
        },
        child: const Icon(Icons.edit),
      )
    );  
  }
}