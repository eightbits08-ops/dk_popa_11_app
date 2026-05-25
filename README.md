# DK POPA 11 - Cricket Scoring App 🏏

A lightweight offline Flutter mobile app for scoring cricket matches. Built specifically for personal cricket team "DK POPA 11" to replace manual Notepad scoring.

## Features ✨

### Core Scoring
- 📊 Ball-by-ball scoring (0, 1, 2, 3, 4, 6 runs)
- ⚾ Extras (Wide, No Ball, Bye, Leg Bye)
- 🏏 Wicket tracking with multiple dismissal types
- 📈 Automatic overs calculation (3.5 format)
- 🔄 Strike rotation after each over
- ↩️ Undo last ball functionality

### Match Management
- ✏️ Create new matches with opponent, overs, date, venue
- 👥 Player management (add, edit, delete players)
- 🎯 Select playing XI (11-player limit)
- 🪙 Toss management (winner + bat/field choice)
- 📜 Match history with scorecard storage

### User Experience
- 🌙 Dark Material Design 3 theme (optimized for outdoor use)
- 🖱️ Large buttons for one-hand scoring
- ⚡ Fast navigation and smooth transitions
- 📱 Fully responsive design

## Tech Stack 🛠️

- **Frontend:** Flutter (Dart)
- **State Management:** Provider
- **Database:** SQLite (sqflite) - fully offline
- **Architecture:** Clean layered (Models → Repositories → Services → Providers → Screens)
- **Theme:** Material Design 3 with dark mode
- **Min SDK:** Flutter 3.12+, Dart 3.12+

## Project Structure 📁

```
lib/
├── main.dart                     # App entry point & MultiProvider setup
├── app_constants.dart            # Colors, fonts, strings, cricket constants
├── app_theme.dart                # Material Design 3 dark theme
├── database_helper.dart          # SQLite database service
├── models.dart                   # Match, Player, Innings, Ball, Dismissal
├── repositories.dart             # CRUD repositories for all models
├── scoring_services.dart         # Ball scoring, overs, stats, wickets
├── providers.dart                # State management (Score, Match, Player, History)
├── splash_screen.dart            # Splash screen (2-sec intro)
├── home_screen.dart              # Main menu
├── create_match_screen.dart      # Match creation form
├── player_selection_screen.dart  # Playing XI selection
├── toss_screen.dart              # Toss management
├── live_scoring_screen.dart      # Main scoring UI (9 buttons)
├── scorecard_screen.dart         # Match summary & statistics
└── match_history_screen.dart     # Previous matches list
```

## Database Schema 🗄️

- **matches**: Match details (team, opponent, overs, date, venue, toss, status)
- **players**: Player information (name, role: batsman/bowler/allrounder)
- **innings**: Innings data (match, team, runs, wickets, balls)
- **balls**: Ball-by-ball data (over, ball, runs, type, dismissal flag)
- **dismissals**: Dismissal details (batsman, type, bowler, fielder)

## Getting Started 🚀

### Prerequisites
- Flutter 3.12+ installed
- Dart 3.12+ (comes with Flutter)
- Git

### Setup

1. Clone the repository
   ```bash
   git clone https://github.com/eightbits08-ops/dk_popa_11_app.git
   cd dk_popa_11_app
   ```

2. Install dependencies
   ```bash
   flutter pub get
   ```

3. Run the app
   ```bash
   flutter run
   ```

### Build

**Android APK:**
```bash
flutter build apk --release
```

**iOS IPA:**
```bash
flutter build ios --release
```

## Usage Guide 📱

### Quick Start Flow
1. Launch app → Splash screen auto-navigates to home
2. **Home Screen** → Choose "New Match" or "Match History"
3. **Create Match** → Enter opponent, overs, date, venue
4. **Players** → Add team players (batsmen, bowlers, allrounders)
5. **Select XI** → Choose 11 players for this match
6. **Toss** → Confirm toss winner and bat/field choice
7. **Live Scoring** → Tap score buttons to record each ball
   - **0, 1, 2, 3, 4, 6** → Run buttons
   - **Wide, No Ball** → Extra buttons
   - **Wicket** → Opens dismissal dialog
   - **Undo** → Revert last ball
8. **Scorecard** → View match summary after completion
9. **History** → Access all previous scorecards

### Live Scoring Tips
- Tap score buttons rapidly for fast input
- Undo button removes the last ball instantly
- Strike auto-rotates after 6 valid balls
- Dismissals auto-update batting order

## Architecture Details 🏗️

### Layered Architecture
```
Screens (UI Layer)
    ↓
Providers (State Management)
    ↓
Services (Business Logic)
    ↓
Repositories (Data Access)
    ↓
Database (SQLite)
```

### State Management (Provider)
- **ScoreProvider**: Live scoring state (runs, wickets, overs)
- **MatchProvider**: Match creation and management
- **PlayerProvider**: Player list and XI selection
- **HistoryProvider**: Match history queries

### Scoring Logic
- **BallScoringService**: Process score input
- **OverCalculationService**: Track overs (formatted as 3.5)
- **StatsCalculationService**: Player statistics
- **WicketHandlingService**: Dismissal management

## Key Features Implementation 💡

### Automatic Strike Rotation
After 6 valid balls (excluding extras), batsmen automatically swap positions and bowler changes.

### Over Calculation
```
totalBalls ÷ 6 = Overs completed
totalBalls % 6 = Balls in current over
Formatted as: "3.5" (3 overs, 5 balls)
```

### Extras Handling
- Wide: Ball + 1 run, same bowler, same strike
- No Ball: Ball + 1 run, same bowler, same strike
- Bye: No strike change if even runs
- Leg Bye: No strike change if even runs

### Dismissal Types
- Bowled
- LBW (Leg Before Wicket)
- Caught
- Run Out
- Stumped
- Hit Wicket
- Handled Ball

## Testing Checklist ✅

- [ ] App launches without crashes
- [ ] Create new match works
- [ ] Add/delete players works
- [ ] Select XI enforces 11-player limit
- [ ] Toss functionality works
- [ ] Score buttons update correctly
- [ ] Undo removes last ball
- [ ] Over format displays correctly (e.g., 3.5)
- [ ] Strike rotates after each over
- [ ] Wickets increment correctly
- [ ] Scorecard displays match summary
- [ ] Match history stores data
- [ ] Data persists after app restart

## Future Enhancements 🎯

- Partnership analysis
- Detailed batting/bowling statistics
- Player performance analytics across matches
- Export scorecard to PDF
- Team statistics dashboard
- Match replays/analysis
- Multiple innings support
- Player substitutions
- Toss history tracking

## Dependencies 📦

```yaml
provider: ^6.4.0          # State management
sqflite: ^2.3.0           # SQLite database
path: ^1.8.3              # Path utilities
path_provider: ^2.1.1     # Platform-specific directories
intl: ^0.19.0             # Date/time formatting
uuid: ^4.0.0              # Unique ID generation
```

## License 📄

This project is personal software for DK POPA 11 cricket team.

## Support 💬

For issues or feature requests, create an issue in this repository.

---

**Happy Cricket Scoring!** 🏏⭐

Built with ❤️ for DK POPA 11