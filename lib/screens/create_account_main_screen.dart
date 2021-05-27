import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupid_knot_sample/models/user.dart';
import 'package:cupid_knot_sample/screens/create_account_page1.dart';
import 'package:cupid_knot_sample/screens/create_account_page2.dart';
import 'package:cupid_knot_sample/screens/create_account_page3.dart';
import 'package:cupid_knot_sample/screens/finished_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CupidKnotCreateAccountMainScreen extends StatefulWidget {
  const CupidKnotCreateAccountMainScreen({Key? key}) : super(key: key);

  @override
  _CupidKnotCreateAccountMainScreenState createState() =>
      _CupidKnotCreateAccountMainScreenState();
}

class _CupidKnotCreateAccountMainScreenState
    extends State<CupidKnotCreateAccountMainScreen> {
  final _formsPageViewController = PageController();
  int currentPage = 0;
  CupidKnotUser currentUser = CupidKnotUser.empty();
  bool enableButton = false;
  @override
  void initState() {
    super.initState();
  }

  void updateUser(CupidKnotUser user) {
    setState(() {
      currentUser = user;
    });
    checkButtonEnableStatus();
  }

  void _nextFormStep() {
    FocusManager.instance.primaryFocus!.unfocus();
    if (_formsPageViewController.page!.round() < 2) {
      setState(() => {currentPage++});
      _formsPageViewController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      enableButton = false;
    }
  }

  Future<void> _submit() async {
    FocusManager.instance.primaryFocus!.unfocus();
    var user = FirebaseAuth.instance.currentUser;
    final userData = FirebaseFirestore.instance.collection('users');
    final value = currentUser.toMap();
    await userData.add(value);
    print('12');
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CupidKnotFnishedScreen(),
      ),
    );
  }

  bool onWillPop() {
    if (_formsPageViewController.page!.round() ==
        _formsPageViewController.initialPage) return true;

    _formsPageViewController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    setState(() => {currentPage--});
    return false;
  }

  void checkButtonEnableStatus() {
    setState(() {
      if (currentPage == 0) {
        if (currentUser.dob!.day != null &&
            currentUser.dob!.month != null &&
            currentUser.dob!.year != null &&
            currentUser.firstName != null &&
            currentUser.lastName != null &&
            currentUser.phoneNumber != null &&
            currentUser.religion != null &&
            currentUser.income != null) {
          enableButton = true;
        }
      }
      if (currentPage == 1) {
        if (currentUser.gender != null) {
          enableButton = true;
        }
      }
      if (currentPage == 2) {
        if (currentUser.isPrivacyPrivate != null) {
          enableButton = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _forms = [
      WillPopScope(
        onWillPop: () => Future.sync(onWillPop),
        child: CupidKnotCreateAccountPage1(
          user: currentUser,
          onUserChanged: updateUser,
        ),
      ),
      WillPopScope(
        onWillPop: () => Future.sync(onWillPop),
        child: CupidKnotCreateAccountPage2(
          user: currentUser,
          onUserChanged: updateUser,
        ),
      ),
      WillPopScope(
        onWillPop: () => Future.sync(onWillPop),
        child: CupidKnotCreateAccountPage3(
          user: currentUser,
          onUserChanged: updateUser,
        ),
      ),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: false,
      extendBody: false,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          child: currentPage < 2
              ? ElevatedButton(
                  onPressed: enableButton ? _nextFormStep : null,
                  child: Text(
                    'next'.toUpperCase(),
                  ),
                )
              : ElevatedButton(
                  onPressed: enableButton ? _submit : null,
                  child: Text(
                    'Finish'.toUpperCase(),
                  ),
                ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: IconButton(
            icon: Image.asset('assets/03 Create Account/Back.png'),
            onPressed: () {
              if (currentPage == 0) {
                Navigator.pop(context);
              } else {
                onWillPop();
              }
            },
          ),
        ),
        title: Text(
          'Create Account',
          style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              color: Colors.black87),
        ),
      ),
      body: SafeArea(
        child: PageView.builder(
          controller: _formsPageViewController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return _forms[index];
          },
        ),
      ),
    );
  }
}
