import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../core/constant/api_const.dart';
import 'package:http/http.dart' as http;

import '../../all_notes/view/get_all_notes_screen.dart';

class AddNoteProvider extends ChangeNotifier {
  bool isLoading = true;
  final url = Uri.parse(ApiConst.add_note);

  Future addNote({
    required BuildContext context,
    required String title,
    required String content,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await http.post(url, 
          body: jsonEncode({
            "title" : title,
            "content" :content
          }));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Success")));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GetAllNotesScreen(),));

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
