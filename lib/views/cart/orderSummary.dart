import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartekdish/commons/commonServices.dart';
import 'package:zartekdish/controllers/itemController.dart';
import 'package:zartekdish/views/home/listItems.dart';
import 'package:zartekdish/views/widgets/success_dialog.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({Key? key}) : super(key: key);

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  ItemService itemService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        bottomOpacity: 0,
        shadowColor: Colors.grey,
        leading: IconButton(
          onPressed: () {
            Get.back();
            setState(() {});
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black45,
            size: 35,
          ),
        ),
        title: const Text(
          "Order Summary",
          style: TextStyle(
              color: Colors.black45, fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Obx(
              () => Card(
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: CusColors.greendeepdark,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "${itemService.cartTotalItems.length} Dishes - ${itemService.dishItemCounts.value} Items",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        itemService.cartDishes.value.isEmpty 
                            ? nodata()
                            : Container(
                                height: Get.height - 200,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        itemService.cartDishes.value.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final item =
                                          itemService.cartDishes.value[index];
                                      return Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            width: Get.width,
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 5, right: 5),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3),
                                                      height: 20,
                                                      // width: 20,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .green)),
                                                      child: const CircleAvatar(
                                                        radius: 5,
                                                        backgroundColor:
                                                            Colors.green,
                                                      )),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Flex(
                                                          direction:
                                                              Axis.horizontal,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                item.dishName ?? "",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        22),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          5),
                                                              height: 40,
                                                              width: 140,
                                                              decoration: BoxDecoration(
                                                                  color: CusColors.greendeepdark,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              35)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        itemService
                                                                            .removeCart(item);
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            25,
                                                                      )),
                                                                  Text(
                                                                    "${item.count}",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            22,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        itemService
                                                                            .addCart(item);
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            25,
                                                                      ))
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                  "INR ${item.count * item.dishPrice}",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ),
                                                            ),
                                                            //  Text("15 Calories",
                                                            // style: TextStyle(
                                                            //   color: Colors.black,
                                                            //   fontWeight: FontWeight.w500,
                                                            //   fontSize: 18
                                                            // ),
                                                            // )
                                                          ],
                                                        ),
                                                        Text(
                                                          "INR ${item.dishPrice}",
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 18),
                                                        ),
                                                        Text(
                                                          "${item.dishCalories} calaroies",
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 18),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Divider(
                                            height: 20,
                                            color: Colors.grey,
                                          ),
                                          if (index ==
                                              itemService.cartDishes.length - 1)
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        "Total Amount",
                                                        style: TextStyle(
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(
                                                        "INR ${itemService.getTotal()}",
                                                        style: const TextStyle(
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.green),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 100,
                                                )
                                              ],
                                            ),
                                        ],
                                      );
                                    }),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: itemService.cartDishes.isEmpty
          ? Container()
          : GestureDetector(
              onTap: () {
                // itemservice.place_orders();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const OrderSuccessDialog(
                        message:
                            "Order successfully placed."); // Your custom dialog widget
                  },
                );
              },
              child: Container(
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(
                    color: CusColors.greendeepdark,
                    borderRadius: BorderRadius.circular(35)),
                child: const Text(
                  "Place Order",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
    );
  }
}
