import 'package:flutter/material.dart';
import 'package:refazendo_projeto/components/difficulty.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;

  Task(this.nome, this.foto, this.dificuldade, {Key? key}) : super(key: key);
  int nivel = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int level = 0;
  int maxLevel = 5;
  int colorLevel = 0;
  bool assetOrNetwork() {
    if (widget.foto.contains('http')) {
      return false;
    }

    return true;
  }

  List listColors = [
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.pinkAccent,
    Colors.black
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: Colors.blue),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black26,
                      ),
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: assetOrNetwork()
                            ? Image.asset(
                                widget.foto,
                                fit: BoxFit.fill,
                              )
                            : Image.network(widget.foto, fit: BoxFit.cover),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(
                              widget.nome,
                              style: const TextStyle(fontSize: 24),
                              overflow: TextOverflow.ellipsis,
                            )),
                        Difficulty(
                          difficultyLevel: widget.dificuldade,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.nivel++;
                              incrementLevel();
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Icon(Icons.arrow_drop_up),
                              Text(
                                "UP",
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
              Container(
                color: listColors[colorLevel],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        width: 200,
                        child: LinearProgressIndicator(
                          color: Colors.white,
                          value: (widget.dificuldade > 0)
                              ? (widget.nivel / widget.dificuldade) / 10
                              : 1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'N??vel: ${widget.nivel}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void incrementLevel() {
    if (level < (widget.dificuldade * maxLevel)) {
      level = level + 1;
    } else {
      level = 1;

      if (colorLevel < listColors.length - 1) {
        colorLevel++;
      }
    }
  }

  double incrementProgressIndicator() {
    return (widget.dificuldade > 0)
        ? level / (widget.dificuldade * maxLevel)
        : 0;
  }
}
