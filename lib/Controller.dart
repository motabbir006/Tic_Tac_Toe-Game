import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class Controller extends GetxController {
  RxList<String> gameValue = ["", "", "", "", "", "", "", "", ""].obs;
  RxBool isX = false.obs;
  RxBool isWinner = false.obs;
  RxInt click = 0.obs;
  List<int> undoStack = [];
  List<int> redoStack = [];

  void addValue(int index) {
    if (!isWinner.value && gameValue[index] == "") {
      undoStack.add(index);
      if (isX.value) {
        gameValue[index] = "X";
        isX.value = !isX.value;
        click++;
      } else {
        gameValue[index] = "O";
        isX.value = !isX.value;
        click++;
      }
      matchDrawMessage(
          click); // Call matchDrawMessage once after updating click count
      checkwinner();
    } else if (isWinner.value) {
      print('Game has already been won!');
    } else {
      print('Invalid Click');
    }
  }

  void matchDrawMessage(click) {
    if (click == 9) {
      Get.defaultDialog(
        title: 'Match Draw',
       // cancel: Text('Cancel'),
        confirm: TextButton(
            onPressed: () {
              click.value = 0;
              gameValue.value = ["", "", "", "", "", "", "", "", ""];
              Get.back();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            child: Text('PlayAgain')),
      );
    }
  }

  void checkwinner() {
    if (gameValue[0] == gameValue[1] &&
        gameValue[0] == gameValue[2] &&
        gameValue[0] != "") {
      WinnerDialogBox();
    } else if (gameValue[3] == gameValue[4] &&
        gameValue[3] == gameValue[5] &&
        gameValue[3] != "") {
      WinnerDialogBox();
    } else if (gameValue[6] == gameValue[7] &&
        gameValue[6] == gameValue[8] &&
        gameValue[6] != "") {
      WinnerDialogBox();
    } else if (gameValue[0] == gameValue[3] &&
        gameValue[0] == gameValue[6] &&
        gameValue[0] != "") {
      WinnerDialogBox();
    } else if (gameValue[1] == gameValue[4] &&
        gameValue[1] == gameValue[7] &&
        gameValue[1] != "") {
      WinnerDialogBox();
    } else if (gameValue[2] == gameValue[5] &&
        gameValue[2] == gameValue[8] &&
        gameValue[2] != "") {
      WinnerDialogBox();
    }

//diagonal
    else if (gameValue[0] == gameValue[4] &&
        gameValue[0] == gameValue[8] &&
        gameValue[0] != "") {
      WinnerDialogBox();
    } else if (gameValue[2] == gameValue[4] &&
        gameValue[2] == gameValue[6] &&
        gameValue[2] != "") {
      WinnerDialogBox();
    } else {}
  }

  void WinnerDialogBox() {
    isWinner.value = true;
    Get.defaultDialog(
      title: "Winner",
      content: Column(
        children: [
          const Icon(Icons.confirmation_num_rounded,
              size: 50, color: Colors.green),
          const SizedBox(
            height: 10,
          ),
          isX.value
              ? const Text(
                  'Player_01 is Winner',
                  style: TextStyle(fontSize: 30),
                )
              : const Text(
                  'Player_02 is Winner',
                  style: TextStyle(fontSize: 30),
                ),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.close),
                label: Text("Close"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  gameValue.value = ["", "", "", "", "", "", "", "", ""];
                  click.value = 0;
                  isWinner.value = false;
                  Get.back();
                },
                icon: Icon(Icons.play_arrow),
                label: Text("Play again"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  // Add more styling properties here if needed
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void resetGame() {
    gameValue.value = ["", "", "", "", "", "", "", "", ""];
    click.value = 0;
    isWinner.value = false;
  }


  void undoMove() {
    if (click.value > 0) {
      if (undoStack.isNotEmpty) {
        int lastMoveIndex = undoStack.removeLast();
        if (undoStack.length > 1) {
          // Remove the oldest move from the stack if it exceeds 2 moves
          undoStack.removeAt(0);
        }
        redoStack.add(lastMoveIndex);
        click.value--;
        gameValue[lastMoveIndex] = '';
        isX.value = !isX.value;
        isWinner.value = false;
      }
    }
  }
  void redoMove() {
    if (redoStack.isNotEmpty) {
      int redoIndex = redoStack.removeLast();
      if (redoStack.length > 1) {
        redoStack.removeAt(0);
      }
      undoStack.add(redoIndex);
      gameValue[redoIndex] = isX.value ? "X" : "O";
      click.value = redoIndex + 1;
      isX.value = !isX.value;
    }
  }


}
