import 'package:eazz_admin/ShelfDuty/Widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanToShelf extends StatefulWidget {
  const ScanToShelf({super.key});

  @override
  State<ScanToShelf> createState() => _ScanToShelfState();
}

class _ScanToShelfState extends State<ScanToShelf> {
  final GlobalKey _globalKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            const ShelfScanAppbar(),
            SizedBox(
              height: size.height * .02,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.zero,
                child: const Column(
                  children: [
                    Text(
                      'Scan Item',
                      style: TextStyle(
                          fontFamily: 'Roboto-Condensed',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    Text(
                      'Items will be added to the shelves once scanned.',
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
                  globalkey: _globalKey,
                  controller: controller,
                  result: result),
            ),
          ],
        ));
  }
}

class QRCodeScanner extends StatelessWidget {
  final GlobalKey globalkey;
  final QRViewController? controller;
  final Barcode? result;
  const QRCodeScanner(
      {required this.globalkey,
      required this.controller,
      required this.result,
      super.key});

  @override
  Widget build(BuildContext context) {
    void qrCode(QRViewController controller) {
      controller.scannedDataStream.listen((scanData) async {});
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
