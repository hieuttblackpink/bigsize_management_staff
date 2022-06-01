import 'package:flutter/material.dart';

import '../../../../model/module/old_edit_money.dart';

class OldEditList extends StatelessWidget {
  OldEditList({Key? key}) : super(key: key);

  final OldMoneyEdit oldMoneyEdit = OldMoneyEdit(
      id: 0,
      type: EditType.add,
      notes: "Water invoice",
      date: "25-052022",
      amount: 120,
      time: "9:12 AM");

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => listItem(context, oldMoneyEdit),
      separatorBuilder: (_, __) => const SizedBox(
        height: 5,
      ),
      itemCount: 10,
    );
  }

  Widget listItem(BuildContext context, OldMoneyEdit item) => ListTile(
        title: Text(
          item.notes,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text("${item.date} - ${item.time}"),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Column(
            children: [
              Text("${item.amount} EGP"),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(
                    item.type.icon,
                    size: 20,
                    color: item.type.color,
                  ),
                  Text(item.type.text,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: item.type.color))
                ],
              )
            ],
          ),
        ),
      );
}
