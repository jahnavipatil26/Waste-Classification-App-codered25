import 'package:deep_waste/components/category_card.dart';
import 'package:deep_waste/database_manager.dart';
import 'package:deep_waste/models/Category.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder<List<Category>>(
            future: DatabaseManager.instance.getCategories(),
            builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text("Loading"));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No Categories found'));
              }
              // Safely map the data and handle null values
              return Row(
                children: snapshot.data!
                    .map((category) => CategoryCard(category: category))
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
