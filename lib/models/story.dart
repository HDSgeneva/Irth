enum EntityType { name, place, date }

class StoryDetails {
  const StoryDetails({required this.names, required this.places, required this.dates});

  final List<String> names;
  final List<String> places;
  final List<String> dates;

  factory StoryDetails.fromMap(Map<String, dynamic> map) {
    return StoryDetails(
      names: List<String>.from(map['names'] as List? ?? const []),
      places: List<String>.from(map['places'] as List? ?? const []),
      dates: List<String>.from(map['dates'] as List? ?? const []),
    );
  }
}

class TranscriptSegment {
  const TranscriptSegment(this.text, [this.type]);

  final String text;
  final EntityType? type;
}

class TriviaQuestion {
  const TriviaQuestion({
    required this.prompt,
    required this.options,
    required this.correctIndex,
  });

  final String prompt;
  final List<String> options;
  final int correctIndex;
}

class FakeStory {
  const FakeStory({
    required this.title,
    required this.narrator,
    required this.arabicTranscript,
    required this.englishTranscript,
    required this.extractedNames,
    required this.extractedPlace,
    required this.extractedYear,
    required this.trivia,
    required this.answerAudioAsset,
    required this.answerAudioLabel,
  });

  final String title;
  final String narrator;
  final List<TranscriptSegment> arabicTranscript;
  final List<TranscriptSegment> englishTranscript;
  final List<String> extractedNames;
  final String extractedPlace;
  final String extractedYear;
  final TriviaQuestion trivia;
  final String answerAudioAsset;
  final String answerAudioLabel;
}
