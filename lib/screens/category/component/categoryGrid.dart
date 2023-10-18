import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/models/category_model.dart';

class CategoryGridItemWidget extends StatefulWidget {
  final List<CategoryModel> category;
  final String heroTag;
  const CategoryGridItemWidget({super.key, required this.category, required this.heroTag});

  @override
  State<CategoryGridItemWidget> createState() => _CategoryGridItemWidgetState();
}

class _CategoryGridItemWidgetState extends State<CategoryGridItemWidget> {
  @override
  Widget build(BuildContext context) {
    List<String> subdetails= ['Authentic','Healthy','Protein Rich'];
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: PKTheme.greyColor.withOpacity(0.2),
      onTap: () {
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
          ],
          border: Border.all(color: Colors.black.withOpacity(0.05)),
        ),
        child: Wrap(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                child: Image.network("https://q9q9m2j8.rocketcdn.me/wp-content/uploads/2023/05/D1BE40D1-1BFE-4715-B443-320B4F9314EB.png")),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Panjeeri ladoo',
                    style: TextStyle(
                      color: PKTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // SizedBox(height: 5,),
                  // Text(
                  //   '400 gm',
                  //   style: TextStyle(
                  //     color: PKTheme.blackColor,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                 if(subdetails.isNotEmpty)
                    Divider(height: 25, thickness: 0.5),
                  if(subdetails.isNotEmpty)
                  Wrap(
                    spacing: 5,
                    children: List.generate(3,
                        (index) {
                      return GestureDetector(
                        onTap: () {
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          child: Text(subdetails[index],
                              style: TextStyle(fontSize: 10)),
                          decoration: BoxDecoration(
                              color: PKTheme.primaryColor.withOpacity(0.2),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      );
                    }),
                    runSpacing: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
