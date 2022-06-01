import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bigsize_management_staff/view_model/app_provider.dart';

import '../../../../../model/module/deals.dart';
import '../../../../../model/module/ui_models.dart';

class EntryLayout extends StatelessWidget {
  const EntryLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Selector<AppProvider, ShowData<EntryModel>>(
        selector: (context, appProvider) => appProvider.entriesShow,
        builder: (context, entries, _) => ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                Text("Total Entries ${entries.maxNumber}",
                    style: Theme.of(context).textTheme.headline4),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Divider(
                    color: Theme.of(context).colorScheme.onBackground,
                    // thickness: 10,
                    height: 10,
                  ),
                ),
              ],
            ),
            const Divider(
              height: 10,
              thickness: 0,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => index == entries.maxNumber
                  ? entries.lastItem
                  : listItem(context, entries.data[index]),
              separatorBuilder: (_, __) => const SizedBox(
                height: 5,
              ),
              itemCount: entries.data.length + 1,
            )
          ],
        ),
      ),
    );
  }

  Widget listItem(BuildContext context, EntryModel item) => ListTile(
        title: Text(
          item.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        isThreeLine: false,
        subtitle: Text("${item.date} | ${item.itemsCount} items"),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Column(
            children: [
              Text("${item.totalMoney} EGP"),
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
