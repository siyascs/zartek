import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zartek/utils/Colors.dart';
import 'package:zartek/view/authenitcationScreen.dart';
import 'package:zartek/view/homeScreen.dart';
import 'package:zartek/widget/styles.dart';

class LoginPhoneScreen extends StatefulWidget {
  @override
  State<LoginPhoneScreen> createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  final _phoneController = TextEditingController();

  final _codeController = TextEditingController();

  bool _isLogin = false;

  Future<bool> loginUser(String phone, BuildContext context) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: "+91$phone",
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          Navigator.of(context).pop();

          UserCredential result = await _auth.signInWithCredential(credential);

          User user = result.user;

          if(user != null){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => HomeScreen(authType: "phone")
            ));
          }else{
            print("Error");
          }

        },
        verificationFailed: (FirebaseAuthException exception){
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Confirm"),
                      // textColor: Colors.white,
                      // color: Colors.blue,
                      onPressed: () async{
                        final code = _codeController.text.trim();
                        AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);

                        UserCredential result = await _auth.signInWithCredential(credential);

                        User user = result.user;

                        if(user != null){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => HomeScreen(authType: "phone")
                          ));
                        }else{
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              }
          );
        },
        codeAutoRetrievalTimeout: null
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.grey),
            onPressed: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => UserAuthentication()
            )),
          ),
          title:  Text("Login",style: poppinsMediumText()),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[300])
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Mobile Number"

                    ),
                    controller: _phoneController,
                  ),

                  SizedBox(height: 16,),


                  if(_isLogin==false)Container(
                    width: double.infinity,
                    child: TextButton(
                      child: Text("LOGIN"),

                      onPressed: () {
                        final phone = _phoneController.text.trim();
                        loginUser(phone, context);
                        setState((){
                          _isLogin=true;
                        });

                      },
                      // color: Colors.blue,
                    ),
                  ),
                  if(_isLogin==true)Container(
                    width: double.infinity,
                    child: TextButton(
                      child: Text("Please Wait..."),

                      onPressed: () {
                        },
                      // color: Colors.blue,
                    ),
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
}
