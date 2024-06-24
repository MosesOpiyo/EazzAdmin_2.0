import 'package:eazz_admin/Pages/GeneratedReceipts/Widgets/appbar.dart';
import 'package:flutter/material.dart';

class ReceiptStatistics extends StatefulWidget {
  const ReceiptStatistics({super.key});

  @override
  State<ReceiptStatistics> createState() => _ReceiptStatisticsState();
}

class _ReceiptStatisticsState extends State<ReceiptStatistics> {
  @override
  Widget build(BuildContext context) {
    final List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    int currentMonthIndex = DateTime.now().month;
    int startIndex = currentMonthIndex - 6;
    if (startIndex < 0) {
      startIndex += 12;
    }
    List<String> reorderedMonths = [
      ...months.sublist(currentMonthIndex),
      ...months.sublist(0, currentMonthIndex)
    ];
    String currentMonth = reorderedMonths.last;

    final ScrollController scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const GeneratedReceiptsAppbar(),
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  height: 40, // Fixed height for the ListView
                  child: Center(
                    child: ListView.builder(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: 12,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 70.0, // Adjust the width as needed
                          margin: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: currentMonth == reorderedMonths[index]
                                  ? Colors.deepOrange
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              reorderedMonths[index].toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'Roboto-Condensed',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: currentMonth == reorderedMonths[index]
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.only(top: 15, left: 10, bottom: 10),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Total Receipts: 300',
                    style: TextStyle(
                        fontFamily: 'Roboto-Condensed',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: ListView.builder(
              itemCount: 20,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: const Center(
                                child: Icon(Icons.receipt_outlined,
                                    color: Colors.white)),
                          ),
                          const SizedBox(width: 10),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Text1",
                                style: TextStyle(
                                    fontFamily: 'Roboto-Condensed',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                              Text(
                                "Text2",
                                style: TextStyle(
                                    fontFamily: 'Roboto-Condensed',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                          const Spacer(),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "-KSH. 10.00",
                                style: TextStyle(
                                    fontFamily: 'Roboto-Condensed',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                              Text(
                                "28 Feb, 02:34PM",
                                style: TextStyle(
                                    fontFamily: 'Roboto-Condensed',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
                // Handle tap on the list item
              },
            ),
          )
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.month, this.sales);
  final String month;
  final double sales;
}
