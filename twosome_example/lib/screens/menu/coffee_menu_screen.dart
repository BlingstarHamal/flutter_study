import 'package:flutter/material.dart';
import 'package:twosome_example/models/coffee.dart';
import 'package:twosome_example/screens/menu/menu_detail_screen.dart';

class CoffeeMenuScreen extends StatelessWidget {
  const CoffeeMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
          coffees.length,
              (index) => Container(
                height: 150.0,

                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder:
                            (context) => MenuDetailScreen(item:coffees[index]),
                          ),
                        );
                    },
                  child: Padding(padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Image.asset("${coffees[index].imageUrl}"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 메뉴명
                            Text(
                              "${coffees[index].title}",
                              style: Theme.of(context).textTheme.titleLarge,
                              ),
                            // 가격
                            Text(
                              "${coffees[index].price}원",
                              style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ], //children
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ),
      );
  }
}
