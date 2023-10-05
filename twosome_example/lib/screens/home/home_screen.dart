// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:twosome_example/screens/menu/coffee_menu_screen.dart';
import 'package:twosome_example/widgets/banner_widget.dart';
import 'package:twosome_example/widgets/today_menu_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> menuItems = [
      'New',
      'Coffee & Drink',
      'Ice-Cream & Shaved-Ice',
      'Cake',
    ];
    List<String> bannerItemImgUrl = [
      'assets/images/banner01.jpg',
      'assets/images/banner02.jpg',
    ];
// 탭바 컨트롤러
    return DefaultTabController(
      length: menuItems.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '메뉴',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: const Icon(
            Icons.home,
            color: Colors.grey,
          ),
// 탭바 생성
          bottom: TabBar(
            tabs: List.generate(
              menuItems.length,
              (index) => Tab(
                text: menuItems[index],
              ),
            ),
            unselectedLabelColor: Colors.black38,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
          ),
        ),

        // 탭바 뷰
        body: TabBarView(
          children: [
            Column(
              // 배너위젯 적용 위치
              children: [
                BannerWidget(bannerItemImgUrl: bannerItemImgUrl),
                // 오늘의 메뉴 적용 위치
                const TodayMenuWidget(),
              ],
            ),
            // 커피 음료 화면
            // Center(
            //   child: Text("Coffee&Drink 화면입니다."),
            //   ),
            const CoffeeMenuScreen(),

            // 아이스크림 빙수 화면
            const Center(
              child: Text("Ice-cream&shaved-ice 화면입니다."),
            ),
            // 케이크 화면
            const Center(
              child: Text("Cake 화면입니다."),
            ),
          ],
        ),
      ),
    );
  }
}
