import 'package:flutter/material.dart';

import '../../data/fake_dalla_data.dart';
import '../../models/dalla.dart';
import '../../theme/app_theme.dart';

class PlanTripScreen extends StatefulWidget {
  const PlanTripScreen({super.key});

  @override
  State<PlanTripScreen> createState() => _PlanTripScreenState();
}

class _PlanTripScreenState extends State<PlanTripScreen> {
  bool _planned = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Plan a trip')),
      body: SafeArea(
        child: _planned
            ? const _TripResult()
            : Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.flight_takeoff_outlined, size: 48, color: theme.colorScheme.primary),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Plan the family summer trip',
                        style: theme.textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        "Dalla checks everyone's leave, budget and who's coming — flights, "
                        "a stay, and suggested leave days, in one plan.",
                        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => setState(() => _planned = true),
                          child: const Text('Plan our trip'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class _TripResult extends StatelessWidget {
  const _TripResult();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trip = fakeTripPlan;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 110,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.ghaf500, AppColors.ghaf900],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(AppSpacing.md),
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(trip.destination, style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white)),
                    Text(
                      '${trip.dateRangeLabel} · ${trip.travelerCount} travelers',
                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WHY HERE',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(trip.whyHere, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const _SectionLabel('Flights'),
        _FlightTile(flight: trip.outboundFlight),
        const SizedBox(height: AppSpacing.sm),
        _FlightTile(flight: trip.returnFlight),
        const SizedBox(height: AppSpacing.md),
        const _SectionLabel('Stay'),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: context.appColors.band,
                    borderRadius: BorderRadius.circular(AppRadii.input),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.hotel_outlined, color: theme.colorScheme.primary),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(trip.hotelName, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                      Text(
                        '${trip.hotelRating} ★ · ${trip.hotelNote}',
                        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                Text(trip.hotelPriceLabel, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const _SectionLabel('Suggested leave'),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Column(
              children: [
                for (final leave in trip.leaveSuggestions)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    child: Row(
                      children: [
                        Icon(Icons.event_busy_outlined, size: 18, color: context.appColors.amber),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                leave.personName,
                                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                leave.note,
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Card(
          color: context.appColors.band,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    'Nothing is booked. Total estimate ${trip.totalBudgetLabel} — send this to the family to vote.',
                    style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sent to the family for a vote')),
              );
            },
            child: const Text('Put it to the family'),
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Text(
        label.toUpperCase(),
        style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, letterSpacing: 1),
      ),
    );
  }
}

class _FlightTile extends StatelessWidget {
  const _FlightTile({required this.flight});

  final FlightLeg flight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Icon(Icons.flight_outlined, color: theme.colorScheme.primary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(flight.route, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                  Text(
                    '${flight.dayLabel} · ${flight.timeRangeLabel} · ${flight.airline}',
                    style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            Text(flight.priceLabel, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
