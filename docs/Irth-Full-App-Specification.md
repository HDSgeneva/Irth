# IRTH — إرث
### Full Product Specification · SMAC 2026 (Khalifa University) · v1.0

> **Irth** (إرث) — *legacy*, with the built-in second meaning of *inheritance*.
> The things a family passes down: stories, names, habits, care.

---

## 0. Scoping notes before you read

Two things to verify with the SMAC organisers, because they change the plan:

1. **Theme.** The public SMAC 2026 page still lists *"AI Adventures in Sustainability."* If the family theme came from the kickoff briefing, confirm it in writing. This document is written family-first, but §4 gives you a ready-made sustainability framing so Irth scores under either rubric without a rewrite.
2. **Timeline.** The published dates are Kickoff 6 July, Submission **1 September**, Demo Day **16 September 2026**. That is roughly **4–5 weeks to submission**, not 8. The build plan in §18 is written to that shorter clock, with the two weeks between submission and Demo Day used for polish and rehearsal.

---

## 1. The pitch

**One line:** Irth turns a family's spoken memories into a game they play together — and wraps it in the private calendar, planner, and care tools that actually keep a family in each other's lives.

**Thirty seconds:** In the UAE, three generations often live within twenty minutes of each other and still communicate through a muted WhatsApp group. Grandparents hold stories nobody has recorded. Cousins forget birthdays. Somebody's mother runs out of her blood pressure medication and doesn't want to bother anyone. Irth is a private, invitation-only family app with one loop at its centre: an elder records a two-minute voice memory, AI transcribes it and pulls out the people, places, and dates inside it, and by Thursday the whole family is playing a trivia round built from that memory — *"Where did Jeddo first meet Teta?"* Every story quietly assembles a family tree and timeline the children can explore. Around that core sit the practical things: a shared calendar, an AI planner that finds a dinner slot everyone can make, tiered alerts so a grandmother's request for medication reaches someone immediately, and a reminder system that knows who is responsible for what.

**The insight worth defending in front of judges:** archiving is a chore, and chore apps die. Nobody opens a family archive twice. But families will show up weekly for something they *play*. Irth uses play as the delivery mechanism for preservation — the archive is a side effect of the game, not the ask.

---

## 2. The problem, concretely

| Problem | Evidence you can cite | What Irth does |
|---|---|---|
| Oral heritage dies with its holders | UNESCO lists the **Majlis** as intangible cultural heritage precisely because transmission is oral and fragile. The Arabic proverb version: *when an elder dies, a library burns.* | Low-friction voice capture designed for someone who does not use apps |
| Existing tools are one-way archives | Ancestry/StoryCorps-style products are built for the person doing the archiving, not the family | Capture → structure → **play**; the family consumes it weekly |
| Coordination cost kills gatherings | Three generations, competing work/school/leave calendars, nobody wants to be the organiser | Shared calendar + AI planner that proposes, polls, and books |
| Elder needs are under-signalled | A grandmother will not "bother" the group chat; her message sits below a meme | Tiered alerts with acknowledgement and escalation |
| Care load is invisible and unevenly distributed | Medication, school runs, appointments — held in one person's head | Responsibility-aware reminders with a visible care ledger |
| Social media is public by default | Families won't post real content to a public graph | Closed graph. No discovery, no strangers, no public profiles |

---

## 3. Why now — national alignment

This is Irth's strongest non-technical asset. Do not bury it.

- **UAE Year of Family 2026**, tagline **"Growing in Unity,"** designated by directive of President H.H. Sheikh Mohamed bin Zayed Al Nahyan, launched under the UAE Year Of national storytelling platform.
- Its three declared strategic priorities are **Roots, Bonds, Branches** — and Irth's three product pillars map onto them one-to-one. This is the spine of your pitch deck.
- **National Family Growth Agenda 2031**, approved at the UAE Government Annual Meetings, is the long-term policy framework the Year of Family sits inside.
- **"Our Family Album"** — a national initiative inviting UAE families to submit everyday moments into a curated storytelling journey. Irth is, in effect, infrastructure for exactly this at household scale.
- **Dubai CDA's "Generations in Majlis,"** under the *Connected Generations* programme within the **Season of Wulfa** launched by H.H. Sheikh Hamdan bin Mohammed bin Rashid Al Maktoum, pairs senior citizens with children to transfer Emirati heritage through the majlis format. Irth is the digital continuation of that session after everyone goes home.

**Pitch line:** *The Year of Family asked for Roots, Bonds, and Branches. We built an app with exactly three pillars.*

---

## 4. Alignment & impact framing (covers both possible rubrics)

**If the theme is family:** Roots / Bonds / Branches, verbatim (see §6).

**If the rubric weights sustainability:** frame Irth as **social sustainability + intangible cultural heritage preservation**.

- **SDG 3 — Good Health and Wellbeing:** medication adherence, reduced elder social isolation (a documented mortality risk factor).
- **SDG 4 — Quality Education:** informal intergenerational learning; heritage literacy in children.
- **SDG 10 / 11 — Reduced Inequalities, Sustainable Communities:** social cohesion, elders repositioned as knowledge assets rather than dependents.
- **UNESCO ICH:** every recorded story is a preserved unit of oral heritage. *Cultural sustainability is sustainability.*
- **Minor but real environmental angle:** coordinated planning consolidates trips — one family convoy instead of five separate cars, one booked trip instead of three abandoned plans.

---

## 5. Users

| Persona | Age | Device fluency | What they want | What Irth gives them |
|---|---|---|---|---|
| **Jeddo Rashid** — the Narrator | 74 | Low. Large text, WhatsApp voice notes only | To be listened to; to matter | One giant record button. Elder Mode. Hears his grandkids answer questions about him |
| **Maryam** — the Keeper (primary user) | 41 | High | To hold the family together without being the only one doing it | Planner does the coordination; care load becomes visible and shareable |
| **Khalid** — the Provider | 45 | Medium | Not to be nagged; to be told exactly what is needed and when | Leave-aware calendar, single actionable alerts, no group-chat noise |
| **Sara** — the Teen | 16 | Native | Something that isn't cringe; to not be bored at family dinners | Weekly play round, streaks, story reels, a tree she can actually explore |
| **Ahmed** — the Child | 9 | Native, supervised | Games | Play rounds, tree unlocks, guardian-controlled account |
| **Noura** — the Caregiver | 38 | Medium | Not to be the single point of failure on her mother's medication | Care ledger, refill prediction, escalation to a backup person |

**Adoption unit is the family, not the individual.** Irth is worthless with two members and valuable at seven. Every design decision below serves the invite loop.

---

## 6. Product architecture — three pillars

```
                          ┌─────────────────────────┐
                          │      THE GHAF TREE       │
                          │  (shared progress state) │
                          └─────────────────────────┘
                                      ▲
              ┌───────────────────────┼───────────────────────┐
              │                       │                       │
    ┌─────────┴────────┐   ┌──────────┴─────────┐   ┌─────────┴────────┐
    │      ROOTS       │   │       BONDS        │   │     BRANCHES     │
    │   جذور            │   │      روابط          │   │      فروع         │
    ├──────────────────┤   ├────────────────────┤   ├──────────────────┤
    │ Voice stories    │   │ Private circle feed│   │ Family calendar  │
    │ AI structuring   │   │ Group + 1:1 chat   │   │ Dalla AI planner │
    │ Majlis Play      │   │ Tiered alerts      │   │ Events & voting  │
    │ Family tree      │   │ Reactions, replies │   │ Care & reminders │
    │ Timeline         │   │ Events attendance  │   │ Medication ledger│
    └──────────────────┘   └────────────────────┘   └──────────────────┘
```

Everything a member does in any pillar deposits **Dana** (points) into the family's shared Ghaf Tree. That single shared object is what makes three loosely related feature sets feel like one product.

---

## 7. ROOTS — stories, structure, play

### 7.1 Capture

Three ways in, deliberately ranked by friction:

1. **Solo record.** One button. Optional prompt card on screen (*"Tell us about the first house you lived in"*). Max 5 minutes, soft-nudged at 2.
2. **Interview Mode** *(this is the important one)*. A grandchild sits with a grandparent and taps record. Irth displays AI-generated follow-up questions on screen in large Arabic/English text as the elder talks — *"What did it smell like?" "Who else was there?"* The grandchild is the operator, the elder is the source. **This removes elder tech adoption as a blocker entirely**, and it recreates the Generations in Majlis format one-to-one. Judges will notice this.
3. **Prompt of the Week.** Push notification with a seasonal question tied to Ramadan, National Day, a family birthday, or a gap the AI found in the tree.

Also supported: text stories, photo-with-caption ("why this object matters"), and short video.

### 7.2 The AI pipeline

```
audio ──► [1] ASR + diarisation ──► raw transcript
              │                          │
              │                          ▼
              │                    [2] Cleanup LLM ──► readable transcript (ar + en)
              │                                             │
              ▼                                             ▼
        family glossary                          [3] Entity extraction LLM
     (names, places, nicknames)                  ──► people | places | dates
        biases the ASR                               objects | events | relations
                                                            │
                              ┌─────────────────────────────┼──────────────────────────┐
                              ▼                             ▼                          ▼
                    [4] Graph merge                [5] Play generation        [6] Embeddings
                 (link to existing tree,           (3–5 question cards        (pgvector, powers
                  flag new person, ask             + 1 "guess who" +           "ask the archive")
                  human to confirm)                 1 photo/audio clip)
```

**Step-by-step detail:**

**[1] ASR.** Gulf Arabic is the hard part. Plan: Whisper large-v3 or ElevenLabs Scribe as primary, Azure Speech `ar-AE` as fallback, with **an initial-prompt glossary of the family's own names, place names, and nicknames injected per request** — this alone materially lifts accuracy on proper nouns, which is what the trivia questions depend on. Handle Arabic/English code-switching (extremely common in Emirati households) by not forcing a language and letting the model produce mixed output.

**[2] Cleanup.** Remove filler, keep voice. Never paraphrase into "correct" MSA — the dialect *is* the heritage. Produce a parallel translation so English-dominant grandchildren can read it, always presented as a subtitle beneath the original, never replacing it.

**[3] Extraction.** Claude with a strict JSON schema:

```json
{
  "title": "How Jeddo met Teta",
  "summary_ar": "...", "summary_en": "...",
  "era": { "start": 1968, "end": 1969, "confidence": "medium" },
  "people": [{ "name": "Fatima", "role": "spouse", "confidence": 0.9,
               "match_candidate_id": "mem_412" }],
  "places": [{ "name": "Al Ain", "type": "city", "geo_hint": "AE-AZ" }],
  "objects": [{ "name": "silver dallah", "significance": "wedding gift" }],
  "themes": ["marriage", "migration"],
  "sensitive": false,
  "verification_needed": ["era.start", "people[0].match_candidate_id"]
}
```

**[4] Graph merge.** The AI never silently writes to the family tree. Anything above a confidence threshold is *proposed*, and the storyteller or an admin taps to confirm. A wrong ancestor in a family tree is worse than a missing one — this is a trust product.

**[5] Play generation.** Question types: multiple choice, true/false, "who said this" audio clip, "guess the year," "put these in order," photo identification. Difficulty is banded so a nine-year-old and a forty-year-old can score in the same round. **Hard rule: the storyteller cannot be asked questions about their own story** — they get the *host* role instead, and earn Dana when others answer correctly.

**[6] Embeddings.** Powers semantic search across the archive: *"What did anyone ever say about the old house in Al Ain?"* Retrieval-augmented, answers cite the specific story and timestamp so nothing is hallucinated into family history.

### 7.3 Majlis Play

- Fires **once weekly**, default Thursday evening (the start of the UAE weekend and the traditional family gathering night). Family-configurable.
- Asynchronous by default — everyone has 24 hours. A synchronous "Live Majlis" mode lets everyone play at once when they're physically together.
- 5–7 questions, under three minutes.
- Ends on a **"the answer, in his own voice"** card — the actual audio clip. This is the emotional payoff and the thing that will make a judge's room go quiet.
- Scoring rewards *participation over accuracy*: showing up is worth more than being right. Deliberate — the goal is attendance, not competition.

### 7.4 Tree & timeline

- **Tree view:** interactive graph, pinch-zoom, each node a photo with a story count badge. Tap a person → their stories, their era, their relationships. Empty branches are shown as *invitations* ("No stories yet from Amtee Aisha — ask her?") which converts gaps into capture prompts.
- **Timeline view:** horizontal scroll of family events against a faint band of national milestones (1971 Union, 1990s development, Expo 2020, Year of Family 2026). Positions the family inside the national story — a very strong visual for the demo.

---

## 8. BONDS — private circle, chat, alerts

### 8.1 The circle feed

- Closed graph. **No discovery, no search for users, no public profiles, no follower counts.** You are in a family or you are nowhere.
- Post types: photo, video (≤2 min), voice note, text, milestone (graduation, new baby, new job), story publication, event recap.
- Reactions include culturally-native ones alongside standard emoji: *Masha'Allah*, *Barak Allah feek*, dua hands.
- Comments threaded, one level deep. No quote-posting, no resharing outside the family. There is no mechanism by which family content leaves the family.
- **Cross-family visibility (V2):** in-laws belong to two families. Model this as a member holding memberships in multiple family graphs with per-family visibility, plus an explicit "share this to my other family" action. Do not try to merge graphs automatically.

### 8.2 Chat

- Family group, sub-groups (Cousins, Siblings, Care Team), 1:1.
- Voice notes first-class, with **auto-transcription** so a busy parent can read Teta's voice note in a meeting. Small feature, disproportionately loved.
- Chat is **end-to-end encrypted**; story audio is not, because it needs server-side AI processing. Say this plainly in onboarding rather than implying blanket E2E. Honesty here is a scoring asset, not a weakness.
- "Turn this into an event" — long-press a message where a plan is forming and Dalla drafts the event.

### 8.3 Alert tiers — the *Nida* system

Four levels. This is a genuinely differentiated feature; specify it carefully.

| Tier | Name | Behaviour | Who can send |
|---|---|---|---|
| 0 | **Hams** (همس) — Whisper | In-app badge only. No push. Feed posts, reactions | Everyone |
| 1 | **Normal** | Standard push, respects Do Not Disturb and quiet hours | Everyone |
| 2 | **Muhim** (مهم) — Important | Push that bypasses muted-chat settings. Distinct amber styling and sound. Requires acknowledgement | Adults + elders |
| 3 | **Nida** (نداء) — Call | Time-Sensitive/Critical notification, bypasses Do Not Disturb, repeats every 5 min. **If unacknowledged after 10 min, automatically escalates to the next person on the responsibility chain, then places a phone call.** Red styling | Elders always; others rate-limited |

**Anti-abuse (essential, or the whole system rots):**
- Nida is rate-limited to 3/week per member; elders are exempt from the limit.
- Each Nida requires a category (medical / safety / urgent errand / other).
- Every member sets a personal escalation chain: who gets called if they don't respond.
- Per-relationship overrides: *"Anything from Teta is always at least tier 2."* This is the exact scenario in the brief — Teta needs medication from the pharmacy and it must not sit below a meme in the group chat.
- Quiet hours are per-member and respected by tiers 0–2 absolutely.

---

## 9. BRANCHES — calendar, planner, care

### 9.1 Shared family calendar

- Layered view: each member is a colour, toggleable. Month / week / agenda.
- Two-way sync with Google Calendar and Apple Calendar (read for availability, write for confirmed family events).
- **Privacy-preserving availability:** by default others see only **busy/free blocks**, not titles. You opt in to sharing detail. This is what makes working adults willing to connect a work calendar at all.
- Block types: work, school, travel, **annual leave** (critical — the brief specifically calls for leave planning), religious/observance, medical, family event.
- Auto-populated: birthdays, anniversaries, Hijri dates, Ramadan and Eid, National Day, school terms.

### 9.2 Dalla — the AI planner

Named for the **dalla**, the Arabic coffee pot passed around the majlis. Hospitality, and the thing that circulates.

Dalla operates at three tiers of ambition:

**Tier 1 — Find a time.** *"Dinner with everyone this week."* Deterministic constraint solver over calendars returns viable slots ranked by attendance; the LLM only writes the human-readable explanation. **Scheduling logic must never be an LLM.** Say this out loud in the demo — judges reward knowing where not to use AI.

**Tier 2 — Plan an outing.** *"Find somewhere for 11 people, Friday, someone's vegetarian, Teta needs step-free access, under AED 800."* Dalla calls Google Places, filters on hard constraints (accessibility, capacity, halal, price band), ranks on ratings and stored family preferences, returns 3 options with reasoning, opens a vote, books the winner into the calendar, and sends invites at the right alert tier.

**Tier 3 — Plan a trip.** *"Summer, budget AED 40,000, six people including a 6-year-old and a 71-year-old, somewhere cooler than here, max 6 hours flying."* Dalla reasons over the shared budget, everyone's leave balances and blackout dates, flight time, visa requirements, interests stored per member, and accessibility needs, and produces a day-by-day itinerary with flight and hotel candidates and **a recommended leave-request window per working adult**. Output goes to a family vote, then to the calendar, with booking handed off to external links.

**Design rules for Dalla:**
- **Always proposes, never books.** Explicit human confirmation before anything touches money or the calendar.
- **Shows its constraints.** "I picked Thursday because Khalid has leave and Sara has no exam" — visible reasoning builds trust and makes the AI legible to non-technical judges.
- **Preference memory.** Learns per member: dietary, mobility, budget sensitivity, interests, disliked venues. Editable by the member, always.
- **Silent poller.** Asks members individually via chat rather than turning the group chat into a 40-message negotiation.

### 9.3 Care & reminders

The most socially valuable pillar, and the one to be most careful with.

**Reminder types:**
- Medication (dose-level, per person)
- **Refill prediction** — from start date, dose, and pack size, compute run-out and alert the responsible person *5 days before*, not on the day. Deterministic arithmetic, not AI.
- Appointments, with a "who is driving?" assignment
- Recurring responsibilities — school pickup, physiotherapy, grocery run
- Contextual, calendar-derived — *"Ahmed's school ends at 2 today, you have a free block, can you collect him?"*

**Responsibility chains.** Every care task has a primary owner and a backup. Unacknowledged → escalates to backup → escalates to Nida. This is the feature that means an elder's medication does not depend on one person's memory.

**The care ledger.** A calm, non-competitive view of who did what this month. Purpose is *visibility*, not scoring — invisible care load is the actual family problem, and making it visible is the intervention.

**Ethical guardrails (state these in the deck):**
- Care actions credit the **family pool**, never an individual leaderboard. Do not gamify eldercare into a competition.
- Irth gives **no medical advice**, no dosage suggestions, no interaction warnings. It is a scheduling and reminder tool. Medication data is entered by a human and displayed back unchanged.
- Elders control their own care data and can see exactly who has visibility into it. Care must never feel like surveillance.

---

## 10. Roles & permissions

| Role | Who | Key permissions |
|---|---|---|
| **Founder** | Created the family | Everything, plus transfer ownership, delete family |
| **Admin** (up to 3) | Usually 30–60, the organisers | Invite/remove, assign roles, edit tree structure, moderate, configure alert policy |
| **Elder / Rāwī** | Grandparents, honorary | Full member rights + unlimited Nida + Elder Mode UI + story attribution and veto over their own stories |
| **Adult** | 18+ | Post, chat, plan, record, create events, manage own care tasks |
| **Teen** (13–17) | Guardian-linked | Post, chat, play, record. Cannot: initiate Nida, manage others' care, edit tree, spend family budget |
| **Child** (<13) | Guardian-managed | Play, view tree, react, guardian-approved posting. No DMs with non-family. No location sharing |
| **Caregiver** | Explicitly granted | Read/write access to *one specified person's* care schedule only. Time-boxed and revocable |
| **Guest** | New in-law, family friend | Read the feed, join events. No tree access, no care access, no archive access. Auto-expires in 90 days unless upgraded |

**Principles:** least privilege by default; every permission change is logged and visible to admins; **anyone can always delete their own content and export their own data**; removing a member removes their access but their stories persist with attribution unless they choose deletion.

---

## 11. Engagement — Dana, the Ghaf Tree, and rewards

### 11.1 Dana (دانة) — the point currency
*Dana* is a large, precious pearl. Pearling is the UAE's foundational family industry, and pearls were passed down. Perfect fit, and no naming conflict.

| Action | Dana | Note |
|---|---|---|
| Record a story | 50 | The highest-value action, priced accordingly |
| Interview Mode session (2 people) | 40 each | Rewards the intergenerational pairing specifically |
| Play the weekly round | 20 | Participation, not accuracy |
| Correct answer | +2 each | Deliberately small |
| Confirm/enrich a tree node | 15 | Data quality, crowdsourced |
| Attend a family event (geo/QR check-in) | 60 | **Highest single reward — real-world presence is the point** |
| Plan an event that ≥3 people attend | 45 | Rewards the organiser, who is usually unrewarded |
| Complete a care task | 25 | To the family pool |
| Post to the circle | 10 | Capped at 3/day |
| Weekly streak (any 3 actions) | 30 | See anti-patterns below |
| Comment on a story | 5 | Capped |

### 11.2 The Ghaf Tree — shared family progress

One shared living illustration on the home screen. The ghaf is the UAE's national tree: drought-resistant, deep-rooted, shelters everything under it. The metaphor writes itself.

| Level | Name | Cumulative Dana | Unlocks |
|---|---|---|---|
| 1 | **Badhra** (بذرة) — Seed | 0 | Core app |
| 2 | **Nabta** (نبتة) — Sprout | 1,500 | Family crest builder, 6 majlis themes |
| 3 | **Fasīla** (فسيلة) — Sapling | 5,000 | Timeline view, story card frames, Live Majlis mode |
| 4 | **Ghaf** (غاف) | 15,000 | Dalla Tier-3 trip planning, unlimited archive search, custom prompt packs |
| 5 | **Ghaf Mu'ammar** (غاف معمّر) — Ancient Ghaf | 40,000 | Annual printed **Irth Book**, family documentary reel auto-cut from the year's stories, heritage-cause donation in the family's name |

**Why collective, not individual:** an individual leaderboard inside a family creates resentment and turns Teta into a competitor. A shared tree means Sara's streak helps her grandfather's level. Cooperative by construction.

### 11.3 Individual titles (earned, non-competitive, no ranking)

- **الراوي Rāwī** — Narrator · 10 stories recorded
- **السامع Sāmi'** — Listener · 25 stories heard end to end
- **المنظّم Munaẓẓim** — Organiser · 5 events planned and attended
- **الحارس Ḥāris** — Guardian · 30 days of care tasks completed
- **الواصل Wāṣil** — Connector · connected to every living member of the tree

*Wāṣil* references **ṣilat al-raḥm** (صلة الرحم) — the maintaining of kinship ties, a core cultural and religious value in the region. If you use one Arabic phrase in your pitch, use this one: **Irth is an app for ṣilat al-raḥm.** It will land.

### 11.4 Anti-patterns — explicitly designed out
- No public inter-family leaderboards. Ever.
- No guilt notifications. *"You're the only one who hasn't played"* — never ships.
- Elders never lose points and never break streaks. Streaks pause automatically on detected illness/travel.
- Streak loss costs level progress, never content or access.
- Points unlock **cosmetics and convenience only**. Nothing core — not stories, not care, not chat — is ever paywalled behind engagement.
- Weekly cap on Dana, so nobody can farm the system by spamming the feed.

---

## 12. AI system design

| Function | Approach | Why |
|---|---|---|
| Speech-to-text | Whisper large-v3 / ElevenLabs Scribe, Azure `ar-AE` fallback, per-family glossary prompt | Gulf dialect is the technical risk; glossary biasing is the cheapest big win |
| Transcript cleanup, translation | LLM, low temperature | Language task |
| Entity & relationship extraction | LLM, strict JSON schema, confidence scores | Language task with structured output |
| Tree merge | **Human-confirmed**, AI proposes only | Correctness matters more than automation |
| Question generation | LLM with difficulty banding + storyteller-exclusion rule | Creative task |
| Archive Q&A | RAG over pgvector, answers must cite a story + timestamp | Prevents hallucinated family history |
| Availability solving | **Deterministic constraint solver** | Scheduling must be correct, not plausible |
| Venue/trip ranking | LLM over tool-call results (Places API) | Judgement task with real data underneath |
| Medication timing, refill maths | **Deterministic rules engine** | Safety-critical. No LLM anywhere near dosing |
| Alert escalation | **Deterministic state machine** | Safety-critical |
| Reminder phrasing | LLM | Cosmetic layer only |

**The line to say out loud in the demo:** *"We used AI for language and judgement, and ordinary code for anything where being wrong matters. Scheduling, medication, and escalation are deterministic by design."* This is exactly what an engineering judging panel wants to hear, and most student teams won't say it.

**Cost control:** batch story processing (nothing is real-time); cache Places results per family for 30 days; Tier-3 trip planning costs Dana, which naturally rate-limits your most expensive call; downgrade to a smaller model for cleanup and phrasing, reserve the frontier model for extraction and planning.

---

## 13. Data model (core entities)

```
Family(id, name, crest, tree_level, dana_total, locale, created_by)
Member(id, family_id, user_id, display_name, arabic_name, role, dob,
       elder_mode, quiet_hours, escalation_chain[], avatar)
Relationship(from_member, to_member, type, verified_by, confidence)
Story(id, family_id, author_id, title, type, duration, status,
      visibility, era_start, era_end, sensitive)
MediaAsset(id, story_id, kind, uri, checksum, encrypted_at_rest)
Transcript(id, story_id, lang, text, segments[], confidence, edited_by)
ExtractedEntity(id, story_id, kind, value, confidence, linked_member_id,
                confirmed_by, confirmed_at)
PlayCard(id, story_id, question_type, prompt, options[], answer,
         difficulty_band, media_ref)
PlaySession(id, family_id, week_of, card_ids[], host_id)
PlayResponse(id, session_id, member_id, card_id, answer, correct, answered_at)
Event(id, family_id, title, start, end, location, place_id, budget,
      created_by, status)
EventRsvp(id, event_id, member_id, status, checked_in_at)
Poll / PollVote
CalendarBlock(id, member_id, start, end, kind, visibility, external_ref)
Chat / Message(id, chat_id, sender_id, body_encrypted, alert_tier,
               ack_required, acked_by[])
AlertPolicy(id, member_id, from_member_id, min_tier)
CareTask(id, family_id, subject_member_id, kind, schedule_rrule,
         owner_id, backup_id, escalation_after_min)
CareCompletion(id, task_id, completed_by, completed_at, note)
Medication(id, subject_member_id, name, dose, pack_size,
           started_on, refill_due_on)
DanaLedger(id, family_id, member_id, action, amount, created_at)
Post / Comment / Reaction
```

---

## 14. Tech stack

Chosen for **two people, five weeks**.

| Layer | Choice | Rationale |
|---|---|---|
| Client | **Flutter** | One codebase, iOS + Android, excellent RTL support, fast UI iteration |
| Backend | **Supabase** (Postgres, Auth, Storage, Realtime, Edge Functions) | Auth, DB, storage, realtime and row-level security out of the box. RLS is how you enforce the closed family graph — one policy layer, not scattered checks |
| Vector search | **pgvector** in the same Postgres | No extra service |
| AI orchestration | Supabase Edge Functions → Anthropic API, tool-calling for Places | Server-side only; no API keys in the client, ever |
| ASR | Whisper / ElevenLabs Scribe API | See §12 |
| Push | Firebase Cloud Messaging + APNs | Tier 3 uses iOS Time-Sensitive notifications; **Critical Alerts require an Apple entitlement you will not get in time — implement the fallback (repeat + auto-call) and say so honestly** |
| Places / maps | Google Places API | Ratings, accessibility, opening hours |
| Calendar sync | Google Calendar API, iOS EventKit | |
| Hosting region | **AWS `me-central-1` (UAE)** or Azure UAE North | Data residency. See §15 |
| Analytics | PostHog, self-hosted | No third-party family data |

**Build order for a two-person team:** one owns Roots (record → pipeline → play → tree), the other owns Branches + Bonds (calendar → planner → chat → alerts). Shared: auth, family graph, design system, Ghaf Tree. Agree the DB schema on day one and do not renegotiate it.

---

## 15. Privacy, safety, compliance

**This section wins or loses the judging.** A family app that hasn't thought about privacy is a red flag; one that has is credible.

- **Closed graph.** Invite-only via link or code. No user search, no discovery, no recommendations, no public profiles. Content cannot leave the family through any in-app mechanism.
- **UAE PDPL** — Federal Decree-Law No. 45 of 2021 on Personal Data Protection. Design accordingly: lawful basis, purpose limitation, retention limits, right to access, right to erasure.
- **Data residency.** Host in-country (AWS `me-central-1`). Note honestly that AI inference may leave the region; mitigate by using regional endpoints where available, disclosing it in onboarding, and offering **Local Mode** — on-device transcription with no AI enrichment — for families who want it. Offering the honest trade-off is stronger than claiming a purity you can't deliver.
- **Consent for elders.** A spoken, in-app consent step before a story is processed, in the elder's language, in plain words: *what is recorded, where it goes, who can hear it, how to delete it.* Interview Mode requires the elder's own confirmation, not just the operator's.
- **Minors.** Guardian-linked accounts. No DMs outside the family graph. No location sharing for under-13s. No behavioural profiling of minors, and no engagement mechanics tuned on children's data.
- **Encryption.** TLS in transit, AES-256 at rest, E2E for chat. Media assets stored with signed, short-lived URLs.
- **Deletion.** Any member can permanently delete their own stories and media, including derived transcripts, embeddings, and generated play cards. Cascade delete must be real, and demonstrable.
- **Sensitive content.** The extraction step flags stories touching illness, death, divorce, or conflict as `sensitive: true`. **No trivia cards are ever generated from a flagged story.** Nothing would destroy trust faster than a quiz question about a family bereavement. This single rule is worth mentioning in the demo — it shows you thought about failure modes.
- **Inheritance protocol.** When a member dies, their content locks to read-only, their profile gains a memorial state, and their stories are preserved permanently. Handle this with care; families will encounter it, and it is the deepest meaning of the name.

---

## 16. Design system

### 16.1 Direction

**"Majlis at dusk."** Warm, unhurried, textile-informed. Not a startup gradient; not a heritage pastiche. The reference points are a sadu-woven cushion, a sand-coloured wall at golden hour, and the deep green of a ghaf tree at the edge of a farm. Content is the hero — voices, faces, the tree.

### 16.2 Colour

| Token | Hex | Use |
|---|---|---|
| `ghaf-900` | `#173A2F` | Darkest brand, headers on light |
| `ghaf-700` | **`#2E5E4E`** | **Primary brand.** Buttons, active nav, tree |
| `ghaf-500` | `#4A806C` | Hover, secondary fills |
| `ghaf-100` | `#DCE8E2` | Tints, selected states, chips |
| `sand-50` | **`#F7F2E9`** | **App background (light).** Warm paper |
| `sand-100` | `#EFE7D9` | Section bands, dividers |
| `surface` | `#FFFFFF` | Cards |
| `ink-900` | `#171A18` | Primary text |
| `ink-600` | `#5C635E` | Secondary text |
| `ink-300` | `#A8AEA9` | Disabled, placeholder |
| `dana-500` | **`#C8A24A`** | **Accent.** Points, streaks, tree level, celebration |
| `amber-500` | `#E0913A` | Tier-2 *Muhim* alerts, warnings |
| `khor-500` | `#2F6F8F` | Calendar, plans, informational |
| `nida-500` | `#C0463C` | **Tier-3 alerts only.** Never decorative |
| `success` | `#3F8F5F` | Confirmations, completed care |

**Dark mode** (default at night, since story listening skews evening): `bg #12100D` · `surface #1C1A16` · `ghaf-700 → #4A806C` · text `#F2EFE8` · dana holds at `#D4B160`.

**Rules:** `nida-500` appears in exactly one context. `dana-500` is for earned moments — it should feel scarce, so it feels like a reward. Backgrounds are always warm-toned; a cool grey background will make the whole app feel clinical and kill it.

### 16.3 Typography

- **Display / headings:** Tajawal Bold — Arabic-first, geometric, warm.
- **UI / body:** IBM Plex Sans Arabic — dual-script, superb legibility at small sizes, open-licensed.
- **Story transcripts (long-form Arabic):** Noto Naskh Arabic — built for extended reading.

| Style | Size / Line | Weight |
|---|---|---|
| Display | 32 / 40 | 700 |
| Title | 24 / 32 | 700 |
| Heading | 20 / 28 | 600 |
| Body L | 17 / 26 | 400 |
| Body | 15 / 22 | 400 |
| Caption | 13 / 18 | 500 |

Arabic renders one step larger than its Latin counterpart at equal optical weight. **Elder Mode** scales the whole ramp ×1.3 and raises minimum touch targets from 44pt to 56pt.

### 16.4 Shape, motif, motion

- Radii: cards 20px, sheets 28px top, inputs 12px, avatars fully round, buttons 14px.
- Elevation: single soft shadow, `0 2px 8px rgba(23,26,24,.06)`. No hard borders on cards.
- **Sadu motif:** a thin geometric line pattern used as section divider, empty-state illustration, and story-card frame. Maximum 12% opacity. Never a full-bleed background — that is the line between "cultural" and "costume."
- Motion: 220ms ease-out standard. The Ghaf Tree grows on level-up with a 600ms spring. Recording uses a live waveform with a soft breathing pulse.
- Spacing: 4pt base grid, 16pt screen gutters, 12pt card padding.

### 16.5 RTL and bilingual

- Full mirroring for Arabic. Chevrons, back gestures, progress bars, tree layout — all flip. Test every screen in both directions from week one; retrofitting RTL is expensive.
- Per-member language, not per-family. Teta reads Arabic, Sara reads English, same content.
- Numerals: Arabic-Indic (٠١٢٣) in Arabic locale, Western in English locale, dates always dual Gregorian + Hijri.
- Mixed-script strings (Arabic name in an English sentence) are extremely common — set text direction per-run, not per-widget.

### 16.6 Accessibility

Minimum 4.5:1 contrast throughout. Full screen-reader labels including Arabic. No information carried by colour alone — alert tiers also carry an icon and text label. Every voice story auto-captioned. Elder Mode: larger type, higher contrast, fewer options per screen, one primary action per view.

---

## 17. Screens

**Bottom navigation (5):** `Majlis` · `Hikayat` (Stories) · `Plan` · `Chat` · `Me`

**1 · Majlis — home**
Ghaf Tree header showing level and this week's Dana → *This Week's Play* card (the primary CTA) → any active care/alert cards pinned above the fold → circle feed → *Prompt of the Week* record card. The tree header is persistent; it is the app's identity.

**2 · Hikayat — stories**
Segmented: `Listen` · `Record` · `Tree` · `Timeline`. Record opens a full-screen sheet: one large `ghaf-700` circle, a live waveform, an optional prompt card, and a language toggle. Interview Mode is a second, equally prominent entry point — do not hide it.

**3 · Play** (modal from Majlis, not a tab)
Full-screen cards, swipe to advance, per-card timer, family progress dots at top. Ends with the audio reveal and a Dana animation.

**4 · Plan**
Segmented: `Calendar` · `Events` · `Care`. Calendar defaults to agenda view on mobile with member colour dots. Floating action button opens Dalla as a chat sheet with three suggestion chips: *Find a time* · *Plan an outing* · *Plan a trip*. Dalla's output renders as proposal cards with visible reasoning, not as a wall of text.

**5 · Chat**
Standard list. Alert-tier badge on each thread. Long-press a message → *Make an event* · *Set a reminder* · *Send as Muhim*.

**6 · Me**
Profile, my stories, my titles, my care tasks, quiet hours, alert preferences, escalation chain, language, Elder Mode toggle, privacy and data export, family settings if admin.

**7 · Onboarding**
`Create or join` → `Name your family` → `Add yourself` → `Invite by WhatsApp deep link` (invites are the whole game — make this step beautiful and hard to skip) → `Add your first elder` → **first prompt fires within 90 seconds of install.** The app must produce one recorded story on day one or it has failed onboarding.

---

## 18. Scope — what ships for SMAC

**Discipline is the difference between a demo and an apology.** Everything above is the product. Below is what exists as working software on 1 September.

### MUST — the demo dies without these
1. Auth, family creation, invite by code, roles (Admin / Adult / Elder / Teen)
2. Voice recording + upload + Interview Mode
3. Full AI pipeline: ASR → cleanup → extraction → play-card generation
4. Weekly Play with async participation and the audio-reveal ending
5. Family tree, auto-populated from confirmed extractions
6. Shared calendar with member layers and manual event creation
7. Dalla Tier 1 (find a time) and Tier 2 (venue suggestions via Places)
8. Group chat with the 4-tier alert system and acknowledgement
9. Care reminders with responsibility chains and escalation
10. Dana ledger + Ghaf Tree with 5 levels
11. Elder Mode + full Arabic RTL
12. Feed with posts and reactions

### SHOULD — build if the MUSTs are done by week 3
13. Timeline view with national milestones
14. Dalla Tier 3 (trip planning) — *even a scripted single scenario demos beautifully*
15. Refill prediction
16. Archive semantic search
17. External calendar sync

### WON'T — roadmap slides, not code
Cross-family / in-law graphs · printed Irth Book · live synchronous Majlis · video stories · memorial protocol · government programme integrations · the family documentary reel

> If you are behind in week 3, cut **17, 16, 14** in that order. Never cut **3, 4, 9, or 11** — those four are what make Irth *Irth* rather than a group chat with a calendar.

---

## 19. Build plan — two people, 30 July → 1 September

| Week | Person A (Roots) | Person B (Bonds + Branches) | Shared milestone |
|---|---|---|---|
| **W1** · Jul 30 – Aug 5 | Recording UI, upload, storage, ASR wired end to end | Supabase schema, auth, RLS policies, family creation, invite flow | **Design system + schema locked. Do not touch either again.** |
| **W2** · Aug 6 – 12 | Extraction pipeline → JSON → DB. Tree data structure + confirm-flow UI | Calendar, member layers, event creation, chat, 4-tier alerts | Audio in → structured entities out |
| **W3** · Aug 13 – 19 | Play generation, play UI, audio-reveal card, Dana hooks | Dalla Tier 1 + 2 with Places, care reminders, escalation state machine | **Vertical slice: record a story on Monday, play it on Thursday** |
| **W4** · Aug 20 – 26 | Tree visualisation, Elder Mode, Arabic RTL pass | Ghaf Tree visual, Dana ledger, feed, push notifications | **Feature freeze Aug 26.** Load real family data |
| **W5** · Aug 27 – Sep 1 | Bug fixing, empty states, error handling | Bug fixing, seed data, demo account | **Submit Sep 1** |
| **W6–7** · Sep 2 – 15 | Demo rehearsal, video, deck, offline fallback build | Demo rehearsal, deck, poster | **Demo Day Sep 16** |

**Non-negotiables:**
- **Use your own families as test data from week 2.** Real grandparents, real Arabic, real dialect. Synthetic data will hide every problem that matters, and a real recording of a real grandmother is worth more in the demo than any feature.
- **Build the demo path first, polish second.** Every feature should be reachable in the exact click sequence you'll use on stage by end of week 3.
- **Have an offline build.** Conference Wi-Fi fails. Pre-cache one processed story, one play round, and one Dalla plan so the demo runs with the network unplugged.

---

## 20. Demo Day script — 6 minutes

1. **0:00 — Open on a real photo of your grandparent.** "Every family has someone who holds the stories. Nobody has recorded them." *(No slides yet. Just the photo.)*
2. **0:30 — The number.** Three generations, twenty minutes apart, one muted group chat.
3. **1:00 — Live capture.** Record 20 seconds into Interview Mode on stage. Let a judge ask the follow-up question that appears on screen.
4. **1:45 — The pipeline, visibly.** Transcript appears. Entities highlight. A new node lights up in the tree. Say the line: *"AI for language and judgement, ordinary code for anything where being wrong matters."*
5. **2:45 — Play.** Put the trivia round on screen. **Ask the judges a question about your own grandfather.** Let them answer. Then play his actual voice as the reveal. *This is the moment the room goes quiet — do not rush it and do not talk over the audio.*
6. **4:00 — The other two pillars, fast.** Dalla finds a dinner slot for 11 people in four seconds. Teta sends a Nida for her medication; it lands as a red alert, unacknowledged, and escalates to the backup. Thirty seconds each, no more.
7. **5:00 — Roots, Bonds, Branches.** One slide. The Year of Family's three priorities, your three pillars. Then: *"Irth is an app for ṣilat al-raḥm."*
8. **5:30 — Ask.** What you'd build next, and what you need.

**Rehearse the timing out loud eight times.** The single biggest differentiator among student demos is whether the team has practised.

---

## 21. Success metrics

**North star:** *weekly cross-generational interactions per family* — any interaction between members ≥25 years apart in age. It measures the actual thing Irth exists to cause.

| Metric | Target (pilot) |
|---|---|
| Families with ≥3 generations active weekly | 60% |
| Stories captured per family per month | 4+ |
| Play participation rate | 70% of members |
| Story listen-through rate | 80% |
| Care tasks completed on time | 90% |
| Nida acknowledged within 10 min | 95% |
| Elder 30-day retention | 50% |
| Family 30-day retention | 70% |
| Planned events that actually happen | 65% |

Track the **elder** cohort separately and obsessively. If elders churn, Irth is a calendar app with extra steps.

---

## 22. Risks

| Risk | Severity | Mitigation |
|---|---|---|
| Gulf dialect ASR accuracy | **High** | Family glossary prompt biasing, human-editable transcripts, fallback provider, and an honest accuracy number in the deck rather than a claim you can't support |
| Elders won't use an app | **High** | Interview Mode makes elder tech adoption unnecessary. Elder Mode for those who want it |
| Cold start — an empty family is useless | **High** | WhatsApp deep-link invites, family onboarding not individual onboarding, first story within 90 seconds |
| Privacy fear about family data | Medium | Closed graph, in-country hosting, Local Mode, plain-language consent, real deletion |
| Feature bloat kills the build | **High** | §18. The MUST list is 12 items and you cut from the bottom |
| Notification fatigue | Medium | Tier 0 default, rate limits on Nida, per-member quiet hours |
| Sensitive stories mishandled | Medium | `sensitive` flag blocks play-card generation entirely |
| Apple Critical Alert entitlement unavailable | Low | Time-Sensitive notification + repeat + auto-call fallback, disclosed honestly |
| A judge asks "why not WhatsApp?" | **Certain** | *"WhatsApp is where family content goes to disappear. Irth structures it, plays it back, and hands it to the next generation. Also: WhatsApp has no family tree, no shared calendar, no care escalation, and no memory."* Have this answer ready verbatim |

---

## 23. Sustainability of the product itself

- **Free forever:** stories, tree, play, chat, calendar, care. The social mission cannot be paywalled.
- **Irth+ (per family, ~AED 25/mo):** Dalla Tier-3 trip planning, unlimited archive, 4K media retention, annual printed Irth Book.
- **Institutional licensing:** Dubai CDA, Ministry of Community Development, and schools running intergenerational programmes need exactly this tool — Generations in Majlis produces content with nowhere to live. This is the credible path from student project to funded pilot, and it is worth one slide.
- **Heritage partnership:** families can opt in to donate anonymised stories to a national oral-history archive, feeding initiatives like *Our Family Album*. Opt-in only, per story, revocable.

---

## Appendix A — Naming

**Irth (إرث)** is clear. Verified: no competing UAE app or brand in this space; the closest uses are a Saudi architecture exhibit and a Saudi travel company, neither adjacent. Compare *Sanad* (Abu Dhabi Police e-service, and a Mubadala company) and *Rawi* (an existing AI storytelling app) — both taken.

Before launch, run a formal check with the UAE Ministry of Economy trademark register and secure `irth.ae` plus the app-store names.

Sub-brands used in this document: **Dalla** (دلّة, the coffee pot — the AI planner) · **Dana** (دانة, pearl — points) · **Nida** (نداء, a call — the urgent alert tier) · **Majlis Play** · **Ghaf Tree** · **Rāwī / Sāmi' / Munaẓẓim / Ḥāris / Wāṣil** (member titles).

## Appendix B — Taglines

- **إرث — ما نورّثه، نلعبه** · *Irth — what we inherit, we play.*
- *Every family has a library. Ours has a login.*
- *Roots. Bonds. Branches.*
- *An app for ṣilat al-raḥm.*
