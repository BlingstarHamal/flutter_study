import 'package:as_test/widgets/image_slider_widget.dart';
import 'package:flutter/material.dart';
import '../auth.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> menuItems = [
      '홈',
      '공지사항',
      '프로그램',
      '예약안내',
      '커뮤니티',
      'Shop',
    ];

    List<String> bannerUrlItems = [
      "assets/images/vis1_2.jpg",
      "assets/images/vis2_jupiter.gif",
      "assets/images/vis3.jpg",
    ];

    List<String> bannerPhrases = [
      "assets/images/vis-txt1.png",
      "assets/images/vis-txt2.png",
      "assets/images/vis-txt3.png",
    ];

    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    List<Widget> bannerPrograms(int numImg) {
      List<Widget> images = [];
      List<String> urls = [];

      urls.add("assets/images/welcome0.jpg");
      urls.add("assets/images/welcome1.jpg");
      urls.add("assets/images/welcome2.jpg");
      urls.add("assets/images/welcome3.jpg");
      urls.add("assets/images/welcome4.jpg");
      urls.add("assets/images/welcome5.jpg");

      Widget image;
      int i = 0;
      while (i < numImg) {
        image = Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain, image: AssetImage(urls[i % 5]))),
        );
        images.add(image);
        i++;
      }
      return images;
    }

    return DefaultTabController(
      length: menuItems.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Image.asset('assets/images/logo.png',
              width: 80.0, height: 80.0, fit: BoxFit.fitWidth),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
            },
            icon: const Icon(Icons.home),
            color: const Color.fromARGB(255, 21, 52, 107),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthWidget()),
                );
              },
              icon: const Icon(Icons.login),
              color: const Color.fromARGB(255, 21, 52, 107),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
              color: const Color.fromARGB(255, 21, 52, 107),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: Container(
              color: const Color.fromARGB(255, 21, 52, 107),
              child: TabBar(
                tabs: List.generate(
                  menuItems.length,
                  (index) => Tab(
                    text: menuItems[index],
                  ),
                ),
                unselectedLabelColor: Colors.white,
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: [
                ImageSliderWidget(
                  bannerUrlItems: bannerUrlItems,
                  bannerPhrases: bannerPhrases,
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15.0),
                      child: Stack(
                        children: <Widget>[
                          Text(
                            '프로그램 소개',
                            style: TextStyle(
                                //color: Color.fromARGB(255, 58, 239, 255),
                                fontSize: 30,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1
                                  ..color =
                                      const Color.fromARGB(150, 0, 98, 255),
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            '프로그램 소개',
                            style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 58, 239, 255),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Text(
                            "전체보기",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: sizeX,
                      height: sizeY / 2,
                      child: GridView.count(
                        crossAxisCount: 2,
                        scrollDirection: Axis.vertical,
                        childAspectRatio: 1.6,
                        //mainAxisSpacing: 5.0,
                        crossAxisSpacing: 5.0,
                        padding: const EdgeInsets.all(3.0),
                        children: bannerPrograms(6),
                      ),
                    )
                  ],
                )
              ],
            ),
            const Center(
              child: Text('공지사항'),
            ),
            const Center(
              child: Text('프로그램'),
            ),
            const Center(
              child: Text('예약안내'),
            ),
            const Center(
              child: Text('커뮤니티'),
            ),
            const Center(
              child: Text('Shop'),
            ),
          ],
        ),
      ),
    );
  }
}
