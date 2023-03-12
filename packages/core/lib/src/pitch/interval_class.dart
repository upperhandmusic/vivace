import 'pitch_class.dart';

class IntervalClass {
  // i(a,b) = the smaller of i<a,b> and i<b,a>
  // where i<a,b> is the ordered pitch class interval
  IntervalClass(PitchClass a, PitchClass b)
      : id = (a.setNumber - b.setNumber) % 12;

  final int id;
}
