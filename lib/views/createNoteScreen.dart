import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController NotesController = TextEditingController();
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Create Peaceful Notes"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: NotesController,
                maxLines: null,
                decoration: InputDecoration(hintText: "Add Notes"),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                var note = NotesController.text.trim();

                if (note != "") {
                  try {
                    await FirebaseFirestore.instance
                        .collection("notes")
                        .doc()
                        .set({
                      "createdAt": DateTime.now(),
                      "notes": note,
                      "userId": userId?.uid, //null check by ?
                    });
                    Navigator.pop(context); // Go back after saving note
                  } catch (e) {
                    print("Error: $e");
                  }
                }
              },
              child: Icon(Icons.check),
            ),
          ],
        ),
      ),
    );
  }
}
