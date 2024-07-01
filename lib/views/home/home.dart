import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartekdish/commons/commonServices.dart';
import 'package:zartekdish/controllers/itemController.dart';
import 'package:zartekdish/models/itemModel.dart';
import 'package:zartekdish/views/authentications/authenticate.dart';
import 'package:zartekdish/views/cart/orderSummary.dart';
import 'package:zartekdish/views/home/listItems.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? name;
  String? id;

  List<ItemModel>? item;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ItemService itemService = Get.put(ItemService());

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                //await call_logout();

                SESSION.removeAll();
                Get.offAll(Authenticate());
                // Close the dialog
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    init_call();
    super.initState();
  }

  init_call() async {
    await itemService.fetchApi();
    String userName = await SESSION.getStringvalue("user");
    String userId = await SESSION.getStringvalue("uid");
    setState(() {
      name = userName;
      id = userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: const Icon(
            Icons.menu,
            size: 35,
          ),
        ),
        actions: [
          Obx(
            () => GestureDetector(
              onTap: () {
                Get.to(const OrderSummary());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Stack(
                  children: <Widget>[
                    const Icon(
                      Icons.shopping_cart,
                      // color: Colors.grey,
                      size: 35,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${itemService.cartTotalItems.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          Container(
            height: 250,
            decoration:  BoxDecoration(
                gradient: LinearGradient(
                  colors: [CusColors.greendark, CusColors.greenlight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                color: Colors.green,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      name ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "ID: ${id ?? ""}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              _scaffoldKey.currentState?.closeDrawer();
              showLogoutDialog(context);
            },
            child: const ListTile(
              leading: Icon(
                Icons.logout,
                size: 30,
                color: Colors.black54,
              ),
              title: Text(
                "Logout",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      )),
      body: Container(
          height: Get.height,
          width: Get.width,
          child: Obx(() {
            if (itemService.Loading.value) {
              return loader();
            } else if (itemService.Error.value) {
              return error();
            } else {
              final item = itemService.itemData.value[0];
              return DefaultTabController(
                length: item.tableMenuList!.length, // Number of tabs
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Colors.red,
                      labelColor: Colors.red,
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      tabs: [
                        for (var i = 0; i < item.tableMenuList!.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              item.tableMenuList![i].menuCategory! ?? "",
                              style: const TextStyle(
                                  // color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        for (var i = 0; i < item.tableMenuList!.length; i++)
                          ListItems(index: i),
                      ]),
                    )
                  ],
                ),
              );
            }
          })),
    );
  }
}
