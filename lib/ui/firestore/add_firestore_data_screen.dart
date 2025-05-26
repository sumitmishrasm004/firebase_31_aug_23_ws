import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_application_1/widgets/round_button.dart';

class AddFirestoreDataScreen extends StatefulWidget {
  const AddFirestoreDataScreen({super.key});

  @override
  State<AddFirestoreDataScreen> createState() => _AddFirestoreDataScreenState();
}

class _AddFirestoreDataScreenState extends State<AddFirestoreDataScreen> {
  final postController = TextEditingController();
  bool isLoading = false;
  final fireStore = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Firestore Data'),
        centerTitle: true,
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
              String id = DateTime.now().millisecondsSinceEpoch.toString();
              fireStore.doc(id).set({
                'title' : postController.text.toString(),
                'id' : id,
              }).then((value) {
                Utils().toastMessage('Post Added');
                setState(() {
                isLoading = false;
              });
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
                setState(() {
                isLoading = false;
              });
              });
             
              
            }),
          ],
        ),
      ),
    );
  }
}
