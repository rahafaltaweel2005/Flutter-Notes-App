import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feature/add_note/controller/add_note_provider.dart';
import 'feature/all_notes/controller/get_All_Notes_Provider.dart';
import 'feature/all_notes/view/get_all_notes_screen.dart';
import 'feature/edit_note/controller/edit_note_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetAllNotesProvider()),
        ChangeNotifierProvider(create: (_) => AddNoteProvider()),
        ChangeNotifierProvider(create: (_) => EditNoteProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: GetAllNotesScreen(),
    );
  }
}
