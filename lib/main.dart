import 'package:flutter/material.dart';
import 'models/nada_form_data.dart';
import 'utils/nada_app_colors.dart';
import 'utils/nada_validators.dart';
import 'widgets/nada_custom_text_field.dart';
import 'widgets/nada_custom_button.dart';
import 'painters/nada_painter.dart';

void main() {
  runApp(const NadaApp());
}

class NadaApp extends StatefulWidget {
  const NadaApp({super.key});

  @override
  NadaAppState createState() => NadaAppState();
}

class NadaAppState extends State<NadaApp> with TickerProviderStateMixin {
  final _nadaFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nadaFormData = NadaFormData();
  bool nadaIsArabic = false;
  bool isDarkMode = false;

  late AnimationController _nadaButtonController;
  late Animation<double> _nadaButtonAnimation;
  late AnimationController _nadaLanguageController;
  late Animation<double> _nadaRotateAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize button animation
    _nadaButtonController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _nadaButtonAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(_nadaButtonController);

    // Initialize language animation
    _nadaLanguageController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _nadaRotateAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(_nadaLanguageController);
  }

  @override
  void dispose() {
    _nadaButtonController.dispose();
    _nadaLanguageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Builder(
        builder: (context) => Scaffold(
          key: _scaffoldKey,
          appBar: _nadaBuildAppBar(),
          backgroundColor: isDarkMode ? Colors.grey[900] : NadaAppColors.nadaWhite,
          body: _nadaBuildBody(),
        ),
      ),
    );
  }

  PreferredSizeWidget _nadaBuildAppBar() {
    return AppBar(
      title: Text(
        nadaIsArabic ? 'استمارة ندى' : 'Nada\'s Form',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: NadaAppColors.nadaWhite,
        ),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [NadaAppColors.nadaGradientStart, NadaAppColors.nadaGradientEnd],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
      elevation: 2,
      centerTitle: true,
      actions: [
        Row(
          children: [
            const Text('Dark Mode'),
            Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _nadaBuildBody() {
    return Stack(
      children: [
        CustomPaint(
          painter: NadaPainter(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        Directionality(
          textDirection: nadaIsArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                  vertical: 24,
                ),
                child: ClipPath(
                  clipper: CurveClipper(),
                  child: Card(
                    elevation: 2,
                    color: NadaAppColors.nadaPrimary.withOpacity(0.95),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [NadaAppColors.nadaGradientStart, NadaAppColors.nadaGradientEnd],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                        vertical: MediaQuery.of(context).size.height * 0.05,
                      ),
                      child: Form(
                        key: _nadaFormKey,
                        child: Column(
                          crossAxisAlignment: nadaIsArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: nadaIsArabic ? Alignment.centerRight : Alignment.centerLeft,
                                    child: _nadaBuildHeader(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: _nadaBuildLanguageToggle(),
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                            _nadaBuildFormFields(),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                            Center(
                              child: _nadaBuildSubmitButton(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _nadaBuildHeader() {
    return Column(
      crossAxisAlignment: nadaIsArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          nadaIsArabic ? 'المعلومات الشخصية' : 'Personal Information',
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w500,
            color: NadaAppColors.nadaWhite,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          nadaIsArabic ? 'يرجى ملء التفاصيل الخاصة بك أدناه' : 'Please fill in your details below',
          style: const TextStyle(
            fontSize: 15,
            color: NadaAppColors.nadaWhite,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _nadaBuildFormFields() {
    return Column(
      children: [
        NadaCustomTextField(
          nadaLabel: nadaIsArabic ? 'رقم الهوية' : 'ID Number',
          nadaHint: nadaIsArabic ? 'أدخل رقم الهوية' : 'Enter your ID number',
          nadaIcon: Icons.numbers_outlined,
          nadaOnChanged: (value) => _nadaFormData.nadaId = value,
          nadaValidator: NadaFormValidators.nadaValidateNumberOnly,
          nadaTextColor: NadaAppColors.nadaWhite,
        ),
        const SizedBox(height: 24),
        NadaCustomTextField(
          nadaLabel: nadaIsArabic ? 'الاسم الأول' : 'First Name',
          nadaHint: nadaIsArabic ? 'أدخل اسمك الأول' : 'Enter your first name',
          nadaIcon: Icons.person_outline,
          nadaOnChanged: (value) => _nadaFormData.nadaFirstName = value,
          nadaValidator: NadaFormValidators.nadaValidateTextOnly,
          nadaTextColor: NadaAppColors.nadaWhite,
        ),
        const SizedBox(height: 24),
        NadaCustomTextField(
          nadaLabel: nadaIsArabic ? 'البريد الإلكتروني' : 'Email Address',
          nadaHint: nadaIsArabic ? 'أدخل بريدك الإلكتروني' : 'Enter your email address',
          nadaIcon: Icons.email_outlined,
          nadaOnChanged: (value) => _nadaFormData.nadaEmail = value,
          nadaValidator: NadaFormValidators.nadaValidateEmail,
          nadaTextColor: NadaAppColors.nadaWhite,
        ),
        const SizedBox(height: 24),
        NadaCustomTextField(
          nadaLabel: nadaIsArabic ? 'رقم الهاتف' : 'Phone Number',
          nadaHint: nadaIsArabic ? 'أدخل رقم هاتفك' : 'Enter your phone number',
          nadaIcon: Icons.phone_outlined,
          nadaOnChanged: (value) => _nadaFormData.nadaPhoneNumber = value,
          nadaValidator: NadaFormValidators.nadaValidatePhoneNumber,
          nadaTextColor: NadaAppColors.nadaWhite,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Checkbox(
              value: _nadaFormData.nadaAcceptTerms,
              onChanged: (bool? value) {
                setState(() {
                  _nadaFormData.nadaAcceptTerms = value ?? false;
                });
              },
              activeColor: const Color(0xFF35367F),
            ),
            Expanded(
              child: Text(
                nadaIsArabic 
                  ? 'أوافق على الشروط والأحكام'
                  : 'I agree to the terms and conditions',
                style: const TextStyle(
                  color: NadaAppColors.nadaWhite,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _nadaBuildSubmitButton() {
    return NadaCustomButton(
      nadaText: nadaIsArabic ? 'إرسال' : 'Submit',
      nadaOnPressed: _nadaHandleSubmit,
      nadaAnimationController: _nadaButtonController,
      nadaAnimation: _nadaButtonAnimation,
    );
  }

  void _nadaHandleSubmit() {

    
    if (_nadaFormKey.currentState?.validate() ?? false) {
    
      
      if (_nadaFormData.nadaAcceptTerms) {
   
        
        final context = _scaffoldKey.currentContext;
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    nadaIsArabic 
                      ? 'تم إرسال النموذج بنجاح'
                      : 'Form submitted successfully',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              backgroundColor: const Color(0xFF35367F),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1,
                left: 16,
                right: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 6,
              duration: const Duration(seconds: 1),
            ),
          );
        }
      } else {

        
        final context = _scaffoldKey.currentContext;
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    nadaIsArabic 
                      ? 'يرجى الموافقة على الشروط والأحكام'
                      : 'Please accept the terms and conditions',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              backgroundColor: const Color.fromARGB(255, 62, 25, 25),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1,
                left: 16,
                right: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 6,
              duration: const Duration(seconds: 1),
            ),
          );
        }
      }
    }
  }

  Widget _nadaBuildLanguageToggle() {
    return NadaCustomButton(
      nadaText: nadaIsArabic ? 'EN' : 'عربي',

      nadaIsSmall: true,
      nadaIcon: RotationTransition(
        turns: _nadaRotateAnimation,
      
        child: const Icon(
          Icons.language,
          color: Colors.white,
          size: 20,
        
        ),
      ),
      nadaOnPressed: () {
        _nadaLanguageController.forward(from: 0);
        setState(() {
          nadaIsArabic = !nadaIsArabic;
        });
      },
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 30);
    
    // Top curve - wave style
    path.quadraticBezierTo(
      size.width * 0.25, 0,
      size.width * 0.5, 30,
    );
    path.quadraticBezierTo(
      size.width * 0.75, 60,
      size.width, 30,
    );
    
    // Right line
    path.lineTo(size.width, size.height - 30);
    
    // Bottom curve - wave style
    path.quadraticBezierTo(
      size.width * 0.75, size.height - 60,
      size.width * 0.5, size.height - 30,
    );
    path.quadraticBezierTo(
      size.width * 0.25, size.height,
      0, size.height - 30,
    );
    
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}