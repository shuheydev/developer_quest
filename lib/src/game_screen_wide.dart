import 'dart:math';

import 'package:dev_rpg/src/game_screen/character_pool_page.dart';
import 'package:dev_rpg/src/shared_state/game/company.dart';
import 'package:dev_rpg/src/style.dart';
import 'package:dev_rpg/src/widgets/app_bar/coin_badge.dart';
import 'package:dev_rpg/src/widgets/app_bar/joy_badge.dart';
import 'package:dev_rpg/src/widgets/app_bar/stat_separator.dart';
import 'package:dev_rpg/src/widgets/app_bar/users_badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_screen/task_pool_page.dart';

class GameScreenWide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var availableWidth = MediaQuery.of(context).size.width;
    var taskColumnWidth = min(modalMaxWidth, availableWidth / 3);
    var charactersWidth = availableWidth - taskColumnWidth * 2;
    var numCharacterColumns =
        (charactersWidth / idealCharacterWidth).round().clamp(2, 4).toInt();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(59, 59, 73, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Consumer<Company>(
          builder: (context, company, child) {
            // Using RepaintBoundary here because this part of the UI
            // changes frequently.
            return RepaintBoundary(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: const BorderSide(
                      color: statsSeparatorColor,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(width: 125, child: UsersBadge(company.users)),
                    StatSeparator(),
                    Container(width: 125, child: JoyBadge(company.joy)),
                    StatSeparator(),
                    Expanded(child: CoinBadge(company.coin)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      body: Row(
        children: [
          SizedBox(
            width: charactersWidth,
            child: CharacterPoolPage(numColumns: numCharacterColumns),
          ),
          SizedBox(
            width: taskColumnWidth,
            child: const TaskPoolPage(display: TaskPoolDisplay.inProgress),
          ),
          SizedBox(
            width: taskColumnWidth,
            child: const TaskPoolPage(display: TaskPoolDisplay.completed),
          ),
        ],
      ),
    );
  }
}
