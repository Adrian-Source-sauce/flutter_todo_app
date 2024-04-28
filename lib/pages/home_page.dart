// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:todolistwithsqllite/data/dataSources/local_datasource.dart';
import 'package:todolistwithsqllite/data/models/note.dart';
import 'package:todolistwithsqllite/pages/detail_page.dart';
import 'package:todolistwithsqllite/pages/tambah_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];

  bool isLoading = false;

  Future<void> getNotes() async {
    setState(() {
      isLoading = true;
    });
    notes = await LocalDatasource().getNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Todo List Adrian',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: notes.isEmpty
            ? const Center(
                child: Text(
                  'Belum ada data',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              )
            : isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DetailPage(
                                note: notes[index],
                              );
                            }));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: Color.fromARGB(255, 255, 0, 0),
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('Hapus data'),
                                              content:
                                                  const Text('Apa anda yakin'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text('Batalkan')),
                                                TextButton(
                                                    onPressed: ()  {
                                                      LocalDatasource()
                                                          .delete(notes[index]);
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return const HomePage();
                                                      }));
                                                    },
                                                    child: const Text("Hapus"))
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    notes[index].title,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    notes[index].content,
                                    style: const TextStyle(
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                    itemCount: notes.length,
                  ),
        backgroundColor: Colors.deepPurple,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const Tambah();
            }));
          },
          backgroundColor: Colors.purple,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
