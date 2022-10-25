import 'package:flutter/material.dart';

import '../functions/other_functions.dart';
import './home_screen.dart';

class AddVoucherScreen extends StatefulWidget {
  static const routeName = "/add-voucher";
  final Map<String, dynamic>? data;
  final String id;
  const AddVoucherScreen({
    super.key,
    required this.data,
    required this.id,
  });

  @override
  State<AddVoucherScreen> createState() => _AddVoucherScreenState();
}

class _AddVoucherScreenState extends State<AddVoucherScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final codeController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlController = TextEditingController();
  String? type;
  String desc = "";
  String image = "";
  final valueController = TextEditingController();
  final types = ["1", "2"];
  late Future<bool> isEdit;

  bool isLoading = false;

  Future<bool> isEditing() async {
    if (widget.data == null) {
      return false;
    }
    setState(() {
      codeController.text = widget.data!["code"];
      imageUrlController.text = widget.data!["imageUrl"];
      image = widget.data!["imageUrl"];
      desc = widget.data!["description"];
      descriptionController.text = widget.data!["description"];
      valueController.text = widget.data!["value"];
      type = widget.data!["type"];
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
    isEdit = isEditing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Edit Voucher",
          textScaleFactor: 1,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder(
            future: isEdit,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    snapshot.data ?? false
                        ? Text(
                            "Code: ${codeController.text}",
                            textScaleFactor: 1,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          )
                        : TextFormField(
                            key: const ValueKey("code"),
                            autocorrect: true,
                            enableSuggestions: true,
                            controller: codeController,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.characters,
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
                                Icons.discount,
                              ),
                              labelText: "Code",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter code";
                              }
                              return null;
                            },
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      key: const ValueKey("description"),
                      autocorrect: true,
                      enableSuggestions: true,
                      controller: descriptionController,
                      textCapitalization: TextCapitalization.sentences,
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
                          Icons.description,
                        ),
                        labelText: "Description",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter description";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      key: const ValueKey("imageUrl"),
                      autocorrect: true,
                      enableSuggestions: true,
                      controller: imageUrlController,
                      keyboardType: TextInputType.url,
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
                          Icons.image,
                        ),
                        labelText: "Display Banner URL",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter disply banner URL";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    snapshot.data ?? false
                        ? Text(
                            type == "1"
                                ? "Value: ₹${valueController.text}"
                                : "Value: ${valueController.text}%",
                            textScaleFactor: 1,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          )
                        : TextFormField(
                            key: const ValueKey("value"),
                            autocorrect: false,
                            enableSuggestions: false,
                            controller: valueController,
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
                                Icons.numbers,
                              ),
                              labelText: "Value",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter value for the voucher";
                              }
                              return null;
                            },
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    snapshot.data ?? false
                        ? Text(
                            "Voucher Type: $type",
                            textScaleFactor: 1,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          )
                        : Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black38,
                                width: 0.7,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: Text(
                                  "Select Type",
                                  textScaleFactor: 1,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                value: type,
                                items: types.map(buildMenuItem).toList(),
                                icon: const Icon(Icons.arrow_drop_down),
                                onChanged: (value) {
                                  setState(() {
                                    type = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (isLoading)
                      const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    if (!isLoading)
                      ElevatedButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            isLoading = true;
                          });
                          bool valid = _formKey.currentState!.validate();
                          if (!valid) {
                            return;
                          }
                          _formKey.currentState!.save();
                          if (image == imageUrlController.text.trim() &&
                              desc == descriptionController.text.trim()) {
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please change something before saving",
                                  textScaleFactor: 1,
                                ),
                              ),
                            );
                            return;
                          }
                          if (type!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please select a type",
                                  textScaleFactor: 1,
                                ),
                              ),
                            );
                            return;
                          }
                          snapshot.data ?? false
                              ? await OtherFunctions.editVoucher(
                                  desc: descriptionController.text.trim(),
                                  id: widget.id,
                                  imageUrl: imageUrlController.text.trim(),
                                ).then(
                                  (_) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      HomeScreen.routeName,
                                      (route) => false,
                                    );
                                  },
                                )
                              : await OtherFunctions.addVoucher(
                                  code:
                                      codeController.text.trim().toUpperCase(),
                                  desc: descriptionController.text.trim(),
                                  type: type!,
                                  value: valueController.text.trim(),
                                  imageUrl: imageUrlController.text.trim(),
                                ).then(
                                  (_) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      HomeScreen.routeName,
                                      (route) => false,
                                    );
                                  },
                                );
                        },
                        child: const Text(
                          "Save Voucher",
                          textScaleFactor: 1,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String type) {
  return DropdownMenuItem(
    value: type,
    child: Text(
      type,
      textScaleFactor: 1,
    ),
  );
}
