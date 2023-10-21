import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/databaseHelper.dart';
import 'package:travel_app/pages/details_page.dart';
import 'package:travel_app/widget/reuseable_text.dart';

class OffersPage extends StatelessWidget {
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10.0);

  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    
    Future<List<Offer>> getOffers() async {
      return await DatabaseHelper.instance.getAllOffers();
    }

    return FutureBuilder<List<Offer>>(
      future: getOffers(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData)
        {
          List<Offer> offers = snapshot.data!;
          
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: _buildAppBar(size),
              body: SizedBox(
                width: size.width,
                height: size.height,
                child: Padding(
                  padding: padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        text: "Offers",
                        size: 35,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: offers.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: FadeInUp(
                                delay: Duration(milliseconds: 150 * index + 150),
                                child: HorizontalOfferTab(offer: offers[index])
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: _buildAppBar(size),
            body: SizedBox(
              width: size.width,
              height: size.height,
              child: Padding(
                padding: padding,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "Offers",
                      size: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    Center(
                      child: Text("Loading..."),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

  }

  PreferredSize _buildAppBar(Size size) {
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


class HorizontalOfferTab extends StatelessWidget {
  final Offer offer;
  const HorizontalOfferTab({ required this.offer, Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      // onTap: () => Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => DetailsPage(
      //       personData: null,
      //       tabData: current,
      //       isCameFromPersonSection: false,
      //     ),
      //   ),
      // ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Hero(
            tag: offer.offer_id,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              width: size.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage("assets/places/${offer.offer_destination}.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: size.height * 0.2,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              width: size.width * 0.53,
              height: size.height * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(153, 0, 0, 0),
                    Color.fromARGB(118, 29, 29, 29),
                    Color.fromARGB(54, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.07,
            bottom: size.height * 0.045,
            child: AppText(
              text: offer.offer_url,
              size: 15,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          Positioned(
            left: size.width * 0.07,
            bottom: size.height * 0.025,
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 15,
                ),
                SizedBox(
                  width: size.width * 0.01,
                ),
                AppText(
                  text: offer.offer_destination,
                  size: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
