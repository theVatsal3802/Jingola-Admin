import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './add_voucher_screen.dart';
import '../widgets/voucher_list_tile.dart';

class VoucherDisplayScreen extends StatelessWidget {
  static const routeName = "/vouchers";
  const VoucherDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Vouchers",
          textScaleFactor: 1,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddVoucherScreen.routeName);
        },
        tooltip: "Add New Voucher",
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("vouchers").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return VoucherListTile(
                    data: snapshot.data!.docs[index].data(),
                    id: snapshot.data!.docs[index].id,
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            }),
      ),
    );
  }
}
