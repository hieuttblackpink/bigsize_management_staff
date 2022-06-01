import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../model/module/product.dart';

class OldEntryList extends StatelessWidget {
  OldEntryList({Key? key}) : super(key: key);

  final Product product = Product(
    notes: '',
    name: 'Laser Bag',
    date: '11-9-2020',
    amount: 10,
    id: 2,
    img: Uint8List(0),
    realPrice: 10,
    sellPrice: 12,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => listItem(context, product),
      separatorBuilder: (_, __) => const SizedBox(
        height: 5,
      ),
      itemCount: 10,
    );
  }

  Widget listItem(BuildContext context, Product item) => Dismissible(
        key: Key(item.id.toString()),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          child: dismissibleBackGround(),
        ),
        child: ListTile(
          title: Text(
            item.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          isThreeLine: false,
          subtitle: Text("2 Items | ${item.sellPrice} EGP"),
          trailing: const FittedBox(
            fit: BoxFit.fill,
            child: Text("120 EGP"),
          ),
        ),
      );

  Widget dismissibleBackGround() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      );
}
