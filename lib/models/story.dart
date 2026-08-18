enum EntityType { name, place, date }

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
  });

  final String title;
  final String narrator;
  final List<TranscriptSegment> arabicTranscript;
  final List<TranscriptSegment> englishTranscript;
  final List<String> extractedNames;
  final String extractedPlace;
  final String extractedYear;
  final TriviaQuestion trivia;
}
