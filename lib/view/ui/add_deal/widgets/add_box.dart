import 'package:bigsize_management_staff/blocs/product_bloc.dart';
import 'package:bigsize_management_staff/model/module/product.dart';
import 'package:bigsize_management_staff/models/product_detail.dart';
import 'package:bigsize_management_staff/models/product_search.dart'
    as productSearch;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:bigsize_management_staff/view/shared/widgets/form_field.dart';

import '../../../resources/styles_manager.dart';
import '../../../shared/widgets/numeric_field.dart';

class AddBox extends StatefulWidget {
  const AddBox({Key? key}) : super(key: key);

  @override
  _AddBox createState() => _AddBox();
}

class _AddBox extends State<AddBox> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ProductBloc _productBloc = ProductBloc();
  productSearch.ProductSearch? searchProductList;
  ProductDetail? productDetail;

  bool isHaveProduct = false;

  Future<productSearch.ProductSearch> searchProductByName(
      String searchKey) async {
    return await _productBloc.searchProductByName(searchKey);
  }

  Future<ProductDetail> getProduct(int id) async {
    return await _productBloc.getProductDetail("", id);
  }

  Product? product;

  @override
  Widget build(BuildContext context) {
    amountController.text = "1";

    return Column(
      children: <Widget>[
        Form(
          key: formKey,
          child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  boxShadow: StyleManager.shadow,
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: StyleManager.border),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            showAddForm(context);
                          },
                          child: const Text("Them san pham")))
                ],
              )),
        ),
        const SizedBox(height: 20),
        isHaveProduct
            ? Container(
                alignment: Alignment.center,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => listItem(context, product!),
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 5,
                  ),
                  itemCount: 10,
                ))
            : Container(),
      ],
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

  showAddForm(BuildContext context) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(),
        );
      });
}
