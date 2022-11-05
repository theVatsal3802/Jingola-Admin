import 'package:flutter/material.dart';

import '../functions/other_functions.dart';

class AddAdBannerScreen extends StatefulWidget {
  static const routeName = "/add-ad";
  const AddAdBannerScreen({super.key});

  @override
  State<AddAdBannerScreen> createState() => _AddAdBannerScreenState();
}

class _AddAdBannerScreenState extends State<AddAdBannerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final imageUrlController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Ad Banners",
          textScaleFactor: 1,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              TextFormField(
                key: const ValueKey("banner"),
                controller: imageUrlController,
                enableSuggestions: true,
                autocorrect: true,
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
                    Icons.link,
                  ),
                  labelText: "Ad Banner Url",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter ad banner URL";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    isLoading = true;
                  });
                  bool valid = _formKey.currentState!.validate();
                  if (!valid) {
                    setState(() {
                      isLoading = false;
                    });
                    return;
                  }
                  _formKey.currentState!.save();
                  await OtherFunctions.addBanner(
                    imageUrl: imageUrlController.text.trim(),
                    context: context,
                  ).then(
                    (value) {
                      setState(() {
                        isLoading = false;
                      });
                      if (value) {
                        Navigator.of(context).pop();
                      }
                    },
                  );
                },
                child: const Text(
                  "Add Banner",
                  textScaleFactor: 1,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
