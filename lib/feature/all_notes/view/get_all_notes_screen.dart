import 'package:assignment6/feature/all_notes/model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../add_note/view/add_note_screen.dart';
import '../../edit_note/view/edit_note_screen.dart';
import '../controller/get_All_Notes_Provider.dart';
import '../model/get_note.dart';

class GetAllNotesScreen extends StatefulWidget {
  const GetAllNotesScreen({super.key});

  @override
  State<GetAllNotesScreen> createState() => _GetAllNotesScreenState();
}

class _GetAllNotesScreenState extends State<GetAllNotesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetAllNotesProvider>().getAllNote(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final allNote = context.watch<GetAllNotesProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("Note"), actions: []),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: size.width * 0.02,
              vertical: size.height * 0.02,
            ),
            child: Row(
              children: [
                Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      allNote.notesList[index].title.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    Text(allNote.notesList[index].content.toString()),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNoteScreen(
                          id: allNote.notesList[index].id.toString(),
                          title: allNote.notesList[index].title.toString(),
                          content: allNote.notesList[index].content.toString(),
                        ),
                      ),
                    );
                  },
                  child: Icon(Icons.edit),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: allNote.notesList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNoteScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
