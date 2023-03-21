import 'package:flutter/material.dart';

class TextInputCustom extends StatefulWidget {
  String? hint;
  String? title;
  static bool? obscure = false;
  Function(String?)? onSave;
  TextEditingController? controller = TextEditingController();

  TextInputCustom(
      {super.key,
      this.hint,
      this.title,
      obscure,
      this.controller,
      this.onSave});

  @override
  State<TextInputCustom> createState() => _TextInputCustomState();
}

class _TextInputCustomState extends State<TextInputCustom> {
  bool isDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Text(
                widget.title!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            TextFormField(
              onSaved: widget.onSave,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: widget.controller,
              obscureText: TextInputCustom.obscure!,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  border: OutlineInputBorder(),
                  hintText: widget.hint),
            )
          ],
        ));
  }
}
