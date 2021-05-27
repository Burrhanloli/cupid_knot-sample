import 'package:cupid_knot_sample/screens/google_connect_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CupidKnotSplashScreen extends StatefulWidget {
  const CupidKnotSplashScreen({Key? key}) : super(key: key);

  @override
  _CupidKnotSplashScreenState createState() => _CupidKnotSplashScreenState();
}

class _CupidKnotSplashScreenState extends State<CupidKnotSplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
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
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Center(
                      child: Image.asset('assets/01 Splas Screen/Logo.png'),
                    ),
                  ),
                ),
                Text(
                  'Chalo Banaye,',
                  style: GoogleFonts.montserrat(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.0),
                ),
                const SizedBox(height: 10),
                Text(
                  'Ek Naya Rishta',
                  style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 4.0,
                      color: Colors.black87),
                ),
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/01 Splas Screen/img.png'),
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
