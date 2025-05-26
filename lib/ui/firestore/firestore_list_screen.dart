import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/auth/login_screen.dart';
import 'package:flutter_application_1/ui/firestore/add_firestore_data_screen.dart';
import 'package:flutter_application_1/utils/utils.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final _auth = FirebaseAuth.instance;
  final editController = TextEditingController();
   final fireStore = FirebaseFirestore.instance.collection('users').snapshots();
  Future<void> signOut(context) async {
    try {
      final value = await _auth.signOut();
      debugPrint("Successfully sign out");
      Utils().toastMessage("Successfully sign out");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } catch (e) {
      debugPrint("failed to sign out");
      Utils().toastMessage("failed to sign out");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () async => signOut(context),
              icon: Icon(Icons.login_outlined)),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddFirestoreDataScreen ()));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          // StreamBuilder<QuerySnapshot>(
          //   stream: fireStore,
          //   builder: (BuildContext context , AsyncSnapshot snapshot) {
              
          // }),
          // Stream builder

          // Expanded(child: StreamBuilder(
          //   stream: ref.onValue,
          //   builder: (context, AsyncSnapshot<DatabaseEvent> snapshot){
          //   if(!snapshot.hasData){
          //     return CircularProgressIndicator();
          //   } else {

          //     Map<dynamic , dynamic> map = snapshot.data!.snapshot.value as dynamic;
          //     List<dynamic> list = [];
          //     list.clear();
          //     list = map.values.toList();

          //     return ListView.builder(
          //       itemCount: snapshot.data!.snapshot.children.length,
          //       itemBuilder: (context, index){
          //       return ListTile(
          //         title: Text(list[index]['note']),
          //         subtitle: Text(list[index]['id'].toString()),
          //       );
          //     });
          //   }
          // })),

          // Firebase Animated Widget
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text('addd'),
                );
            })
          ),
        ],
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Update'),
          content: Container(
            child: TextField(
              controller: editController,
              decoration: InputDecoration(
                hintText: 'Edit',
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Cancel')),
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Update')),
          ],
        );
      }
    );
  }
}