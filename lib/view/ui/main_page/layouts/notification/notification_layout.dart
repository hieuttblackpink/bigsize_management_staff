import 'package:bigsize_management_staff/blocs/notification_bloc.dart';
import 'package:bigsize_management_staff/models/notification/notification.dart';
import 'package:bigsize_management_staff/services/storage_service.dart';
import 'package:bigsize_management_staff/view/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class NotificationLayout extends StatefulWidget {
  const NotificationLayout({Key? key}) : super(key: key);

  @override
  _NotificationLayout createState() => _NotificationLayout();
}

class _NotificationLayout extends State<NotificationLayout> {
  final StorageService _storageService = StorageService();
  final NotificationBloc _notificationBloc = NotificationBloc();
  NotificationModel? notification;
  //TextEditingController searchController = TextEditingController();
  //String _searchText = "";
  final ScrollController _controller = ScrollController();
  String tokenUser = "";

  int page = 1;
  bool isFirstLoad = true;
  bool isLoadMoreRunning = false;
  bool hasNextPage = false;
  //bool isSearching = false;
  bool hasToken = false;

  Future<String?> getUserToken() async {
    return await _storageService.readSecureData("UserToken");
  }

  Future<NotificationModel> getNotification(String token, int page) async {
    NotificationModel notify =
        await _notificationBloc.getNotification(token, page);
    if (mounted && isFirstLoad && !hasToken) {
      setState(() {
        notification = notify;
        isFirstLoad = false;
        hasNextPage = notify.hasNext!;
        tokenUser = token;
        hasToken = true;
        //_controller.addListener(_loadMore);
        print(hasNextPage.toString());
        print(notify.content!.toList());
      });
    }
    return notify;
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_loadMore);
  }

  void _loadMore() async {
    //print("Loadmore " + _controller.position.extentAfter.toString());
    if (hasNextPage == true &&
        isFirstLoad == false &&
        isLoadMoreRunning == false &&
        hasToken == true &&
        //isSearching == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      page += 1; // Increase _page by 1
      try {
        NotificationModel getMoreNotify =
            await getNotification(tokenUser, page);

        if (getMoreNotify.content!.isNotEmpty) {
          setState(() {
            notification!.content!.addAll(getMoreNotify.content!.toList());
            hasNextPage = getMoreNotify.hasNext!;
            print(notification!.content!.length);
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
        title: const Text("Thông báo"),
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: <Widget>[
            FutureBuilder<String?>(
                future: getUserToken(),
                builder: (context, token) {
                  if (token.hasData) {
                    getNotification(token.data.toString(), page);
                    return Column(
                      children: <Widget>[
                        /*
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
                                  await getNotification(_searchText, 1);
                              setState(() {
                                notification = search;
                                page = 1;
                                isSearching = false;
                                hasNextPage = search.hasNext!;
                              });
                            },
                          ),
                        ),*/
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          //controller: _controller,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: notification == null
                              ? 0
                              : notification!.content!.length,
                          itemBuilder: (context, index) {
                            if (notification != null &&
                                notification!.content!.isNotEmpty &&
                                !isFirstLoad) {
                              return GestureDetector(
                                  onTap: () => {
                                        /*
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ProductDetail(
                                                      userToken:
                                                          token.data.toString(),
                                                      productID: notification!
                                                          .content![index]
                                                          .productId,
                                                    )))
                                                    */
                                      },
                                  child: Card(
                                      shadowColor: Colors.grey,
                                      child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Column(children: [
                                            Row(children: <Widget>[
                                              /*
                                              Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Image.network(
                                                    notification!
                                                        .content![index]
                                                        .imageUrl
                                                        .toString(),
                                                    width: 100,
                                                    height: 100,
                                                  )),*/
                                              const SizedBox(width: 10),
                                              Expanded(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                    Text(
                                                        notification!
                                                            .content![index]
                                                            .title
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontFamily:
                                                                "QuicksandBold",
                                                            color:
                                                                Colors.black)),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                        '${notification!.content![index].message}',
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                "QuicksandMedium",
                                                            color:
                                                                Colors.black)),
                                                    const SizedBox(height: 3),
                                                    Text(
                                                        '${notification!.content![index].createDate}',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors
                                                                .black54)),
                                                  ])),
                                            ]),
                                            const SizedBox(height: 8),
                                          ]))));
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
