import 'package:flutter/material.dart';

import '../functions/other_functions.dart';

class StaffListTile extends StatelessWidget {
  final Map<String, dynamic> data;
  final String id;
  final String role;
  const StaffListTile({
    super.key,
    required this.id,
    required this.data,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(5),
        title: Text(
          data["name"],
          textScaleFactor: 1,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4,
        ),
        subtitle: Text(
          data["email"],
          textScaleFactor: 1,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        trailing: IconButton(
          onPressed: () async {
            final decision = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    "Are you sure?",
                    textScaleFactor: 1,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  content: Text(
                    "Make sure you delete the Authentication Details from the Firebase Authentication dashboard.",
                    textScaleFactor: 1,
                    style: Theme.of(context).textTheme.headline4,
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
            if (decision) {
              await OtherFunctions.deleteStaff(
                id: id,
                role: role,
                context: context,
              );
            } else {
              return;
            }
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
