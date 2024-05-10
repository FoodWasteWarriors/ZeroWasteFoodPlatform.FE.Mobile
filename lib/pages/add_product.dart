import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:food_waste_2/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class AddProduct extends StatefulWidget {
  final String id;
  final String token;
  final String role;

  const AddProduct({
    super.key,
    required this.id,
    required this.token,
    required this.role,
  });

  @override
  State<AddProduct> createState() => _AddProductWidgetState();
}

class _AddProductWidgetState extends State<AddProduct> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String dropdownValue = list.first;
  List<String>? choiceChipsValue;

  final fullNameController = TextEditingController();
  final fullNameFocusNode = FocusNode();
  final ageController = TextEditingController();
  final ageFocusNode = FocusNode();
  final phoneNumberController = TextEditingController();
  final phoneNumberFocusNode = FocusNode();
  final dateController = TextEditingController();
  final dateFocusNode = FocusNode();
  final descriptionController = TextEditingController();
  final descriptionFocusNode = FocusNode();
  FormFieldController<List<String>>? choiceChipsValueController;
  final originalPriceController = TextEditingController();
  final originalPriceFocusNode = FocusNode();
  final percentDiscountController = TextEditingController();
  final percentDiscountFocusNode = FocusNode();

  DateTime _dateOfBirth = DateTime(1900);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Adding Form',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: const Color(0xFF15161E),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              'Please fill out the form below to continue.',
              style: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'Outfit',
                    color: const Color(0xFF606A85),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ].divide(const SizedBox(height: 4)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 12, 8),
            child: FlutterFlowIconButton(
              borderColor: const Color(0xFFE5E7EB),
              borderRadius: 12,
              borderWidth: 1,
              buttonSize: 40,
              fillColor: Colors.white,
              icon: const Icon(
                Icons.close_rounded,
                color: Color(0xFF15161E),
                size: 24,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: Form(
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0, -1),
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 770,
                          ),
                          decoration: const BoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 12, 16, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller: fullNameController,
                                  focusNode: fullNameFocusNode,
                                  autofocus: true,
                                  textCapitalization: TextCapitalization.words,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: const Color(0xFF606A85),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: const Color(0xFF606A85),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    errorStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Figtree',
                                          color: const Color(0xFFFF5963),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFFE5E7EB),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFF6F61EF),
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
                                    fillColor:
                                        (fullNameFocusNode?.hasFocus ?? false)
                                            ? const Color(0x4D9489F5)
                                            : Colors.white,
                                    contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 20, 16, 20),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: const Color(0xFF15161E),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                  cursorColor: const Color(0xFF6F61EF),
                                ),
                                Container(
                                  child: () {
                                    if (widget.role != 'Customer') {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 12.0),
                                            child: TextFormField(
                                              controller: originalPriceController,
                                              focusNode: originalPriceFocusNode,
                                              autofocus: true,
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'Original Price',
                                                labelStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .headlineMedium
                                                    .override(
                                                      fontFamily: 'Outfit',
                                                      color:
                                                          const Color(0xFF606A85),
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                hintStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily: 'Outfit',
                                                      color:
                                                          const Color(0xFF606A85),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                errorStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Figtree',
                                                      color:
                                                          const Color(0xFFFF5963),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFE5E7EB),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFF6F61EF),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFFF5963),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFFF5963),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                filled: true,
                                                fillColor: (fullNameFocusNode
                                                            ?.hasFocus ??
                                                        false)
                                                    ? const Color(0x4D9489F5)
                                                    : Colors.white,
                                                contentPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(16, 20, 16, 20),
                                              ),
                                              style: FlutterFlowTheme.of(context)
                                                  .headlineMedium
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color:
                                                        const Color(0xFF15161E),
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                              cursorColor:
                                                  const Color(0xFF6F61EF),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 12.0),
                                            child: TextFormField(
                                              controller:
                                                  percentDiscountController,
                                              focusNode: percentDiscountFocusNode,
                                              autofocus: true,
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'Percent Discount',
                                                labelStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .headlineMedium
                                                    .override(
                                                      fontFamily: 'Outfit',
                                                      color:
                                                          const Color(0xFF606A85),
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                hintStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily: 'Outfit',
                                                      color:
                                                          const Color(0xFF606A85),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                errorStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Figtree',
                                                      color:
                                                          const Color(0xFFFF5963),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFE5E7EB),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFF6F61EF),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFFF5963),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFFF5963),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                filled: true,
                                                fillColor: (fullNameFocusNode
                                                            ?.hasFocus ??
                                                        false)
                                                    ? const Color(0x4D9489F5)
                                                    : Colors.white,
                                                contentPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(16, 20, 16, 20),
                                              ),
                                              style: FlutterFlowTheme.of(context)
                                                  .headlineMedium
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color:
                                                        const Color(0xFF15161E),
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                              cursorColor:
                                                  const Color(0xFF6F61EF),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  }(),
                                ),

                                /* TextFormField(
                                  controller: ageController,
                                  focusNode: ageFocusNode,
                                  autofocus: true,
                                  textCapitalization: TextCapitalization.words,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Description',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: const Color(0xFF606A85),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: const Color(0xFF606A85),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    errorStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Figtree',
                                          color: const Color(0xFFFF5963),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFFE5E7EB),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFF6F61EF),
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
                                    fillColor: (ageFocusNode?.hasFocus ?? false)
                                        ? const Color(0x4D9489F5)
                                        : Colors.white,
                                    contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 20, 16, 20),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Figtree',
                                        color: const Color(0xFF15161E),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  cursorColor: const Color(0xFF6F61EF),
                                ), */
                                TextFormField(
                                  controller: phoneNumberController,
                                  focusNode: phoneNumberFocusNode,
                                  autofocus: true,
                                  textCapitalization: TextCapitalization.words,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Photo',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: const Color(0xFF606A85),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: const Color(0xFF606A85),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    errorStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Figtree',
                                          color: const Color(0xFFFF5963),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFFE5E7EB),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFF6F61EF),
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
                                    fillColor:
                                        (phoneNumberFocusNode?.hasFocus ??
                                                false)
                                            ? const Color(0x4D9489F5)
                                            : Colors.white,
                                    contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 20, 16, 20),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Figtree',
                                        color: const Color(0xFF15161E),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  cursorColor: const Color(0xFF6F61EF),
                                ),
                                TextFormField(
                                  controller: dateController,
                                  focusNode: dateFocusNode,
                                  onTap: () async {
                                    DateTime? date = DateTime(1900);
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());

                                    date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100));

                                    _dateOfBirth = date ?? _dateOfBirth;
                                    dateController.text = date != null
                                        ? date.toString().substring(0, 10)
                                        : dateController.text;
                                  },
                                  autofocus: true,
                                  textCapitalization: TextCapitalization.words,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Expiration Date',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: const Color(0xFF606A85),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: const Color(0xFF606A85),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    errorStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Figtree',
                                          color: const Color(0xFFFF5963),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFFE5E7EB),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFF6F61EF),
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
                                    fillColor:
                                        (dateFocusNode?.hasFocus ?? false)
                                            ? const Color(0x4D9489F5)
                                            : Colors.white,
                                    contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 20, 16, 20),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Figtree',
                                        color: const Color(0xFF15161E),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  cursorColor: const Color(0xFF6F61EF),
                                ),
                                /* DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      dropdownValue = value!;
                                    });
                                  },
                                  items: list.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ), */
                                Text(
                                  'Categories',
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: const Color(0xFF606A85),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                FlutterFlowChoiceChips(
                                  options: const [
                                    ChipData('Diary'),
                                    ChipData('Meat'),
                                    ChipData('Fruit'),
                                    ChipData('Vegetable'),
                                    ChipData('Bakery'),
                                    ChipData('Drink'),
                                    ChipData('Snack'),
                                    ChipData('Canned'),
                                    ChipData('Frozen'),
                                    ChipData('Grain'),
                                    ChipData('Spice'),
                                    ChipData('Sauce'),
                                    ChipData('Oil'),
                                    ChipData('Egg'),
                                    ChipData('Dessert'),
                                    ChipData('Seafood'),
                                    ChipData('Pasta'),
                                    ChipData('Cereal'),
                                  ],
                                  onChanged: (val) => setState(
                                    () {
                                      print(val.toString());
                                      if (val != null) {
                                        choiceChipsValue = val;
                                      }
                                      ;
                                    },
                                  ),
                                  selectedChipStyle: ChipStyle(
                                    backgroundColor: const Color(0x4C39D2C0),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Figtree',
                                          color: const Color(0xFF15161E),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    iconColor: const Color(0xFF15161E),
                                    iconSize: 18,
                                    elevation: 0,
                                    borderColor: const Color(0xFF39D2C0),
                                    borderWidth: 2,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  unselectedChipStyle: ChipStyle(
                                    backgroundColor: const Color(0xFFF1F4F8),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Figtree',
                                          color: const Color(0xFF606A85),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    iconColor: const Color(0xFF606A85),
                                    iconSize: 18,
                                    elevation: 0,
                                    borderColor: const Color(0xFFE5E7EB),
                                    borderWidth: 2,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  chipSpacing: 12,
                                  rowSpacing: 12,
                                  multiselect: true,
                                  alignment: WrapAlignment.start,
                                  controller: choiceChipsValueController ??=
                                      FormFieldController<List<String>>(
                                    [],
                                  ),
                                ),
                                TextFormField(
                                  controller: descriptionController,
                                  focusNode: descriptionFocusNode,
                                  autofocus: true,
                                  textCapitalization: TextCapitalization.words,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Description...',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: const Color(0xFF606A85),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    alignLabelWithHint: true,
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: const Color(0xFF606A85),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    errorStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Figtree',
                                          color: const Color(0xFFFF5963),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFFE5E7EB),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFF6F61EF),
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
                                    fillColor:
                                        (descriptionFocusNode?.hasFocus ??
                                                false)
                                            ? const Color(0x4D9489F5)
                                            : Colors.white,
                                    contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 16, 16, 16),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Figtree',
                                        color: const Color(0xFF15161E),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  maxLines: 9,
                                  minLines: 5,
                                  cursorColor: const Color(0xFF6F61EF),
                                ),
                              ]
                                  .divide(const SizedBox(height: 12))
                                  .addToEnd(const SizedBox(height: 32)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 770,
                ),
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                  child: FFButtonWidget(
                    onPressed: () async {
                      // Add your onPressed code here!
                      print(widget.id);
                      print(dropdownValue);
                      print(choiceChipsValue);
                      print(fullNameController.text);
                      print(ageController.text);
                      print(phoneNumberController.text);
                      print(dateController.text);
                      print(descriptionController.text);

                      /* DateTime parseDate = new DateFormat("yyyy-MM-dd")
                          .parse(dateController.text);
                      var inputDate = DateTime.parse(parseDate.toString());
                      var outputFormat = DateFormat("2024-05-07T19:48:35.471Z");
                      var outputDate = outputFormat.format(inputDate); */
                      // Simulate a network request
                      if (widget.role == 'Customer') {
                        try {
                          final response = await http.post(
                              Uri.parse(
                                  'http://10.0.2.2:5157/api/v1/MonitoredProduct'),
                              headers: {
                                'Content-Type': 'application/json',
                                'Accept': '*/*',
                                'Authorization': 'Bearer ${widget.token}',
                              },
                              body: jsonEncode({
                                'name': fullNameController.text,
                                'description': descriptionController.text,
                                'photo': phoneNumberController.text,
                                'expirationDate': dateController.text,
                                'categoriesIds': choiceChipsValue,
                              }));

                          print(response.body);
                          print(response.statusCode);
                          if (response.statusCode == 200) {
                            print('Product added');
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Product added',
                                ),
                              ),
                            );
                          } else {
                            print('Failed to get products');
                            return null;
                          }
                        } catch (e) {
                          print(e);
                        }
                      } else {
                        try {
                          final response = await http.post(
                              Uri.parse(
                                  'http://10.0.2.2:5157/api/v1/StoreProduct'),
                              headers: {
                                'Content-Type': 'application/json',
                                'Accept': '*/*',
                                'Authorization': 'Bearer ${widget.token}',
                              },
                              body: jsonEncode({
                                'name': fullNameController.text,
                                'description': descriptionController.text,
                                'photo': phoneNumberController.text,
                                'expirationDate': dateController.text,
                                'categoriesIds': choiceChipsValue,
                                // parse to int
                                'originalPrice':
                                    int.parse(originalPriceController.text),
                                'percentDiscount':
                                    int.parse(percentDiscountController.text),
                              }));

                          print(response.body);
                          print(response.statusCode);
                          if (response.statusCode == 200) {
                            print('Product added');
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Product added',
                                ),
                              ),
                            );
                          } else {
                            print('Failed to get products');
                            return null;
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    text: 'Submit Form',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 48,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: const Color(0xFF6F61EF),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Figtree',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                      elevation: 3,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
