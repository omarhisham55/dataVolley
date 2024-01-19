import 'package:data_volley_match/core/utils/colors.dart';
import 'package:flutter/material.dart';

class SharedWidgets {
  static Widget googleButton(BuildContext context, Function() onPressed) =>
      GoogleBtn(
        onPressed: onPressed,
      );
  static Widget outlinedButton(String text, Function() onPressed) =>
      InvertedButtonFb2(
        onPressed: onPressed,
        text: text,
      );

  static Widget filledButton(
    String text,
    Function() onPressed, {
    double? width,
    double? height,
    double? borderRadius,
    EdgeInsets? margin,
    EdgeInsets? textPadding,
    Color? color,
  }) =>
      ButtonImageFb1(
        text: text,
        onPressed: onPressed,
        width: width,
        height: height,
        borderRadius: borderRadius,
        margin: margin,
        textPadding: textPadding,
        color: color,
      );
  static Widget hintTextField({
    required BuildContext context,
    required String hintText,
    required TextEditingController controller,
    required TextInputType keyboardType,
    bool? obscureText = false,
    Widget? suffixIcon,
    String? Function(String? value)? validate,
    EdgeInsets? padding = const EdgeInsets.symmetric(vertical: 10),
  }) =>
      Padding(
        padding: padding!,
        child: TextFormField(
          controller: controller,
          obscureText: obscureText!,
          keyboardType: keyboardType,
          style: Theme.of(context).textTheme.labelLarge,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.labelLarge,
            suffixIcon: suffixIcon,
            suffixIconColor: Colors.grey,
          ),
          validator: validate,
        ),
      );
}

class GoogleBtn extends StatelessWidget {
  final Function() onPressed;
  const GoogleBtn({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/crypto%2Fsearch%20(2).png?alt=media&token=24a918f7-3564-4290-b7e4-08ff54b3c94c",
                width: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Google",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ],
          ),
        ));
  }
}

class InvertedButtonFb2 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color? backgroundColor;
  const InvertedButtonFb2({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          alignment: Alignment.center,
          side: MaterialStateProperty.all(
            BorderSide(width: 1, color: backgroundColor!),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.only(right: 75, left: 75, top: 12.5, bottom: 12.5),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: backgroundColor, fontSize: 18),
        ),
      ),
    );
  }
}

class ButtonImageFb1 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final double? width;
  final double? height;
  final double? borderRadius;
  final EdgeInsets? margin;
  final EdgeInsets? textPadding;
  final Color? color;
  const ButtonImageFb1({
    super.key,
    required this.text,
    required this.onPressed,
    this.height,
    this.borderRadius,
    this.width = double.infinity,
    this.margin = const EdgeInsets.all(0),
    this.textPadding = const EdgeInsets.all(0),
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            color: const Color(0xFF4960F9).withOpacity(.3),
            spreadRadius: 4,
            blurRadius: 50,
          )
        ],
      ),
      child: MaterialButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        splashColor: MainColors.splashButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 24),
        ),
        child: Ink(
          decoration: BoxDecoration(
            //gradient:
            color: color,
            image: color == null
                ? const DecorationImage(
                    image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/finance_app_2%2FbuttonBackgroundSmall.png?alt=media&token=fa2f9bba-120a-4a94-8bc2-f3adc2b58a73"),
                    fit: BoxFit.cover,
                  )
                : null,
            borderRadius: BorderRadius.circular(borderRadius ?? 24),
          ),
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 88.0,
              minHeight: 36.0,
            ),
            padding: textPadding,
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
