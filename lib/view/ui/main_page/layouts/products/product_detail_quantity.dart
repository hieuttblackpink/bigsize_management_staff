import 'package:bigsize_management_staff/blocs/product_bloc.dart';
import 'package:bigsize_management_staff/models/product/product_colour.dart';
import 'package:bigsize_management_staff/models/product/product_quantity_store.dart';
import 'package:bigsize_management_staff/models/product/product_size.dart';
import 'package:bigsize_management_staff/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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

  bool isGetColour = true;
  bool isGetSize = true;
  bool isGetQuantity = true;

  Future<ProductColour> getProductColour(String token, int idP) async {
    ProductColour pC = await _productBloc.getProductColour(token, idP);
    if (mounted && isGetColour) {
      setState(() {
        listProductColour = pC.content;
        isGetColour = false;
      });
    }
    return pC;
  }

  Future<ProductSize> getProductSize(String token, int idP, int idC) async {
    ProductSize pS = await _productBloc.getProductSize(token, idP, idC);
    if (mounted && isGetSize) {
      setState(() {
        listProductSize = pS.content;
        if (listProductSize != null && isGetQuantity) {
          print("a");
          getProductQuantity(
              widget.userToken,
              widget.productID!.toInt(),
              listProductColour![colorIndex].colourId!.toInt(),
              listProductSize![sizeIndex].sizeId!.toInt());
        }
        isGetSize = false;
      });
    }
    return pS;
  }

  Future<ProductQuantityStore> getProductQuantity(
      String token, int idP, int idC, int idS) async {
    ProductQuantityStore pQS =
        await _productBloc.getProductQuantityStore(token, idP, idC, idS);
    if (mounted && isGetQuantity) {
      setState(() {
        productQuantityStoreContent = pQS.content;
        isGetQuantity = false;
      });
    }
    print("b");
    return pQS;
  }

  @override
  void initState() {
    super.initState();
    getProductColour(widget.userToken, widget.productID!.toInt());
  }

  @override
  Widget build(BuildContext context) {
    if (listProductColour != null &&
        listProductColour!.isNotEmpty &&
        isGetSize) {
      getProductSize(widget.userToken, widget.productID!.toInt(),
          listProductColour![colorIndex].colourId!.toInt());
      if (listProductSize != null && isGetQuantity) {
        print("a");
        getProductQuantity(
            widget.userToken,
            widget.productID!.toInt(),
            listProductColour![colorIndex].colourId!.toInt(),
            listProductSize![sizeIndex].sizeId!.toInt());
      }
    }
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: StyleManager.shadow,
          borderRadius: StyleManager.border),
      child: Column(children: <Widget>[
        listProductColour != null &&
                listProductColour!.isNotEmpty &&
                !isGetColour
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 60,
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
                        setState(() {
                          isGetSize = true;
                          isGetQuantity = true;
                        });
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
                            ? Border.all(width: 1, color: Colors.black)
                            : Border.all(width: 1, color: Colors.grey),
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
            : Container(
                alignment: Alignment.centerLeft,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 60,
                            childAspectRatio: 1 / 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: 5,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () async {},
                          child: Shimmer.fromColors(
                            child: Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            baseColor: const Color.fromARGB(255, 225, 225, 225),
                            highlightColor: Colors.white,
                          ));
                    }),
              ),
        const SizedBox(
          height: 20,
        ),
        listProductSize != null && !isGetSize
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 75,
                    childAspectRatio: 1 / 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20),
                itemCount: listProductSize!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      setState(() {
                        sizeIndex = index;
                        setState(() {
                          isGetQuantity = true;
                        });
                        getProductQuantity(
                            widget.userToken,
                            widget.productID!.toInt(),
                            listProductColour![colorIndex].colourId!.toInt(),
                            listProductSize![sizeIndex].sizeId!.toInt());
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: index == sizeIndex
                            ? Border.all(width: 1, color: Colors.black)
                            : Border.all(width: 0, color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: index == sizeIndex
                          ? Container(
                              alignment: Alignment.center,
                              child: Text(
                                listProductSize![index].sizeName.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontFamily: "QuicksandBold"),
                              ),
                            )
                          : Container(
                              alignment: Alignment.center,
                              child: Text(
                                listProductSize![index].sizeName.toString(),
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: "QuicksandMedium"),
                              ),
                            ),
                    ),
                  );
                })
            : Container(
                alignment: Alignment.centerLeft,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 75,
                            childAspectRatio: 1 / 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20),
                    itemCount: 5,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () async {},
                          child: Shimmer.fromColors(
                            child: Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            baseColor: const Color.fromARGB(255, 225, 225, 225),
                            highlightColor: Colors.white,
                          ));
                    }),
              ),
        const SizedBox(
          height: 25,
        ),
        productQuantityStoreContent != null && !isGetQuantity
            ? Row(
                children: <Widget>[
                  const Text(
                    "Sản phẩm trong kho còn: ",
                    style:
                        TextStyle(fontFamily: "QuicksandMedium", fontSize: 15),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    productQuantityStoreContent!.quantity.toString(),
                    style: const TextStyle(
                        fontFamily: "QuicksandBold", fontSize: 25),
                  ),
                ],
              )
            : Container(
                alignment: Alignment.centerLeft,
                child: Shimmer.fromColors(
                  child: const Text(
                    "Sản phẩm trong kho còn: ",
                    style:
                        TextStyle(fontFamily: "QuicksandMedium", fontSize: 15),
                  ),
                  baseColor: const Color.fromARGB(255, 225, 225, 225),
                  highlightColor: Colors.white,
                ),
              ),
        const SizedBox(
          height: 20,
        ),
      ]),
    );
  }
}
