import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "LET ME COOK !",
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.05
          ),
          const Text(
            "FAVORITES RECIPES",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          )
          /*Expanded(

          )*/
        ],
      ),
    );
  }
}

