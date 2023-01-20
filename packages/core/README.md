# Vivace Core

A library for writing music applications.

**THIS PACKAGE IS STILL IN VERY EARLY DEVELOPMENT AND SUBJECT TO CHANGE UNTIL FIRST STABLE RELEASE**

## Features

- Create and manipulate pitches, intervals and scales
- Define rhythms that can serve as the foundation for notated music

## Getting started

```
dart pub get vivace_core
```

## Usage

### Scales

```dart
const cMajor = Scale.major(PitchClass.cNatural);
print(cMajor.tonic); // PitchClass(0)
```
