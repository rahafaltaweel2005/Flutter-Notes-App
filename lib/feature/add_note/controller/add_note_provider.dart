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
    if (title.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Title is required")));
      return false;
    }
    if (content.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Content is required")));
      return false;
    }
    try {
      isLoading = true;
      notifyListeners();
      final Map<String, dynamic> requestBody = {
        "title": title.trim(),
        "content": content.trim(),
      };
      print("Request Body: ${jsonEncode(requestBody)}");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      print("Status Code :${response.statusCode}");
      print("Response Body :${response.body}");
      if (response.body.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Empty response from server")));
        return false;
      }
      final decodedJson = jsonDecode(response.body);

      if(decodedJson is! Map<String, dynamic>){
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Invalid response format")));
      return false;
      }
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Success")));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GetAllNotesScreen()),
        );
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
