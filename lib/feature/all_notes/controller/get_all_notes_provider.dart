import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/constant/api_const.dart';
import '../model/get_note.dart';
import '../model/note_model.dart';

class GetAllNotesProvider extends ChangeNotifier {
  bool isLoading = true;
  final url = Uri.parse(ApiConst.get_note);
  List<NoteModel> notesList = [];

  Future getAllNote({required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Success")));
        GetNote notes = GetNote.fromJson(data);
        notesList = notes.data ?? [];
        notifyListeners();
      } else if (response.statusCode == 409) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("conflict")));
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("bad request")));
      } else if (response.statusCode == 500) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Something went error")));
      }
    } catch (error) {
      print("Exception $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
