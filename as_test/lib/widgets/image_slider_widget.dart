import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSliderWidget extends StatelessWidget {
  const ImageSliderWidget({
    Key? key,
    required this.bannerUrlItems,
    required this.bannerPhrases,
  }) : super(key: key);

  final List<String> bannerUrlItems;
  final List<String> bannerPhrases; // 이미지 경로 리스트

  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;

    return CarouselSlider.builder(
      itemCount: bannerUrlItems.length,
      options: CarouselOptions(
        height: 160,
        autoPlay: true,
        viewportFraction: 1, //화면에 보여지는 이미지 갯수
      ),
      itemBuilder: (context, itemIndex, realIndex) {
        return Stack(
          children: [
            Image.asset(
              bannerUrlItems[itemIndex],
              fit: BoxFit.cover,
              width: appSize.width,
            ),
            Image.asset(
              bannerPhrases[itemIndex],
              alignment: Alignment.center,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                color: Colors.black38,
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "${itemIndex + 1}/${bannerUrlItems.length}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
