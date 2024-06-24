import 'package:eazz_admin/Caches/receipt_cache.dart';
import 'package:eazz_admin/Classes/Receipt/receipt_class.dart';
import 'package:eazz_admin/Pages/BottomNav/bottom_navigation.dart';
import 'package:eazz_admin/Pages/Homepage/Classes/button_class.dart';
import 'package:eazz_admin/Pages/Homepage/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

// import 'package:eazz_admin/Service/Receipt/receipt_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  late int selectedMonth;
  late String month;
  late String prevMonth;
  late List<String> reorderedMonths;
  final ScrollController scrollController = ScrollController();
  int numberOfReceipts = 0;
  int numberOfPrevMonthReceipts = 0;
  int difference = 0;

  @override
  void initState() {
    super.initState();

    reorderedMonths = [
      ...months.sublist(currentMonthIndex),
      ...months.sublist(0, currentMonthIndex)
    ];

    selectedMonth = reorderedMonths.length - 1;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(
        selectedMonth * 100.0,
      );
    });

    Provider.of<ReceiptCache>(context, listen: false).fetchData();
    month = monthNumberToText(DateTime.now().month);
    prevMonth = getPreviousMonth(month);
  }

  String monthNumberToText(int monthNumber) {
    const Map<int, String> monthTextMap = {
      1: 'January',
      2: 'February',
      3: 'March',
      4: 'April',
      5: 'May',
      6: 'June',
      7: 'July',
      8: 'August',
      9: 'September',
      10: 'October',
      11: 'November',
      12: 'December',
    };
    return monthTextMap[monthNumber] ?? 'Unknown';
  }

  String getPreviousMonth(String currentMonth) {
    const List<String> months = [
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

    int currentIndex = months.indexOf(currentMonth);
    int prevIndex = (currentIndex - 1 + months.length) % months.length;
    return months[prevIndex];
  }

  checkReceiptByMonth(String selectedMonth, String prevMonth) {
    List<ReceiptJsonClass> receipts =
        Provider.of<ReceiptCache>(context, listen: false).receipts;
    List<ReceiptJsonClass> filteredReceipts = receipts.where((receipt) {
      DateTime receiptDate = DateTime.parse(receipt.publishDate);
      return receiptDate.year == DateTime.now().year &&
          monthNumberToText(receiptDate.month) == selectedMonth;
    }).toList();
    List<ReceiptJsonClass> filteredPrevReceipts = receipts.where((receipt) {
      DateTime receiptDate = DateTime.parse(receipt.publishDate);
      return receiptDate.year == DateTime.now().year &&
          monthNumberToText(receiptDate.month) == prevMonth;
    }).toList();
    setState(() {
      numberOfReceipts = filteredReceipts.isEmpty ? 0 : filteredReceipts.length;
      numberOfPrevMonthReceipts =
          filteredPrevReceipts.isEmpty ? 0 : filteredPrevReceipts.length;
      difference = numberOfReceipts - numberOfPrevMonthReceipts;
    });

    return;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: const BottomeNavigationBarWidget(),
      body: CustomScrollView(
        slivers: [
          const Appbar2(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: size.height * 0.27,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(child: Consumer<ReceiptCache>(
                        builder: (context, cache, child) {
                          if (cache.receipts.isEmpty) {
                            return const Text(
                              '0',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Condensed',
                                  fontSize: 50,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            );
                          }
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            checkReceiptByMonth(month, prevMonth);
                          });
                          return Text(
                            '$numberOfReceipts',
                            style: const TextStyle(
                                fontFamily: 'Roboto-Condensed',
                                fontSize: 50,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          );
                        },
                      )),
                      const SizedBox(
                          child: Text(
                        "Receipt(s)",
                        style: TextStyle(
                            fontFamily: 'Roboto-Condensed',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey),
                      )),
                      SizedBox(
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
                                    color: selectedMonth == index
                                        ? Colors.blue
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedMonth = index;
                                        month = reorderedMonths[index];
                                        prevMonth = getPreviousMonth(month);
                                      });
                                    },
                                    child: Text(
                                      reorderedMonths[index].toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: 'Roboto-Condensed',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: selectedMonth == index
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: Colors.white,
                              height: 50,
                              width: 170,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25))),
                                      child: const Icon(
                                        Icons.receipt_outlined,
                                        size: 15,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Receipts($prevMonth)",
                                          style: const TextStyle(
                                              fontFamily: 'Roboto-Condensed',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromARGB(
                                                  255, 128, 128, 128)),
                                        ),
                                        Text(
                                          "$numberOfPrevMonthReceipts",
                                          style: const TextStyle(
                                              fontFamily: 'Roboto-Condensed',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                            Container(
                              color: Colors.white,
                              height: 50,
                              width: 150,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          color: difference.isNegative
                                              ? Colors.red
                                              : Colors.green,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(25))),
                                      child: Icon(
                                        difference.isNegative
                                            ? Icons.arrow_downward
                                            : Icons.arrow_upward,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          difference.isNegative
                                              ? "Decrease by"
                                              : "Increase by",
                                          style: const TextStyle(
                                              fontFamily: 'Roboto-Condensed',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromARGB(
                                                  255, 128, 128, 128)),
                                        ),
                                        Text(
                                          "${difference.abs()}",
                                          style: const TextStyle(
                                              fontFamily: 'Roboto-Condensed',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(left: 12.0),
              height: 20.0,
              child: const Text(
                'Operations',
                style: TextStyle(
                    fontFamily: 'Roboto-Condensed',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3, // 2 columns
                children: List.generate(6, (index) {
                  final ButtonItem item = buttons[index];
                  List<String> words = item.name.split(" ");
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: item.navigationWidget,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.5),
                      child: Container(
                        width: double.infinity, // Match the width of the parent
                        height:
                            double.infinity, // Match the height of the parent
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color
                          borderRadius: BorderRadius.circular(
                              8.0), // BorderRadius to make it look like ElevatedButton
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.2), // BoxShadow color
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              item.icon,
                              const SizedBox(height: 15),
                              Text(
                                words[0],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Roboto-Condensed',
                                ),
                              ),
                              Text(
                                words[1],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Roboto-Condensed',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(left: 12.0),
              height: 20.0,
              child: const Text(
                'Recent Transactions',
                style: TextStyle(
                    fontFamily: 'Roboto-Condensed',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
