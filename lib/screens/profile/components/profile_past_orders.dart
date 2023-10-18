
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:intl/intl.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/models/order_item_model.dart';

class PastOrders extends StatelessWidget {
  final String addressName;
  final String addressLine;
  final String price;
  final List<OrderItemModel> orderItems;
  final String orderDate;
  const PastOrders({super.key, required this.addressName, required this.addressLine, required this.price, required this.orderItems, required this.orderDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 20),
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(addressName,style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),),
              Spacer(),
              Text("Delivered",style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),),
              SizedBox(width: 8,),
              Icon(Icons.check_circle,size: 15,color: Colors.green,)
            ],
          ),
          SizedBox(height: 5,),
          Text(addressLine,style: TextStyle(
            color: PKTheme.greyColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),),
          SizedBox(height: 8,),
          Text("\u{20B9} $price",style: TextStyle(
            color: PKTheme.greyColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),),
          SizedBox(height: 10,),
          Dash(
            direction: Axis.horizontal,
            length: MediaQuery.of(context).size.width * 0.9,
            dashColor: PKTheme.greyColor,
            dashLength: 1.5,
          ),
          SizedBox(height: 10,),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: orderItems.length,
            itemBuilder: (context, index) {
              return Text("Chicken Steam Momos (1)",style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: PKTheme.greyColor,
              ),);
            },
          ),
          SizedBox(height: 5,),
          Text(DateFormat("MMMM dd, hh:mm aa").format(DateTime.parse(orderDate)),style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: PKTheme.greyColor,
          ),),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(onPressed: (){

                }, child: Text("REORDER"),style: PKTheme.hollowButtonWithBorder.copyWith(
                    foregroundColor: MaterialStatePropertyAll(PKTheme.blackColor),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        side: BorderSide(color: PKTheme.blackColor)
                    ))
                ),),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: ElevatedButton(onPressed: (){

                }, child: Text("RATE ORDER"),style: PKTheme.hollowButtonWithBorder.copyWith(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        side: BorderSide(
                            color: PKTheme.primaryColor
                        )
                    ))
                ),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
