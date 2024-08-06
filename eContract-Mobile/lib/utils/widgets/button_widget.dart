import 'package:e_contract/resource/style.dart';
import 'package:flutter/material.dart';

class BkavButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final Color? color;

  const BkavButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.onLongPressed,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: color??Colors.lightBlueAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))
            .copyWith(
          elevation: MaterialStateProperty.resolveWith(
                (states) {
              return 0;
            },
          ),
        ),
        onPressed: onPressed,
        onLongPress: onLongPressed,
        child: Text(
          text,
          style: StyleBkav.textStyleFW700(null, 14),
        ),
      ),
    );
  }
}
