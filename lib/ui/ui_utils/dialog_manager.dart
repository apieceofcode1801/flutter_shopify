import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/views/styles/text_styles.dart';
import 'package:flutter_shopify/ui/views/styles/colors.dart';

class DialogManager {
  static Future showCommonDialog(BuildContext context,
      {String message = '',
      required String actionTitle,
      required Function() action,
      Function()? cancelAction,
      bool isAlert = false}) {
    return showDialog<Void>(
        context: context,
        builder: (context) => Wrap(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 48, right: 48, top: 250),
                  decoration: BoxDecoration(
                      color: AppColors.dialog,
                      borderRadius: BorderRadius.circular(4.0)),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: TextStyles.content,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              action();
                            },
                            child: Text(
                              actionTitle,
                              style: TextStyles.buttonText.copyWith(
                                  color: isAlert
                                      ? AppColors.dangerousAction
                                      : AppColors.action),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (cancelAction != null) {
                                cancelAction();
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: Text('Cancel',
                                style: TextStyles.buttonText.copyWith(
                                    color: isAlert
                                        ? AppColors.action
                                        : AppColors.cancel)),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ));
  }
}
