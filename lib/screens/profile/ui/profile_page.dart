import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/screens/profile/components/profile_past_orders.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PKTheme.bgColor,
      appBar: AppBar(
          title: const Text(
            'Your Profile',
            style: TextStyle(color: PKTheme.blackColor),
          ),
          elevation: 2,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back,color: PKTheme.blackColor,),
          ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(87.0), // Adjust the height as needed
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24,vertical: 20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("VINIT",style: TextStyle(
                          fontSize: 18,fontWeight: FontWeight.w700,
                        ),),
                        SizedBox(height:
                        8,),
                        Text("+91 - 8923851561.vishalmauray18@gmail.com",style: TextStyle(
                          fontSize: 12,fontWeight: FontWeight.w500,color: PKTheme.greyColor,
                        ),),
                      ],
                    ),
                    SizedBox(width: 8,),
                    TextButton(onPressed: (){

                    }, child: Text("EDIT",style: TextStyle(
                      fontSize: 14,fontWeight: FontWeight.w700,
                    ),)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Addresses",style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),),
                    SizedBox(width: 8,),
                    IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: (){

                    },icon: Icon(Icons.arrow_forward_ios_rounded,size: 20,))
                  ],
                ),
                SizedBox(height: 10,),
                Text("Share, Edit & Add New Addresses",style: TextStyle(
                  color: PKTheme.greyColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),)
              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text('PAST ORDERS',style: TextStyle(
              fontSize: 16,fontWeight: FontWeight.w700,
            ),),
          ),
          SizedBox(height: 8,),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return PastOrders(
                  addressLine: "kharghar",
                  addressName: "wor kitchen",
                  orderDate: DateTime.now().toString(),
                  orderItems: [],
                  price: "89",
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
