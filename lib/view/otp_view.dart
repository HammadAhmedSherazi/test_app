import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_app/utils/extension.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../export_all.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  int _secondsRemaining = 60; // 1-minute timer
  Timer? _timer;
  late final TextEditingController? controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get formattedTime {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  bool isComplete = false;

  @override
  Widget build(BuildContext context) {
    return AuthScreenTemplateWidget(
      bottomWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Please check your inbox and insert the code below to sign in.",
            style: context.textStyle.titleSmall!.copyWith(
              color: Color.fromRGBO(15, 19, 36, 0.6),
            ),
          ),
          10.ph,
          PinCodeTextField(
            backgroundColor: Colors.transparent,
            controller: controller,
            appContext: context,
            length: 6, // Number of OTP boxes
            obscureText: false,
            keyboardType: TextInputType.number,
            animationType: AnimationType.fade,
            hintCharacter: "-",
            pinTheme: PinTheme(
              fieldOuterPadding: EdgeInsets.zero,
              errorBorderColor: Colors.red,

              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10), // Rounded edges
              fieldHeight: 35.w,
              fieldWidth: 35.w,
              activeColor: Colors.blue, // Border color when active
              inactiveColor: Colors.grey.shade300, // Border color when inactive
              selectedColor: Colors.blueAccent, // Border color when selected
            ),
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: false,
            onCompleted: (v) {
              isComplete = true;
              setState(() {});
            },
            onChanged: (value) {
              if (controller!.text.length < 6) {
                isComplete = false;
                setState(() {});
              }
            },
          ),

          // Timer Text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Time left",
                style: context.textStyle.titleSmall!.copyWith(
                  color: Color.fromRGBO(15, 19, 36, 0.6),
                ),
              ),
              // rgba(45, 156, 219, 1)
              const SizedBox(width: 5),
              Text(
                formattedTime, // Add Timer Logic
                style: context.textStyle.labelSmall!.copyWith(
                  color: Color.fromRGBO(45, 156, 219, 1),
                ),
              ),
            ],
          ),
          10.ph,

          // Login Button
          CustomButtonWidget(isDisable: !isComplete, onTap: () {}),
        ],
      ),

      topWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Just one more step",
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
                  "We’ve sent a code to your email",
                  style: context.textStyle.titleMedium!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "john.smith@albusayra.",
            style: context.textStyle.displayMedium!.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
