import 'package:flutter/material.dart';

import './home_screen.dart';
import '../functions/other_functions.dart';

class AddStaffScreen extends StatefulWidget {
  static const routeName = "/add-staff";
  const AddStaffScreen({super.key});

  @override
  State<AddStaffScreen> createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? role;
  RegExp email = RegExp(r"\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,6}");

  final roles = [
    "admin",
    "managers",
    "delivery person",
    "chefs",
  ];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Add Staff Member",
          textScaleFactor: 1,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  key: const ValueKey("name"),
                  autocorrect: true,
                  enableSuggestions: true,
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
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
                      Icons.person,
                    ),
                    labelText: "Name",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  key: const ValueKey("email"),
                  autocorrect: false,
                  enableSuggestions: false,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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
                      Icons.email,
                    ),
                    labelText: "Email",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    } else if (!email.hasMatch(value.trim().toLowerCase())) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  key: const ValueKey("password"),
                  autocorrect: false,
                  obscureText: true,
                  enableSuggestions: false,
                  controller: passwordController,
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
                      Icons.key,
                    ),
                    labelText: "Password",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
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
                        "Select Role",
                        textScaleFactor: 1,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      value: role,
                      items: roles.map(buildMenuItem).toList(),
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (value) {
                        setState(() {
                          role = value!;
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
                      if (role!.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Please select a role",
                              textScaleFactor: 1,
                            ),
                          ),
                        );
                        return;
                      }
                      bool result = await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Are you sure?",
                              textScaleFactor: 1,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            content: Text(
                              "You will be re-directed to the home screen",
                              textScaleFactor: 1,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text(
                                  "NO",
                                  textScaleFactor: 1,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: const Text(
                                  "YES",
                                  textScaleFactor: 1,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                      if (!result) {
                        setState(() {
                          isLoading = false;
                        });
                        return;
                      }
                      await OtherFunctions.addStaff(
                        name: nameController.text.trim(),
                        email: emailController.text.trim().toLowerCase(),
                        password: passwordController.text.trim(),
                        role: role!,
                        context: context,
                      ).then(
                        (_) {
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            HomeScreen.routeName,
                            (route) => false,
                          );
                        },
                      );
                    },
                    child: const Text(
                      "Add Staff Member",
                      textScaleFactor: 1,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) {
  return DropdownMenuItem(
    value: item,
    child: Text(
      item,
      textScaleFactor: 1,
    ),
  );
}
