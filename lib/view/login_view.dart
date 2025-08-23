import 'package:test_app/utils/extension.dart';
import 'package:test_app/utils/router.dart';

import '../export_all.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenTemplateWidget(
      bottomWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            
            text: TextSpan(
              style: context.textStyle.bodyMedium,
            children: [
              TextSpan( text: "Employee ID "),
              TextSpan(text: "*", style: context.textStyle.bodyMedium!.copyWith(
                color: Colors.red
              ))
            ]
          )),
          const SizedBox(height: 8),
          TextFormField(
            style: context.textStyle.bodyMedium,
            controller: textEditingController,
            key: formKey,
            onChanged: (v) {
              setState(() {});
            },
   
            decoration: InputDecoration(
              
              contentPadding: EdgeInsets.symmetric(
                vertical: 5.r,
                horizontal: 15.r,
              ),
              filled: true,
              fillColor: Colors.transparent,

              hintText: "etc. ABDS-12345",

              hintStyle: context.textStyle.bodyMedium!.copyWith(
                color: Color.fromRGBO(10, 15, 41, 0.25),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Login Button
          CustomButtonWidget(
            isDisable: textEditingController.text == "",
            onTap: () {
              AppRouter.push(OtpView());
            },
          ),
        ],
      ),

      topWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Login your account",
            style: context.textStyle.displayMedium!.copyWith(
              fontSize: 20.sp,
              color: Colors.white,
            ),
          ),
          10.ph,
          Row(
            children: [
              Expanded(
                child: Text(
                  "Please use your employee id provided by your organization to log in.",
                  style: context.textStyle.titleMedium!.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomButtonWidget extends StatelessWidget {
  final bool isDisable;
  final VoidCallback onTap;
  const CustomButtonWidget({
    super.key,
    required this.isDisable,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          backgroundColor:
              isDisable
                  ? Color.fromRGBO(209, 213, 230, 1)
                  : const Color(0xFF02243F),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        onPressed: isDisable ? null : onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: context.textStyle.labelMedium!.copyWith(
                color:
                    isDisable ? Color.fromRGBO(10, 15, 41, 0.25) : Colors.white,
              ),
            ),
            5.pw,
            Icon(
              Icons.exit_to_app,
              size: 20.r,
              color:
                  isDisable ? Color.fromRGBO(10, 15, 41, 0.25) : Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
