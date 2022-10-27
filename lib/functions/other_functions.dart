import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtherFunctions {
  static Future<void> updateCategory(
    String id,
    String imageUrl,
    BuildContext context,
  ) async {
    try {
      await FirebaseFirestore.instance.collection("categories").doc(id).update(
        {
          "imageUrl": imageUrl,
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something went wrong, please try again.",
            textScaleFactor: 1,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  static Future<void> addCategory(
    String name,
    String imageUrl,
    BuildContext context,
  ) async {
    try {
      await FirebaseFirestore.instance.collection("categories").add(
        {
          "name": name,
          "imageUrl": imageUrl,
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something went wrong, please try again.",
            textScaleFactor: 1,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
    required BuildContext context,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("menu").doc(id).update(
        {
          "imageUrl": imageUrl,
          "description": description,
          "price": price.toStringAsFixed(2),
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something went wrong, please try again.",
            textScaleFactor: 1,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  static Future<void> addMenuItem({
    required String name,
    required String imageUrl,
    required String category,
    required String description,
    required double price,
    required bool isVeg,
    required BuildContext context,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("menu").add(
        {
          "name": name,
          "imageUrl": imageUrl,
          "category": category,
          "description": description,
          "price": price.toStringAsFixed(2),
          "isVeg": isVeg,
          "in stock": true,
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something went wrong, please try again.",
            textScaleFactor: 1,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  static Future<void> deleteMenuItem(
    String id,
    BuildContext context,
  ) async {
    try {
      await FirebaseFirestore.instance.collection("menu").doc(id).delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something went wrong, please try again.",
            textScaleFactor: 1,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  static Future<void> deleteStaff({
    required String id,
    required String role,
    required BuildContext context,
  }) async {
    try {
      await FirebaseFirestore.instance.collection(role).doc(id).delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something went wrong, please try again.",
            textScaleFactor: 1,
          ),
          duration: Duration(seconds: 2),
        ),
      );
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something went wrong, please try again.",
            textScaleFactor: 1,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  static Future<void> deleteVoucher(
    String id,
    BuildContext context,
  ) async {
    try {
      await FirebaseFirestore.instance.collection("vouchers").doc(id).delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something went wrong, please try again.",
            textScaleFactor: 1,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  static Future<void> addVoucher({
    required String code,
    required String desc,
    required String type,
    required String value,
    required String imageUrl,
    required BuildContext context,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("vouchers").add(
        {
          "code": code,
          "value": value,
          "description": desc,
          "imageUrl": imageUrl,
          "type": type,
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something went wrong, please try again.",
            textScaleFactor: 1,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  static Future<void> editVoucher({
    required String desc,
    required String imageUrl,
    required String id,
    required BuildContext context,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("vouchers").doc(id).update(
        {
          "description": desc,
          "imageUrl": imageUrl,
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something went wrong, please try again.",
            textScaleFactor: 1,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  static Future<void> markOutOfStock(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection("menu").doc(id).update(
        {
          "in stock": false,
        },
      ).then(
        (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Item Marked Out of Stock",
                textScaleFactor: 1,
              ),
              duration: Duration(seconds: 2),
            ),
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something went wrong, please try again.",
            textScaleFactor: 1,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  static Future<void> markInStock(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection("menu").doc(id).update(
        {
          "in stock": true,
        },
      ).then(
        (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Item Marked In Stock",
                textScaleFactor: 1,
              ),
              duration: Duration(seconds: 2),
            ),
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something went wrong, please try again.",
            textScaleFactor: 1,
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  static Future<bool> saveSettings({
    required String fees,
    required String minAmount,
    required BuildContext context,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("settings")
          .doc("App Settings")
          .update(
        {
          "delivery fees": fees,
          "minimum amount": minAmount,
        },
      );
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Something went wrong, please try again.",
            textScaleFactor: 1,
          ),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
  }
}
