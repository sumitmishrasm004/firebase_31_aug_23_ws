import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/auth/login_screen.dart';
import 'package:flutter_application_1/ui/auth/post/add_posts.dart';
import 'package:flutter_application_1/utils/utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchController = TextEditingController();
  final editController = TextEditingController();

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
        title: Text("Post"),
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
              MaterialPageRoute(builder: (context) => AddPostScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (String value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: 'Search', border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 30,
          ),
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
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                final title = snapshot.child('note').value.toString();
                final id = snapshot.child('id').value.toString();
                if (searchController.text.isEmpty) {
                  return ListTile(
                    title: Text(snapshot.child('note').value.toString()),
                    subtitle: Text(id),
                    trailing: PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      itemBuilder: (context) =>[ 
                        PopupMenuItem(child: ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Edit'),
                        onTap: (){
                          Navigator.pop(context);
                          showMyDialog(title , id);
                        },
                      )),
                        PopupMenuItem(child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text('Delete'),
                        onTap: (){
                          Navigator.pop(context);
                          ref.child(id).remove();
                        },
                      )),
                      ]),
                  );
                } else if (title
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase().toString())) {
                  return ListTile(
                    title: Text(snapshot.child('note').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                  );
                } else {
                  return Container();
                }
              },
              defaultChild: Text("Loading"),
            ),
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
              ref.child(id).update({
                'note' : editController.text.toString(),
              }).then((value) {
                Utils().toastMessage("Post Updated");
              }).onError((error, stackTrace) {
                 Utils().toastMessage(error.toString());
              });
            }, child: Text('Update')),
          ],
        );
      }
    );
  }
}
