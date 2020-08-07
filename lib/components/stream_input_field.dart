import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_kids/util/style.dart';

class StreamReusablefield extends StatelessWidget {
  final String label;
  final bool isPass;
  final TextInputType type;
  final String hint;
  final onChangeFunction;
  final Stream stream;
  final String initialValue;
  StreamReusablefield({
    @required this.label,
    @required this.stream,
    this.initialValue,
    this.hint,
    this.isPass,
    @required this.onChangeFunction,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: stream,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                label,
                style: GoogleFonts.capriola(
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: Color(0xff000000),
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  height: 50.00,
                  width: 276.00,
                  padding: EdgeInsets.only(left: 15),
                  child: TextField(
                    obscureText: isPass == null ? false : isPass,
                    onChanged: onChangeFunction,
                    keyboardType: type,
                    inputFormatters: type == TextInputType.phone
                        ? [
                            WhitelistingTextInputFormatter(RegExp("[+0-9]")),
                            LengthLimitingTextInputFormatter(13),
                          ]
                        : type == TextInputType.emailAddress
                            ? [
                                WhitelistingTextInputFormatter(
                                    RegExp("[a-zA-Z0-9@._-]")),
                                LengthLimitingTextInputFormatter(50)
                              ]
                            : null,
                    decoration: InputDecoration(
                      hintText: hint,
                      border: InputBorder.none,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.00, 2.00),
                        color: Color(0xff000000).withOpacity(0.10),
                        blurRadius: 6,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8.00),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  snapshot.error ?? "",
                  style: kCapriola20.copyWith(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}

// new Container(
//         height: 50.00,
//     width: 276.00,
//         decoration: BoxDecoration(
//         color: Color(0xffffffff),
//     boxShadow: [
//         BoxShadow(
//             offset: Offset(0.00,2.00),
//             color: Color(0xff000000).withOpacity(0.10),
// blurRadius: 6,
//     ),
//   ], borderRadius: BorderRadius.circular(8.00),
//     ),
//     )
