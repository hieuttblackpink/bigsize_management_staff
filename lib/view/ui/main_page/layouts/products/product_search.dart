import 'package:bigsize_management_staff/blocs/product_bloc.dart';
import 'package:bigsize_management_staff/models/product/product_search.dart';
import 'package:bigsize_management_staff/services/storage_service.dart';
import 'package:bigsize_management_staff/view/resources/styles_manager.dart';
import 'package:bigsize_management_staff/view/shared/widgets/form_field.dart';
import 'package:bigsize_management_staff/view/shared/widgets/text_field_search.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/products/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  Future<String?> getUserToken() async {
    return await _storageService.readSecureData("UserToken");
  }

  Future<ProductSearch> searchProductByName(String searchKey) async {
    ProductSearch search = await _productBloc.searchProductByName(searchKey);
    setState(() {
      productSearch = search;
    });
    return search;
  }

  @override
  void initState() {
    super.initState();
    searchProductByName(_searchText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tìm kiếm sản phẩm"),
      ),
      body: SingleChildScrollView(
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
                              _searchText = searchController.text;
                              ProductSearch search =
                                  await searchProductByName(_searchText);
                              setState(() {
                                productSearch = search;
                                searchController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: searchController.text.length));
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: productSearch == null
                              ? 0
                              : productSearch!.content!.length,
                          itemBuilder: (context, index) {
                            if (productSearch != null &&
                                productSearch!.content!.isNotEmpty) {
                              return GestureDetector(
                                  onTap: () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ProductDetail(
                                                      userToken:
                                                          token.toString(),
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
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black)),
                                                    const SizedBox(height: 3),
                                                    Text(
                                                        '${productSearch!.content![index].price}',
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black)),
                                                    const SizedBox(height: 3),
                                                    Text(
                                                        '${productSearch!.content![index].promotionPrice}',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors
                                                                .black54)),
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
                      ],
                    );
                  }

                  return const CircularProgressIndicator();
                })
          ],
        ),
      ),
    );
  }
}
