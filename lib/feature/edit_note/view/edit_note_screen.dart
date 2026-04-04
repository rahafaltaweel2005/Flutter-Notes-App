import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/edit_note_provider.dart';


class EditNoteScreen extends StatefulWidget {
  final String id;
  final String title;
  final String content;

  const EditNoteScreen({
    super.key,
    required this.id,
    required this.title,
    required this.content,
  });
  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController id = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  @override
  void initState() {
    super.initState();
    id.text = widget.id;
    title.text = widget.title;
    content.text = widget.content;
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final addNote = context.watch<EditNoteProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
        actions: [
          ElevatedButton(
            onPressed: () {
              addNote.editNote(
                context: context,
                id: id.text,
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
            controller: id,
            decoration: InputDecoration(
              hintText: "id",
              border: OutlineInputBorder(),
            ),
          ), TextField(
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
