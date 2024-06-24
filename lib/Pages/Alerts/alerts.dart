import 'package:eazz_admin/Pages/Alerts/widgets/appbar.dart';
import 'package:flutter/material.dart';

class Alerts extends StatelessWidget {
  const Alerts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const AlertsAppbar(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red)),
                      onPressed: null,
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '!0 Alerts',
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
                  ),
                  Container(
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.amber)),
                        onPressed: null,
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '15 Alerts',
                                style: TextStyle(
                                    fontFamily: 'Roboto-Condensed',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Container(
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green)),
                        onPressed: null,
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '10 Alerts',
                                style: TextStyle(
                                    fontFamily: 'Roboto-Condensed',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              )),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.only(left: 12.0, top: 16),
                child: const Row(
                  children: [
                    Text(
                      'Alerts Posted',
                      style: TextStyle(
                          fontFamily: 'Roboto-Condensed',
                          fontSize: 12,
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
                        onPressed: () {},
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
                                    'Reported by: Me',
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
                                width: 120,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white)),
                                  onPressed: null,
                                  child: const Center(
                                    child: Row(
                                      children: [
                                        Icon(Icons.warning_amber,
                                            color: Colors.red),
                                        SizedBox(width: 5),
                                        Text(
                                          'Critical',
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
