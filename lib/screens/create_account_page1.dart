import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cupid_knot_sample/models/user.dart';

class CupidKnotCreateAccountPage1 extends StatefulWidget {
  const CupidKnotCreateAccountPage1({
    Key? key,
    required this.user,
    required this.onUserChanged,
  }) : super(key: key);
  final CupidKnotUser user;
  final void Function(CupidKnotUser) onUserChanged;
  @override
  _CupidKnotCreateAccountPage1State createState() =>
      _CupidKnotCreateAccountPage1State();
}

class _CupidKnotCreateAccountPage1State
    extends State<CupidKnotCreateAccountPage1> {
  CupidKnotUser user = CupidKnotUser.empty();
  String age = '-';

  @override
  void initState() {
    super.initState();
    final loogedInUser = FirebaseAuth.instance.currentUser;
    if (loogedInUser != null) {
      final names = loogedInUser.displayName!.split(' ');
      user = widget.user.copyWith(
        firstName: names[0],
        lastName: names.length > 1 ? names[1] : names[0],
      );
    } else {
      user = widget.user;
    }
  }

  final months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final days = List<String>.generate(31, (i) => (i + 1).toString());

  final years = [
    ...List<String>.generate(
        99, (i) => "19${(i + 1).toString().padLeft(2, '0')}"),
    ...List<String>.generate(
        10, (i) => "20${(i + 1).toString().padLeft(2, '0')}")
  ];

  final religions = [
    'Islam',
    'Christainity',
    'Jewism',
    'Hinduism',
  ];

  void checkandUpdateUserAge(DOB userDob) {
    if (userDob.month != null && userDob.year != null && userDob.day != null) {
      final dob = DateTime(
        int.parse(userDob.year!),
        int.parse(userDob.month!),
        int.parse(userDob.day!),
      );

      final differenceInDays = DateTime.now().difference(dob);

      setState(() {
        age = (differenceInDays.inDays / 365).floor().toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
        left: 20.0,
        right: 20.0,
      ),
      child: Container(
        height: size.height * 0.7,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Details',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  DotsIndicator(
                    dotsCount: 3,
                    position: 0,
                    decorator: DotsDecorator(
                      activeSize: const Size.square(17),
                      size: const Size.square(15),
                      color: Colors.grey[500]!, // Inactive color
                      activeColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: user.firstName,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(labelText: 'First Name'),
                        onChanged: (value) {
                          user = user.copyWith(firstName: value);
                          widget.onUserChanged(user);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        initialValue: user.lastName,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(labelText: 'Last Name'),
                        onChanged: (value) {
                          user = user.copyWith(lastName: value);
                          widget.onUserChanged(user);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  initialValue:
                      user.phoneNumber?.substring(3, user.phoneNumber?.length),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  onChanged: (value) {
                    user = user.copyWith(phoneNumber: '+91$value');
                    widget.onUserChanged(user);
                  },
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date of birth',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  //Todo
                  Text(
                    'Age $age',
                    style: GoogleFonts.montserrat(
                        letterSpacing: 2.0,
                        fontSize: 16,
                        color: Colors.black38),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          DropdownButtonFormField(
                            onChanged: (String? value) {
                              user = user.copyWith(
                                  dob: user.dob!.copyWith(
                                      month: (months.indexOf(value!) + 1)
                                          .toString()));
                              checkandUpdateUserAge(user.dob!);
                              widget.onUserChanged(user);
                            },
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              contentPadding: const EdgeInsets.only(
                                left: 25,
                                top: 10,
                                bottom: 10,
                                right: 0,
                              ),
                              hintMaxLines: 1,
                              labelText: 'Month',
                              labelStyle: GoogleFonts.montserrat(
                                  letterSpacing: 1.5,
                                  fontSize: 16,
                                  color: Colors.black54),
                              hintText: 'Month',
                              hintStyle: GoogleFonts.montserrat(
                                  letterSpacing: 1.5,
                                  fontSize: 16,
                                  color: Colors.black54),
                            ),
                            items: months
                                .map((e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField(
                        onChanged: (String? value) {
                          user = user.copyWith(
                              dob: user.dob!.copyWith(day: value));
                          checkandUpdateUserAge(user.dob!);
                          widget.onUserChanged(user);
                        },
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          contentPadding: const EdgeInsets.only(
                            left: 25,
                            top: 10,
                            bottom: 10,
                            right: 0,
                          ),
                          hintMaxLines: 1,
                          labelText: 'Day',
                          labelStyle: GoogleFonts.montserrat(
                              letterSpacing: 1.5,
                              fontSize: 16,
                              color: Colors.black54),
                          hintText: 'Day',
                          hintStyle: GoogleFonts.montserrat(
                              letterSpacing: 1.5,
                              fontSize: 16,
                              color: Colors.black54),
                        ),
                        items: days
                            .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField(
                        onChanged: (String? value) {
                          user = user.copyWith(
                              dob: user.dob!.copyWith(year: value));
                          checkandUpdateUserAge(user.dob!);
                          widget.onUserChanged(user);
                        },
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          contentPadding: const EdgeInsets.only(
                            left: 25,
                            top: 10,
                            bottom: 10,
                            right: 0,
                          ),
                          hintMaxLines: 1,
                          labelText: 'Year',
                          labelStyle: GoogleFonts.montserrat(
                              letterSpacing: 1.5,
                              fontSize: 16,
                              color: Colors.black54),
                          hintText: 'Year',
                          hintStyle: GoogleFonts.montserrat(
                              letterSpacing: 1.5,
                              fontSize: 16,
                              color: Colors.black54),
                        ),
                        items: years
                            .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Religion',
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintMaxLines: 1,
                    hintText: 'Select your religion',
                    hintStyle: GoogleFonts.montserrat(
                        letterSpacing: 1.5,
                        fontSize: 16,
                        color: Colors.black54),
                    contentPadding: const EdgeInsets.only(
                      left: 25,
                      top: 10,
                      bottom: 10,
                      right: 25,
                    ),
                  ),
                  onChanged: (String? value) {
                    user = user.copyWith(religion: value);
                    widget.onUserChanged(user);
                  },
                  items: religions
                      .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Income',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Enter your yearly income',
                    style: GoogleFonts.montserrat(
                        letterSpacing: 2.0,
                        fontSize: 16,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  onChanged: (value) {
                    user = user.copyWith(income: value);
                    widget.onUserChanged(user);
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'eg, 250,000',
                    hintStyle: GoogleFonts.montserrat(
                        letterSpacing: 2.0,
                        fontSize: 16,
                        color: Colors.black54),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
