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
            await OtherFunctions.deleteStaff(
              id: id,
              role: role,
              context: context,
            ).then(
              (_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Staff Member removed successfully!",
                      textScaleFactor: 1,
                    ),
                  ),
                );
              },
            );
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
