import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:food_waste_2/models/customer.dart';
import 'package:food_waste_2/models/user.dart';
import 'package:food_waste_2/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateAccount extends StatefulWidget {
  final Function toggleView;
  const CreateAccount({super.key, required this.toggleView});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Auth authManager = Auth();

  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  FocusNode emailAddressFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode passwordConfirmFocusNode = FocusNode();

  bool passwordVisibility = false;
  bool passwordConfirmVisibility = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailAddressController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();

    super.dispose();
  }

  void onSubmit() async {
    if (emailAddressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Email is required!',
          ),
        ),
      );
      return;
    }

    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password is required!',
          ),
        ),
      );
      return;
    }

    if (passwordConfirmController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password confirmation is required!',
          ),
        ),
      );
      return;
    }

    if (passwordController.text != passwordConfirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Passwords don\'t match!',
          ),
        ),
      );
      return;
    }
    final customer = CustomerModel(
      username: 'sprinkai',
      email: emailAddressController.text,
      phoneNumber: '',
      firstName: '',
      lastName: '',
      avatar: '',
      password: passwordController.text,
    );

    try {
      UserModel? user = await authManager.createCustomer(customer);

      print(user);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 8,
              child: Container(
                width: 100,
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                alignment: const AlignmentDirectional(0, -1),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 140,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        alignment: const AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(32, 0, 0, 0),
                          child: Text(
                            'brand.ai',
                            style: GoogleFonts.getFont(
                              'Overpass',
                              color: Colors.black,
                              fontSize: 36,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create an account',
                                style: GoogleFonts.getFont(
                                  'Overpass',
                                  color: const Color(0xFF57636C),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 12, 0, 24),
                                child: Text(
                                  'Let\'s get started by filling out the form below.',
                                  style: GoogleFonts.getFont(
                                    'Overpass',
                                    color: const Color(0xFF57636C),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 16),
                                child: SizedBox(
                                  width: 370,
                                  child: TextFormField(
                                    controller: emailAddressController,
                                    focusNode: emailAddressFocusNode,
                                    autofocus: true,
                                    autofillHints: const [AutofillHints.email],
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: GoogleFonts.getFont(
                                        'Overpass',
                                        color: const Color(0xFF57636C),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFF1F4F8),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF4B39EF),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFFF1F4F8),
                                    ),
                                    style: GoogleFonts.getFont(
                                      'Overpass',
                                      color: const Color(0xFF101213),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 16),
                                child: SizedBox(
                                  width: 370,
                                  child: TextFormField(
                                    controller: passwordController,
                                    focusNode: passwordFocusNode,
                                    autofocus: true,
                                    autofillHints: const [
                                      AutofillHints.password
                                    ],
                                    obscureText: !passwordVisibility,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: GoogleFonts.getFont(
                                        'Overpass',
                                        color: const Color(0xFF57636C),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFF1F4F8),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF4B39EF),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFFF1F4F8),
                                      suffixIcon: InkWell(
                                        onTap: () => setState(
                                          () => passwordVisibility =
                                              !passwordVisibility,
                                        ),
                                        focusNode:
                                            FocusNode(skipTraversal: true),
                                        child: Icon(
                                          passwordVisibility
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: const Color(0xFF57636C),
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    style: GoogleFonts.getFont(
                                      'Overpass',
                                      color: const Color(0xFF101213),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 16),
                                child: SizedBox(
                                  width: 370,
                                  child: TextFormField(
                                    controller: passwordConfirmController,
                                    focusNode: passwordConfirmFocusNode,
                                    autofocus: true,
                                    autofillHints: const [
                                      AutofillHints.password
                                    ],
                                    obscureText: !passwordConfirmVisibility,
                                    decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      labelStyle: GoogleFonts.getFont(
                                        'Overpass',
                                        color: const Color(0xFF57636C),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFF1F4F8),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF4B39EF),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFFF1F4F8),
                                      suffixIcon: InkWell(
                                        onTap: () => setState(
                                          () => passwordConfirmVisibility =
                                              !passwordConfirmVisibility,
                                        ),
                                        focusNode:
                                            FocusNode(skipTraversal: true),
                                        child: Icon(
                                          passwordConfirmVisibility
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: const Color(0xFF57636C),
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    style: GoogleFonts.getFont(
                                      'Overpass',
                                      color: const Color(0xFF101213),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    minLines: 1,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 16),
                                child: FFButtonWidget(
                                  onPressed: onSubmit,
                                  text: 'Create Account',
                                  options: FFButtonOptions(
                                    width: 370,
                                    height: 44,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                    iconPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                    color: const Color(0xFF4B39EF),
                                    textStyle: GoogleFonts.getFont(
                                      'Overpass',
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    elevation: 3,
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),

                              // You will have to add an action on this rich text to go to your login page.
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 12, 0, 12),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Already have an account? ',
                                        style: TextStyle(
                                          color: Color(0xFF57636C),
                                          fontSize: 16,
                                        ),
                                      ),
                                      // Wrap only the "Create one" text with GestureDetector
                                      TextSpan(
                                        text: 'Sign in',
                                        style: const TextStyle(
                                          color: Color(0xFF4B39EF),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Navigate to another screen when "Create one" is tapped
                                            widget.toggleView();
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (responsiveVisibility(
              context: context,
              phone: false,
              tablet: false,
            ))
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: 100,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1514924013411-cbf25faa35bb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1380&q=80')),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
