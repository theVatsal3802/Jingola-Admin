import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/staff_list_tile.dart';
import './add_staff_screen.dart';

class ManagerDisplayScreen extends StatelessWidget {
  static const routeName = "/manager-display";
  const ManagerDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Managers",
          textScaleFactor: 1,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddStaffScreen.routeName);
        },
        tooltip: "Add New Manager",
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("managers").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return snapshot.data!.docs.isEmpty
                ? Center(
                    child: Text(
                      "No Managers yet!",
                      textScaleFactor: 1,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return StaffListTile(
                        role: snapshot.data!.docs[index].get("role"),
                        id: snapshot.data!.docs[index].id,
                        data: snapshot.data!.docs[index].data(),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
