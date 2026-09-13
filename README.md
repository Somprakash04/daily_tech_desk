# 📱 Daily Tech Desk

A personal technology news desk for students and developers — built with **Flutter**, **ASP.NET Core**, **PostgreSQL (Supabase)**, and **NewsAPI**.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white)
![.NET](https://img.shields.io/badge/.NET%2010-512BD4?style=flat&logo=dotnet&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=flat&logo=postgresql&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3FCF8E?style=flat&logo=supabase&logoColor=white)
![Render](https://img.shields.io/badge/Deployed%20on-Render-46E3B7?style=flat&logo=render&logoColor=white)

🔗 **Live Demo:** [your-demo-link-here](#)

---

## 🎥 Demo

<!-- Replace with your actual video link, or an embedded GIF -->
[![Watch the demo](docs/screenshots/thumbnail.png)](https://your-video-link-here)

## 📸 Screenshots

<p align="center">
  <img src="docs/screenshots/home_dark_mode.jpeg" width="200" />
  <img src="docs/screenshots/personalized.jpeg" width="200" />
  <img src="docs/screenshots/drawer.jpeg" width="200" />
</p>
<p align="center">
  <img src="docs/screenshots/home_light_mode.jpeg" width="200" />
  <img src="docs/screenshots/daily_digest.jpeg" width="200" />
  <img src="docs/screenshots/saved_article.jpeg" width="200" />
</p>

---

## 🎯 About

Daily Tech Desk gives students and developers a personalized technology feed — covering AI/ML, Flutter, programming, cloud, cybersecurity, DevOps, big tech, startups, open source, and web development — instead of requiring manual searching.

---

## 🛠 Tech Stack

**Frontend:** Flutter, Dart, BLoC/Cubit, GoRouter, Dio, SharedPreferences
**Backend:** ASP.NET Core (.NET 10), Entity Framework Core, Npgsql
**Database:** PostgreSQL (Supabase)
**External API:** NewsAPI
**Deployment:** Render (API) · Supabase (DB)

---

## 🏗 Architecture

```text
Flutter App  --HTTPS-->  ASP.NET Core API (Render)  --->  PostgreSQL (Supabase)
                                                    --->  NewsAPI
```

The NewsAPI key stays server-side — the Flutter app never accesses it directly.

---

## ✨ Features

- Personalized technology feed with category filtering
- Daily Digest of the day's top tech news
- Bookmark / save articles (persisted locally via `SharedPreferences`)
- Offline access to saved articles
- Share & open original article links
- Light/dark theme support

---

## 🔌 API Endpoints

| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/api/articles` | Paginated technology articles |
| `GET` | `/api/articles/{category}` | Articles filtered by category |
| `GET` | `/api/articles/daily-digest` | Today's technology digest |

All support `?page=1&pageSize=20` pagination.

---

## 💻 Running Locally

**Backend**
```bash
dotnet restore
dotnet run
```
Set your PostgreSQL connection string via user secrets:
```bash
dotnet user-secrets set "ConnectionStrings:DefaultConnection" "Host=...;Database=...;Username=...;Password=..."
```

**Flutter**
```bash
flutter pub get
flutter run
```
Point `app_config.dart` to your local API URL (development only) or the deployed Render URL (production).

---

## 📊 Status

| Component | Status |
|---|---|
| Frontend / Backend / DB | ✅ Done |
| NewsAPI integration | ✅ Done |
| Daily Digest & Saved Items | ✅ Done |
| Deployment (Render) | 🔄 In progress |
| Play Store publishing | ⏳ Next |

---

<p align="center">Built with ❤️ using Flutter, ASP.NET Core, PostgreSQL & Supabase.</p>