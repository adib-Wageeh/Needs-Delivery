import 'package:flutter/material.dart';
import 'package:needs_delivery/core/extensions/context_extension.dart';
import 'package:needs_delivery/features/profile/presentation/widgets/profile_form_field.dart';
import 'package:needs_delivery/generated/l10n.dart';



class EditProfileForm extends StatelessWidget {
  const EditProfileForm({required this.lastNameController,
    required this.emailController, required this.nameController,
    required this.phoneController, required this.locationController,
    required this.addressController,super.key,});

  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController locationController;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileFormField(
          controller: nameController,
          icon: Icons.person_2,
          fieldTitle: S.of(context).register_first_name_hint,
          hintText: context.currentUser?.name,
        ),
        ProfileFormField(
          icon: Icons.person,
          controller: lastNameController,
          fieldTitle: S.of(context).register_last_name_hint,
          hintText: context.currentUser?.lastName,
        ),
        ProfileFormField(
          icon: Icons.email,
          controller: emailController,
          fieldTitle: S.of(context).register_email_hint,
          hintText: context.currentUser?.email,
        ),
        ProfileFormField(
          icon: Icons.phone_android,
          controller: phoneController,
          fieldTitle: S.of(context).login_phone_number_hint,
          hintText: context.currentUser?.mobile,
        ),
        ProfileFormField(
          icon: Icons.home,
          controller: addressController,
          fieldTitle: S.of(context).register_address_hint,
          hintText: context.currentUser?.address,
        ),
        ProfileFormField(
          icon: Icons.location_on,
          controller: locationController,
          fieldTitle: S.of(context).register_location_hint,
          hintText: context.currentUser?.location,
          readOnly: true,
        ),
      ],
    );
  }
}
