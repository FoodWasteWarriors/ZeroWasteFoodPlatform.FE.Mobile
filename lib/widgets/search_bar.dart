import 'package:flutter/material.dart';

class StickySearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final Function() onFilterPressed;

  const StickySearchBar({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onFilterPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x33000000),
              offset: Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 8, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(
                Icons.search_rounded,
                color: Colors.white,
                size: 24,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      onChanged: onChanged,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Search listings...',
                        labelStyle: Theme.of(context).textTheme.subtitle1,
                        hintStyle: Theme.of(context).textTheme.subtitle1,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      style: Theme.of(context).textTheme.bodyText1,
                      cursorColor: Theme.of(context).primaryColor,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Field is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                  color: Colors.grey.shade300,
                ),
                child: IconButton(
                  icon: const Icon(Icons.tune_rounded),
                  color: Theme.of(context).primaryColor,
                  iconSize: 24,
                  onPressed: onFilterPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
