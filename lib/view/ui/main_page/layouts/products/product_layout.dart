import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bigsize_management_staff/model/module/product.dart';

import '../../../../../model/module/ui_models.dart';
import '../../../../../view_model/app_provider.dart';
import '../../../../resources/styles_manager.dart';

class ProductLayout extends StatelessWidget {
  const ProductLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Selector<AppProvider, ShowData<Product>>(
        selector: (context, appProvider) => appProvider.productsShow,
        builder: (context, entries, _) => ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                Text("Total Products ${entries.maxNumber}",
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
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) => index == entries.maxNumber
                  ? entries.lastItem
                  : listItem(context, entries.data[index]),
              itemCount: entries.data.length + 1,
            )
          ],
        ),
      ),
    );
  }

  Widget listItem(BuildContext context, Product item) => Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: StyleManager.border,
            boxShadow: StyleManager.shadow),
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: StyleManager.border, // Image border
                    child: Image.network(
                      'https://design-milk.com/images/2014/09/PLAAT-Bag-Dewi-Bekker-qoowl-1.jpg',
                      height: constraints.maxHeight * .58,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Tooltip(
                          message: "Real price ${item.realPrice} EGP",
                          child: Text(
                            "${item.sellPrice} EGP",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                        Text(
                          item.date,
                          style: Theme.of(context).textTheme.headline4,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                right: 10,
                top: constraints.maxHeight * .58 - 10,
                child: CircleAvatar(
                  radius: 20,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  backgroundColor: Theme.of(context).colorScheme.onSurface,
                  child: Text(item.amount.toString()),
                ),
              )
            ],
          ),
        ),
      );
}
