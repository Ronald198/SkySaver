import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/constants.dart';
import 'package:travel_app/databaseHelper.dart';
import 'package:travel_app/nav_pages.dart/couponSubPage/coupons_qr_page.dart';

class HorizontalCoupon extends StatelessWidget {
  final Coupon coupon;

  const HorizontalCoupon({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color.fromARGB(255, 196, 194, 243);
    const Color secondaryColor = SkySaverPalette.mainColor;
    
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => 
            CouponsQrPage(couponCode: coupon.coupon_code,),
          )
        );
      },
      child: Ink(
        child: CouponCard(
          height: 150,
          backgroundColor: primaryColor,
          curveAxis: Axis.vertical,
          firstChild: Container(
            decoration: const BoxDecoration(
              color: secondaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${coupon.coupon_discount}%",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'OFF',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: Colors.white54, height: 0),
                const Expanded(
                  child: Center(
                    child: Text(
                      'SkyClub',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          secondChild: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Coupon Code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                SelectableText(
                  coupon.coupon_code,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  'Valid Till - ${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(coupon.coupon_expirationDate * 1000).subtract(const Duration(days: 1)))}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}