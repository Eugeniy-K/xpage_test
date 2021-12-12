import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xpage_test/UI/product_detals/deleted_ingredients.dart';
import 'package:xpage_test/UI/widgets/custom_button.dart';
import 'package:xpage_test/tools/platform/platform_widgets.dart';
import 'package:xpage_test/utils/constants.dart';

void showIngridientsModal(BuildContext context, {required List<String> items}) {
  double width = MediaQuery.of(context).size.width - 24;
  final radius = BorderRadius.circular(20);

  showPlatformDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return Platform.isAndroid
              ? AlertDialog(
                  scrollable: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  // insetPadding: const EdgeInsets.symmetric(horizontal: 30),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PlatformText(
                        'Убрать ингредиенты',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        key: UniqueKey(),
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(
                            items.length,
                            (index) => DeletedIngrediants(
                                  title: items[index],
                                  isDeleted: false,
                                )),
                      )
                    ],
                  ),
                  actionsPadding: const EdgeInsets.all(20),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        setModalState(() {});
                        Navigator.of(context).pop();
                      },
                      child: PlatformText('Сбросить'),
                    )
                  ],
                )
              : Center(
                  child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom * 0.60),
                  child: Container(),
                ));
        });
      });
}
