import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:needs_delivery/core/common/app/providers/locale.dart';
import 'package:needs_delivery/core/common/app/providers/user_provider.dart';
import 'package:needs_delivery/core/res/colours.dart';
import 'package:needs_delivery/core/utils/core_utils.dart';
import 'package:needs_delivery/features/authentication/data/models/user_model.dart';
import 'package:needs_delivery/features/authentication/domain/entites/user_entity.dart';
import 'package:needs_delivery/features/profile/presentation/cubits/update/update_cubit.dart';
import 'package:needs_delivery/features/profile/presentation/providers/edit_profile_provider.dart';
import 'package:needs_delivery/features/profile/presentation/widgets/edit_profile_form.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileProvider>(
      builder: (BuildContext context, EditProfileProvider provider,_) {
        return BlocConsumer<UpdateCubit,UpdateState>(
          builder: (context,state){
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  foregroundColor: Colors.white,
                  backgroundColor: Colours.primaryColor,
                  centerTitle: true,
                  title: Text(
                    S.of(context).profile_my_profile,
                  ),
                  elevation: 0,
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: TextButton(onPressed: (){
                        if(provider.nothingChanged){
                          Navigator.pop(context);
                        }else{
                          UserEntity user = provider.getUpdatedUser();
                          final lang = context.read<LocaleProvider>().getLocale!.languageCode;
                          BlocProvider.of<UpdateCubit>(context).update(user,lang);
                        }
                      },
                          child:
                          (state is UpdateLoading)?
                          const Center(child: CircularProgressIndicator.adaptive(),):
                          AutoSizeText(
                          minFontSize: 14,
                          maxFontSize: 24
                          ,S.of(context).number_verification_confirm,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color:
                                (provider.nothingChanged)?Colors.grey:
                                Colors.green
                            ),
                          )
                      ),
                    ),
                  ],
                )
                ,body:
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10),
              shrinkWrap: true,
              children: [
                EditProfileForm(
                  nameController: provider.getNameController,
                  lastNameController: provider.getLastNameController,
                  phoneController: provider.getPhoneController,
                  emailController: provider.getEmailController,
                  locationController: provider.getLocationController,
                  addressController: provider.getAddressController,
                ),
                BlocBuilder<UpdateCubit, UpdateState>(
                  builder: (context, state) {
                    if(state is! AuthLocationLoading) {
                      return IconButton(onPressed: () async {
                        final network = await InternetConnectionChecker()
                            .connectionStatus;
                        if (network == InternetConnectionStatus.disconnected) {
                          if (context.mounted) {
                            CoreUtils.showSnackBar(
                                context, 'no internet connection');
                          }
                        } else {
                          if (context.mounted) {
                            BlocProvider.of<UpdateCubit>(context, listen: false)
                                .requestLocation();
                          }
                        }
                      },
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent
                          ,
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.location_on,
                                  color: Colours.secondaryColor),
                              SizedBox(width: 4.w,),
                              Text(S.of(context).update_location),
                            ],
                          ));
                    }else{
                      return const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircularProgressIndicator.adaptive(),
                        ],
                      );
                    }
                  },
                ),
              ],
            )
            );

          }, listener: (context,state){
          if(state is UpdateError){
            CoreUtils.showSnackBar(context
              , state.error.message!,);
          }if(state is AuthLocationGathered){
            provider.updateLocation(state.placemark,state.position.latitude.toString()
                ,state.position.longitude.toString());
            CoreUtils.showSnackBar(context
              , 'location has been updated please confirm',);
          }
          if(state is UserUpdated){
            Provider.of<UserProvider>(context,listen: false).initUser(state.userEntity as UserModel);
            Navigator.pop(context);
            CoreUtils.showSnackBar(context
              , 'Data has been updated successfully',);
          }
        },);
      },
    );
  }
}
