import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zartek/view/LoginPhone.dart';
import 'package:zartek/view/homeScreen.dart';

class UserAuthentication extends StatefulWidget {
  const UserAuthentication({Key key}) : super(key: key);

  @override
  State<UserAuthentication> createState() => _UserAuthenticationState();
}

class _UserAuthenticationState extends State<UserAuthentication> {
  User _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool isSignIn =false;
  bool google =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/firebase.png",height: 90,width: 90),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF528BF7),
                  shadowColor: Colors.transparent
              ),
              onPressed: () {
                _signInWithGoogle();
              },
              child: Row(
                children: [
                  Image.asset("assets/images/google.png",width: 18,height: 18,), // <-- Text
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("Google")
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.only(left: 20,right: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF10A51D),
                  shadowColor: Colors.transparent
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPhoneScreen()));
              },
              child: Row(
                children: [
                  Image.asset("assets/images/phone.png",width: 18,height: 18,), // <-- Text
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("Phone")
                ],
              ),
            ),
          ),
        ],
      )

    );
  }

  Future<void> _signInWithGoogle() async{
    GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    print('${userCredential.user.displayName}');
    if(userCredential != null){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => HomeScreen(authType: "google")
      ));
    }
  }
}
