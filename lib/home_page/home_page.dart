import 'package:flutter/material.dart';
import 'package:sammilani_delegate/home_page/delegate_card.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: Container(
          
        
          
             width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          
          image: DecorationImage(
            image: AssetImage("assets/images/white-texture.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
      
        child: DelegateCard(),
          

        )
      ),

    );
  }
}