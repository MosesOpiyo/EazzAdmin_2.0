import 'package:eazz_admin/ShelfDuty/Widgets/appbar.dart';
import 'package:eazz_admin/ShelfDuty/scan_to_shelf.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ShelfDuty extends StatefulWidget {
  const ShelfDuty({super.key});

  @override
  State<ShelfDuty> createState() => _ShelfDutyState();
}

class _ShelfDutyState extends State<ShelfDuty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const ShelfDutyAppbar(),
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.only(left: 12.0),
                height: 30.0,
                child: const Row(
                  children: [
                    Text(
                      'Inventory',
                      style: TextStyle(
                          fontFamily: 'Roboto-Condensed',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ],
                )),
          ),
          SliverList.builder(
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 67,
                    child: FloatingActionButton.extended(
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.bottomToTop,
                              child: const ScanToShelf(),
                            ),
                          );
                        },
                        label: Container(
                          width: 300,
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Item Name',
                                    style: TextStyle(
                                        fontFamily: 'Roboto-Condensed',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Category: Kitchen',
                                    style: TextStyle(
                                        fontFamily: 'Roboto-Condensed',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 110,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white)),
                                  onPressed: null,
                                  child: const Row(
                                    children: [
                                      Icon(Icons.inventory_2_outlined,
                                          color: Colors.blue),
                                      SizedBox(width: 5),
                                      Text(
                                        '1,200',
                                        style: TextStyle(
                                            fontFamily: 'Roboto-Condensed',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ));
              // Handle tap on the list item
            },
          )
        ],
      ),
    );
  }
}
