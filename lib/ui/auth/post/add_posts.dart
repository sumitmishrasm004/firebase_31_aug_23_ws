import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_application_1/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController = TextEditingController();
  bool isLoading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "What is in your mind?",
                border: OutlineInputBorder(),
              ),
              controller: postController,
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(title: 'Add', onTap: () async{
              setState(() {
                isLoading = true;
              });
              // databaseRef.child(DateTime.now().millisecondsSinceEpoch.toString()).child('Comments').set({
              //   'id' : 1,
              //   'note' : postController.text.toString(),
              // });
              String id = DateTime.now().millisecondsSinceEpoch.toString();
              try {
               await databaseRef.child(id).set({
                'id' : id,
                'note' : postController.text.toString(),
              });
              Utils().toastMessage('Post Added');
              setState(() {
                isLoading = false;
              });
              } catch (e) {
                Utils().toastMessage(e.toString());
                setState(() {
                isLoading = false;
              });
              }
              
            }),
          ],
        ),
      ),
    );
  }
}
