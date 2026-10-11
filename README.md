# TFA2 POS System

This CodeIgniter 4 POS project extends TFA1 so the Customer Accounts and User Accounts pages read records from MySQL. The existing POSarce branding, routes, landing page, About page, and TFA1 sample names are retained.

## Hosting requirements

- PHP 8.2 or later (the version required by this project) with `intl`, `mbstring`, and `mysqli` enabled.
- MySQL/MariaDB database access.
- Apache with URL rewriting enabled, or an equivalent web server configuration.
- The project dependencies in `vendor/` (the repository's `composer.lock` identifies them).

The project currently uses CodeIgniter 4.7.4. No framework upgrade is needed for TFA2.

## Database import on InfinityFree

The SQL export is `database/tfa2_pos.sql`. It creates only the `customers` and `users` tables and inserts five existing TFA1 sample records into each. It contains no database creation/use statements and no credentials.

1. Sign in to the InfinityFree account and open phpMyAdmin for the already-created database `if0_42942486_pos_tfa2`.
2. Select that database in phpMyAdmin's left sidebar.
3. Open **Import**, choose the local `database/tfa2_pos.sql` file, keep the detected SQL format, then select **Import** / **Go**.
4. Confirm that `customers` and `users` appear and each contains five records. Importing again into a database that already has these tables will fail unless you first remove the existing tables; do not drop existing data without checking it.

## InfinityFree file placement

The checked-in CodeIgniter layout has `app/`, `vendor/`, `writable/`, and `.env` at the project root, with the web front controller under `public/`. `public/index.php` loads `../app/Config/Paths.php`, and that paths file locates `vendor/`, `writable/`, and `.env` relative to the project root. InfinityFree uses `htdocs` as the web root and may remove files uploaded outside it, so keep the project root in a named subfolder within `htdocs`, then block web requests to that private subfolder. The provided public `.htaccess` denies requests to `/TFA1/`.

Use this layout in the InfinityFree account's file manager (the public document root is `htdocs`):

```text
account root/
└── htdocs/                       # public document root
    ├── TFA1/                     # project root; blocked from direct web access
    │   ├── .env                  # private behind the deny rule
    │   ├── app/
    │   ├── vendor/
    │   ├── writable/
    │   ├── spark
    │   └── public/               # source copy; not the document root itself
    ├── index.php                 # copy from TFA1/public/index.php
    ├── .htaccess                 # copy from TFA1/public/.htaccess
    ├── favicon.ico               # copy from TFA1/public/
    └── robots.txt                # copy from TFA1/public/
```

Upload the updated raw project files into `htdocs/TFA1/` and copy the contents of `htdocs/TFA1/public/` into `htdocs/`. In `htdocs/index.php`, change the Paths include from:

```php
require FCPATH . '../app/Config/Paths.php';
```

to:

```php
require FCPATH . 'TFA1/app/Config/Paths.php';
```

The `Paths.php` file itself can remain as shipped because it resolves the project directories relative to its own location. Do not copy the repository-root `.htaccess` into `htdocs`; use `TFA1/public/.htaccess`, which routes requests to the front controller and blocks `/TFA1/` URLs before dispatch. This deny rule assumes the private folder is named exactly `TFA1`; if you rename it, update the rule in `.htaccess` as well as the `index.php` path. Keep `TFA1/.env` outside Git; the checked-in `.gitignore` already excludes `.env`.

The `.env` belongs at `htdocs/TFA1/.env`, beside `spark`. It is under the document root on disk, so rely on the public `.htaccess` deny rule for all `/TFA1/` web requests, and keep this rule in place. The checked-in `.gitignore` excludes `.env`; do not publish it in the GitHub repository.

## Hosted environment configuration

The project loads CodeIgniter's `.env` from the private project root (configured in `app/Config/Paths.php`). The root `.env` in this working copy has the host-specific non-secret values and obvious placeholders. On the server, edit `htdocs/TFA1/.env`, preserve unrelated settings, replace the URL with the real HTTPS site domain, and replace the password placeholder with the password from the hosting account. Never add the real password to source code, SQL, or README.

```ini
CI_ENVIRONMENT = production
app.baseURL = 'https://YOUR-DOMAIN/'
database.default.hostname = sql105.infinityfree.com
database.default.database = if0_42942486_pos_tfa2
database.default.username = if0_42942486
database.default.password = REPLACE_WITH_PRIVATE_DATABASE_PASSWORD
database.default.DBDriver = MySQLi
database.default.port = 3306
database.default.DBDebug = false
```

Replace `YOUR-DOMAIN` with the actual domain/subdomain assigned to this hosting account, including `https://` and the trailing slash (for example, `https://example.infinityfreeapp.com/`). No domain was confirmed in the project, so the placeholder is intentional. Replace `REPLACE_WITH_PRIVATE_DATABASE_PASSWORD` with the database password privately in File Manager/editor or the hosting environment. Do not share that value or commit the server `.env`.

## Local use

Keep `.env` out of version control. For local development, use `CI_ENVIRONMENT = development`, your local HTTPS/HTTP base URL, and local database credentials; do not use the hosted password in a local committed file. Install dependencies with Composer if `vendor/` is not present. Run `php spark serve` from the project root for local browsing.

## Routes and structure

| Route | Purpose |
| --- | --- |
| `/` | POS landing page |
| `/about` | Project information |
| `/customers` | Customer Accounts from `customers` via `CustomerModel` |
| `/users` | User Accounts from `users` via `UserModel` |

The routes remain in `app/Config/Routes.php`; the existing controllers query with CodeIgniter models, and the account views escape displayed values with `esc()`. The database schema contains only the specified fields; user roles are not displayed or stored.

## Upload and hosted verification

Upload the updated raw project files, including `database/tfa2_pos.sql`, to `htdocs/TFA1/`, and copy the public files to `htdocs/`. The project directory is denied to web requests, so the SQL export is not publicly downloadable; do not put it at the top level of `htdocs`. Import the SQL from your computer with phpMyAdmin, finish the private `.env`, then visit the hosted `/customers` and `/users` pages and confirm they show the imported records. Also check `/` and `/about` and verify the navigation and HTTPS base URL. This README does not claim that the project has been uploaded or tested live.
