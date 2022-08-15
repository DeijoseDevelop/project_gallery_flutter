import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleMenu extends StatelessWidget {
  const TitleMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(width: 10),
        LetterGoogle(
          letter: 'G',
          color: Colors.blue,
        ),
        LetterGoogle(
          color: Colors.red,
          letter: 'o',
        ),
        LetterGoogle(
          color: Colors.yellow,
          letter: 'o',
        ),
        LetterGoogle(
          color: Colors.blue,
          letter: 'g',
        ),
        LetterGoogle(
          color: Colors.green,
          letter: 'l',
        ),
        LetterGoogle(
          color: Colors.red,
          letter: 'e',
        ),
        const SizedBox(width: 10),
        const Text(
          'PhotosFake',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}

class LetterGoogle extends StatelessWidget {
  String letter;
  Color color;
  LetterGoogle({
    required this.color,
    required this.letter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      letter,
      style: GoogleFonts.roboto(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }
}
