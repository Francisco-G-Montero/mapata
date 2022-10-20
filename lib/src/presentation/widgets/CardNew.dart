import 'package:flutter/material.dart';

class CardNew extends StatelessWidget {
  final Widget child;
  const CardNew({Key? key, required this.child}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children:[SizedBox(height: 300,
        child: Card(
          semanticContainer: true,
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(30),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Expanded(child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://www.purina-latam.com/sites/g/files/auxxlc391/files/styles/kraken_generic_max_width_960/public/Purina%C2%AE%20Como%20disciplinar%20a%20tu%20gato.jpg?itok=Nxydhxbv"),
                  ),
                ),
              )),


            ],

          ),

        ),
      ),
      ],
    );
  }
}