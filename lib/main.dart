import 'package:flutter/material.dart';
import 'models/nada_form_data.dart';
import 'utils/nada_app_colors.dart';
import 'utils/nada_validators.dart';
import 'widgets/nada_custom_text_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: NadaAppColors.nadaPrimary,
          surface: NadaAppColors.nadaBackground,
        ),
        scaffoldBackgroundColor: NadaAppColors.nadaBackground,
      ),
      home: const MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = NadaFormData();
  bool isArabic = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: NadaAppColors.nadaBackground,
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        isArabic ? 'استمارة ندى' : 'Nada\'s Form',
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

  Widget _buildBody() {
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
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
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          _buildHeader(),
                          const SizedBox(height: 32),
                          _buildFormFields(),
                          const SizedBox(height: 32),
                          _buildSubmitButton(),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: isArabic ? 16 : null,
                  right: isArabic ? null : 16,
                  child: Container(
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
                          setState(() {
                            isArabic = !isArabic;
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
                              const Icon(
                                Icons.language,
                                color: NadaAppColors.nadaWhite,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                isArabic ? 'EN' : 'عربي',
                                style: const TextStyle(
                                  color: NadaAppColors.nadaWhite,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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

  Widget _buildHeader() {
    return Align(
      alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? 'المعلومات الشخصية' : 'Personal Information',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: NadaAppColors.nadaTextPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isArabic ? 'يرجى ملء التفاصيل الخاصة بك أدناه' : 'Please fill in your details below',
            style:const TextStyle(
              fontSize: 16,
              color: NadaAppColors.nadaTextSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        NadaCustomTextField(
          nadaLabel: isArabic ? 'الاسم الأول' : 'First Name',
          nadaHint: isArabic ? 'أدخل اسمك الأول' : 'Enter your first name',
          nadaIcon: Icons.person_outline,
          nadaOnChanged: (value) => _formData.nadaFirstName = value,
          nadaValidator: (value) => NadaFormValidators.nadaValidateField(
            value, 
            isArabic ? 'الاسم الأول' : 'first name'
          ),
        ),
        const SizedBox(height: 24),
        NadaCustomTextField(
          nadaLabel: isArabic ? 'اسم العائلة' : 'Last Name',
          nadaHint: isArabic ? 'أدخل اسم العائلة' : 'Enter your last name',
          nadaIcon: Icons.person_outline,
          nadaOnChanged: (value) => _formData.nadaLastName = value,
          nadaValidator: (value) => NadaFormValidators.nadaValidateField(
            value, 
            isArabic ? 'اسم العائلة' : 'last name'
          ),
        ),
        const SizedBox(height: 24),
        NadaCustomTextField(
          nadaLabel: isArabic ? 'البريد الإكتروني' : 'Email Address',
          nadaHint: isArabic ? 'أدخل بريدك الإلكتروني' : 'Enter your email address',
          nadaIcon: Icons.email_outlined,
          nadaIsEmail: true,
          nadaOnChanged: (value) => _formData.nadaEmail = value,
          nadaValidator: (value) => NadaFormValidators.nadaValidateField(
            value, 
            isArabic ? 'البريد الإلكتروني' : 'email',
            isEmail: true
          ),
        ),
        const SizedBox(height: 24),
        NadaCustomTextField(
          nadaLabel: isArabic ? 'رقم الهاتف' : 'Phone Number',
          nadaHint: isArabic ? 'أدخل رقم هاتفك' : 'Enter your phone number',
          nadaIcon: Icons.phone_outlined,
          nadaOnChanged: (value) => _formData.nadaPhoneNumber = value,
          nadaValidator: (value) => NadaFormValidators.nadaValidateField(
            value, 
            isArabic ? 'رقم الهاتف' : 'phone number'
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      height: 54,
      child: ElevatedButton(
        onPressed: _handleSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: NadaAppColors.nadaPrimary,
          foregroundColor: NadaAppColors.nadaWhite,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return NadaAppColors.nadaHover;
            }
            return null;
          }),
        ),
        child: Text(
          isArabic ? 'إرسال' : 'Submit',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: NadaAppColors.nadaWhite,
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _showSuccessMessage();
    }
  }

  void _showSuccessMessage() {
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
} 