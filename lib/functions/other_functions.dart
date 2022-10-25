import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtherFunctions {
  static Future<void> updateCategory(String id, String imageUrl) async {
    await FirebaseFirestore.instance.collection("categories").doc(id).update(
      {
        "imageUrl": imageUrl,
      },
    );
  }

  static Future<void> addCategory(String name, String imageUrl) async {
    await FirebaseFirestore.instance.collection("categories").add(
      {
        "name": name,
        "imageUrl": imageUrl,
      },
    );
  }

  static Future<void> deleteCategory(String id, String name) async {
    final docs = await FirebaseFirestore.instance
        .collection("menu")
        .where("category", isEqualTo: name)
        .get();
    List<String> ids = [];
    for (var element in docs.docs) {
      ids.add(element.id);
    }
    for (var i = 0; i < ids.length; i++) {
      await FirebaseFirestore.instance.collection("menu").doc(ids[i]).delete();
    }
    await FirebaseFirestore.instance.collection("categories").doc(id).delete();
  }

  static Future<void> updateMenuItem({
    required String id,
    required String imageUrl,
    required String description,
    required double price,
  }) async {
    await FirebaseFirestore.instance.collection("menu").doc(id).update(
      {
        "imageUrl": imageUrl,
        "description": description,
        "price": price.toStringAsFixed(2),
      },
    );
  }

  static Future<void> addMenuItem({
    required String name,
    required String imageUrl,
    required String category,
    required String description,
    required double price,
    required bool isVeg,
  }) async {
    await FirebaseFirestore.instance.collection("menu").add(
      {
        "name": name,
        "imageUrl": imageUrl,
        "category": category,
        "description": description,
        "price": price.toStringAsFixed(2),
        "isVeg": isVeg,
      },
    );
  }

  static Future<void> deleteMenuItem(
    String id,
  ) async {
    await FirebaseFirestore.instance.collection("menu").doc(id).delete();
  }

  static Future<void> deleteStaff({
    required String id,
    required String role,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.currentUser!.delete().then(
        (_) async {
          await FirebaseFirestore.instance.collection(role).doc(id).delete();
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "An error occurred",
                textScaleFactor: 1,
                style: Theme.of(context).textTheme.headline4,
              ),
              content: Text(
                "Cannot delete this staff member now. Ask him to logout and login again and then try again",
                textScaleFactor: 1,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            );
          },
        );
      }
    }
  }

  static Future<void> addStaff({
    required String name,
    required String email,
    required String password,
    required String role,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (userCredential) async {
          await FirebaseFirestore.instance
              .collection(role)
              .doc(userCredential.user!.uid)
              .set(
            {
              "name": name,
              "email": email,
              "role": role,
            },
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      var msg = "Something went wrong";
      if (e.code == "email-already-in-use") {
        msg = "Email Already in Use";
      } else if (e.code == "invalid-email") {
        msg = "Invalid Email";
      } else if (e.code == "weak-password") {
        msg == "Password too weak";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            msg,
            textScaleFactor: 1,
          ),
        ),
      );
    }
  }

  static Future<void> deleteVoucher(String id) async {
    await FirebaseFirestore.instance.collection("vouchers").doc(id).delete();
  }

  static Future<void> addVoucher({
    required String code,
    required String desc,
    required String type,
    required String value,
    required String imageUrl,
  }) async {
    await FirebaseFirestore.instance.collection("vouchers").add(
      {
        "code": code,
        "value": value,
        "description": desc,
        "imageUrl": imageUrl,
        "type": type,
      },
    );
  }

  static Future<void> editVoucher({
    required String desc,
    required String imageUrl,
    required String id,
  }) async {
    await FirebaseFirestore.instance.collection("vouchers").doc(id).update(
      {
        "description": desc,
        "imageUrl": imageUrl,
      },
    );
  }
}
