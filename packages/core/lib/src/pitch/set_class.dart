class SetClass {
  // [0] PU / P8
  // [0,1] m2 / M7
  // [0,2] M2 / m7
  // [0,3] m3 / M6
  // [0,4] M3 / m6
  // [0,5] P4 / P5
  // [0,6] A4 / d5 (tritone)

  // sus chord [0,2,7]
  // dim chord [0,3,6]
  // minor chord [0,3,7]
  // major chord [0,4,7]
  // aug chord [0,4,8]

  // [0,1,4,7] dim maj7 chord
  // [0,1,4,8] min maj7 chord
  // [0,1,5,8] maj7 chord
  // [0,2,4,8] aug7 chord
  // [0,2,6,8] aug6 chord
  // [0,3,5,8] min7 chord
  // [0,2,5,8] half dim7 chord
  // [0,3,6,8] dominant 7 chord
  // [0,3,6,9] dim7 chord
  // [0,2,3,6,9] dominant b9 chord
  // [0,2,4,6,9] dominant 9 chord
  // [0,1,3,5,6,8] maj11 chord
  // [0,2,4,6,7,9] dominant 11 chord

  // [0,1,3,5,6,8,10] diatonic scale
  // [0,1,3,4,6,8,10] altered scale
  // [0,1,2,4,6,8,10] locrian #2 / locrian major scale
  // [0,1,3,4,6,8,9] harmonic minor scale
  // [0,1,3,5,6,8,9] harmonic major scale
  // [0,1,3,4,6,7,9,10] octatonic scale
  // [0,1,2,3,5,7,8,10] bebop scale
  // [0,2,5,7,8,9] blues scale
  // [0,2,4,6,8,10] whole tone scale
  List<int> get primeForm => throw UnimplementedError();
}
