import 'dart:io';

import 'package:cupid_knot_sample/models/user.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class CupidKnotCreateAccountPage2 extends StatefulWidget {
  const CupidKnotCreateAccountPage2({
    Key? key,
    required this.user,
    required this.onUserChanged,
  }) : super(key: key);
  final CupidKnotUser user;
  final void Function(CupidKnotUser) onUserChanged;

  @override
  _CupidKnotCreateAccountPage2State createState() =>
      _CupidKnotCreateAccountPage2State();
}

class _CupidKnotCreateAccountPage2State
    extends State<CupidKnotCreateAccountPage2> {
  final _picker = ImagePicker();
  final List<File> _pictures = [];

  int currentPicture = 0;
  final maxPicturesLimit = 6;

  bool isMale = true;

  Future<void> selectImage() async {
    final image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        currentPicture++;
        _pictures.add(File(image.path));
      }
    });
  }

  void delete(File file) async {
    setState(() {
      currentPicture--;
      _pictures.remove(file);
    });
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile Picture',
                        style: GoogleFonts.montserrat(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      DotsIndicator(
                        dotsCount: 3,
                        position: 1,
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
                    'upload your picture',
                    style: GoogleFonts.montserrat(
                        fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 10),
                  children: [
                    ..._pictures
                        .map((e) => Stack(children: [
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.file(e),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  delete(e);
                                },
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                    width: 30,
                                    child: Image.asset(
                                      'assets/04 Create Account_2/Delete.png',
                                    ),
                                  ),
                                ),
                              )
                            ]))
                        .toList(),
                    if (_pictures.length < maxPicturesLimit)
                      GestureDetector(
                        onTap: selectImage,
                        child: Stack(children: [
                          Image.asset(
                            'assets/04 Create Account_2/picture add Box.png',
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: Image.asset(
                                    'assets/04 Create Account_2/picture.png',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Add ${_pictures.isEmpty ? "one" : "more "} picture',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14, color: Colors.black54),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      )
                  ]),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gender',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Select your gender',
                    style: GoogleFonts.montserrat(
                        letterSpacing: 2.0,
                        fontSize: 16,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),
            Expanded(
                child: ToggleButtons(
              borderRadius: BorderRadius.circular(15),
              isSelected: [isMale, !isMale],
              selectedBorderColor: Colors.yellow,
              onPressed: (_) {
                setState(() {
                  isMale = !isMale;
                  var user = widget.user;
                  user = user.copyWith(gender: isMale ? 'male' : 'female');
                  widget.onUserChanged(user);
                });
              },
              children: [
                Container(
                  color: isMale ? Colors.yellow : null,
                  width: (MediaQuery.of(context).size.width - 50) / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.male_outlined),
                      Text(
                        'Male',
                        style: GoogleFonts.montserrat(
                            letterSpacing: 2.0,
                            fontSize: 16,
                            fontWeight:
                                isMale ? FontWeight.bold : FontWeight.normal,
                            color: isMale ? Colors.black : Colors.black54),
                      )
                    ],
                  ),
                ),
                Container(
                  color: !isMale ? Colors.yellow : null,
                  width: (MediaQuery.of(context).size.width - 50) / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.female_outlined),
                      Text(
                        'Female',
                        style: GoogleFonts.montserrat(
                            letterSpacing: 2.0,
                            fontSize: 16,
                            fontWeight:
                                !isMale ? FontWeight.bold : FontWeight.normal,
                            color: !isMale ? Colors.black : Colors.black54),
                      )
                    ],
                  ),
                ),
              ],
            )),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
