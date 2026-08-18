import '../models/story.dart';

const fakeStory = FakeStory(
  title: 'The house in Al Ain',
  narrator: 'Jeddo Rashid',
  arabicTranscript: [
    TranscriptSegment('وعمي '),
    TranscriptSegment('سيف', EntityType.name),
    TranscriptSegment(' بنى غرفة المجلس بنفسه في سنة '),
    TranscriptSegment('١٩٦٨', EntityType.date),
    TranscriptSegment('، في مدينة '),
    TranscriptSegment('العين', EntityType.place),
    TranscriptSegment('. وكل يوم جمعة كان الحي كله يجي يتغدى عندنا.'),
  ],
  englishTranscript: [
    TranscriptSegment('My uncle '),
    TranscriptSegment('Saif', EntityType.name),
    TranscriptSegment(' built the majlis room himself in '),
    TranscriptSegment('1968', EntityType.date),
    TranscriptSegment(', in the city of '),
    TranscriptSegment('Al Ain', EntityType.place),
    TranscriptSegment('. Every Friday the whole neighborhood came to eat with us.'),
  ],
  extractedNames: ['Jeddo Rashid', 'Saif'],
  extractedPlace: 'Al Ain',
  extractedYear: '1968',
  trivia: TriviaQuestion(
    prompt: 'Who built the majlis room in the Al Ain house?',
    options: ['Saif', 'Khalid', 'Rashid', 'A hired builder'],
    correctIndex: 0,
  ),
);

const followUpQuestions = [
  'What did the house smell like?',
  'Who else was there with you?',
  'What did you eat that day?',
  'How old were you then?',
  'What happened after that?',
];
