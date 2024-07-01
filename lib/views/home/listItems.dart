import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartekdish/commons/commonServices.dart';
import 'package:zartekdish/controllers/itemController.dart';

class ListItems extends StatefulWidget {
  const ListItems({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  _ListItemsState createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  final itemService = Get.put(ItemService());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.only(top: 10),
        width: Get.width,
        child: ListView.builder(
            itemCount: itemService.itemData.value![0]
                .tableMenuList![widget.index].categoryDishes!.length,
            itemBuilder: (BuildContext context, int index) {
              final data = itemService.itemData.value[0]
                  .tableMenuList![widget.index].categoryDishes![index];
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: Get.width,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(top: 5, right: 5),
                              padding: const EdgeInsets.all(3),
                              height: 20,
                              decoration: BoxDecoration(
                                  border: Border.all(color: CusColors.greendark,)),
                              child:  CircleAvatar(
                                radius: 5,
                                backgroundColor: CusColors.greendark,
                              )),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.dishName ?? "",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'INR, ${data.dishPrice}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      "${data.dishCalories} Calories",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    data.dishDescription ?? "",
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: 45,
                                  width: 160,
                                  decoration: BoxDecoration(
                                      color: CusColors.greendark,
                                      borderRadius: BorderRadius.circular(35)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            itemService.removeCart(data);
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 30,
                                          )),
                                      Text(
                                        '${data.count}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            itemService.addCart(data);
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 30,
                                          ))
                                    ],
                                  ),
                                ),
                                if (data.addonCat!.isNotEmpty)
                                  const Text(
                                    "Custamization Available",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18),
                                  )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            height: 100,
                            width: 80,
                            child: Image.network(
                              data.dishImage!,
                              fit: BoxFit.fill,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 0,
                    color: Colors.grey,
                  )
                ],
              );
            }),
      ),
    );
  }
}
