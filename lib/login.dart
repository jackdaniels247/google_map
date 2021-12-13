// @dart=2.9
import 'package:authenticator_app/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Auth")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(

              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: const Center(
                      child: Text("Phone Authentication",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28))

                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40,right: 10,left: 10),
                  child: TextField(
                    decoration: const InputDecoration(
                        hintText: 'Phone Number',
                        prefix: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text('+91'),
                        )
                    ),
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: _controller,
                  ),
                )
              ]),
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
              child: FlatButton(
                color: Colors.blue,
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=> const Home()
                  ));
                },
                child: const Text('Next',style: TextStyle(color: Colors.white),),
              ),
          )
        ],
      )


    );
  }
}
