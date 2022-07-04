import 'package:bigsize_management_staff/blocs/product_bloc.dart';
import 'package:bigsize_management_staff/models/product/product_colour.dart';
import 'package:bigsize_management_staff/models/product/product_quantity_store.dart';
import 'package:bigsize_management_staff/models/product/product_size.dart';
import 'package:flutter/material.dart';

class ProductDetailQuantity extends StatefulWidget {
  final String userToken;
  final int? productID;
  const ProductDetailQuantity(
      {Key? key, required this.userToken, required this.productID})
      : super(key: key);

  @override
  _ProductDetailQuantity createState() => _ProductDetailQuantity();
}

class _ProductDetailQuantity extends State<ProductDetailQuantity> {
  final ProductBloc _productBloc = ProductBloc();
  List<ProductColourContent>? listProductColour;
  List<ProductSizeContent>? listProductSize;
  ProductQuantityStoreContent? productQuantityStoreContent;

  int colorIndex = 0;
  int sizeIndex = 0;

  Future<ProductColour> getProductColour(String token, int idP) async {
    ProductColour pC = await _productBloc.getProductColour(token, idP);
    setState(() {
      listProductColour = pC.content;
    });
    return pC;
  }

  Future<ProductSize> getProductSize(String token, int idP, int idC) async {
    ProductSize pS = await _productBloc.getProductSize(token, idP, idC);
    if (mounted) {
      setState(() {
        listProductSize = pS.content;
      });
    }
    return pS;
  }

  Future<ProductQuantityStore> getProductQuantity(
      String token, int idP, int idC, int idS) async {
    ProductQuantityStore pQS =
        await _productBloc.getProductQuantityStore(token, idP, idC, idS);
    if (mounted) {
      setState(() {
        productQuantityStoreContent = pQS.content;
      });
    }
    return pQS;
  }

  @override
  void initState() {
    super.initState();
    getProductColour(widget.userToken, widget.productID!.toInt());
  }

  @override
  Widget build(BuildContext context) {
    if (listProductColour != null) {
      getProductSize(widget.userToken, widget.productID!.toInt(),
          listProductColour![colorIndex].colourId!.toInt());
      if (listProductSize != null) {
        getProductQuantity(
            widget.userToken,
            widget.productID!.toInt(),
            listProductColour![colorIndex].colourId!.toInt(),
            listProductSize![sizeIndex].sizeId!.toInt());
      }
    }
    return Container(
      alignment: Alignment.center,
      child: Column(children: <Widget>[
        listProductColour != null
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 50,
                    childAspectRatio: 1 / 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: listProductColour!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      setState(() {
                        colorIndex = index;
                        sizeIndex = 0;
                        getProductSize(
                            widget.userToken,
                            widget.productID!.toInt(),
                            listProductColour![colorIndex].colourId!.toInt());
                        getProductQuantity(
                            widget.userToken,
                            widget.productID!.toInt(),
                            listProductColour![colorIndex].colourId!.toInt(),
                            listProductSize![sizeIndex].sizeId!.toInt());
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(int.parse(
                            "FF" +
                                listProductColour![index]
                                    .colourCode!
                                    .replaceAll('#', ''),
                            radix: 16)),
                        shape: BoxShape.circle,
                        border: index == colorIndex
                            ? Border.all(
                                width: 1, color: Colors.black.withOpacity(0.5))
                            : Border.all(width: 0, color: Colors.white),
                      ),
                      child: index == colorIndex
                          ? Container(
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            )
                          : Container(),
                    ),
                  );
                })
            : Container(),
        const SizedBox(
          height: 10,
        ),
        listProductSize != null
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 50,
                    childAspectRatio: 1 / 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: listProductSize!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      setState(() {
                        sizeIndex = index;
                        getProductQuantity(
                            widget.userToken,
                            widget.productID!.toInt(),
                            listProductColour![colorIndex].colourId!.toInt(),
                            listProductSize![sizeIndex].sizeId!.toInt());
                      });
                    },
                    child: Container(
                      width: 70,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: index == sizeIndex
                            ? Border.all(
                                width: 1, color: Colors.black.withOpacity(0.5))
                            : Border.all(width: 0, color: Colors.white),
                      ),
                      child: index == sizeIndex
                          ? Container(
                              alignment: Alignment.center,
                              child: Text(
                                listProductSize![index].sizeName.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            )
                          : Container(
                              alignment: Alignment.center,
                              child: Text(
                                listProductSize![index].sizeName.toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                    ),
                  );
                })
            : Container(),
        const SizedBox(
          height: 20,
        ),
        productQuantityStoreContent != null
            ? Row(
                children: <Widget>[
                  const Text("San pham trong kho"),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(productQuantityStoreContent!.quantity.toString()),
                ],
              )
            : Container(),
      ]),
    );
  }
}
