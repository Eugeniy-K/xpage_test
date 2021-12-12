import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xpage_test/models/prod_detail_model.dart';
import 'package:xpage_test/tools/platform/platform_widgets.dart';
import 'package:xpage_test/utils/constants.dart';

class PizzaRadius extends StatefulWidget {
  PizzaRadius(
      {Key? key,
      required this.offers,
      required this.callBack,
      required this.price})
      : super(key: key);

  final List<Offer> offers;
  final double price;
  final Function(double) callBack;

  @override
  _PizzaRadiusState createState() => _PizzaRadiusState();
}

class _PizzaRadiusState extends State<PizzaRadius> {
  double price = 0;

  @override
  Widget build(BuildContext context) {
    this.price = this.widget.price;
    // print('TUT' + price.toString());
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width - 24,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: kPizzaRadiusColor, borderRadius: BorderRadius.circular(40)),
      child: Row(
          // key: UniqueKey(),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(this.widget.offers.length, (index) {
            bool isSelected = this.widget.offers[index].price == this.price;
            return PizzaSize(
                offer: this.widget.offers[index],
                isSelected: isSelected,
                callBack: (value) {
                  setState(() {
                    this.price = value;
                  });
                  this.widget.callBack(value);
                });
          })),
    );
  }
}

class PizzaSize extends StatelessWidget {
  const PizzaSize(
      {Key? key,
      required this.offer,
      required this.isSelected,
      required this.callBack})
      : super(key: key);

  final Offer offer;
  final bool isSelected;
  final Function(double) callBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.callBack(this.offer.price.toDouble());
      },
      child: Container(
          alignment: Alignment.center,
          height: 94,
          width: MediaQuery.of(context).size.width / 3 - 24,
          decoration: BoxDecoration(
              color: this.isSelected ? kWhiteColor : Colors.transparent,
              borderRadius: BorderRadius.circular(40)),
          child: PlatformText(this.offer.name)),
    );
  }
}
