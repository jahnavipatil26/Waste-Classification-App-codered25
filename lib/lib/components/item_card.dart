import 'package:deep_waste/constants/app_properties.dart';
import 'package:deep_waste/constants/size_config.dart';
import 'package:deep_waste/models/Item.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    // Map of sustainable practices for each item name
    final Map<String, String> sustainablePractices = {
      "Plastic": "Recycle at a designated recycling center or reuse for storage.",
      "Paper": "Use both sides of paper and recycle once used.",
      "Metal": "Rinse and recycle to reduce waste.",
      "E-Waste": "Dispose of at certified e-waste collection centers.",
      "Glass": "Clean and reuse or recycle at a local glass recycling facility.",
      "Organic Waste": "Compost at home to create natural fertilizer.",
      "Clothes": "Donate or repurpose old clothes instead of discarding.",
      "Batteries": "Dispose of at hazardous waste collection points.",
      "Light Bulbs": "Recycle at a nearby electronics recycling facility.",
      "Cardboard": "Flatten boxes and recycle them at your local recycling center. Avoid contamination with food or liquids.",
      "Trash": "Dispose of non-recyclable items responsibly. Reduce waste by opting for reusable alternatives and segregating recyclable materials.",
    };


    // Get sustainable practice for the item
    final String sustainablePractice =
        sustainablePractices[item.name] ?? "Practice sustainability by reducing, reusing, and recycling.";

    return Row(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(90),
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(item.imageURL),
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: TextStyle(
                  color: kSecondaryColor,
                  fontSize: getProportionateScreenWidth(14),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Text(
                "Sustainable Practice:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(12),
                  color: kSecondaryColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                sustainablePractice,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(12),
                  color: kSecondaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
