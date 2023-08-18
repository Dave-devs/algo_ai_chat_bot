import 'package:algo_ai_chat_bot/common/pallete/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatureTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color color;
  const FeatureTile({super.key, required this.title, required this.subTitle, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.w,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.w)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Pallete.blackText
            ),
          ),

          SizedBox(height: 10.h,),

          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Text(
              subTitle,
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Pallete.blackText
              ),
            ),
          )
        ],
      ),
    );
  }
}
