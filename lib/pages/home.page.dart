import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:language/repositories/user_repositories.dart';
import '../widgets/drawer.widget.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserRepository userRepository = UserRepository(firebaseAuth: FirebaseAuth.instance);
  var datas;
  @override
  Widget build(BuildContext context) {
    User? user = userRepository.getCurrentUser();
    String? uid = user?.uid;
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("users").where('uid',isEqualTo: uid).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Some Error');
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting :
                      return Center(child: CircularProgressIndicator());
                    default : return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        return Center(
                          child: Text('Welcome back '+data['name'],style: Theme.of(context).textTheme.headline4,),
                        );
                      }).toList(),
                    );
                  }
                }
            ),
          ],
        )
    );
  }
}




/*final String documentId;

GetUserName(this.documentId);

@override
Widget build(BuildContext context) {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  return FutureBuilder<DocumentSnapshot>(
    future: users.doc(documentId).get(),
    builder:
        (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

      if (snapshot.hasError) {
        return Text("Something went wrong");
      }

      if (snapshot.hasData && !snapshot.data!.exists) {
        return Text("Document does not exist");
      }

      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        return Text("Full Name: ${data['full_name']} ${data['last_name']}");
      }

      return Text("loading");
    },
  );
}*/


