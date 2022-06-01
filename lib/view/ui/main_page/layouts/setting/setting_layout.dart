import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bigsize_management_staff/view/shared/widgets/numeric_field.dart';
import 'package:bigsize_management_staff/view_model/setting_provider.dart';

import '../../../../resources/styles_manager.dart';

class SettingLayout extends StatelessWidget {
  const SettingLayout({Key? key}) : super(key: key);

  SettingProvider settingProvider(BuildContext context) =>
      context.read<SettingProvider>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text("Setting"),
            ),
          ],
        ));
  }

  Widget database(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: StyleManager.border,
            boxShadow: StyleManager.shadow),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _button(context, 'Import database',
                () => settingProvider(context).importDataBase()),
            _divider(context),
            _button(context, 'Export database',
                () => settingProvider(context).exportDataBase()),
            _divider(context),
            _button(context, 'Clear database',
                () => settingProvider(context).clearDataBase()),
          ],
        ),
      );
  Widget product(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: StyleManager.border,
            boxShadow: StyleManager.shadow),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Minimum amount',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                      width: 120,
                      child: NumericField(
                        TextEditingController(
                            text: settingProvider(context)
                                .minimumAmount
                                .toString()),
                        onChange: (v) => settingProvider(context)
                            .changeMinimumAmount(int.parse(v)),
                      ))
                ],
              ),
            ),
            _divider(context),
            _button(
              context,
              'Hide wholesale price',
              () => settingProvider(context).hidePrice(),
            ),
          ],
        ),
      );

  Widget reports(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: StyleManager.border,
            boxShadow: StyleManager.shadow),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, _) => _divider(context),
          itemCount: 5,
          itemBuilder: (context, index) => Align(
            alignment: Alignment.centerLeft,
            child: [
              _button(
                context,
                'Not in stock items',
                () => settingProvider(context).printZeroProduct(),
              ),
              _button(
                context,
                'Less than minimum amount',
                () => settingProvider(context).printLessProduct(),
              ),
              _button(
                context,
                'All products',
                () => settingProvider(context).printAllProduct(),
              ),
              _button(
                context,
                'All entries',
                () => settingProvider(context).printAllEntries(),
              ),
              _button(
                context,
                'All Orders',
                () => settingProvider(context).printAllOrders(),
              ),
            ][index],
          ),
        ),
      );

  Widget _button(BuildContext context, String text, Function() onPressed) =>
      TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      );

  Widget _title(BuildContext context, String text) => Row(
        children: [
          Expanded(
            child: Divider(
              color: Theme.of(context).colorScheme.onBackground,
              // thickness: 10,
              height: 10,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(text, style: Theme.of(context).textTheme.headline4),
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
      );

  Widget _divider(BuildContext context) => Padding(
        padding: EdgeInsets.zero,
        child: Divider(
          color: Theme.of(context).colorScheme.onBackground,
          height: 0,
        ),
      );
}
