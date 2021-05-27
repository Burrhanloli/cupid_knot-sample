import 'package:cupid_knot_sample/screens/google_connect_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CupidKnotFnishedScreen extends StatefulWidget {
  const CupidKnotFnishedScreen({Key? key}) : super(key: key);

  @override
  _CupidKnotFnishedScreenState createState() => _CupidKnotFnishedScreenState();
}

class _CupidKnotFnishedScreenState extends State<CupidKnotFnishedScreen> {
  void _startOver() {
    Future.delayed(
      const Duration(seconds: 1),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CupidKnotGoogleConnectScreen(),
        ),
      ),
    );
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
                  flex: 3,
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Center(
                      child:
                          Image.asset('assets/06 Successfully/checklist 1.png'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Your profile has been saved\n Successfully',
                      style: GoogleFonts.montserrat(
                        color: Colors.black45,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _startOver,
                      child: Text(
                        "Let's Start",
                      ),
                    ),
                  ),
                )),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
