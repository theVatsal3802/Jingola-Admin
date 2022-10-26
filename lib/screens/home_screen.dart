import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './manager_display_screen.dart';
import './menu_display_screen.dart';
import './auth_screen.dart';
import '../widgets/home_list_tile.dart';
import './new_order_screen.dart';
import './past_order_screen.dart';
import './category_display_screen.dart';
import './chef_display_screen.dart';
import './voucher_display_screen.dart';
import './delivery_boy_display_screen.dart';
import '../widgets/change_settings.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Welcome",
          textScaleFactor: 1,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.white,
              ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then(
                (_) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AuthScreen.routeName,
                    (route) => false,
                  );
                },
              );
            },
            child: Text(
              "Logout",
              textScaleFactor: 1,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  return Text(
                    "Total Users: ${snapshot.data!.docs.length}",
                    textScaleFactor: 1,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const ChangeSetting(),
              const SizedBox(
                height: 20,
              ),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: [
                  HomeListTile(
                    title: "Edit Categories",
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(CategoryDisplayScreen.routeName);
                    },
                    leading: const Icon(
                      Icons.category,
                      size: 48,
                    ),
                  ),
                  HomeListTile(
                    title: "Edit Menu",
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(MenuDisplayScreen.routeName);
                    },
                    leading: const Icon(
                      Icons.menu_book,
                      size: 48,
                    ),
                  ),
                  HomeListTile(
                    title: "Check New Orders",
                    onTap: () {
                      Navigator.of(context).pushNamed(NewOrderScreen.routeName);
                    },
                    leading: const Icon(
                      Icons.fiber_new,
                      size: 48,
                    ),
                  ),
                  HomeListTile(
                    title: "Check Completed Orders",
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(PastOrderScreen.routeName);
                    },
                    leading: const Icon(
                      Icons.check_circle,
                      size: 48,
                    ),
                  ),
                  HomeListTile(
                    title: "Edit Vouchers",
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(VoucherDisplayScreen.routeName);
                    },
                    leading: const Icon(
                      Icons.discount,
                      size: 48,
                    ),
                  ),
                  HomeListTile(
                    title: "Edit Managers",
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ManagerDisplayScreen.routeName);
                    },
                    leading: const Icon(
                      Icons.manage_accounts_rounded,
                      size: 48,
                    ),
                  ),
                  HomeListTile(
                    title: "Edit Chefs",
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ChefDisplayScreen.routeName);
                    },
                    leading: const Icon(
                      Icons.person,
                      size: 48,
                    ),
                  ),
                  HomeListTile(
                    title: "Edit Delivery Boys",
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(DeliveryBoyDisplayScreen.routeName);
                    },
                    leading: const Icon(
                      Icons.delivery_dining,
                      size: 48,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
