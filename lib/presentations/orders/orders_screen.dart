import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/active_widget.dart';
import 'widgets/delivered_widget.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  foregroundColor: Colors.black,
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const CircleAvatar(
                        radius: 5,
                        backgroundImage: AssetImage('assets/images/prev.jpg')),
                  ),
                  title: Text(
                    "My Orders",
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                          letterSpacing: .5,
                          fontSize: 26,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  bottom: const TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          'Active',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Delivered',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.black,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 3.0,
                      ),
                      insets: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
                body: const TabBarView(
                  children: <Widget>[
                    ActiveWidget(),
                    DeliveredWidget(),
                  ],
                ))),
      ),
    );
  }
}
