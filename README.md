# 🌱 EcoLove-Mobile

> *"Love Me Again"* — *"From the people, by the people, for the people"*

---

## 👥 Nama Anggota & NPM

| Nama Lengkap | NPM |
| :--- | :---: |
| **Maurilla Maharani Nur Abdul** | `2506588374` |
| **David Mesakh** | `2506604503` |
| **Qanita Syafika** | `2506551996` |
| **Karen Lim** | `2506623982` |
| **Sayyid Aqil Kusuma** | `2506596331` |

---

## 📖 Deskripsi Aplikasi

**EcoLove-Mobile** adalah aplikasi mobile marketplace dari EcoLove yang mempertemukan masyarakat untuk menjual, membeli, dan menemukan barang maupun kegiatan yang mendukung gaya hidup berkelanjutan.

Melalui EcoLove, pengguna dapat memberikan kesempatan kedua kepada barang-barang yang masih layak digunakan, seperti pakaian preloved, perabot, buku, alat elektronik, wadah pakai ulang, produk upcycle, serta berbagai barang ramah lingkungan lainnya. Konsep tersebut direpresentasikan melalui tagline **“Love Me Again”**, yaitu mengajak pengguna untuk kembali menghargai dan memperpanjang masa pakai suatu barang.

Berbeda dari marketplace umum, EcoLove berfokus pada barang dan aktivitas yang memiliki nilai keberlanjutan. Setiap barang dapat dilengkapi dengan kategori dan *sustainability tags*, seperti:
* `preloved`
* `reusable`
* `recycled`
* `upcycled`
* `refillable`
* `repairable`
* `locally made`
* `low-waste`

Selain marketplace, EcoLove menyediakan informasi kegiatan bertema lingkungan, seperti acara pertukaran barang, workshop perbaikan, bazar barang bekas, kegiatan bersih-bersih, dan webinar. Pengguna juga dapat membaca serta membagikan konten edukasi mengenai konsumsi sadar, perawatan barang, daur ulang, dan gaya hidup minim sampah.

EcoLove mengusung konsep **“From the people, by the people, for the people”** karena konten dan aktivitas di dalam aplikasi berasal dari kontribusi masyarakat. Pengguna dapat menjadi pembeli, penjual, penyelenggara kegiatan, pemberi ulasan, maupun kontributor konten edukasi dalam satu akun yang sama.

---

## 🧩 Daftar Modul & PIC

| Modul | Person in Charge (PIC) | NPM |
| :--- | :--- | :---: |
| **Auth-Profile-User** | Qanita Syafika | `2506551996` |
| **Event + Education** | David Mesakh | `2506604503` |
| **Item** | Karen Lim | `2506623982` |
| **Review** | Sayyid Aqil Kusuma | `2506596331` |
| **Transaction + Payment** | Maurilla Maharani Nur Abdul | `2506588374` |

---

## 🎭 User Role & Target User

### User Role
* **Guest / Anonymous:** Hanya bisa melihat katalog produk berdasarkan lokasi, membaca artikel edukasi, dan melihat jadwal acara.
* **Buyer (User):** Dapat mengelola profil, membeli barang bekas menggunakan pembayaran Midtrans, dan memberikan ulasan pesanan.
* **Seller (User):** Dapat mengunggah foto produk bekas, menetapkan harga, menentukan lokasi penjemputan, dan mengatur status barang.
* **Event + Education:** Hanya superuser yang boleh membuat, mengedit, dan menghapus event/artikel. Pengguna login boleh berkomentar pada event; artikel hanya dibaca.
* **Admin:** Memegang kendali penuh untuk memoderasi produk, memantau transaksi Midtrans, mengelola akun, dan memvalidasi konten.

### Target User
* **Gen Z & Thrifter:** Anak muda berusia 18–35 tahun yang mencari barang bekas berkualitas.
* **Penjual:** Individu yang ingin menjual barang layak pakai di rumahnya secara mudah dan aman.

---

## 📊 Perbandingan dengan Aplikasi Sejenis

Compared to existing secondhand marketplaces, EcoLove combines marketplace functionality with features that support sustainable living.

* **OLX** provides **User & Profile, Item, Transaction & Payment, and Reviews**, but does not include **Events** or **Education** features.
* **Facebook Marketplace** provides **User & Profile, Item, Transaction & Payment, Reviews, and Events**, but does not specifically provide an **Education** feature.
* **EcoLove** includes all of these features: **User & Profile, Item, Transaction & Payment, Reviews, Events, and Education**. The combination is designed to support not only secondhand transactions, but also community engagement and awareness of sustainable living.

| Fitur / Aspek | OLX | Facebook Marketplace | EcoLove |
| :--- | :---: | :---: | :---: |
| **User & Profile** | ✅ | ✅ | ✅ |
| **Item** | ✅ | ✅ | ✅ |
| **Transaction & Payment** | ✅ | ✅ | ✅ |
| **Reviews** | ✅ | ✅ | ✅ |
| **Events** | ❌ | ✅ | ✅ |
| **Education** | ❌ | ❌ | ✅ |

---

## 🔄 Alur Pengintegrasian dengan Web Service (Django & Flutter)

Untuk memastikan sinkronisasi data secara *real-time* antara aplikasi *web* **EcoLove** dan aplikasi *mobile* berbasis Flutter, keduanya terhubung ke satu *backend* dan *database* terpusat yang dibangun menggunakan Django. Alur pengintegrasiannya meliputi tahapan berikut:

1. **Pembuatan Aplikasi Autentikasi Mobile & Konfigurasi CORS pada Django**
   * Membuat *django-app* khusus (seperti `authentication`) untuk menangani alur *login*, *register*, dan *logout* dari aplikasi Flutter dengan respons berbasis JSON serta manajemen *session cookies*.
   * Mengonfigurasi `django-cors-headers` dan mengatur *middleware* serta pengaturan *cookie* (`SESSION_COOKIE_SAMESITE`, `CSRF_COOKIE_SAMESITE`, `CORS_ALLOW_CREDENTIALS`) pada `settings.py` agar aplikasi Flutter diizinkan mengirimkan *request* lintas asal (*cross-origin*) dengan membawa kredensial pengguna.

2. **Manajemen Sesi & Autentikasi di Flutter (`pbp_django_auth` & `provider`)**
   * Menggunakan *package* **`pbp_django_auth`** yang dikombinasikan dengan **`provider`** pada root aplikasi Flutter (`CookieRequest`).
   * *State* `CookieRequest` ini dibagikan ke seluruh halaman aplikasi sehingga setiap *request* HTTP (seperti menambah barang, menyukai item, atau melihat *My Marketplace*) otomatis menyertakan *session cookie* pengguna yang sedang *login*.

3. **Pemodelan Data Dart dari Respons JSON (Quicktype)**
   * Mengambil contoh keluaran data JSON dari *endpoint* Django yang sudah ada (seperti `/marketplace/api/items` yang mengembalikan struktur data `Item` beserta relasi `seller`, `like_count`, dan `category`).
   * Menggunakan bantuan **Quicktype** (`https://app.quicktype.io/`) untuk mengonversi struktur JSON tersebut menjadi kelas model *type-safe* dalam bahasa Dart (lengkap dengan fungsi `fromJson` dan `toJson`) agar mudah diolah oleh *widget* Flutter.

4. **Penyediaan & Penyesuaian Endpoint JSON untuk Operasi CRUD**
   * Memanfaatkan *endpoint* JSON yang sudah tersedia pada web (seperti `get_items_json` untuk katalog produk dan pencarian) serta menambahkan *endpoint* API khusus *mobile* yang dibungkus dekorator `@csrf_exempt` atau validasi *session* untuk menangani operasi **Create** (tambah produk baru), **Read** (filter katalog & *My Marketplace*), **Update** (edit detail produk), dan **Delete** (hapus produk) dari aplikasi Flutter.

5. **Konsumsi API & Pembaruan UI Asinkron di Flutter**
   * Aplikasi Flutter melakukan panggilan HTTP (`GET` untuk mengambil daftar produk dan `POST` untuk mengirim data form/JSON baru) secara asinkron menggunakan `CookieRequest`.
   * Respons JSON dari server Django kemudian dipetakan ke dalam objek model Dart dan dirender secara dinamis ke antarmuka aplikasi menggunakan `FutureBuilder` maupun pengelolaan *state* lokal, sehingga setiap perubahan data di *mobile* langsung tercermin di versi *web* maupun sebaliknya.

---

## 🔗 Sumber Public API & Desain

* **Sumber Public API:** [API Wilayah Indonesia (emsifa)](https://github.com/emsifa/api-wilayah-indonesia.git)
* **Link Desain Figma:** [EcoLove — Revised Design](https://www.figma.com/design/iqNqWjLpHtqI7QjbV63KtU/EcoLove-%E2%80%94-Revised-Design?node-id=1-4256&p=f)