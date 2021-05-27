import 'package:cupid_knot_sample/screens/create_account_main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CupidKnotGoogleConnectScreen extends StatefulWidget {
  const CupidKnotGoogleConnectScreen({Key? key}) : super(key: key);

  @override
  _CupidKnotGoogleConnectScreenState createState() =>
      _CupidKnotGoogleConnectScreenState();
}

class _CupidKnotGoogleConnectScreenState
    extends State<CupidKnotGoogleConnectScreen> {
  Future<void> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    var instance = FirebaseAuth.instance;

    await instance.signInWithCredential(credential);
    if (instance.currentUser != null) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CupidKnotCreateAccountMainScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Center(
                      child: Image.asset(
                          'assets/02 Connect with google/Seddow Logo.png'),
                    ),
                  ),
                ),
                Text(
                  'Welcome !',
                  style: GoogleFonts.montserrat(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Sign in or Sign up With Google',
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    width: 150,
                    height: 150,
                    child: GestureDetector(
                      onTap: signInWithGoogle,
                      child: Image.asset(
                          'assets/02 Connect with google/Contact with google.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Contact with google',
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      'assets/01 Splas Screen/img.png',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
