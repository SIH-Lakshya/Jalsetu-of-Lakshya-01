# Jalsetu Mobile App Design

## 1. High‑level Architecture
```
┌───────────────────────┐
│  Flutter (Dart) App   │
│  ├─ UI Layer          │
│  ├─ Feature Modules  │
│  │   ├─ Auth         │
│  │   ├─ Observations │
│  │   ├─ Map          │
│  │   ├─ Interventions│
│  │   ├─ Sync         │
│  │   └─ Reports      │
│  ├─ Core Services     │
│  │   ├─ API Client   │
│  │   ├─ Auth Manager │
│  │   ├─ DB Manager   │
│  │   └─ Location     │
│  └─ Utilities         │
└───────────────────────┘
        │
        ▼
┌───────────────────────┐
│  FastAPI Backend       │
│  ├─ Auth (JWT)         │
│  ├─ Observations API   │
│  ├─ Interventions API │
│  ├─ Layers API         │
│  ├─ Sync API           │
│  └─ Reports API        │
└───────────────────────┘
        │
        ▼
┌───────────────────────┐
│  PostgreSQL + PostGIS │
└───────────────────────┘
        │
        ▼
┌───────────────────────┐
│  AWS S3 (Object Store) │
└───────────────────────┘
        │
        ▼
┌───────────────────────┐
│  GeoServer (WMS/WMTS) │
└───────────────────────┘
```

## 2. Core Screens & Flow

| Screen | Purpose | Key UI Elements |
|--------|---------|-----------------|
| **Splash / Onboarding** | App launch, show branding | Logo, tagline, progress indicator |
| **Login / Sign‑up** | Auth | Email/Password, Google Sign‑in, role selector |
| **Home / Dashboard** | Overview | Quick‑access cards: New Observation, Map, Sync Queue, Reports |
| **Watershed Selector** | Choose area | List of watersheds, search, filter |
| **Observation Form** | Capture field data | GPS status, photo picker, text fields, status dropdown |
| **Photo Review** | Inspect captured photos | Thumbnail grid, map pin, metadata |
| **Map View** | Visualize data | Map widget, layer toggles, markers, pop‑ups |
| **Intervention List** | Track interventions | List, status badge, details button |
| **Report Viewer** | Export & view reports | PDF viewer, share button |
| **Sync Queue** | Offline sync status | List of pending uploads, retry button |
| **Settings** | App preferences | Theme, account, data usage |

## 3. Data Flow
1. **Capture**
   - User opens Observation Form → GPS location fetched → Photo taken → Data stored locally (SQLite) → UI shows “Draft”.
2. **Sync**
   - Background service checks connectivity → Queued items sent to `/observations` API → On success, mark as uploaded, delete local draft.
3. **Map**
   - Map screen requests `/watersheds/{id}/layers` → GeoServer returns WMS tiles → Render on map → User taps marker → Pop‑up shows observation details + photo thumbnails.
4. **Reports**
   - User selects date range → API `/reports` generates PDF → App downloads via S3 presigned URL → Display in PDF viewer.

## 4. State Management
- Use **Riverpod** for dependency injection and state.
- Separate **Feature Providers** for Auth, Observations, Map, Sync, Reports.
- Local persistence via **Drift** (SQLite) for offline drafts and sync queue.
- Remote data via **Dio** HTTP client with interceptors for JWT.

## 5. Offline Strategy
- All writes go to local DB first.
- Sync service runs every 5 min or on connectivity change.
- Conflict resolution: last‑write‑wins with manual merge UI if needed.
- GPS accuracy displayed; if below threshold, prompt user to move.

## 6. Security
- JWT tokens stored in secure storage (`flutter_secure_storage`).
- Photos encrypted at rest in S3 (server‑side encryption).
- Role‑based access enforced on API endpoints.

## 7. Testing Strategy
| Layer | Tests |
|-------|------|
| UI | Widget tests for each screen |
| Feature | Integration tests for Observation flow |
| Backend | Unit tests for API endpoints, integration tests with test DB |
| Sync | Mock connectivity to test retry logic |
| GIS | Validate layer rendering with sample GeoServer tiles |

## 8. Milestone Roadmap (High‑level)
| Sprint | Focus |
|--------|-------|
| 1 | Project scaffolding, auth, splash |
| 2 | Observation form, local DB |
| 3 | Sync service, offline queue |
| 4 | Map integration, layer toggles |
| 5 | Interventions list, status |
| 6 | Reports generation, PDF viewer |
| 7 | Sync queue UI, retry logic |
| 8 | Polish, performance, CI/CD |

---

**Next step:** Create the Flutter project skeleton and set up the core modules (Auth, Observations, Map). Then implement the Observation form and local persistence. This will give a working MVP that can be iterated on.
