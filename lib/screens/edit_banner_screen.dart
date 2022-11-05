import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './add_ad_banner_screen.dart';
import '../widgets/ad_list_tile.dart';

class EditBannerScreen extends StatelessWidget {
  static const routeName = "/edit-ad";
  const EditBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Ad Banners",
          textScaleFactor: 1,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddAdBannerScreen.routeName);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("ads").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return snapshot.data!.docs.isEmpty
                ? Center(
                    child: Text(
                      "No Advertisement Banners",
                      textScaleFactor: 1,
                      style: Theme.of(context).textTheme.headline3,
                      maxLines: 2,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return AdListTile(
                        id: snapshot.data!.docs[index].id,
                        imageUrl: snapshot.data!.docs[index]["imageUrl"],
                        newContext: context,
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
          },
        ),
      ),
    );
  }
}
