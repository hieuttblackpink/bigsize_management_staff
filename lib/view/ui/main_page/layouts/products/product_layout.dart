import 'package:bigsize_management_staff/blocs/product_bloc.dart';
import 'package:bigsize_management_staff/models/product/product.dart';
import 'package:bigsize_management_staff/services/storage_service.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/products/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../resources/styles_manager.dart';

class ProductLayout extends StatefulWidget {
  const ProductLayout({Key? key}) : super(key: key);

  @override
  _ProductLayout createState() => _ProductLayout();
}

class _ProductLayout extends State<ProductLayout> {
  final StorageService _storageService = StorageService();
  final ProductBloc _productBloc = ProductBloc();

  Future<String?> getUserToken() async {
    return await _storageService.readSecureData("UserToken");
  }

  Future<List<ContentProductList>?> getProductList(String token) async {
    return await _productBloc
        .getListProduct(token)
        .then((value) => value.content);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          FutureBuilder<String?>(
              future: getUserToken(),
              builder: (context, token) {
                if (token.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FutureBuilder<List<ContentProductList>?>(
                        future: getProductList(token.data.toString()),
                        builder: (context, entries) {
                          if (entries.hasData) {
                            return ListView(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        "Hiển thị: ${entries.data!.length} sản phẩm",
                                        style: const TextStyle(
                                          fontFamily: "QuicksandMedium",
                                          fontSize: 18,
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 2,
                                      height: 10,
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
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.9,
                                  ),
                                  itemBuilder: (context, index) =>
                                      index == entries.data!.length
                                          ? listItem(
                                              context,
                                              entries.data!.last,
                                              token.data.toString())
                                          : listItem(
                                              context,
                                              entries.data![index],
                                              token.data.toString()),
                                  itemCount: entries.data!.length,
                                )
                              ],
                            );
                          }

                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.9,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    borderRadius: StyleManager.border,
                                    boxShadow: StyleManager.shadow),
                                child: LayoutBuilder(
                                  builder: (context, constraints) => Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius: StyleManager
                                                  .border, // Image border
                                              child: Shimmer.fromColors(
                                                  child: Container(
                                                    height:
                                                        constraints.maxHeight *
                                                            .6,
                                                    width: double.infinity,
                                                    decoration: ShapeDecoration(
                                                      color: Colors.grey[400]!,
                                                      shape:
                                                          const RoundedRectangleBorder(),
                                                    ),
                                                  ),
                                                  baseColor:
                                                      const Color.fromARGB(
                                                          255, 225, 225, 225),
                                                  highlightColor:
                                                      Colors.white)),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Shimmer.fromColors(
                                                    child: Container(
                                                      height: 20,
                                                      width: 70,
                                                      decoration:
                                                          ShapeDecoration(
                                                        color:
                                                            Colors.grey[400]!,
                                                        shape:
                                                            const RoundedRectangleBorder(),
                                                      ),
                                                    ),
                                                    baseColor:
                                                        const Color.fromARGB(
                                                            255, 225, 225, 225),
                                                    highlightColor:
                                                        Colors.white),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Tooltip(
                                                  message: "",
                                                  child: Shimmer.fromColors(
                                                      child: Container(
                                                        height: 18,
                                                        width: 120,
                                                        decoration:
                                                            ShapeDecoration(
                                                          color:
                                                              Colors.grey[400]!,
                                                          shape:
                                                              const RoundedRectangleBorder(),
                                                        ),
                                                      ),
                                                      baseColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              225,
                                                              225,
                                                              225),
                                                      highlightColor:
                                                          Colors.white),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Shimmer.fromColors(
                                                    child: Container(
                                                      height: 18,
                                                      width: 100,
                                                      decoration:
                                                          ShapeDecoration(
                                                        color:
                                                            Colors.grey[400]!,
                                                        shape:
                                                            const RoundedRectangleBorder(),
                                                      ),
                                                    ),
                                                    baseColor:
                                                        const Color.fromARGB(
                                                            255, 225, 225, 225),
                                                    highlightColor:
                                                        Colors.white),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: 10,
                          );
                        }),
                  );
                }

                return const CircularProgressIndicator();
              })
        ],
      ),
    );
  }

  Widget listItem(
          BuildContext context, ContentProductList item, String token) =>
      GestureDetector(
          onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProductDetail(
                              userToken: token,
                              productID: item.productId,
                            )))
              },
          child: Container(
            margin: const EdgeInsets.all(5.0),
            height: 300,
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
                          item.imageUrl.toString(),
                          height: constraints.maxHeight * .6,
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
                              item.productName.toString().length <= 12
                                  ? item.productName.toString()
                                  : item.productName!.substring(0, 12) + "...",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: "QuicksandBold",
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Tooltip(
                              message: "Real price ${item.price} VND",
                              child: Text(
                                "${item.price} VND",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                            Text(
                              item.promotionValue.toString() == "null"
                                  ? "Giảm giá: Khong"
                                  : "Giảm giá: " +
                                      item.promotionValue.toString(),
                              style: Theme.of(context).textTheme.headline4,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  /*
                  Positioned(
                    right: 10,
                    top: constraints.maxHeight * .58 - 10,
                    child: CircleAvatar(
                      radius: 20,
                      foregroundColor:
                          Theme.of(context).colorScheme.onSecondary,
                      backgroundColor: Theme.of(context).colorScheme.onSurface,
                      child: Text(item.quantity.toString()),
                    ),
                  )*/
                ],
              ),
            ),
          ));
}
