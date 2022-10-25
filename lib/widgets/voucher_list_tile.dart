import 'package:flutter/material.dart';
import 'package:jingola_admin/screens/add_voucher_screen.dart';

import '../functions/other_functions.dart';

class VoucherListTile extends StatelessWidget {
  final Map<String, dynamic> data;
  final String id;
  const VoucherListTile({
    super.key,
    required this.id,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
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
      onDismissed: (direction) async {
        await OtherFunctions.deleteVoucher(id);
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
                "Are you sure you want to permanently delete ${data["code"]} voucher?",
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
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return AddVoucherScreen(
                    data: data,
                    id: id,
                  );
                },
              ),
            );
          },
          isThreeLine: true,
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            child: Text(
              data["type"],
              textScaleFactor: 1,
            ),
          ),
          title: Text(
            data["code"],
            textScaleFactor: 1,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          subtitle: Text(
            data["description"],
            textScaleFactor: 1,
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1!,
          ),
          trailing: Chip(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            label: Text(
              data["type"] == "1" ? "₹${data["value"]}" : "${data["value"]}%",
              textScaleFactor: 1,
            ),
          ),
        ),
      ),
    );
  }
}
