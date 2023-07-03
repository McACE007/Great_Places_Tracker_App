import 'package:flutter/material.dart';
import 'package:list_of_great_places_app/providers/great_places.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';
import 'place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: const Center(
                  child: Text("Got no places yet, try adding some!"),
                ),
                builder: (context, greatPlaces, ch) => greatPlaces
                        .places.isEmpty
                    ? ch!
                    : ListView.builder(
                        itemCount: greatPlaces.places.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatPlaces.places[index].image),
                          ),
                          title: Text(greatPlaces.places[index].title),
                          subtitle:
                              Text(greatPlaces.places[index].location!.address),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              PlaceDetailScreen.routeName,
                              arguments: greatPlaces.places[index].id,
                            );
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
