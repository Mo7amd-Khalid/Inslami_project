class SebhaState{
  double turns;

  int counter = 0;
  int zekr = 0;
  List<String> azkar = [
    "سبحان الله",
    "الحمد الله",
    "لا إله إلا الله",
    "الله اكبر",
  ];

  SebhaState({this.turns = 0.0, this.counter = 0,this.zekr = 0});
  SebhaState copyWith({
    double? turns,
    int? counter,
    int? zekr,
  }) {
    return SebhaState(
      turns: turns ?? this.turns,
      counter: counter ?? this.counter,
      zekr: zekr ?? this.zekr,
    );
  }
}

sealed class SebhaAction{}
class ClickOnSebha extends SebhaAction{
  double turns;
  int counter;
  int zekr;
  ClickOnSebha(this.turns, this.counter, this.zekr);
}
class ResetCounter extends SebhaAction{}
