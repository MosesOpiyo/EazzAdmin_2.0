import 'package:eazz_admin/Classes/Receipt/receipt_class.dart';
import 'package:eazz_admin/Pages/NewReceipt/Widgets/appbar.dart';
import 'package:eazz_admin/Pages/NewReceipt/Widgets/billing_appbar.dart';
import 'package:eazz_admin/Service/Receipt/receipt_service.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class NewReceipt extends StatefulWidget {
  const NewReceipt({super.key});

  @override
  State<NewReceipt> createState() => _NewReceiptState();
}

class _NewReceiptState extends State<NewReceipt> {
  bool isScanning = true;
  final GlobalKey _globalKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;
  ReceiptJsonClass? newReceipt;
  int counter = 0;
  bool success = false;

  toggleOption() {
    setState(() {
      isScanning = !isScanning;
    });
  }

  void killCam(QRViewController controller) {
    controller.stopCamera();
  }

  void qrView(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      counter++;
      if (counter == 1) {
        controller.stopCamera();
        if (newReceipt == null) {
          ReceiptService().newReceipt().then((response) {
            setState(() {
              newReceipt = response;
              result = scanData;
              addItemToReceipt(newReceipt?.receiptNumber, result?.code);
              if (success == true) {
                setState(() {
                  counter = 0;
                  controller.resumeCamera();
                });
              }
            });
          });
        } else {
          setState(() {
            result = scanData;
            addItemToReceipt(newReceipt?.receiptNumber, result?.code);
            if (success == true) {
              setState(() {
                counter = 0;
                controller.resumeCamera();
              });
            }
          });
        }
      }
    });
  }

  addItemToReceipt(receiptNumber, itemNumber) {
    ReceiptService().newReceiptItem(receiptNumber, itemNumber).then((value) {
      setState(() {
        success = true;
        final snackBar = SnackBar(
          content: Text('New Item ${result?.code} added'),
          action: SnackBarAction(
            label: 'Continue',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            const ReceiptAppBar(),
            SizedBox(
              height: size.height * .02,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    isScanning
                        ? const Text(
                            'Scan Item',
                            style: TextStyle(
                                fontFamily: 'Roboto-Condensed',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          )
                        : const Text(
                            'Scan Buyer Code',
                            style: TextStyle(
                                fontFamily: 'Roboto-Condensed',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                    isScanning
                        ? const Text(
                            'Items will be added to the receipt once scanned.',
                            style: TextStyle(
                                fontFamily: 'Roboto-Condensed',
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          )
                        : const Text(
                            'Buyer Code required for payment prompt',
                            style: TextStyle(
                                fontFamily: 'Roboto-Condensed',
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * .02),
              height: size.height * .7,
              child: QRCodeScanner(
                  isScanning: isScanning,
                  globalkey: _globalKey,
                  controller: controller,
                  result: result),
            ),
            const Spacer(),
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 228, 228, 228),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              width: size.width * 0.8,
              height: 40.0,
              padding: const EdgeInsets.all(4.0),
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  SizedBox(
                    width: isScanning ? size.width * 0.4 : size.width * 0.4,
                    child: isScanning
                        ? FloatingActionButton.extended(
                            onPressed: () {
                              setState(() {
                                if (isScanning != true) {
                                  toggleOption();
                                }
                              });
                            },
                            backgroundColor: Colors.white,
                            label: const Text(
                              'ITEMS TO RECEIPT',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Condensed',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          )
                        : TextButton(
                            onPressed: () {
                              if (isScanning != true) {
                                toggleOption();
                              }
                            },
                            child: const Text(
                              'ITEMS TO RECEIPT',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Condensed',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            )),
                  ),
                  const Spacer(),
                  SizedBox(
                      width: isScanning ? size.width * 0.35 : size.width * 0.35,
                      child: isScanning
                          ? TextButton(
                              onPressed: () {
                                if (isScanning == true) {
                                  toggleOption();
                                }
                              },
                              child: const Text(
                                'SCANNING COMPLETE',
                                style: TextStyle(
                                    fontFamily: 'Roboto-Condensed',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ))
                          : FloatingActionButton.extended(
                              onPressed: () {
                                if (isScanning == true) {
                                  toggleOption();
                                }
                              },
                              backgroundColor: Colors.white,
                              label: const Text(
                                'SCANNING COMPLETE',
                                style: TextStyle(
                                    fontFamily: 'Roboto-Condensed',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            )),
                ],
              ),
            ),
          ],
        ));
    // : Column(
    //     children: [
    //       const BillingAppbar(),
    //       SizedBox(
    //         child: Padding(
    //           padding: const EdgeInsets.only(top: 8.0, left: 16),
    //           child: Align(
    //             alignment: Alignment.centerLeft,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 const Text(
    //                   'Receipt Processing',
    //                   style: TextStyle(
    //                       fontFamily: 'Roboto-Condensed',
    //                       fontSize: 22,
    //                       fontWeight: FontWeight.bold,
    //                       color: Colors.black),
    //                 ),
    //                 Text(
    //                   'Current Date: ${currentDate.day}-${currentDate.month}-${currentDate.year}, $formattedTime',
    //                   style: const TextStyle(
    //                       fontFamily: 'Roboto-Condensed',
    //                       fontSize: 14,
    //                       fontWeight: FontWeight.normal,
    //                       color: Colors.grey),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //       Container(
    //         margin: const EdgeInsets.all(16),
    //         padding: const EdgeInsets.all(8),
    //         child: Column(
    //           children: [
    //             const SizedBox(
    //               height: 40,
    //               child: Align(
    //                 alignment: Alignment.center,
    //                 child: Text(
    //                   'Naivas',
    //                   style: TextStyle(
    //                       fontFamily: 'Roboto-Condensed',
    //                       fontSize: 22,
    //                       fontWeight: FontWeight.bold,
    //                       color: Colors.black),
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               child: Align(
    //                   alignment: Alignment.center,
    //                   child: Container(
    //                     color: Colors.black,
    //                     width: 200,
    //                     height: 200,
    //                   )),
    //             ),
    //             const SizedBox(
    //               height: 50,
    //             ),
    //             const Row(
    //               children: [
    //                 Text(
    //                   'Net Total:',
    //                   style: TextStyle(
    //                       fontFamily: 'Roboto-Condensed',
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.w700,
    //                       color: Colors.black),
    //                 ),
    //                 Spacer(),
    //                 Text(
    //                   'Ksh 10,000.00',
    //                   style: TextStyle(
    //                       fontFamily: 'Roboto-Condensed',
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.w700,
    //                       color: Colors.black),
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(
    //               height: 30,
    //             ),
    //             const Row(
    //               children: [
    //                 Text(
    //                   'Tax Amount:',
    //                   style: TextStyle(
    //                       fontFamily: 'Roboto-Condensed',
    //                       fontSize: 15,
    //                       fontWeight: FontWeight.w700,
    //                       color: Colors.black),
    //                 ),
    //                 Spacer(),
    //                 Text(
    //                   'Ksh 587.00',
    //                   style: TextStyle(
    //                       fontFamily: 'Roboto-Condensed',
    //                       fontSize: 15,
    //                       fontWeight: FontWeight.w700,
    //                       color: Colors.black),
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(
    //               height: 10,
    //             ),
    //             const Row(
    //               children: [
    //                 Text(
    //                   'Item Count:',
    //                   style: TextStyle(
    //                       fontFamily: 'Roboto-Condensed',
    //                       fontSize: 15,
    //                       fontWeight: FontWeight.w700,
    //                       color: Colors.black),
    //                 ),
    //                 Spacer(),
    //                 Text(
    //                   '25 Items',
    //                   style: TextStyle(
    //                       fontFamily: 'Roboto-Condensed',
    //                       fontSize: 15,
    //                       fontWeight: FontWeight.w700,
    //                       color: Colors.black),
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(
    //               height: 10,
    //             ),
    //             const Row(
    //               children: [
    //                 Text(
    //                   'Total Saving:',
    //                   style: TextStyle(
    //                       fontFamily: 'Roboto-Condensed',
    //                       fontSize: 15,
    //                       fontWeight: FontWeight.w700,
    //                       color: Colors.black),
    //                 ),
    //                 Spacer(),
    //                 Text(
    //                   'Ksh 190.00',
    //                   style: TextStyle(
    //                       fontFamily: 'Roboto-Condensed',
    //                       fontSize: 15,
    //                       fontWeight: FontWeight.w700,
    //                       color: Colors.black),
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(
    //               height: 30,
    //             ),
    //             const Row(
    //               children: [
    //                 Text(
    //                   'Cashier:',
    //                   style: TextStyle(
    //                       fontFamily: 'Roboto-Condensed',
    //                       fontSize: 15,
    //                       fontWeight: FontWeight.w700,
    //                       color: Colors.black),
    //                 ),
    //                 Spacer(),
    //                 Text(
    //                   'Kevin Njoroge',
    //                   style: TextStyle(
    //                       fontFamily: 'Roboto-Condensed',
    //                       fontSize: 15,
    //                       fontWeight: FontWeight.w700,
    //                       color: Colors.black),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //       const Spacer(),
    //       Container(
    //         decoration: const BoxDecoration(
    //             color: Color.fromARGB(255, 228, 228, 228),
    //             borderRadius: BorderRadius.all(Radius.circular(20))),
    //         width: size.width * 0.8,
    //         height: 40.0,
    //         padding: const EdgeInsets.all(4.0),
    //         margin: const EdgeInsets.only(bottom: 10.0),
    //         child: Row(
    //           children: [
    //             SizedBox(
    //               width:
    //                   isScanning ? size.width * 0.4 : size.width * 0.4,
    //               child: isScanning
    //                   ? FloatingActionButton.extended(
    //                       onPressed: () {
    //                         setState(() {
    //                           if (isScanning != true) {
    //                             toggleOption();
    //                           }
    //                         });
    //                       },
    //                       backgroundColor: Colors.white,
    //                       label: const Text(
    //                         'ITEMS TO RECEIPT',
    //                         style: TextStyle(
    //                             fontFamily: 'Roboto-Condensed',
    //                             fontSize: 10,
    //                             fontWeight: FontWeight.w700,
    //                             color: Colors.black),
    //                       ),
    //                     )
    //                   : TextButton(
    //                       onPressed: () {
    //                         if (isScanning != true) {
    //                           toggleOption();
    //                         }
    //                       },
    //                       child: const Text(
    //                         'ITEMS TO RECEIPT',
    //                         style: TextStyle(
    //                             fontFamily: 'Roboto-Condensed',
    //                             fontSize: 10,
    //                             fontWeight: FontWeight.w700,
    //                             color: Colors.black),
    //                       )),
    //             ),
    //             const Spacer(),
    //             SizedBox(
    //                 width: isScanning
    //                     ? size.width * 0.35
    //                     : size.width * 0.35,
    //                 child: isScanning
    //                     ? TextButton(
    //                         onPressed: () {
    //                           if (isScanning == true) {
    //                             toggleOption();
    //                           }
    //                         },
    //                         child: const Text(
    //                           'SCANNING COMPLETE',
    //                           style: TextStyle(
    //                               fontFamily: 'Roboto-Condensed',
    //                               fontSize: 10,
    //                               fontWeight: FontWeight.w700,
    //                               color: Colors.black),
    //                         ))
    //                     : FloatingActionButton.extended(
    //                         onPressed: () {
    //                           if (isScanning == true) {
    //                             toggleOption();
    //                           }
    //                         },
    //                         backgroundColor: Colors.white,
    //                         label: const Text(
    //                           'SCANNING COMPLETE',
    //                           style: TextStyle(
    //                               fontFamily: 'Roboto-Condensed',
    //                               fontSize: 10,
    //                               fontWeight: FontWeight.w700,
    //                               color: Colors.black),
    //                         ),
    //                       )),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ));
  }
}

class QRCodeScanner extends StatelessWidget {
  final bool isScanning;
  final GlobalKey globalkey;
  final QRViewController? controller;
  final Barcode? result;
  const QRCodeScanner(
      {required this.isScanning,
      required this.globalkey,
      required this.controller,
      required this.result,
      super.key});

  @override
  Widget build(BuildContext context) {
    void qrCode(QRViewController controller) {
      controller.scannedDataStream.listen((scanData) async {
        if (isScanning == true) {
          // Scanning for products
        } else {
          // Scanning for buyer details
        }
      });
    }

    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;

    return Column(
      children: [
        Expanded(
            flex: 1,
            child: QRView(
              key: globalkey,
              onQRViewCreated: qrCode,
              overlay: QrScannerOverlayShape(
                  borderColor: Colors.deepOrange,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: scanArea),
            ))
      ],
    );
  }
}

class Billing extends StatelessWidget {
  final Function callback;
  final bool isScanning;
  const Billing({required this.callback, required this.isScanning, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        const BillingAppbar(),
        const Spacer(),
        SliverToBoxAdapter(
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 228, 228, 228),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            width: size.width * 0.8,
            height: 40.0,
            padding: const EdgeInsets.all(4.0),
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: [
                SizedBox(
                  width: isScanning ? size.width * 0.4 : size.width * 0.4,
                  child: isScanning
                      ? FloatingActionButton.extended(
                          onPressed: () {
                            if (isScanning != true) {
                              callback;
                            }
                          },
                          backgroundColor: Colors.white,
                          label: const Text(
                            'ITEMS TO RECEIPT',
                            style: TextStyle(
                                fontFamily: 'Roboto-Condensed',
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            if (isScanning != true) {
                              callback;
                            }
                          },
                          child: const Text(
                            'ITEMS TO RECEIPT',
                            style: TextStyle(
                                fontFamily: 'Roboto-Condensed',
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          )),
                ),
                const Spacer(),
                SizedBox(
                    width: isScanning ? size.width * 0.35 : size.width * 0.35,
                    child: isScanning
                        ? TextButton(
                            onPressed: () {
                              if (isScanning == true) {
                                callback;
                              }
                            },
                            child: const Text(
                              'SCANNING COMPLETE',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Condensed',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ))
                        : FloatingActionButton.extended(
                            onPressed: () {
                              if (isScanning == true) {
                                callback;
                              }
                            },
                            backgroundColor: Colors.white,
                            label: const Text(
                              'SCANNING COMPLETE',
                              style: TextStyle(
                                  fontFamily: 'Roboto-Condensed',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          )),
              ],
            ),
          ),
        )
      ],
    );
  }
}
