import 'package:flutter/material.dart';
import 'models/nada_form_data.dart';
import 'utils/nada_app_colors.dart';
import 'utils/nada_validators.dart';
import 'widgets/nada_custom_text_field.dart';

void main() {
  runApp(const NadaApp());
}

class NadaApp extends StatelessWidget {
  const NadaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'CustomFont',
        colorScheme: const ColorScheme.light(
          primary: NadaAppColors.nadaPrimary,
          surface: NadaAppColors.nadaBackground,
        ),
        scaffoldBackgroundColor: NadaAppColors.nadaBackground,
      ),
      home: const NadaForm(),
    );
  }
}

class NadaForm extends StatefulWidget {
  const NadaForm({super.key});

  @override
  State<NadaForm> createState() => _NadaFormState();
}

class _NadaFormState extends State<NadaForm> with TickerProviderStateMixin {
  final _nadaFormKey = GlobalKey<FormState>();
  final _nadaFormData = NadaFormData();
  bool nadaIsArabic = false;
  late AnimationController _nadaLanguageController;
  late Animation<double> _nadaRotateAnimation;
  late AnimationController _nadaButtonController;
  late Animation<double> _nadaButtonAnimation;

  @override
  void initState() {
    super.initState();
    _nadaLanguageController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _nadaRotateAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159, // Full rotation (2π)
    ).animate(CurvedAnimation(
      parent: _nadaLanguageController,
      curve: Curves.easeInOut,
    ));

    _nadaButtonController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _nadaButtonAnimation = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(
        parent: _nadaButtonController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _nadaLanguageController.dispose();
    _nadaButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _nadaBuildAppBar(),
      backgroundColor: NadaAppColors.nadaBackground,
      body: _nadaBuildBody(),
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
      backgroundColor: NadaAppColors.nadaPrimary,
      elevation: 2,
      centerTitle: true,
    );
  }

  Widget _nadaBuildBody() {
    return Directionality(
      textDirection: nadaIsArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Stack(
              children: [
                Card(
                  elevation: 2,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _nadaFormKey,
                      child: Column(
                        crossAxisAlignment: nadaIsArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          _nadaBuildHeader(),
                          const SizedBox(height: 32),
                          _nadaBuildFormFields(),
                          const SizedBox(height: 32),
                          _nadaBuildSubmitButton(),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: nadaIsArabic ? 16 : null,
                  right: nadaIsArabic ? null : 16,
                  child: _nadaBuildLanguageToggle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nadaBuildHeader() {
    return Align(
      alignment: nadaIsArabic ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: nadaIsArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            nadaIsArabic ? 'المعلومات الشخصية' : 'Personal Information',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: NadaAppColors.nadaTextPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            nadaIsArabic ? 'يرجى ملء التفاصيل الخاصة بك أدناه' : 'Please fill in your details below',
            style:const TextStyle(
              fontSize: 15,
              color: NadaAppColors.nadaTextSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _nadaBuildFormFields() {
    return Column(
      children: [
        NadaCustomTextField(
          nadaLabel: nadaIsArabic ? 'الاسم الأول' : 'First Name',
          nadaHint: nadaIsArabic ? 'أدخل اسمك الأول' : 'Enter your first name',
          nadaIcon: Icons.person_outline,
          nadaOnChanged: (value) => _nadaFormData.nadaFirstName = value,
          nadaValidator: (value) => NadaFormValidators.nadaValidateField(
            value, 
            nadaIsArabic ? 'الاسم الأول' : 'first name'
          ),
        ),
        const SizedBox(height: 24),
        NadaCustomTextField(
          nadaLabel: nadaIsArabic ? 'اسم العائلة' : 'Last Name',
          nadaHint: nadaIsArabic ? 'أدخل اسم العائلة' : 'Enter your last name',
          nadaIcon: Icons.person_outline,
          nadaOnChanged: (value) => _nadaFormData.nadaLastName = value,
          nadaValidator: (value) => NadaFormValidators.nadaValidateField(
            value, 
            nadaIsArabic ? 'اسم العائلة' : 'last name'
          ),
        ),
        const SizedBox(height: 24),
        NadaCustomTextField(
          nadaLabel: nadaIsArabic ? 'البريد الإكتروني' : 'Email Address',
          nadaHint: nadaIsArabic ? 'أدخل بريدك الإلكتروني' : 'Enter your email address',
          nadaIcon: Icons.email_outlined,
          nadaIsEmail: true,
          nadaOnChanged: (value) => _nadaFormData.nadaEmail = value,
          nadaValidator: (value) => NadaFormValidators.nadaValidateField(
            value, 
            nadaIsArabic ? 'البريد الإلكتروني' : 'email',
            isEmail: true
          ),
        ),
        const SizedBox(height: 24),
        NadaCustomTextField(
          nadaLabel: nadaIsArabic ? 'رقم الهاتف' : 'Phone Number',
          nadaHint: nadaIsArabic ? 'أدخل رقم هاتفك' : 'Enter your phone number',
          nadaIcon: Icons.phone_outlined,
          nadaOnChanged: (value) => _nadaFormData.nadaPhoneNumber = value,
          nadaValidator: (value) => NadaFormValidators.nadaValidateField(
            value, 
            nadaIsArabic ? 'رقم الهاتف' : 'phone number'
          ),
        ),
      ],
    );
  }

  Widget _nadaBuildSubmitButton() {
    return ScaleTransition(
      scale: _nadaButtonAnimation,
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [NadaAppColors.nadaGradientStart, NadaAppColors.nadaGradientEnd],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: NadaAppColors.nadaGradientStart.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            _nadaButtonController.forward().then((_) {
              _nadaButtonController.reverse();
            });
            _nadaHandleSubmit();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            nadaIsArabic ? 'إرسال' : 'Submit',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: NadaAppColors.nadaWhite,
            ),
          ),
        ),
      ),
    );
  }

  void _nadaHandleSubmit() {
    if (_nadaFormKey.currentState!.validate()) {
      _nadaShowSuccessMessage();
    }
  }

  void _nadaShowSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children:[
            Icon(Icons.check_circle, color: NadaAppColors.nadaWhite),
            SizedBox(width: 8),
            Text('Form submitted successfully'),
          ],
        ),
        backgroundColor: NadaAppColors.nadaPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin:  EdgeInsets.all(16),
      ),
    );
  }

  Widget _nadaBuildLanguageToggle() {
    return Container(
      decoration: BoxDecoration(
        color: NadaAppColors.nadaPrimary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _nadaLanguageController.forward(from: 0);
            setState(() {
              nadaIsArabic = !nadaIsArabic;
            });
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RotationTransition(
                  turns: _nadaRotateAnimation,
                  child: const Icon(
                    Icons.language,
                    color: NadaAppColors.nadaWhite,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    nadaIsArabic ? 'EN' : 'عربي',
                    key: ValueKey<bool>(nadaIsArabic),
                    style: const TextStyle(
                      color: NadaAppColors.nadaWhite,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 