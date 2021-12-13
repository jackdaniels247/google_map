// @dart=2.9
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart  ';
import 'home.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTPScreen extends StatefulWidget {

  final String phone;

  OTPScreen(this.phone);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey=GlobalKey<ScaffoldState>();
  String _verificationCode='';
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Verify +91-${widget.phone}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(20.0),
            child: PinPut(
              fieldsCount: 6,
              onSubmit: (pin) async {
                try{
                  await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(
                    verificationId:_verificationCode,smsCode:pin
                  )).then((value) async {
                    if(value.user!=null){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Home()), (route) => false);
                    }
                  });
                }
                catch(e){
                  FocusScope.of(context).unfocus();
                  _scaffoldkey.currentState
                      .showSnackBar(const SnackBar(content: Text('invalid OTP')));

                }
              },
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: _pinPutDecoration.copyWith(
                borderRadius: BorderRadius.circular(20.0),
              ),
              selectedFieldDecoration: _pinPutDecoration,
              followingFieldDecoration: _pinPutDecoration.copyWith(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: Colors.deepPurpleAccent.withOpacity(.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
            if(value.user!=null){
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                      (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e){
          print(e.message);
        },
        codeSent: (String verificationID, resendToken){
          setState(() {
            _verificationCode=verificationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId){
          setState(() {
            _verificationCode=verificationId;
          });
        },timeout: const Duration(seconds: 60));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}
