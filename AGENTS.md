# AGENTS.md — hugo-kusandriadi

Panduan ini ditujukan untuk AI coding agents (Claude Code, Cursor, Codex, dll.) yang bekerja di repository ini. Tujuannya: memberi konteks yang cukup agar agent bisa mengambil keputusan yang tepat tanpa perlu bertanya berulang.

> **Catatan kerja:** Project ini ditulis dengan campuran Bahasa Indonesia dan Inggris (terutama di posts). Tetap pertahankan gaya bahasa per-artikel — jangan menerjemahkan post dari Bahasa Indonesia ke Inggris atau sebaliknya kecuali diminta.

---

## 1. Ringkasan Project

- **Nama:** `hugo-kusandriadi`
- **Tipe:** Static site source — Hugo
- **URL produksi:** https://kusandriadi.com
- **Hosting:** GitHub Pages via repo terpisah `kusandriadi/kusandriadi.github.io` (custom domain `kusandriadi.com` via CNAME)
- **Hugo version:** `0.161.1` extended (lihat `.github/workflows/deploy.yml`)
- **Theme:** [`hugo-theme-minos`](https://github.com/carsonip/hugo-theme-minos) (di-vendor di `themes/hugo-theme-minos/`)
- **Author:** Kus Andriadi (`me[at]kusandriadi[dot]com`)
- **Bahasa konten:** Bahasa Indonesia & English (mixed, per-post)

Repo ini adalah **sumber** (source). Output statis yang dihasilkan Hugo dipublish ke repo lain (`kusandriadi.github.io`). Jangan campur aduk keduanya.

---

## 2. Struktur Direktori

```
hugo-kusandriadi/
├── .github/workflows/deploy.yml   # GH Actions: build + push ke kusandriadi.github.io
├── .gitmodules                    # Submodule: public/ -> kusandriadi.github.io.git (legacy, lihat §6)
├── .gitignore                     # /public, /_test-build, resources/_gen/, .hugo_build.lock, .DS_Store
├── archetypes/
│   └── default.md                 # Template front matter untuk `hugo new`
├── config.toml                    # Konfigurasi utama Hugo (baseURL, menu, params, taxonomies, dll.)
├── content/
│   ├── about/_index.md            # Halaman /about/
│   └── posts/                     # Artikel blog (format: YYYYMMDD-slug.md)
├── deploy.sh                      # Skrip deploy manual (legacy — workflow GH Actions adalah cara resmi)
├── layouts/                       # Override theme: index, single, list, partials, section
│   ├── 404.html
│   ├── index.html                 # Homepage (dengan sidebar AI feed dari kusandriadi.com/ai-blog)
│   ├── robots.txt
│   ├── _default/{list,single}.html
│   ├── partials/{head,meta,seo,footer,article}.html
│   └── section/about.html
├── public/                        # (gitignored) Output Hugo, juga didefinisikan sebagai submodule legacy
├── resources/                     # (gitignored isi _gen) Cache Hugo
├── static/                        # Asset statis: css/, images/
└── themes/hugo-theme-minos/       # Theme vendored (bukan submodule)
```

### File yang sering disentuh
- `content/posts/*.md` — menambah/edit artikel
- `config.toml` — konfigurasi site, menu, taxonomies
- `layouts/index.html` — homepage layout (sidebar AI feed)
- `layouts/partials/*.html` — head, meta, seo, footer, article
- `.github/workflows/deploy.yml` — CI deploy

### File yang **jarang** disentuh (hati-hati)
- `themes/hugo-theme-minos/**` — theme upstream; lebih baik override via `layouts/` di root daripada modifikasi theme
- `deploy.sh` — sudah digantikan oleh GH Actions, biarkan kecuali user explicit minta

---

## 3. Konvensi Konten

### Penamaan file post
Format: `YYYYMMDD-slug-kebab-case.md` (lihat `content/posts/`).
- Tanggal di filename adalah **tanggal asli artikel**, bukan tanggal commit.
- Slug pakai lowercase + dash, tanpa spasi/underscore.
- Contoh valid: `20210721-deploy-and-manage-mongodb-with-docker.md`

### Front matter
Template default di `archetypes/default.md`:
```yaml
---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true
---
```

Front matter yang umum dipakai di repo ini:
```yaml
---
title: "Judul Artikel"
date: 2021-07-20T16:55:31+07:00
tags: ["Hugo", "DevOps"]            # optional, taxonomies = tag
description: "Ringkasan untuk SEO"   # optional, dipakai di partials/seo.html
featuredImage: "/images/foo.jpg"     # optional, di-render di homepage card
hidden: false                        # set "true" untuk sembunyikan dari paginator homepage
draft: false                         # WAJIB false sebelum publish
---
```

### Permalink
Dari `config.toml`:
```
[permalinks]
  posts = "/:section/:title/"
```
Artinya post `content/posts/foo.md` → `https://kusandriadi.com/posts/foo/`.
Title-slug dihasilkan dari `title` di front matter (di-slugify oleh Hugo), **bukan** dari filename. Kalau mau permalink stabil, set `slug:` di front matter.

### Konvensi tulisan
- **Read more break:** gunakan `<!--more-->` untuk memotong summary di homepage (lihat `20190530-hello-hugo.md`).
- **Mixed language OK:** beberapa post English, beberapa Bahasa Indonesia. Jangan paksa konsistensi.
- **Markdown unsafe HTML:** sudah diaktifkan (`markup.goldmark.renderer.unsafe = true`), jadi raw HTML di markdown akan di-render. Hati-hati dengan content user-generated.
- **Tags:** taxonomy `tag = "tags"`. Gunakan array di front matter.

---

## 4. Command Workflow

### Lokal development
```bash
# preview dengan draft
hugo server -D

# preview produksi (skip draft, future, expired)
hugo server

# bind ke 0.0.0.0 (akses dari device lain di jaringan)
hugo server --bind 0.0.0.0 --baseURL http://<lan-ip>:1313
```
Default port: `1313`. Live reload aktif.

### Build
```bash
# build penuh (sama dengan yang dipakai di CI)
hugo --minify --gc

# build dengan theme explicit (legacy, dari deploy.sh)
hugo -t hugo-theme-minos
```

### Membuat post baru
```bash
hugo new posts/YYYYMMDD-slug.md
# lalu edit file, set draft: false sebelum commit
```

### Deploy
**Cara resmi (saat ini):** Push ke branch `master` atau `main` → GH Actions di `.github/workflows/deploy.yml` otomatis build dengan Hugo 0.161.1 extended dan push ke `kusandriadi/kusandriadi.github.io@master` (publish_dir: `./public`, cname: `kusandriadi.com`).

Workflow juga ber-trigger:
- Setiap push ke `master`/`main`
- Cron `15 */6 * * *` (tiap 6 jam, untuk refresh sidebar AI feed yang fetch remote JSON saat build)
- `workflow_dispatch` (manual)

**Cara legacy (`deploy.sh`):** Hanya pakai kalau user explicit minta. Skrip ini build → cd public → git commit & push. Memerlukan `public/` sebagai submodule git valid.

---

## 5. Sidebar AI Feed (penting)

Homepage (`layouts/index.html`) fetch remote JSON saat **build-time** (bukan runtime):
```
{{ $url := "https://kusandriadi.com/ai-blog/data/posts.json" }}
{{ with try (resources.GetRemote $url) }}
```
Implikasi:
- Sidebar **stale** sampai site di-rebuild → ini alasan cron 6-jam-an di workflow.
- Kalau remote JSON down, fallback render: "AI feed unavailable right now." Build tetap success.
- Saat dev lokal, sidebar boleh kosong/error — tidak perlu di-fix kecuali user keluhkan.

---

## 6. Submodule `public/` (legacy — JANGAN sentuh)

`.gitmodules` masih mendefinisikan `public/` sebagai submodule menuju `kusandriadi.github.io.git@master`. Ini **sisa workflow lama** (sebelum GH Actions). Sekarang:
- `public/` masuk `.gitignore` → diabaikan saat commit ke source repo.
- GH Actions menggunakan `peaceiris/actions-gh-pages@v4` untuk push (bukan submodule push).
- Jangan jalankan `git submodule update` di CI — tidak diperlukan.
- Jangan hapus `.gitmodules` tanpa konfirmasi user — masih dipakai oleh `deploy.sh` legacy.

Kalau perlu lihat hasil build untuk debugging, bisa `hugo` lokal lalu inspect `public/` (gitignored).

---

## 7. Theme & Layout Override

`hugo-theme-minos` di-vendor (bukan submodule), tapi convention Hugo: **layout di root (`layouts/`) mengoverride layout dari theme** dengan path yang sama.

Contoh yang sudah di-override di repo ini:
- `layouts/index.html` → homepage custom dengan sidebar AI feed (tidak ada di theme upstream)
- `layouts/_default/single.html` → tambahan GraphComment embed (`graphcomment_id: 'kusandri-id'`)
- `layouts/partials/seo.html` → JSON-LD structured data

**Aturan:** Kalau mau tweak tampilan, edit di `layouts/` root, jangan di `themes/hugo-theme-minos/`. Itu membuat upgrade theme jadi merge conflict.

---

## 8. Konfigurasi yang Worth Knowing

Dari `config.toml`:
- `baseURL = "https://kusandriadi.com/"` — harus diakhiri slash
- `googleAnalytics = "UA-141670233-1"` — UA properti (legacy GA, bukan GA4). Kalau user minta migrasi ke GA4 (`G-XXXXXXX`), update sini.
- `enableEmoji = true` — `:smile:` di markdown akan di-render
- `canonifyurls = true` — semua URL relatif diubah jadi absolute
- `showShareIcons = true` — flag custom theme
- Menu utama: About, Resources (dropdown: Computer Science, AI Blog, Jadwal Sholat Indonesia, Elcompia). Resources items adalah link ke subpath `kusandriadi.com/*` yang **bukan** dihandle repo ini — itu microsite/app terpisah.

---

## 9. Untuk Agent: Do's & Don'ts

**Do:**
- ✅ Tambah/edit post di `content/posts/` dengan format penamaan `YYYYMMDD-slug.md`.
- ✅ Pertahankan campuran Bahasa Indonesia/Inggris per-post — jangan auto-translate.
- ✅ Set `draft: false` saat artikel siap publish; jangan tinggalkan `draft: true` kalau user bilang sudah selesai.
- ✅ Override layout di `layouts/` root, bukan di `themes/`.
- ✅ Test lokal dengan `hugo server -D` sebelum claim "selesai" kalau memungkinkan.
- ✅ Convert tanggal relatif user ("kemarin", "minggu lalu") ke absolute `YYYY-MM-DDTHH:MM:SS+07:00` (WIB) saat menulis front matter.

**Don't:**
- ❌ Jangan commit `public/`, `resources/_gen/`, `.hugo_build.lock`, `.DS_Store` — sudah di-gitignore.
- ❌ Jangan edit file di repo `kusandriadi.github.io` secara manual untuk fix tampilan — itu output, akan tertimpa di build berikutnya. Fix di source ini.
- ❌ Jangan modifikasi `themes/hugo-theme-minos/**` kalau bisa override di `layouts/`.
- ❌ Jangan ganti Hugo version di `deploy.yml` tanpa test lokal — theme mungkin tidak compatible dengan versi lain.
- ❌ Jangan hapus `.gitmodules` atau `deploy.sh` tanpa konfirmasi — legacy tapi masih ter-referensi.
- ❌ Jangan hardcode AI feed JSON ke layout — itu sengaja remote fetch via cron rebuild.
- ❌ Jangan auto-commit dengan pesan "rebuilding site" — itu format legacy `deploy.sh`, sekarang GH Actions handle commit message sendiri.

---

## 10. Troubleshooting Cepat

| Gejala | Kemungkinan & Cara Cek |
|---|---|
| Post baru tidak muncul di homepage | (a) `draft: true` belum diubah, (b) `date:` di masa depan, (c) `hidden: "true"` di front matter, (d) belum di-rebuild |
| Sidebar AI feed kosong di production | Remote JSON `kusandriadi.com/ai-blog/data/posts.json` down — bukan masalah Hugo. Tunggu cron rebuild atau trigger `workflow_dispatch` |
| Build fail di GH Actions | Cek version Hugo (0.161.1 extended), cek apakah ada partial yang reference param yang tidak ada di front matter post |
| URL post tidak sesuai expectation | Cek `[permalinks]` di `config.toml` + title slug di front matter |
| Theme tampilan rusak setelah edit | Pastikan editing di `layouts/` root, bukan di `themes/` — atau ada partial yang ke-rename |
| `hugo server` error "module not found" | Hugo dipakai dalam mode legacy theme (non-Hugo-Modules). Cukup pastikan `themes/hugo-theme-minos/` ada |

---

## 11. Konteks Tambahan (yang sering ditanya)

- **Kenapa ada dua repo?** `hugo-kusandriadi` = source markdown + theme + layout. `kusandriadi.github.io` = HTML hasil build yang di-serve GitHub Pages dengan custom domain. Pemisahan ini umum di Hugo + GH Pages.
- **Kenapa GraphComment, bukan Disqus?** Sudah set di `layouts/_default/single.html` (`graphcomment_id: 'kusandri-id'`). Theme support Disqus via `site.Config.Services.Disqus.Shortname` tapi tidak di-enable.
- **Kenapa di config.toml ada menu link ke kusandriadi.com/cs, /ai-blog, /salat-time, /elcompia?** Itu microsite/app terpisah yang di-host di subpath domain yang sama. Bukan tanggung jawab repo ini — jangan coba bikin halaman Hugo untuk itu.
- **Google Analytics masih UA-?** Ya, UA-141670233-1. Kalau user minta upgrade ke GA4, butuh property GA4 baru + ganti di `config.toml`.

---

## 12. Saat Commit/PR

- Pesan commit pendek, Imperative mood OK (Indonesian/English bebas).
- Tidak ada pre-commit hooks di repo ini.
- Branch utama: `master` (CI juga listen ke `main` untuk safety).
- Push ke `master`/`main` = auto-deploy ke production. **Hati-hati**, tidak ada staging environment. Kalau ragu, test lokal dulu (`hugo server`).
