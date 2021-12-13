// @dart=2.9
import 'package:authenticator_app/screens/google_map.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

 //import 'login.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //String uid='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.logout),
        //     onPressed: () async {
        //       await FirebaseAuth.instance.signOut();
        //       Navigator.pushAndRemoveUntil(
        //           context,
        //           MaterialPageRoute(builder: (context) => const LoginScreen()),
        //               (route) => false);
        //     },
        //   )
        // ],
      ),
      body: const Center(
        child: Text('Google Map Demo',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Google()),
                  (route) => false);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation),
      ),
    );
  }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   uid = FirebaseAuth.instance.currentUser.uid;
  // }
}
