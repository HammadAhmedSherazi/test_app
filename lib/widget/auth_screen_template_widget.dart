import 'package:test_app/export_all.dart';
import 'package:test_app/utils/extension.dart';

class AuthScreenTemplateWidget extends StatelessWidget {
  final Widget topWidget;
  final Widget bottomWidget;
  const AuthScreenTemplateWidget({super.key, required this.topWidget, required this.bottomWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.scaffoldBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Form(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.logo, width: 235.r, height: 42.r),
                50.ph,
                LoginBox(
                  topWidget: topWidget,  bottomWidget: bottomWidget
                   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginBox extends StatelessWidget {
  final Widget topWidget;
  final Widget bottomWidget;
  const LoginBox({
    super.key,
    required this.topWidget,
    required this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        gradient: AppColors.secondaryGradient,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Section (Gradient Header)
          ClipPath(
            clipper: CurvedBottomClipper(),
            child: Container(
              padding: EdgeInsets.only(
                left: 30.r,
                right: 30.r,
                top: 30.r,
                bottom: 80.r,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF02243F), Color(0xFF1F4F74)],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: topWidget,
            ),
          ),

          // Bottom Section (Form)
          Padding(
            padding: EdgeInsets.only(left: 30.r, right: 30.r, bottom: 20.r),
            child: bottomWidget,
          ),
        ],
      ),
    );
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40); // Start from left-bottom
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 40,
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0); // Top-right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
