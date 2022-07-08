// ignore_for_file: camel_case_types, unnecessary_null_comparison

import 'package:bigsize_management_staff/blocs/product_bloc.dart';
import 'package:bigsize_management_staff/model/module/product.dart';
import 'package:bigsize_management_staff/models/order/new_order.dart';
import 'package:bigsize_management_staff/models/product/product_chosen_data.dart';
import 'package:bigsize_management_staff/models/product/product_detail.dart';
import 'package:bigsize_management_staff/models/product/product_detail_specific.dart';
import 'package:bigsize_management_staff/models/product/product_search.dart'
    as productSearch;
import 'package:bigsize_management_staff/services/storage_service.dart';
import 'package:bigsize_management_staff/view/ui/add_deal/add_entry.dart';
import 'package:bigsize_management_staff/view/ui/add_deal/widgets/product_search_to_add.dart';
import 'package:flutter/material.dart';
import 'package:bigsize_management_staff/view/shared/widgets/form_field.dart';

import '../../../resources/styles_manager.dart';

class AddBox extends StatefulWidget {
  const AddBox({Key? key}) : super(key: key);

  @override
  addBox createState() => addBox();
}

class addBox extends State<AddBox> {
  final StorageService _storageService = StorageService();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ProductBloc _productBloc = ProductBloc();

  String _searchText = "";
  productSearch.ProductSearch? searchProductList;
  ProductDetail? productDetail;
  List<ProductDetailSpecific>? listOrderProduct = [];

  bool isHaveProduct = false;

  Future<String?> getUserToken() async {
    return await _storageService.readSecureData("UserToken");
  }

  Future<productSearch.ProductSearch> searchProductByName(
      String searchKey) async {
    productSearch.ProductSearch search =
        await _productBloc.searchProductByName(searchKey);
    setState(() {
      searchProductList = search;
    });
    return search;
  }

  Future<ProductDetail> getProduct(int id) async {
    return await _productBloc.getProductDetail("", id);
  }

  Future<ProductDetailSpecific> getProductDetail(int id, int detailID) async {
    return await _productBloc.getProductSpecificDetail("", id, detailID);
  }

  void searchAndAddProduct(BuildContext context) async {
    ProductChosenData? chosenProductData = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const SearchProductToAdd(),
          fullscreenDialog: true,
        ));

    if (chosenProductData != null) {
      //print("CPID2: " + chosenProductData.chosenProductID.toString() + " " + chosenProductData.chosenProductDetailID.toString());
      if (listOrderProduct != null) {
        var isExistProduct = listOrderProduct!.where((product) =>
            product.content!.productId.toString() ==
                chosenProductData.chosenProductID.toString() &&
            product.content!.productDetailList!.first.productDetailId
                    .toString() ==
                chosenProductData.chosenProductDetailID.toString());

        if (isExistProduct.isNotEmpty) {
          var index = listOrderProduct!.indexWhere((product) =>
              product.content!.productId.toString() ==
                  chosenProductData.chosenProductID.toString() &&
              product.content!.productDetailList!.first.productDetailId
                      .toString() ==
                  chosenProductData.chosenProductDetailID.toString());

          AddOrderView.of(context)!.onProductDetailChange(ProductInNewOrder(
              productDetailId: isExistProduct
                  .first.content!.productDetailList!.first.productDetailId,
              quantity: listOrderProduct![index.toInt()].quantityInNewOrder =
                  listOrderProduct![index.toInt()].quantityInNewOrder!.toInt() +
                      1));

          AddOrderView.of(context)!.onProductChange(
              isExistProduct.first.content!.price!.toDouble(), 0);

          setState(() {
            listOrderProduct![index.toInt()].quantityInNewOrder =
                listOrderProduct![index.toInt()].quantityInNewOrder!.toInt() +
                    0;
          });
        } else {
          ProductDetailSpecific chosenProduct = await getProductDetail(
              int.parse(chosenProductData.chosenProductID.toString()),
              int.parse(chosenProductData.chosenProductDetailID.toString()));

          chosenProduct.quantityInNewOrder = 1;

          AddOrderView.of(context)!.onProductDetailChange(ProductInNewOrder(
              productDetailId: chosenProduct
                  .content!.productDetailList!.first.productDetailId,
              quantity: 1));

          AddOrderView.of(context)!
              .onProductChange(chosenProduct.content!.price!.toDouble(), 1);

          setState(() {
            listOrderProduct?.add(chosenProduct);
            isHaveProduct = true;
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    searchProductByName(_searchText);
  }

  @override
  Widget build(BuildContext context) {
    amountController.text = "1";

    return Column(
      children: <Widget>[
        FutureBuilder<String?>(
            future: getUserToken(),
            builder: (context, token) {
              if (token.hasData) {
                return Column(
                  children: <Widget>[
                    Form(
                      key: formKey,
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              //boxShadow: StyleManager.shadow,
                              //color: Theme.of(context).colorScheme.onSecondary,
                              borderRadius: StyleManager.border),
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Danh sách sản phẩm",
                                style: Theme.of(context).textTheme.headline4,
                                textAlign: TextAlign.left,
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      searchAndAddProduct(context);
                                    },
                                    child: const Text("Thêm sản phẩm")),
                              ),
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
                              itemBuilder: (context, index) =>
                                  listItem(context, listOrderProduct![index]),
                              separatorBuilder: (_, __) => const SizedBox(
                                height: 5,
                              ),
                              itemCount: listOrderProduct!.length,
                            ))
                        : Container(),
                  ],
                );
              }

              return const CircularProgressIndicator();
            })
      ],
    );
  }

  Widget listItem(BuildContext context, ProductDetailSpecific item) =>
      Dismissible(
        //key: Key(item.content!.productId.toString()),
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) async {
          AddOrderView.of(context)!.onProductDetailChange(ProductInNewOrder(
              productDetailId:
                  item.content!.productDetailList!.first.productDetailId,
              quantity: 0));
          AddOrderView.of(context)!.onProductChange(
              item.content!.price!.toDouble() *
                  item.quantityInNewOrder!.toInt() *
                  -1,
              -1);
          listOrderProduct!.remove(item);
          if (listOrderProduct!.isEmpty) {
            listOrderProduct!.clear();
          }
        },
        background: Container(
          color: Colors.red,
          child: dismissibleBackGround(),
        ),
        child: ListTile(
          leading: Image.network(
            item.content!.images!.first.imageUrl.toString(),
            height: 50,
            width: 50,
          ),
          title: Text(
            item.content!.productName.toString(),
            softWrap: false,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            //textWidthBasis: TextWidthBasis.longestLine,
          ),
          isThreeLine: false,
          subtitle: Text(
            item.content!.productDetailList!.first.colour!.colourName
                    .toString() +
                " - " +
                item.content!.productDetailList!.first.size!.sizeName
                    .toString() +
                " - ${item.quantityInNewOrder} cái",
            style: const TextStyle(fontFamily: "QuicksandMedium"),
          ),
          trailing: FittedBox(
            fit: BoxFit.fill,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("${item.content!.price} VND"),
                Row(
                  children: <Widget>[
                    IconButton(
                        onPressed: item.quantityInNewOrder == 1
                            ? () => {
                                  showAlertDialog(context,
                                      "Không thể giảm thêm.\nNếu muốn xóa sản phẩm này, hãy trượt sang bên trái."),
                                }
                            : () async {
                                setState(() {
                                  item.quantityInNewOrder =
                                      item.quantityInNewOrder!.toInt() - 1;
                                });
                                AddOrderView.of(context)!.onProductDetailChange(
                                    ProductInNewOrder(
                                        productDetailId: item
                                            .content!
                                            .productDetailList!
                                            .first
                                            .productDetailId,
                                        quantity: item.quantityInNewOrder));
                                AddOrderView.of(context)!.onProductChange(
                                    item.content!.price!.toDouble() * -1, 0);
                              },
                        icon: const Icon(
                          Icons.remove,
                          size: 20,
                        )),
                    Text(item.quantityInNewOrder.toString()),
                    IconButton(
                        onPressed: () async {
                          setState(() {
                            item.quantityInNewOrder =
                                item.quantityInNewOrder!.toInt() + 1;
                          });
                          AddOrderView.of(context)!.onProductDetailChange(
                              ProductInNewOrder(
                                  productDetailId: item.content!
                                      .productDetailList!.first.productDetailId,
                                  quantity: item.quantityInNewOrder));
                          AddOrderView.of(context)!.onProductChange(
                              item.content!.price!.toDouble(), 0);
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 20,
                        ))
                  ],
                ),
              ],
            ),
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
            'Xóa khỏi danh sách',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      );

  showAlertDialog(context, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Thông báo"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /*
  showAddForm(BuildContext context, String token) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: StyleManager.border,
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: DefaultFormField(
                    border: true,
                    controller: searchController,
                    title: "Search Product",
                    prefix: Icons.search,
                    onChange: (value) async {
                      searchController.text = value;
                      _searchText = searchController.text;
                      productSearch.ProductSearch search =
                          await searchProductByName(_searchText);
                      setState(() {
                        searchProductList = search;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchProductList == null
                      ? 0
                      : searchProductList!.content!.length,
                  itemBuilder: (context, index) {
                    if (searchProductList != null &&
                        searchProductList!.content!.isNotEmpty) {
                      return GestureDetector(
                          onTap: () async {
                            ProductDetail chooseProduct = await getProduct(
                                searchProductList!.content![index].productId!
                                    .toInt());
                            setState(() {
                              listOrderProduct!.add(chooseProduct);
                            });
                            Navigator.pop(context);
                          },
                          child: Card(
                              shadowColor: Colors.grey,
                              child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(children: [
                                    Row(children: <Widget>[
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Image.network(
                                            searchProductList!
                                                .content![index].imageUrl
                                                .toString(),
                                            width: 100,
                                            height: 100,
                                          )),
                                      const SizedBox(width: 7),
                                      Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            Text(
                                                searchProductList!
                                                    .content![index].productName
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black)),
                                            const SizedBox(height: 3),
                                            Text(
                                                '${searchProductList!.content![index].price}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black)),
                                            const SizedBox(height: 3),
                                            Text(
                                                '${searchProductList!.content![index].promotionPrice}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black54)),
                                          ])),
                                    ]),
                                    const SizedBox(height: 8),
                                    /*
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: CircleAvatar(
                                                  backgroundColor: Colors.blue
                                                      .withOpacity(0.1),
                                                  radius: 15,
                                                  child: const Text('-',
                                                      style: const TextStyle(
                                                          color: Colors.blue))),
                                              onTap: () =>
                                                  controller.quantityMinus(e)),
                                          const SizedBox(width: 5),
                                          Text('${e.quantity.value}'),
                                          const SizedBox(width: 5),
                                          InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: CircleAvatar(
                                                  backgroundColor: Colors.blue
                                                      .withOpacity(0.1),
                                                  radius: 15,
                                                  child: const Text('+',
                                                      style: const TextStyle(
                                                          color: Colors.blue))),
                                              onTap: () =>
                                                  controller.quantityAdd(e))
                                        ])*/
                                  ]))));
                    } else if (searchProductList != null &&
                        searchProductList!.content!.isEmpty) {
                      return Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "Khong co ket qua",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                          ),
                        ),
                      );
                    }

                    return Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      });*/
}
