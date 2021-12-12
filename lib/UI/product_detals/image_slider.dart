import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:xpage_test/utils/constants.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key, required this.images}) : super(key: key);

  final List<String> images;

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        CarouselSlider(
          items: this
              .widget
              .images
              .map(
                (e) => Builder(
                    builder: (context) => Image.network(e, fit: BoxFit.cover)),
              )
              .toList(),
          options: CarouselOptions(
              height: MediaQuery.of(context).size.height / 2,
              enableInfiniteScroll: false,
              onPageChanged: (val, reason) {
                setState(() {
                  _current = val;
                });
              }),
        ),
        Positioned(
          bottom: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: this.widget.images.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == entry.key
                        ? Color(0xffDC5E49)
                        : kWhiteColor),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
