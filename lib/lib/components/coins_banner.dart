import 'package:flutter/material.dart';
import 'package:deep_waste/constants/size_config.dart';
import 'package:deep_waste/models/Item.dart';
import 'package:url_launcher/url_launcher.dart';

class CoinsBanner extends StatelessWidget {
  final List<Item> items;

  const CoinsBanner({
    Key? key,
    required this.items,
  }) : super(key: key);

  Future<void> _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    int currentCoins =
    items.fold(0, (sum, item) => (item.count * item.points) + sum);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: getProportionateScreenWidth(20)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenWidth(15),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(3, 3), // Changes position of shadow
          ),
          BoxShadow(
            color: Colors.black,
            offset: const Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "PLAY !!!\n",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(16),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getProportionateScreenWidth(10)),
                    Text(
                      "How well do you know your waste? Play the game to find out!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(14),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Image.asset(
                  'assets/images/coins.png',
                  height: 100,
                  width: 350,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenWidth(20)),
          ElevatedButton(
            onPressed: () {
              _launchURL('instagram://ar?ch=ZDU3YjEzZjE5YzU3ODBjZGM5Y2IxMmRmMGM0OWFjODk%3D'); // Replace with your URL
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent, // Set background color here
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(10),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Go to Website",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: Colors.white, // Text color in white
              ),
            ),
          ),
        ],
      ),
    );
  }
}
