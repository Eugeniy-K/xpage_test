import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:xpage_test/tools/platform/platform_widgets.dart';
import 'package:xpage_test/utils/constants.dart';

class DeletedIngrediants extends StatefulWidget {
  const DeletedIngrediants(
      {Key? key, required this.title, required this.isDeleted})
      : super(key: key);

  final String title;
  final bool isDeleted;

  @override
  _DeletedIngrediantsState createState() => _DeletedIngrediantsState();
}

class _DeletedIngrediantsState extends State<DeletedIngrediants> {
  bool isDeleted = false;

  @override
  void initState() {
    this.isDeleted = this.widget.isDeleted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 16, right: 0),
        height: 40,
        decoration: BoxDecoration(
            color: this.isDeleted ? kPizzaRadiusColor : kGrayColor,
            borderRadius: BorderRadius.circular(40)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PlatformText(
              this.widget.title,
              style: TextStyle(
                  fontSize: 12,
                  color: this.isDeleted ? kBlackColor : kWhiteColor,
                  decoration:
                      this.isDeleted ? TextDecoration.lineThrough : null),
            ),
            PlatformIconButton(
              padding: const EdgeInsets.all(0),
              icon: Icon(CupertinoIcons.clear, size: 15),
              onPressed: () {
                setState(() {
                  this.isDeleted = !this.isDeleted;
                });
              },
            )
          ],
        ));
  }
}
