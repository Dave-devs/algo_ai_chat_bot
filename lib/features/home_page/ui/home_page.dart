import 'package:algo_ai_chat_bot/common/pallete/pallete.dart';
import 'package:algo_ai_chat_bot/features/chat_page/ui/chat_page.dart';
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
        leading: Icon(
          Icons.menu,
          color: Pallete.greyBG,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings_outlined,
                color: Pallete.greyBG,
              ))
        ],
      ),
      body: ListView(
        children: [
          //Top Leading Texts
          const LeadingTexts(),

          //Three Boxes
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                //Biggest Container
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  decoration: BoxDecoration(
                      color: Pallete.purpleTile,
                      borderRadius: BorderRadius.circular(16.w)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //Top Min Text
                      Text(
                        'Voice helper',
                        style: GoogleFonts.roboto(fontSize: 8.sp),
                      ),

                      SizedBox(
                        height: 10.h,
                      ),

                      //Top Mic Icon
                      Container(
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                            color: Pallete.purpleIcon, shape: BoxShape.circle),
                        child: Icon(
                          Icons.mic_outlined,
                          color: Pallete.whiteText,
                          size: 15,
                        ),
                      ),

                      SizedBox(
                        height: 40.h,
                      ),

                      //Middle White Text
                      Padding(
                        padding: EdgeInsets.only(right: 40.w),
                        child: SizedBox(
                          width: 100.w,
                          child: Text(
                            "Let's find new things using speech.",
                            softWrap: true,
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w600,
                                color: Pallete.whiteText),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20.h,
                      ),

                      //Bottom Search Button
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ChatPage())
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          decoration: BoxDecoration(
                              color: Pallete.whiteText,
                              borderRadius: BorderRadius.circular(20.w)),
                          child: Text(
                            'Search Prompt',
                            style: GoogleFonts.roboto(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Pallete.blackText),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(
                  width: 10.w,
                ),

                Column(
                  children: [
                    //First Child Container
                    const DoubleContainer(
                        text: 'Start New Chat', icon: Icons.mic_outlined),

                    SizedBox(
                      height: 5.h,
                    ),

                    //Second Child Container
                    const DoubleContainer(
                        text: 'Search by Images', icon: Icons.photo_outlined),
                  ],
                )
              ],
            ),
          ),

          SizedBox(
            height: 40.h,
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Text(
              'Recently Search',
              textAlign: TextAlign.left,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500, color: Pallete.greyText),
            ),
          ),

          SizedBox(height: 30.h),

          //Recently Search
          const RecentlySearchTile(
              text:
                  'Look for 5 potential headlines for websites with fintech themes.'),

          const RecentlySearchTile(
              text: 'Find the python code to create a 10 fold branch.'),

          const RecentlySearchTile(
              text:
                  '5 copywriting for the benefits and features section on the Saas webite.'),

          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}
