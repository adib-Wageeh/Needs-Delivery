import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:needs_delivery/core/common/widgets/i_field.dart';
import 'package:needs_delivery/features/authentication/presentation/cubits/register/register_cubit.dart';
import 'package:needs_delivery/generated/l10n.dart';
import 'package:provider/provider.dart';


class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<RegisterCubit>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          IField(
            controller: auth.firstNameController,
            hintText: S.of(context).register_first_name_hint,
            prefixIcon: const Icon(Icons.person_2_outlined),
          ),
          const SizedBox(
            height: 8,
          ),
          IField(
            controller: auth.lastNameController,
            hintText: S.of(context).register_last_name_hint,
            prefixIcon: const Icon(Icons.person_2_outlined),
          ),
          const SizedBox(
            height: 8,
          ),
          IField(
            controller: auth.emailController,
            hintText: S.of(context).register_email_hint,
            prefixIcon: const Icon(Icons.email),
          ),
          const SizedBox(
            height: 8,
          ),
          IField(
            controller: auth.phoneController,
            keyboardType: TextInputType.phone,
            hintText: S.of(context).login_phone_number_hint,
            prefixIcon: const Icon(Icons.phone),
          ),
          const SizedBox(
            height: 8,
          ),
          IField(
            controller: auth.passwordController,
            hintText: S.of(context).register_password_hint,
            prefixIcon: const Icon(Icons.key),
            enableSuggestions: false,
            autoCorrect: false,
            obscureText: true,
            overrideValidator: true,
            validator: (text){
              if (text == null || text.isEmpty) {
                return S.of(context).empty_password_text_field_error;
              }else if(text.trim().length <6){
                return S.of(context).password_length_error;
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          IField(
            controller: auth.confirmPasswordController,
            hintText:
            S.of(context).register_confirm_password_hint,
            prefixIcon: const Icon(Icons.key),
            obscureText: true,
            enableSuggestions: false,
            autoCorrect: false,
            overrideValidator: true,
            validator: (text){
              if(text != auth.passwordController.text.trim()){
                return S.of(context).password_confirm_error_hint;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
