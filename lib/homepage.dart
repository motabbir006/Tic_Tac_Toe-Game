import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tic_tac_toe/Controller.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    Controller controller = Get.put(Controller());
    return Scaffold(
        backgroundColor: Colors.green[500],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(() => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: controller.isX.value == false
                                ? Colors.blue
                                : Colors.orangeAccent[800],
                          ),
                          child: Text(
                            'Player_01',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )),

                    Obx(() => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: controller.isX.value == false
                                ? Colors.orangeAccent[800]
                                : Colors.deepOrange,
                          ),
                          child: Text(
                            'Player_02',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: 9,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              print(index);
                              controller.addValue(index);
                            },
                            child: Obx(
                              () => Container(
                                  margin: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[900],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                      child: Text(
                                    controller.gameValue.value[index],
                                    style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ))),
                            ));
                      }),
                ),

                Obx(() => Visibility(
                  visible: !controller.isWinner.value && controller.click.value > 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.10),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 150),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller.undoMove(); // Call function to undo move
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.orange[400], // Text color
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Button padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Button border radius
                              ),
                            ),
                            child: Text(
                              'Undo',
                              style: TextStyle(
                                fontSize: 22, // Button text size
                                fontWeight: FontWeight.bold, // Button text weight
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.redoMove(); // Call function to redo move
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.blueGrey[900], backgroundColor: Colors.orange[400], // Text color
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Button padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Button border radius
                              ),
                            ),
                            child: Text(
                              'Redo',
                              style: TextStyle(
                                fontSize: 22, // Button text size
                                fontWeight: FontWeight.bold, // Button text weight
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                )),



                Obx(() => Visibility(
                  visible: controller.isWinner.value || controller.click.value == 9,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            controller.resetGame(); // Call resetGame function when the button is pressed
                            Get.back(); // Close the dialog
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[400],
                          ),
                          child: const Text(
                            "Start Game",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),





              ],
            ),
          ),
        ));
  }
}
