import '../models/dalla.dart';

const fakeTimeSuggestion = TimeSuggestion(
  dayLabel: 'Thursday',
  timeRangeLabel: '6:00 PM – 7:30 PM',
  reason:
      "Everyone's free Thursday evening: Khalid has no meetings after 5, "
      "and Sara's exams finish Wednesday.",
);

const fakePlaceSuggestion = PlaceSuggestion(
  name: 'Al Fanar Restaurant',
  category: 'Emirati · Family dining',
  rating: 4.5,
  priceLabel: 'AED 120–180 per person',
  reason: 'Fits your budget, has a step-free entrance, and seats groups of 10+ without a wait.',
);

const fakeTripPlan = TripPlan(
  destination: 'Salalah, Oman',
  dateRangeLabel: '21 – 25 August',
  travelerCount: 5,
  totalBudgetLabel: 'AED 7,400',
  whyHere:
      "Khareef season, so it's 24°C instead of 44°C. Flat corniche walks for "
      "Jeddo Rashid, and a hotel pool Sara won't want to leave.",
  outboundFlight: FlightLeg(
    route: 'Dubai → Salalah',
    dayLabel: 'Fri 21 Aug',
    timeRangeLabel: '09:15 – 11:05',
    airline: 'Salam Air',
    priceLabel: 'AED 620 / person',
  ),
  returnFlight: FlightLeg(
    route: 'Salalah → Dubai',
    dayLabel: 'Tue 25 Aug',
    timeRangeLabel: '18:40 – 20:35',
    airline: 'Salam Air',
    priceLabel: 'AED 640 / person',
  ),
  hotelName: 'Juweira Boutique Hotel',
  hotelRating: 4.4,
  hotelNote: 'Step-free rooms · 3 rooms held',
  hotelPriceLabel: 'AED 480 / night',
  leaveSuggestions: [
    LeaveSuggestion(personName: 'Baba Adel', note: 'File leave by 7 Aug'),
    LeaveSuggestion(personName: 'Khalid', note: 'File leave by 7 Aug'),
  ],
);
