import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/add_note_provider.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final addNote = context.watch<AddNoteProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
        actions: [
          ElevatedButton(
            onPressed: () {
              addNote.addNote(
                context: context,
                title: title.text,
                content: content.text,
              );
            },
            child: Icon(Icons.check_rounded),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          TextField(
            controller: title,
            decoration: InputDecoration(
              hintText: "Title",
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: content,
            decoration: InputDecoration(
              hintText: "Content",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
