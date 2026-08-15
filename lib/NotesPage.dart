import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'notes.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  final Box<Note> notesBox = Hive.box<Note>('notes');

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  void addNote() {
    if (titleController.text.isEmpty ||
        contentController.text.isEmpty) {
      return;
    }

    final note = Note(
      title: titleController.text,
      content: contentController.text,
    );

    notesBox.add(note);

    titleController.clear();
    contentController.clear();

    setState(() {});
  }

  void deleteNote(int index) {
    notesBox.deleteAt(index);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    hintText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: addNote,
                  child: const Text('Add Note'),
                ),
              ],
            ),
          ),

          Expanded( // take the remaining space of the app
            child: ListView.builder(
              itemCount: notesBox.length,
              itemBuilder: (context, index) {
                final note = notesBox.getAt(index)!;

                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  trailing: IconButton( // make a delete icon at the right of the list title
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      deleteNote(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}