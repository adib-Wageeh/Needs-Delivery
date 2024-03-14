import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:needs_delivery/core/common/app/providers/user_provider.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:needs_delivery/core/res/media_res.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context,listen: false).user;
    return Container(
      height: 100,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: Colours.homeScreenGradiant
          ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: LayoutBuilder(
          builder: (context,constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: constraints.maxWidth*0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center
                    ,children: [
                      AutoSizeText(S.of(context).home_welcome,
                        minFontSize: 14,
                        maxLines: 1,
                        maxFontSize: 20,
                        style: TextStyle(
                          fontSize: 14.sp,
                            color: Colors.white
                        )
                      ),
                    AutoSizeText('${user!.name} ${user.lastName}',
                          minFontSize: 12,
                          maxFontSize: 20,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          wrapWords: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white
                          )
                      ),
                  ],
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight*0.6,
                  width: constraints.maxWidth*0.4,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.3),
                      BlendMode.srcATop,
                    ),
                    child: Image.asset(MediaRes.logoName,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                SizedBox(
                  width: constraints.maxWidth*0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if(user.image != null)
                      CircleAvatar(
                          radius: 24,
                          backgroundImage: CachedNetworkImageProvider(user.image!),
                        ),
                    ],
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}