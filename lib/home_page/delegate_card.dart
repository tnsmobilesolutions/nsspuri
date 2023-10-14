import 'package:flutter/material.dart';

class DelegateCard extends StatelessWidget {
  const DelegateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
    
        color: Color.fromRGBO(8, 5, 92, 1),
        child: SizedBox(
          width: 400,
          height: 300,
          child: Column(
            
            children: [
              SizedBox(
                height: 20,
              ),
              Text('ଜୟଗୁରୁ', style: TextStyle(
                fontSize: 24,
                color: Colors.white
              ),)
  
            ],
          ),
        ),
      ),
    );
  }
}
