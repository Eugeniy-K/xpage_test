import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:xpage_test/UI/widgets/custom_button.dart';
import 'package:xpage_test/tools/platform/src/platform_text.dart';
import 'package:xpage_test/utils/constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key? key,
      required this.urlImage,
      required this.title,
      required this.description,
      required this.price})
      : super(key: key);

  final String urlImage;
  final String title;
  final String description;
  final double price;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2 - 32;
    return Container(
      // padding: const EdgeInsets.all(8),
      width: width,
      // height: 260,
      decoration: BoxDecoration(
          color: kPizzaRadiusColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: CachedNetworkImage(
              height: 155,
              imageUrl: this.urlImage,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 10),
          PlatformText(
            this.title,
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 30),
          PlatformText(
            this.title,
            style: const TextStyle(fontSize: 10),
          ),
          const SizedBox(height: 10),
          CustomButton(
            type: ButtonType.Rounded,
            width: width - 16,
            price: this.price,
            onPressed: (value, operation) {},
          )
        ],
      ),
    );
  }
}
