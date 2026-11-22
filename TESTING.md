# 🧪 Quality Assurance & Test Documentation — Daily Tech Desk

This document serves as the master **Test Plan, Test Cases Specification, API Testing Guide, and Defect Tracking Log** for **Daily Tech Desk**. It outlines the QA methodology, test matrix, automated execution suite, and defect verification records.

---

## 📑 Table of Contents
1. [Test Strategy & Test Plan](#1-test-strategy--test-plan)
2. [Test Environment & Tools](#2-test-environment--tools)
3. [Test Cases Matrix & Results (Expected vs. Actual)](#3-test-cases-matrix--results-expected-vs-actual)
   - [Module 1: News Feed](#module-1-news-feed)
   - [Module 2: Category Filtering](#module-2-category-filtering)
   - [Module 3: Pagination & Infinite Scroll](#module-3-pagination--infinite-scroll)
   - [Module 4: Bookmarks & Saved Items](#module-4-bookmarks--saved-items)
   - [Module 5: Offline Mode & Cache Persistence](#module-5-offline-mode--cache-persistence)
4. [API Testing with Postman & Newman](#4-api-testing-with-postman--newman)
5. [Automated Testing Suite (Unit & Widget)](#5-automated-testing-suite-unit--widget)
6. [Defect Tracking & Bug Log (GitHub Issues)](#6-defect-tracking--bug-log-github-issues)
7. [QA Sign-Off & Release Summary](#7-qa-sign-off--release-summary)

---

## 1. Test Strategy & Test Plan

### 1.1 Scope
The scope of testing covers end-to-end verification of the Daily Tech Desk application, spanning:
- **Mobile Client:** Flutter app (UI, navigation, local storage caching, state handling).
- **Backend APIs:** ASP.NET Core (.NET 10) endpoints hosted on Render.
- **Database & External Services:** PostgreSQL (Supabase) integration and NewsAPI ingestion.

### 1.2 Test Levels & Types
- **Unit Testing:** Business logic, BLoC state transitions, and repository abstraction using `bloc_test` and `mocktail`.
- **Widget Testing:** UI layout, interactive components, responsive rendering, and button taps using `flutter_test`.
- **API Testing:** Automated Postman test collections with JavaScript assertions for status codes, schemas, and error boundaries.
- **Integration & System Testing:** End-to-end user journeys including offline capability and persistence across app restarts.
- **Regression Testing:** Automated verification via GitHub Actions CI on every code push and pull request.

### 1.3 Entry & Exit Criteria
- **Entry Criteria:** Latest build compiles with 0 compilation errors; backend API endpoints reachable.
- **Exit Criteria:** 100% automated unit and widget test pass rate; all High/Critical severity defects verified as resolved; manual acceptance test suite completed.

---

## 2. Test Environment & Tools

| Category | Tool / Framework | Purpose |
|---|---|---|
| **Unit & State Testing** | `bloc_test: ^10.0.0`, `mocktail: ^1.0.5` | BLoC/Cubit event handling and repository mocking |
| **Widget Testing** | `flutter_test` (Flutter SDK) | Component rendering, gestures, and UI assertions |
| **API Testing** | Postman v10+ & Newman CLI | REST API assertions, schema checking, and boundary tests |
| **CI/CD Automation** | GitHub Actions (`flutter_ci.yml`) | Automated build, static analysis, and test runs on push/PR |
| **Defect Tracking** | GitHub Issues & Bug Report Template | Defect logging, triage, reproduction, and re-testing |
| **Test Devices** | Pixel 7 (Android 14), Galaxy S22, Chrome Web | Cross-platform functional validation |

---

## 3. Test Cases Matrix & Results (Expected vs. Actual)

### Module 1: News Feed

| Test ID | Test Description | Preconditions | Steps | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|:---:|
| `TC-FEED-001` | Initial feed load on startup | Device connected to internet | Launch application and land on Home Page | Displays loading indicator then renders initial 10 articles with title, category chip, source, and image | Initial 10 articles rendered correctly with all metadata | **PASS** |
| `TC-FEED-002` | Pull-to-refresh feed update | App open on Home Feed | Perform pull-down gesture on article list | Refresh indicator triggers; latest articles fetched; feed updates smoothly | Feed reloads with fresh timestamp and updated articles | **PASS** |
| `TC-FEED-003` | Empty state display | API returns empty article list | Launch feed with no articles available | User-friendly empty state screen displayed with retry button | "No articles found" empty state rendered gracefully | **PASS** |
| `TC-FEED-004` | Article tap navigation | Article displayed on feed | Tap on article card | App navigates to Article Details screen showing full article info and original URL link | Navigated to `ArticleDetailsPage` with corresponding article data | **PASS** |

---

### Module 2: Category Filtering

| Test ID | Test Description | Preconditions | Steps | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|:---:|
| `TC-CAT-001` | Filter by specific category (e.g. Flutter) | Home page open | Tap "Flutter" category chip in filter bar | Feed updates showing only Flutter articles; selected chip highlighted | Only articles tagged with 'Flutter' displayed; chip highlighted | **PASS** |
| `TC-CAT-002` | Switch between multiple categories | Category filter active | Tap "AI/ML", then "Cybersecurity" chips | Feed re-filters quickly; previous category articles replaced by newly selected category | Instant filter transition without UI flicker | **PASS** |
| `TC-CAT-003` | Reset filter to "All" feed | Filter active | Tap on active category chip again or select "All" | Feed resets to show all technology topics; all filter chips return to default state | All articles restored; filter set to null | **PASS** |
| `TC-CAT-004` | Category with zero articles | Backend has no records for query | Select a sparse category | Shows informative "No articles found in this category" placeholder | Informative empty message shown with reset option | **PASS** |

---

### Module 3: Pagination & Infinite Scroll

| Test ID | Test Description | Preconditions | Steps | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|:---:|
| `TC-PAG-001` | Incremental page load on scroll | Feed loaded with page 1 | Scroll to the bottom of the list | Bottom loading indicator appears; page 2 (next 10 articles) appended to feed | Next 10 articles seamlessly appended without scrolling jumping | **PASS** |
| `TC-PAG-002` | Duplicate article check across pages | Rapid scrolling down feed | Scroll through pages 1, 2, and 3 | Article IDs in feed remain unique; no duplicates displayed | All rendered articles have unique IDs | **PASS** |
| `TC-PAG-003` | End of feed boundary handling | Last available page reached | Scroll to end of catalog | Loading indicator stops; "You're all caught up" footer indicator appears | Clean end-of-list reached; no redundant API calls made | **PASS** |
| `TC-PAG-004` | Pagination network failure | Page 1 loaded, network interrupted | Scroll down to trigger page 2 load | Floating snackbar / banner notifies user of fetch failure with "Retry" option | Error banner displayed; existing items preserved | **PASS** |

---

### Module 4: Bookmarks & Saved Items

| Test ID | Test Description | Preconditions | Steps | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|:---:|
| `TC-BM-001` | Bookmark an article from feed | Article visible in feed | Tap bookmark outline icon on article card | Icon immediately changes to filled bookmark; article added to saved articles list | Icon state toggles to `Icons.bookmark_rounded`; saved in state | **PASS** |
| `TC-BM-002` | Unbookmark an article from feed | Article already saved | Tap filled bookmark icon on article card | Icon reverts to outline bookmark; article removed from saved list | Article removed from state; icon returns to outline | **PASS** |
| `TC-BM-003` | Verify saved items screen | 2 articles bookmarked | Open drawer > tap "Saved Articles" | Both saved articles appear in list with correct titles and source | Exact 2 bookmarked articles displayed in Saved Items view | **PASS** |
| `TC-BM-004` | Persistence across app restart | Articles saved in local storage | Force close app, relaunch | Previously bookmarked articles remain saved and visible in Saved Items | Articles successfully reloaded from `SharedPreferences` cache | **PASS** |

---

### Module 5: Offline Mode & Cache Persistence

| Test ID | Test Description | Preconditions | Steps | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|:---:|
| `TC-OFF-001` | App startup in offline mode | Device in Airplane Mode (No Wi-Fi/Cellular) | Launch application from cold start | Shows offline indicator; cached feed or empty offline screen with helpful retry prompt | Offline banner displayed; app does not crash or freeze | **PASS** |
| `TC-OFF-002` | Offline access to saved articles | 3 articles saved prior to going offline | Switch device to Airplane Mode > Open "Saved Articles" | All 3 saved articles are fully accessible and readable offline | Full article text and cached images rendered offline | **PASS** |
| `TC-OFF-003` | Feed pull-to-refresh while offline | Offline mode active | Pull down on Home screen | Shows toast/snackbar "No internet connection. Please check your network." | SnackBar alert shown; existing displayed articles remain intact | **PASS** |
| `TC-OFF-004` | Automatic recovery on network restoration | Device was in offline mode | Disable Airplane Mode / Reconnect Wi-Fi | App detects network recovery or allows tap-to-retry to fetch fresh articles | Connection re-established; fresh feed loads on retry | **PASS** |

---

## 4. API Testing with Postman & Newman

Automated API test collections are located in [`postman/`](postman/):
- **Collection:** `postman/daily_tech_desk.postman_collection.json`
- **Environments:** Local (`localhost:5000`) and Production (`Render`).

### Summary of API Test Coverage:
1. `GET /api/articles?page=1&pageSize=10`:
   - Validates status code `200 OK`.
   - Validates response time `< 2000ms`.
   - Asserts `Content-Type: application/json`.
   - Checks JSON schema: `articles` array containing `id`, `title`, `category`, `sourceName`, `publishedAt`, and `articleUrl`.
2. `GET /api/articles/{category}`:
   - Validates category filtering logic (all returned items contain requested category tag).
   - Validates handling of non-existent categories (returns empty array `[]` or `404`).
3. `GET /api/articles/daily-digest`:
   - Validates schema and `readingTimeMinutes >= 1`.
4. **Boundary & Negative Testing:**
   - Negative page parameter `?page=-1`: Asserts `400 Bad Request`.
   - String page parameter `?page=abc`: Asserts `400 Bad Request`.
   - Page size overflow `?pageSize=99999`: Asserts safe clamping to server limit (max 50) or `400 Bad Request`.
   - Malformed SQL injection parameter `' OR 1=1--`: Asserts server does NOT crash with `500 Internal Server Error`.

---

## 5. Automated Testing Suite (Unit & Widget)

All automated tests are written using `bloc_test`, `mocktail`, and `flutter_test`:

```text
test/
├── unit/
│   ├── feed_filter_cubit_test.dart    # Category filter state transitions
│   ├── news_bloc_test.dart            # NewsBloc events (LoadNews, LoadCategoryNews, Error handling)
│   ├── news_repository_test.dart      # NewsRepositoryImpl with Mockito/mocktail & JSON parsing
│   └── saved_articles_cubit_test.dart # Bookmark persistence & SharedPreferences mock
└── widget/
    ├── news_card_widget_test.dart     # UI component test (title, category chip, bookmark toggle, taps)
    └── widget_test.dart               # App bootstrap smoke test
```

### Running Tests Locally:
```bash
# Execute entire test suite
flutter test

# Execute with detailed test reporter
flutter test --reporter expanded

# Run with test coverage
flutter test --coverage
```

**Test Execution Result:** `26 passed (100% pass rate)`.

---

## 6. Defect Tracking & Bug Log (GitHub Issues)

Defects discovered during testing cycles were logged and tracked using the GitHub Issue template ([`.github/ISSUE_TEMPLATE/bug_report.md`](.github/ISSUE_TEMPLATE/bug_report.md)):

### Defect 1: Duplicate Articles Appended on Rapid Pagination
- **Defect ID:** `BUG-001`
- **Severity:** High | **Priority:** High
- **Module:** News Feed / Pagination
- **Steps to Reproduce:**
  1. Open app and scroll down vigorously on Home screen.
  2. Continue triggering pagination before previous page completes loading.
- **Expected Result:** Page requests are debounced or filtered by unique article ID.
- **Actual Result:** Articles from page 2 were appended multiple times, causing duplicate entries in the list.
- **Root Cause:** Scroll listener did not guard against in-flight requests (`isLoading` flag was not checked before emitting new page request).
- **Resolution & Retest:** Added `isLoading` concurrency check in pagination controller. **Retested on build v0.1.0+1 — VERIFIED FIXED.**

---

### Defect 2: Bookmark State Lost on Cold App Restart in Offline Mode
- **Defect ID:** `BUG-002`
- **Severity:** Critical | **Priority:** High
- **Module:** Bookmarks / Local Storage
- **Steps to Reproduce:**
  1. Bookmark 3 articles while online.
  2. Put device into Airplane Mode.
  3. Force kill the app from task manager.
  4. Relaunch app while still offline and check Saved Articles.
- **Expected Result:** Saved articles load directly from local `SharedPreferences` cache.
- **Actual Result:** Saved Articles list was empty upon cold restart.
- **Root Cause:** `_saveArticles()` call in cubit was unawaited before app lifecycle paused, leading to incomplete disk write.
- **Resolution & Retest:** Ensured `SharedPreferences` writes are properly awaited and loaded during app bootstrap in `main.dart`. **Retested on build v0.1.0+1 — VERIFIED FIXED.**

---

### Defect 3: API Endpoint Returned 500 on Negative Page Number Parameter
- **Defect ID:** `BUG-003`
- **Severity:** Medium | **Priority:** High
- **Module:** ASP.NET Core API / Articles Controller
- **Steps to Reproduce:**
  1. Send `GET /api/articles?page=-1&pageSize=10` via Postman.
- **Expected Result:** API returns `400 Bad Request` with structured validation message.
- **Actual Result:** API returned `500 Internal Server Error` due to unhandled `ArgumentOutOfRangeException` in LINQ `.Skip(-10)`.
- **Root Cause:** Missing model validation annotation `[Range(1, int.MaxValue)]` on `page` query parameter.
- **Resolution & Retest:** Added validation filter to ASP.NET Core controller. **Retested in Postman collection — VERIFIED FIXED.**

---

### Defect 4: Bookmark Icon Visual State Desync on Screen Pop
- **Defect ID:** `BUG-004`
- **Severity:** Minor | **Priority:** Medium
- **Module:** UI / Widget State
- **Steps to Reproduce:**
  1. Open an article into Article Details view.
  2. Bookmark article from details view.
  3. Press back button to return to Home Feed.
- **Expected Result:** Home feed card immediately reflects the filled bookmark icon.
- **Actual Result:** Card retained the outline icon until feed was manually scrolled.
- **Root Cause:** Home feed card was not listening to `SavedArticlesCubit` state stream.
- **Resolution & Retest:** Wrapped bookmark icon with `BlocBuilder<SavedArticlesCubit, SavedArticlesState>`. **Retested — VERIFIED FIXED.**

---

## 7. QA Sign-Off & Release Summary

| Metric | Target | Actual Result | Status |
|---|---|---|:---:|
| **Automated Unit Tests** | >= 15 | 20 passed | ✅ **MET** |
| **Automated Widget Tests** | >= 5 | 6 passed | ✅ **MET** |
| **API Automated Tests** | >= 8 | 10 passed | ✅ **MET** |
| **Manual Test Cases** | 20 | 20 executed (20 Passed) | ✅ **MET** |
| **Open Critical/High Bugs** | 0 | 0 open (all resolved & verified) | ✅ **MET** |
| **CI/CD Build & Test Status** | Green | Green on GitHub Actions | ✅ **MET** |

**QA Approval Status:** **APPROVED FOR PRODUCTION RELEASE (v0.1.0+1)**
