import 'package:flutter/material.dart';
import 'package:cgv_clone/widgets/image_slider_widget.dart';
import 'package:cgv_clone/widgets/movie_chart_widget.dart';

class MyHomPage extends StatelessWidget {
  const MyHomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> menuItems = [
      '홈',
      '이벤트',
      '무비톡',
      '패스트오더',
      '기프트샵',
      '@CGV',
    ];

    List<String> bannerUrlItems = [
      "assets/images/banner_01.jpg",
      "assets/images/banner_02.jpg",
      "assets/images/banner_03.jpg",
      "assets/images/banner_04.jpg",
    ];

    // 상단 바
    return DefaultTabController(
      // 탭바 컨트롤러
      length: menuItems.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "CGV",
            style: TextStyle(
              fontSize: 26.0,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.airplane_ticket_outlined),
              color: Colors.red,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.movie_outlined),
              color: Colors.red,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
              color: Colors.red,
            ),
          ],

          // 상단 바아래 메뉴탭
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: Container(
              color: Colors.red,
              child: TabBar(
                tabs: List.generate(
                  menuItems.length,
                  (index) => Tab(
                    text: menuItems[index],
                  ),
                ),
                // 탭바 하단 메뉴 스타일 정리
                unselectedLabelColor: Colors.white,
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
              ),
            ),
          ),
        ),

        // 중앙 화면
        body: TabBarView(
          children: [
            ListView(
              children: [
                // 상단 배너
                ImageSliderWidget(bannerUrlItems: bannerUrlItems),
                // 무비차트
                const MovieChartWidget(),

                // 하단바 -> 바텀네비를 사용해서 아래로 내리는 편이 나을것 같다.
                const Divider(
                  thickness: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildLabelIcon(Icons.phone_android, "MY CGV"),
                      buildLabelIcon(Icons.photo, "포토플레이"),
                      buildLabelIcon(Icons.account_balance_wallet, "할인정보"),
                      buildLabelIcon(Icons.music_note, "CGV스토어"),
                    ],
                  ),
                ),
              ],
            ),
            // Center(
            //   child: Text('홈 화면 입니다.'),
            // ),
            const Center(
              child: Text('이벤트 화면 입니다.'),
            ),
            const Center(
              child: Text('무비톡 화면 입니다.'),
            ),
            const Center(
              child: Text('패스트오더 화면 입니다.'),
            ),
            const Center(
              child: Text('기프트샵 화면 입니다.'),
            ),
            const Center(
              child: Text('@CGV 화면 입니다.'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabelIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.black12,
          ),
          child: Icon(icon),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12.0),
        ),
      ],
    );
  }
}
