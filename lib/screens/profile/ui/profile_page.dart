import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:pk_customer_app/constants/theme.dart';

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
              itemCount: 2,
              itemBuilder: (context, index) {
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
                          Text("Work Kitchen",style: TextStyle(
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
                      Text("Kharghar",style: TextStyle(
                        color: PKTheme.greyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text("\u{20B9}97",style: TextStyle(
                            color: PKTheme.greyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),),
                          SizedBox(width: 5,),
                          Icon(Icons.arrow_forward_ios_rounded,size: 15,color: PKTheme.greyColor,)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Dash(
                        direction: Axis.horizontal,
                        length: MediaQuery.of(context).size.width * 0.9,
                        dashColor: PKTheme.greyColor,
                        dashLength: 1.5,
                      ),
                      SizedBox(height: 10,),
                      Text("Chicken Steam Momos (1)",style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: PKTheme.greyColor,
                      ),),
                      SizedBox(height: 5,),
                      Text("September 6, 2:58 AM",style: TextStyle(
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
              },
            ),
          )
        ],
      ),
    );
  }
}
