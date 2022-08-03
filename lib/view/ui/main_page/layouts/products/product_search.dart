import 'package:bigsize_management_staff/blocs/product_bloc.dart';
import 'package:bigsize_management_staff/models/product/product_search.dart';
import 'package:bigsize_management_staff/services/storage_service.dart';
import 'package:bigsize_management_staff/view/resources/styles_manager.dart';
import 'package:bigsize_management_staff/view/shared/widgets/form_field.dart';
import 'package:bigsize_management_staff/view/shared/widgets/text_field_search.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/products/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';

class SearchProductLayout extends StatefulWidget {
  const SearchProductLayout({Key? key}) : super(key: key);

  @override
  _SearchProductLayout createState() => _SearchProductLayout();
}

class _SearchProductLayout extends State<SearchProductLayout> {
  final StorageService _storageService = StorageService();
  final ProductBloc _productBloc = ProductBloc();
  ProductSearch? productSearch;
  TextEditingController searchController = TextEditingController();
  String _searchText = "";
  final ScrollController _controller = ScrollController();

  int page = 1;
  bool isFirstLoad = true;
  bool isLoadMoreRunning = false;
  bool hasNextPage = false;
  bool isSearching = false;

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
        //_controller.addListener(_loadMore);
        print(hasNextPage.toString());
      });
    }
    return search;
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
                          //controller: _controller,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: productSearch == null
                              ? 0
                              : productSearch!.content!.length,
                          itemBuilder: (context, index) {
                            if (productSearch != null &&
                                productSearch!.content!.isNotEmpty &&
                                !isFirstLoad) {
                              return GestureDetector(
                                  onTap: () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ProductDetail(
                                                      userToken:
                                                          token.data.toString(),
                                                      productID: productSearch!
                                                          .content![index]
                                                          .productId,
                                                    )))
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
                                              const SizedBox(width: 10),
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
                                                            fontSize: 15,
                                                            fontFamily:
                                                                "QuicksandBold",
                                                            color:
                                                                Colors.black)),
                                                    const SizedBox(height: 5),
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
                                                            fontSize: 16,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            fontFamily:
                                                                "QuicksandMedium",
                                                            color: Colors
                                                                .black54)),
                                                    const SizedBox(height: 3),
                                                    Text(
                                                        productSearch!
                                                                    .content![
                                                                        index]
                                                                    .promotionPrice
                                                                    .toString() !=
                                                                "null"
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
                                                            fontSize: 17,
                                                            color:
                                                                Colors.black)),
                                                  ])),
                                              Container(
                                                alignment: Alignment.center,
                                                child: const Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    size: 25,
                                                    color: Colors.blue),
                                              ),
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
                            } else if (productSearch != null &&
                                productSearch!.content!.isEmpty &&
                                !isFirstLoad) {
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

  void scrollUp() {
    const double start = 0;

    //_controller.jumpTo(start);
    _controller.animateTo(start,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }
}
