import 'package:algo_ai_chat_bot/common/pallete/pallete.dart';
import 'package:algo_ai_chat_bot/features/home_page/widgets/double_container.dart';
import 'package:algo_ai_chat_bot/features/home_page/widgets/leading_texts.dart';
import 'package:algo_ai_chat_bot/features/home_page/widgets/recently_searched_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Icon(Icons.menu, color: Pallete.greyBG,),
        actions: [Icon(Icons.settings_outlined, color: Pallete.greyBG,)],
      ),
      body: ListView(
        children: [
          //Top Leading Texts
          const LeadingTexts(),

          SizedBox(height: 10.h,),

          //Three Boxes
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                //Biggest Container
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: Pallete.purpleTile,
                    borderRadius: BorderRadius.circular(6.w)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //Top Min Text
                      const Text('Voice helper'),

                      SizedBox(height: 20.h,),

                      //Top Mic Icon
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: Pallete.purpleIcon,
                          shape: BoxShape.circle
                        ),
                        child: Icon(Icons.mic_outlined, color: Pallete.whiteText,),
                      ),

                      SizedBox(height: 40.h,),

                      //Middle White Text
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          "Let's find new things using speech.",
                          style: GoogleFonts.roboto(fontWeight: FontWeight.w600, color: Pallete.whiteText),
                        ),
                      ),

                      SizedBox(height: 40.h,),

                      //Bottom Search Button
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: Pallete.whiteText,
                          borderRadius: BorderRadius.circular(20.w)
                        ),
                        child: Text(
                          'Search Prompt',
                          style: GoogleFonts.roboto(fontWeight: FontWeight.w500, color: Pallete.blackText),
                        ),
                      )
                    ],
                  ),
                ),

                Column(
                  children: [
                    //First Child Container
                    const DoubleContainer(
                      firstText: 'Start New',
                      secondText: 'Chat',
                      icon: Icons.mic_outlined
                    ),

                    SizedBox(height: 10.h,),

                    //Second Child Container
                    const DoubleContainer(
                      firstText: 'Search by',
                      secondText: 'Images',
                      icon: Icons.photo_outlined
                    ),
                  ],
                )
              ],
            ),
          ),

          SizedBox(height: 20.h,),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w,),
            child: Text(
              'Recently Search',
              textAlign: TextAlign.left,
              style: GoogleFonts.roboto(fontWeight: FontWeight.w500, color: Pallete.greyText),
            ),
          ),

          SizedBox(height: 20.h,),
        
          //Recently Search
          const RecentlySearchTile(text: 'Look for 5 potential headlines for websites with fintech themes.'),
          const RecentlySearchTile(text: 'Find the python code to create a 10 fold branch.'),
          const RecentlySearchTile(text: '5 copywriting for the benefits and features section on the Saas webite.'),

           SizedBox(height: 30.h,),
        ],
      ),
    );
  }
}