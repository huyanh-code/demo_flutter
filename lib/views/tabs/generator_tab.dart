import 'package:flutter/material.dart';
import 'package:namer_app/state/app_state.dart';
import 'package:namer_app/widgets/big_card.dart';
import 'package:provider/provider.dart';

class GeneratorTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<MyAppState>(
        builder: (content, appState, _) {
          var pair = appState.current;

          IconData icon;
          if (appState.favorites.contains(pair)) {
            icon = Icons.favorite;
          } else {
            icon = Icons.favorite_border;
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BigCard(pair: pair),
              SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      appState.toggleFavorite();
                    },
                    icon: Icon(icon),
                    label: Text('Like'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      appState.getNext();
                    },
                    child: Text('Next'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
