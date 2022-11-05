import 'package:flutter/material.dart';

import '../functions/other_functions.dart';

class AdListTile extends StatelessWidget {
  final String imageUrl;
  final String id;
  final BuildContext newContext;
  const AdListTile({
    super.key,
    required this.imageUrl,
    required this.id,
    required this.newContext,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      onDismissed: (direction) async {
        await OtherFunctions.deleteBanner(
          id: id,
          context: newContext,
        );
      },
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Confirm your action",
                textScaleFactor: 1,
                style: Theme.of(context).textTheme.headline4,
              ),
              content: Text(
                "Are you sure you want to permanently delete this advertisement?",
                textScaleFactor: 1,
                style: Theme.of(context).textTheme.headline5,
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
      },
      direction: DismissDirection.startToEnd,
      background: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ],
      ),
      child: Container(
        height: 200,
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
            width: 1,
          ),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
