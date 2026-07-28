import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'AddNoteScreen.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Box notesBox = Hive.box("notes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes App")),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddNoteScreen(),
            ),
          );
        },
      ),

      body: ValueListenableBuilder(
        valueListenable: notesBox.listenable(),

        builder: (context, Box box, _) {

          if (box.isEmpty) {
            return const Center(
              child: Text("No Notes Yet"),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              Map note = box.getAt(index);
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(note["title"]),
                  subtitle: Text(note["content"]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddNoteScreen(
                                note: note,
                                index: index,
                              ),
                            ),
                          );
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          notesBox.deleteAt(index);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}