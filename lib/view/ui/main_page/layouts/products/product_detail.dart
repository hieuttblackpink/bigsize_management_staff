// ignore_for_file: no_logic_in_create_state, avoid_print

import 'package:bigsize_management_staff/blocs/product_bloc.dart';
import 'package:bigsize_management_staff/models/product/product_colour.dart';
import 'package:bigsize_management_staff/models/product/product_detail.dart';
import 'package:bigsize_management_staff/models/product/product_quantity_store.dart';
import 'package:bigsize_management_staff/models/product/product_size.dart';
import 'package:bigsize_management_staff/view/resources/styles_manager.dart';
import 'package:bigsize_management_staff/view/ui/main_page/layouts/products/product_detail_quantity.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetail extends StatefulWidget {
  final String userToken;
  final int? productID;
  const ProductDetail(
      {Key? key, required this.userToken, required this.productID})
      : super(key: key);

  @override
  _ProductDetail createState() => _ProductDetail(userToken, productID);
}

class _ProductDetail extends State<ProductDetail> {
  final String userToken;
  final int? productID;
  final ProductBloc _productBloc = ProductBloc();
  int activePage = 1;

  _ProductDetail(this.userToken, this.productID);

  Future<Content?> getProductDetail(String token, int id) async {
    return await _productBloc
        .getProductDetail(token, id)
        .then((value) => value.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text("Sản phẩm #" + productID.toString()),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FutureBuilder<Content?>(
                  future: getProductDetail(userToken, productID!),
                  builder: (context, detail) {
                    if (detail.hasData) {
                      return Column(
                        children: <Widget>[
                          Container(
                            height: 350,
                            padding: const EdgeInsets.only(bottom: 5),
                            width: double.infinity,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 300,
                                  child: PageView.builder(
                                      itemCount: detail.data!.images!.length,
                                      pageSnapping: true,
                                      controller: PageController(
                                          viewportFraction: 0.8,
                                          initialPage: 1),
                                      onPageChanged: (page) {
                                        setState(() {
                                          activePage = page;
                                        });
                                      },
                                      itemBuilder: (context, pagePosition) {
                                        bool active =
                                            pagePosition == activePage;
                                        return slider(detail.data!.images!,
                                            pagePosition, active);
                                        /*
                                    return imageAnimation(
                                        PageController(
                                            viewportFraction: 0.8,
                                            initialPage: 1),
                                        detail.data!.images!,
                                        pagePosition);*/
                                      }),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: indicators(
                                        detail.data!.images!.length,
                                        activePage))
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 0, right: 14, left: 14),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          detail.data!.brand
                                              .toString(), //Ten nha cung ung
                                          style: const TextStyle(
                                            fontFamily: "QuicksandLight",
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              height: 120,
                                              width: 200,
                                              child: Text(
                                                detail.data!.productName
                                                    .toString(),
                                                maxLines: 2,
                                                softWrap: true,
                                                style: const TextStyle(
                                                  fontFamily: "QuicksandBold",
                                                  fontSize: 35,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              detail.data!.price.toString() +
                                                  " đ",
                                              style: const TextStyle(
                                                fontFamily: "QuicksandMedium",
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          "Mô tả:",
                                          style: TextStyle(
                                            fontFamily: "QuicksandMedium",
                                            fontSize: 17,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          detail.data!.description
                                              .toString(), //description
                                          softWrap: true,
                                          style: const TextStyle(
                                            fontFamily: "QuicksandLights",
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          "So luong san pham trong kho",
                                          style: TextStyle(),
                                        ),
                                        const SizedBox(height: 10),
                                        ProductDetailQuantity(
                                            userToken: userToken,
                                            productID: productID),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    width: 50,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      //color: ,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }

                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 1),
                      child: loadingProduct(),
                    );
                  }),
            ],
          ),
          /*
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.kGreyColor),
              ),
              child: Icon(
                Ionicons.heart_outline,
                size: 30,
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: () {
                  productController.addToCart();
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Obx(
                    () => productController.isAddLoading.value
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : Text(
                            '+ Add to Cart',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),*/
        ));
  }

  Widget loadingProduct() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 225, 225, 225),
            highlightColor: Colors.white,
            child: Container(
              alignment: Alignment.center,
              height: 350,
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 0,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 10, right: 14, left: 14),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 225, 225, 225),
                          highlightColor: Colors.white,
                          child: Container(
                            height: 20,
                            padding: const EdgeInsets.only(bottom: 5),
                            width: 50,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Shimmer.fromColors(
                              baseColor:
                                  const Color.fromARGB(255, 225, 225, 225),
                              highlightColor: Colors.white,
                              child: Container(
                                height: 120,
                                padding: const EdgeInsets.only(bottom: 5),
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Shimmer.fromColors(
                              baseColor:
                                  const Color.fromARGB(255, 225, 225, 225),
                              highlightColor: Colors.white,
                              child: Container(
                                height: 70,
                                padding: const EdgeInsets.only(bottom: 5),
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 225, 225, 225),
                          highlightColor: Colors.white,
                          child: Container(
                            height: 20,
                            padding: const EdgeInsets.only(bottom: 5),
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 225, 225, 225),
                          highlightColor: Colors.white,
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.only(bottom: 5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 225, 225, 225),
                          highlightColor: Colors.white,
                          child: Container(
                            height: 20,
                            padding: const EdgeInsets.only(bottom: 5),
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.only(right: 6),
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                //color: ,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      //color: ,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

AnimatedContainer slider(List<Images> images, pagePosition, active) {
  double margin = active ? 10 : 20;

  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
    margin: EdgeInsets.all(margin),
    decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(images[pagePosition].imageUrl.toString()))),
  );
}

imageAnimation(PageController animation, List<Images> images, pagePosition) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, widget) {
      print(pagePosition);

      return SizedBox(
        width: 200,
        height: 200,
        child: widget,
      );
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      child: Image.network(images[pagePosition].imageUrl.toString()),
    ),
  );
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle),
    );
  });
}
