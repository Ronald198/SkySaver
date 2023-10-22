import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:travel_app/widget/reuseable_text.dart';

class CouponsQrPage extends StatelessWidget {
  final String couponCode;

  const CouponsQrPage({super.key, required this.couponCode});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(size),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const AppText(
                  text: "Coupon Code",
                  size: 35,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 35,top: 60),
              child: Text("Scan to get benefits", style: TextStyle(fontSize: 22),),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 55),
              child: QrImageView(
                data: couponCode,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSize buildAppBar(Size size) {
    return PreferredSize(
      preferredSize: Size.fromHeight(size.height * 0.05),
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}