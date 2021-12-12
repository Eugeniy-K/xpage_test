import 'package:flutter/widgets.dart';
import 'package:xpage_test/UI/widgets/custom_button.dart';
import 'package:xpage_test/models/prod_detail_model.dart';
import 'package:xpage_test/tools/platform/platform_widgets.dart';

class Ingredients extends StatelessWidget {
  const Ingredients(
      {Key? key, required this.ingredientsForAdd, required this.callBack})
      : super(key: key);

  final List<IngredientsForAdd> ingredientsForAdd;
  final Function(double, bool) callBack;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
            this.ingredientsForAdd.length,
            (index) => Item(
                  igredient: this.ingredientsForAdd[index],
                  callBack: (value, operation) {
                    this.callBack(value, operation);
                  },
                )));
  }
}

class Item extends StatelessWidget {
  const Item({Key? key, required this.igredient, required this.callBack})
      : super(key: key);

  final IngredientsForAdd igredient;
  final Function(double, bool) callBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset('assets/icons/cheese.png'),
            const SizedBox(width: 16),
            Expanded(
                child: PlatformText(this.igredient.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 12))),
            CustomButton(
              width: 100,
              type: ButtonType.Rounded,
              price: this.igredient.price.toDouble(),
              onPressed: (value, operation) {
                this.callBack(value, operation);
              },
            )
          ],
        ),
        const SizedBox(height: 22)
      ],
    );
  }
}
