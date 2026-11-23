# 📬 Postman API Test Suite — Daily Tech Desk

This directory contains the automated API test collection for the **Daily Tech Desk ASP.NET Core** backend service.

---

## 🎯 Test Objectives
1. **Endpoint Health & Status Code Validation:** Validating `200 OK`, `400 Bad Request`, and `404 Not Found` responses.
2. **JSON Schema Integrity:** Ensuring required fields (`id`, `title`, `category`, `sourceName`, `publishedAt`, `articleUrl`) are returned with expected data types.
3. **Pagination & Boundary Testing:** Testing page size clamping, zero/negative page values, and extreme limits.
4. **Category Filtering:** Ensuring articles returned belong to the requested domain tag (e.g. `flutter`, `ai-ml`).
5. **Security & Input Sanitization:** Verifying malicious strings, non-numeric values, and special characters do not trigger unhandled 500 server crashes.

---

## 📁 Files
- **`daily_tech_desk.postman_collection.json`**: Complete Postman v2.1 collection with automated JavaScript test assertions (`pm.test`).
- **`daily_tech_desk_local.postman_environment.json`**: Environment variables for local development (`http://localhost:5000/api`).
- **`daily_tech_desk_render.postman_environment.json`**: Environment variables for deployed Render service.

---

## 🚀 How to Run Tests

### 1. In Postman Desktop App
1. Open Postman.
2. Click **Import** in the top-left corner.
3. Select `daily_tech_desk.postman_collection.json` and the desired environment JSON file.
4. Select the environment from the top-right environment selector.
5. Click the collection name > **Run Collection** to execute the complete test suite.

### 2. Via Newman CLI (Command Line / CI)
Run the collection headlessly with Newman:

```bash
# Run with local environment
npx newman run daily_tech_desk.postman_collection.json -e daily_tech_desk_local.postman_environment.json

# Run with HTML report output
npx newman run daily_tech_desk.postman_collection.json -e daily_tech_desk_render.postman_environment.json --reporters cli,htmlextra
```
