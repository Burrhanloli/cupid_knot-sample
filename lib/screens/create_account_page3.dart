import 'package:cupid_knot_sample/models/user.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CupidKnotCreateAccountPage3 extends StatefulWidget {
  const CupidKnotCreateAccountPage3({
    Key? key,
    required this.user,
    required this.onUserChanged,
  }) : super(key: key);
  final CupidKnotUser user;
  final void Function(CupidKnotUser) onUserChanged;

  @override
  _CupidKnotCreateAccountPage3State createState() =>
      _CupidKnotCreateAccountPage3State();
}

class _CupidKnotCreateAccountPage3State
    extends State<CupidKnotCreateAccountPage3> {
  bool isPrivacyPrivate = true;
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
        height: size.height - 170,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Privacy',
                        style: GoogleFonts.montserrat(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      DotsIndicator(
                        dotsCount: 3,
                        position: 2,
                        decorator: DotsDecorator(
                          activeSize: const Size.square(17),
                          size: const Size.square(15),
                          color: Colors.grey[500]!, // Inactive color
                          activeColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Your Profile Privacy',
                    style: GoogleFonts.montserrat(
                        fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Center(
                    child: Image.asset(
                        'assets/05 Account Privacy/security 1.png')),
              ),
            ),
            Expanded(
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(15),
                isSelected: [isPrivacyPrivate, !isPrivacyPrivate],
                selectedBorderColor: Colors.yellow,
                onPressed: (_) {
                  setState(() {
                    isPrivacyPrivate = !isPrivacyPrivate;
                    var user = widget.user;
                    user = user.copyWith(isPrivacyPrivate: isPrivacyPrivate);
                    widget.onUserChanged(user);
                  });
                },
                children: [
                  Container(
                    color: isPrivacyPrivate ? Colors.yellow : null,
                    width: (MediaQuery.of(context).size.width - 50) / 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              child: Image.asset(isPrivacyPrivate
                                  ? 'assets/05 Account Privacy/Privateprass.png'
                                  : 'assets/05 Account Privacy/Privateunprass.png'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Private',
                              style: GoogleFonts.montserrat(
                                  letterSpacing: 2.0,
                                  fontSize: 16,
                                  fontWeight: isPrivacyPrivate
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isPrivacyPrivate
                                      ? Colors.black
                                      : Colors.black54),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: !isPrivacyPrivate ? Colors.yellow : null,
                    width: (MediaQuery.of(context).size.width - 50) / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              child: Image.asset(!isPrivacyPrivate
                                  ? 'assets/05 Account Privacy/Publicprass.png'
                                  : 'assets/05 Account Privacy/Publicunprass.png'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Public',
                              style: GoogleFonts.montserrat(
                                  letterSpacing: 2.0,
                                  fontSize: 20,
                                  fontWeight: !isPrivacyPrivate
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: !isPrivacyPrivate
                                      ? Colors.black
                                      : Colors.black54),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Magna in fugiat aliquip aliqua magna ut quis pariatur eu do ea. Dolore consequat dolor excepteur magna sit nostrud ipsum voluptate dolore sunt aliquip. Duis velit nostrud non incididunt ex exercitation qui esse ea. Ut enim mollit est pariatur consectetur nulla cupidatat ex deserunt dolore dolor in id ullamco. Dolor esse consequat anim esse pariatur consequat enim irure deserunt anim.',
                  style: GoogleFonts.montserrat(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
