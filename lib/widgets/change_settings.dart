import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jingola_admin/functions/other_functions.dart';

class ChangeSetting extends StatefulWidget {
  const ChangeSetting({super.key});

  @override
  State<ChangeSetting> createState() => _ChangeSettingState();
}

class _ChangeSettingState extends State<ChangeSetting> {
  final feeController = TextEditingController();
  final minController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  late Future<List<String>> data;
  bool edit = false;
  bool isloading = false;

  Future<List<String>> getData() async {
    final result = await FirebaseFirestore.instance
        .collection("settings")
        .doc("App Settings")
        .get();
    final String fees = result.get("delivery fees");
    final String minAmount = result.get("minimum amount");
    return [fees, minAmount];
  }

  @override
  void initState() {
    super.initState();
    data = getData();
  }

  @override
  void dispose() {
    super.dispose();
    feeController.dispose();
    minController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        return Form(
          key: _formKey,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Change Monetery Policy",
                  textScaleFactor: 1,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                !edit
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery Fees:",
                            textScaleFactor: 1,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            "₹${snapshot.data![0]}",
                            textScaleFactor: 1,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      )
                    : TextFormField(
                        key: const ValueKey("delivery fee"),
                        autocorrect: true,
                        enableSuggestions: true,
                        controller: feeController,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0.5,
                              color: Colors.black54,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(
                            Icons.delivery_dining,
                          ),
                          labelText: "Delivery Fees",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter delivery fees";
                          } else if (double.parse(value) < 0) {
                            return "Delivery fees cannot be negative";
                          }
                          return null;
                        },
                      ),
                const SizedBox(
                  height: 10,
                ),
                !edit
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Minimum Total Amount:",
                            textScaleFactor: 1,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            "₹${snapshot.data![1]}",
                            textScaleFactor: 1,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      )
                    : TextFormField(
                        key: const ValueKey("minimum amount"),
                        autocorrect: true,
                        enableSuggestions: true,
                        controller: minController,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0.5,
                              color: Colors.black54,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(
                            Icons.monetization_on_sharp,
                          ),
                          labelText: "Minimum Total Amount",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter minimum total amount";
                          } else if (double.parse(value) < 0) {
                            return "Minimum total amount cannot be negative";
                          }
                          return null;
                        },
                      ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: edit
                      ? () async {
                          FocusScope.of(context).unfocus();
                          bool valid = _formKey.currentState!.validate();
                          if (!valid) {
                            return;
                          }
                          _formKey.currentState!.save();
                          setState(() {
                            isloading = true;
                          });
                          await OtherFunctions.saveSettings(
                            fees: feeController.text.trim(),
                            minAmount: minController.text.trim(),
                            context: context,
                          ).then(
                            (value) {
                              setState(() {
                                isloading = false;
                                edit = false;
                              });
                            },
                          );
                        }
                      : () {
                          setState(() {
                            edit = true;
                          });
                        },
                  child: Text(
                    edit ? "Save Changes" : "Edit Policy",
                    textScaleFactor: 1,
                  ),
                ),
                if (edit)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        edit = false;
                      });
                    },
                    child: const Text(
                      "CANCEL",
                      textScaleFactor: 1,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
