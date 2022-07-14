// ignore_for_file: deprecated_member_use

import 'package:bigsize_management_staff/blocs/product_bloc.dart';
import 'package:bigsize_management_staff/models/product/product_chosen_data.dart';
import 'package:bigsize_management_staff/models/product/product_colour.dart';
import 'package:bigsize_management_staff/models/product/product_detail.dart'
    as productDetail;
import 'package:bigsize_management_staff/models/product/product_quantity_store.dart';
import 'package:bigsize_management_staff/models/product/product_search.dart';
import 'package:bigsize_management_staff/models/product/product_size.dart';
import 'package:bigsize_management_staff/services/storage_service.dart';
import 'package:bigsize_management_staff/view/resources/styles_manager.dart';
import 'package:bigsize_management_staff/view/shared/widgets/custom_row.dart';
import 'package:bigsize_management_staff/view/shared/widgets/form_field.dart';
import 'package:bigsize_management_staff/view/shared/widgets/text_field_search.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/products/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';

class SearchProductToAdd extends StatefulWidget {
  const SearchProductToAdd({Key? key}) : super(key: key);

  @override
  _SearchProductToAdd createState() => _SearchProductToAdd();
}

class _SearchProductToAdd extends State<SearchProductToAdd> {
  final StorageService _storageService = StorageService();
  final ProductBloc _productBloc = ProductBloc();
  final ScrollController _controller = ScrollController();
  ProductSearch? productSearch;
  TextEditingController searchController = TextEditingController();
  String _searchText = "";
  List<ProductColourContent>? listProductColour;
  List<ProductSizeContent>? listProductSize;
  ProductQuantityStoreContent? productQuantityStoreContent;
  String productDetailID = "";

  int colorIndex = 0;
  int sizeIndex = 0;
  int page = 1;

  bool isSearching = false;
  bool isGettingColour = false;
  bool isGettingSize = false;
  bool isGettingQuantity = false;

  bool isFirstLoad = true;
  bool isLoadMoreRunning = false;
  bool hasNextPage = false;

  Future<String?> getUserToken() async {
    return await _storageService.readSecureData("UserToken");
  }

  Future<ProductSearch> searchProductByName(String searchKey, int page) async {
    ProductSearch search =
        await _productBloc.searchProductByName(searchKey, page);
    if (mounted && isFirstLoad) {
      setState(() {
        productSearch = search;
        isFirstLoad = false;
        hasNextPage = search.hasNext!;
      });
    }
    return search;
  }

  Future<productDetail.ContentProductDetail?> getProductDetail(
      String token, int id) async {
    return await _productBloc
        .getProductDetail(token, id)
        .then((value) => value.content);
  }

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
        productDetailID = pQS.content!.productDetailId.toString();
      });
    }
    return pQS;
  }

  @override
  void initState() {
    super.initState();
    searchProductByName(_searchText, page);
    _controller.addListener(_loadMore);
  }

  void _loadMore() async {
    //print("Loadmore " + _controller.position.extentAfter.toString());
    if (hasNextPage == true &&
        isFirstLoad == false &&
        isLoadMoreRunning == false &&
        isSearching == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      page += 1; // Increase _page by 1
      try {
        ProductSearch searchMore = await searchProductByName(_searchText, page);

        if (searchMore.content!.isNotEmpty) {
          setState(() {
            productSearch!.content!.addAll(searchMore.content!.toList());
            hasNextPage = searchMore.hasNext!;
            print(productSearch!.content!.length);
          });
        } else {
          setState(() {
            hasNextPage = false;
          });
        }
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        isLoadMoreRunning = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tìm kiếm sản phẩm"),
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: <Widget>[
            FutureBuilder<String?>(
                future: getUserToken(),
                builder: (context, token) {
                  if (token.hasData) {
                    return Column(
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
                            title: "Tìm kiếm sản phẩm",
                            prefix: Icons.search,
                            onChange: (value) async {
                              searchController.text = value;
                              setState(() {
                                searchController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: searchController.text.length));
                                _searchText = searchController.text;
                                isSearching = true;
                              });
                              //_searchText = searchController.text;
                              ProductSearch search =
                                  await searchProductByName(_searchText, 1);
                              setState(() {
                                productSearch = search;
                                page = 1;
                                isSearching = false;
                                hasNextPage = search.hasNext!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: productSearch == null
                              ? 0
                              : productSearch!.content!.length,
                          itemBuilder: (context, index) {
                            if (productSearch != null &&
                                productSearch!.content!.isNotEmpty) {
                              return GestureDetector(
                                  onTap: () async {
                                    productDetail.ContentProductDetail?
                                        getProduct = await getProductDetail(
                                            token.data.toString(),
                                            productSearch!
                                                .content![index].productId!
                                                .toInt());
                                    if (getProduct!
                                        .productDetailList!.isNotEmpty) {
                                      getProduct.productDetailList!.first
                                          .selected = true;
                                      productDetailID = getProduct
                                          .productDetailList!
                                          .first
                                          .productDetailId
                                          .toString();
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 20),
                                              //height: 500,
                                              color: Colors.white,
                                              child: dialogContent(
                                                  context,
                                                  getProduct.productDetailList,
                                                  productSearch!.content![index]
                                                      .productId!
                                                      .toInt()),
                                            );
                                          });
                                    } else {
                                      showNoColorSizeDialog(context);
                                    }

                                    /*    
                                    Navigator.pop(
                                        context,
                                        productSearch!
                                            .content![index].productId!
                                            .toInt());
                                    */
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
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Image.network(
                                                    productSearch!
                                                        .content![index]
                                                        .imageUrl
                                                        .toString(),
                                                    width: 100,
                                                    height: 100,
                                                  )),
                                              const SizedBox(width: 7),
                                              Expanded(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                    Text(
                                                        productSearch!
                                                            .content![index]
                                                            .productName
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "QuicksandMedium",
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black)),
                                                    const SizedBox(height: 3),
                                                    Text(
                                                        MoneyFormatter(
                                                                amount: productSearch!
                                                                    .content![
                                                                        index]
                                                                    .price!
                                                                    .toDouble())
                                                            .output
                                                            .nonSymbol
                                                            .toString(),
                                                        style: const TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            fontFamily:
                                                                "Quicksand",
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black)),
                                                    const SizedBox(height: 3),
                                                    Text(
                                                        productSearch!
                                                                    .content![
                                                                        index]
                                                                    .promotionPrice !=
                                                                null
                                                            ? MoneyFormatter(
                                                                    amount: productSearch!
                                                                        .content![
                                                                            index]
                                                                        .promotionPrice!
                                                                        .toDouble())
                                                                .output
                                                                .nonSymbol
                                                                .toString()
                                                            : MoneyFormatter(
                                                                    amount: productSearch!
                                                                        .content![
                                                                            index]
                                                                        .price!
                                                                        .toDouble())
                                                                .output
                                                                .nonSymbol
                                                                .toString(),
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "QuicksandMedium",
                                                            fontSize: 14,
                                                            color: Colors
                                                                .black54)),
                                                  ])),
                                            ]),
                                            const SizedBox(height: 8),
                                          ]))));
                            } else if (productSearch != null &&
                                productSearch!.content!.isEmpty) {
                              return Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  "Không có kết quả tìm kiếm",
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
                        if (isLoadMoreRunning == true)
                          const Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 40),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    );
                  }

                  return const CircularProgressIndicator();
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.arrow_upward_rounded,
          color: Colors.blue,
          size: 50,
        ),
        onPressed: scrollUp,
      ),
    );
  }

  showNoColorSizeDialog(context) {
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
      content: const Text(
          "Không thể thêm sản phẩm này\nSản phẩm này chưa có\nmàu sắc và kích cỡ."),
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

  dialogContent(BuildContext context,
      List<productDetail.ProductDetailList>? productDetailList, int productID) {
    return StatefulBuilder(builder: (context, setState) {
      return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomAppBar(
            child: Container(
              margin: const EdgeInsets.only(
                  left: 25, right: 25, bottom: 30, top: 30),
              height: 50,
              width: double.infinity,
              child: FlatButton(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                onPressed: () async {
                  ProductChosenData chosenProductData = ProductChosenData(
                      chosenProductID: productID.toString(),
                      chosenProductDetailID: productDetailID);
                  Navigator.pop(context);
                  Navigator.pop(context, chosenProductData);
                },
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text(
                  "Thêm sản phẩm",
                ),
              ),
            ),
          ),
          body: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () => {Navigator.pop(context)},
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  alignment: Alignment.topRight,
                  child: const Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 30.0,
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                color: Colors.white,
                child: const Text(
                  "Chọn màu sắc và kích cỡ",
                  style: TextStyle(fontFamily: "QuicksandMedium", fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Flexible(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.white,
                  ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: productDetailList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      //highlightColor: Colors.red,
                      //splashColor: Colors.blueAccent,
                      onTap: () {
                        setState(() {
                          for (var element in productDetailList) {
                            element.selected = false;
                          }
                          productDetailList[index].selected = true;
                        });
                        this.setState(() {
                          productDetailID = productDetailList[index]
                              .productDetailId
                              .toString();
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 10),
                        height: 75,
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 3.0, bottom: 3.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              productDetailList[index]
                                      .colour!
                                      .colourName
                                      .toString() +
                                  " - " +
                                  productDetailList[index]
                                      .size!
                                      .sizeName
                                      .toString(),
                              style: const TextStyle(
                                  fontFamily: "QuicksandMedium", fontSize: 25),
                            ),
                            productDetailList[index].selected == true
                                ? const Icon(
                                    Icons.radio_button_checked,
                                    color: Colors.amber,
                                  )
                                : const Icon(Icons.radio_button_unchecked),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ), //Custom ListView
              const SizedBox(
                height: 40,
              ),
              /*
              Container(
                margin: const EdgeInsets.only(left: 25, right: 25),
                height: 50,
                width: double.infinity,
                child: FlatButton(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  onPressed: () async {
                    ProductChosenData chosenProductData = ProductChosenData(
                        chosenProductID: productID.toString(),
                        chosenProductDetailID: productDetailID);
                    Navigator.pop(context);
                    Navigator.pop(context, chosenProductData);
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: const Text(
                    "Thêm sản phẩm",
                  ),
                ),
              ),*/
            ],
          ));
    });
  }

  void scrollUp() {
    const double start = 0;

    //_controller.jumpTo(start);
    _controller.animateTo(start,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }
}
