import 'package:flutter/material.dart';
import 'package:marvel_app/app/core/presenter/theme/helpers/theme_color_helper.dart';

class ThemeBottomSheet {
  static Future<T?> show<T>(BuildContext context, {
    required Widget child,
    Key? key,
  }) {
    return showModalBottomSheet<T>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              key: key,
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 5,
                    margin: EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                      color: ThemeColorHelper.primaryGreyColor,
                      borderRadius: BorderRadius.all(Radius.circular(2.5)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                            Icons.close,
                          color: ThemeColorHelper.primaryDarkColor,
                        ),
                      ),
                    ),
                  ),
                  child
                ],
              ),
            ),
          );
        });
  }
}
