import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xpage_test/tools/platform/platform_widgets.dart';
import 'package:xpage_test/utils/constants.dart';

enum ButtonType { Default, Rounded, Text }

class CustomButton extends StatefulWidget {
  const CustomButton(
      {Key? key,
      required this.type,
      this.onPressed,
      this.label,
      this.iconPath,
      this.fontSize,
      this.borderRadius,
      this.width,
      this.textColor,
      this.buttonColor,
      this.price = 0.0})
      : super(key: key);

  final ButtonType type;
  final void Function(double, bool)? onPressed;
  final String? label;
  final String? iconPath;
  final double? fontSize;
  final double? borderRadius;
  final double? width;
  final Color? textColor;
  final Color? buttonColor;
  final double? price;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    switch (this.widget.type) {
      case ButtonType.Default:
        return Container(
          height: 41,
          width: MediaQuery.of(context).size.width - 24,
          decoration: BoxDecoration(
              color: kGreenColor, borderRadius: BorderRadius.circular(40)),
          child: PlatformElevatedButton(
            child: PlatformText(
              'В корзину за ${this.widget.price!.toStringAsFixed(0)} ₽',
              style: const TextStyle(
                  fontSize: 12,
                  color: kWhiteColor,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () {},
            material: (context, platform) => MaterialElevatedButtonData(
                style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
            )),
          ),
        );
      case ButtonType.Rounded:
        return Container(
            height: 31,
            width: this.widget.width,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: kWhiteColor, borderRadius: BorderRadius.circular(40)),
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              direction: Axis.horizontal,
              children: [
                Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                        color: this.value == 0 ? kButtonAddColor : kWhiteColor,
                        shape: BoxShape.circle,
                        border: this.value != 0
                            ? Border.all(width: 1, color: kButtonAddColor)
                            : null),
                    child: this.value == 0
                        ? PlatformIconButton(
                            padding: const EdgeInsets.all(0),
                            color: Colors.black,
                            icon: const Icon(
                              CupertinoIcons.add,
                              size: 15,
                            ),
                            onPressed: () {
                              setState(() {
                                this.value++;
                              });
                              if (this.widget.onPressed != null)
                                this.widget.onPressed!(
                                    this.widget.price!, true);
                            },
                          )
                        : PlatformIconButton(
                            padding: const EdgeInsets.all(0),
                            color: Colors.black,
                            icon: const Icon(
                              CupertinoIcons.minus,
                              size: 15,
                            ),
                            onPressed: () {
                              setState(() {
                                this.value--;
                              });
                              if (this.widget.onPressed != null)
                                this.widget.onPressed!(
                                    this.widget.price!, false);
                            },
                          )),
                PlatformText(this.value == 0
                    ? this.widget.price != null
                        ? '${this.widget.price!.toStringAsFixed(0)} ₽'
                        : '₽'
                    : '${this.value}'),
                this.value == 0
                    ? const SizedBox(height: 27)
                    : Container(
                        width: 27,
                        height: 27,
                        decoration: BoxDecoration(
                            color: kWhiteColor,
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: kTextColor)),
                        child: PlatformIconButton(
                          padding: const EdgeInsets.all(0),
                          color: Colors.black,
                          icon: const Icon(
                            CupertinoIcons.add,
                            color: kTextColor,
                            size: 15,
                          ),
                          onPressed: () {
                            setState(() {
                              this.value++;
                            });
                            if (this.widget.onPressed != null)
                              this.widget.onPressed!(this.widget.price!, true);
                          },
                        )),
              ],
            ));
      case ButtonType.Text:
        return GestureDetector(
          onTap: () {
            if (this.widget.onPressed != null)
              this.widget.onPressed!(0.0, false);
          },
          child: PlatformText(
            this.widget.label ?? 'Button',
            style: TextStyle(
                color: this.widget.textColor,
                fontWeight: FontWeight.w400,
                fontSize: 12),
          ),
        );
      default:
        return Container();
    }
  }
}
