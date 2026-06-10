#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  OneReserve — Database Setup Script
#  Usage:  bash sql/run_all.sh [mysql_user] [mysql_password]
#  Example: bash sql/run_all.sh root mypassword
# ─────────────────────────────────────────────────────────────
USER=${1:-root}
PASS=${2:-}
DIR="$(cd "$(dirname "$0")" && pwd)"

run_sql() {
  if [ -z "$PASS" ]; then
    mysql -u"$USER" < "$1"
  else
    mysql -u"$USER" -p"$PASS" < "$1"
  fi
}

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  OneReserve Database Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "► 01 Creating schema..."       && run_sql "$DIR/schema/01_schema.sql"
echo "► 02 Seeding core data..."     && run_sql "$DIR/seeds/02_seed_core.sql"
echo "► 03 Seeding hotels..."        && run_sql "$DIR/seeds/03_seed_hotels.sql"
echo "► 04 Seeding users/bookings..." && run_sql "$DIR/seeds/04_seed_users_bookings.sql"
echo "► 05 Creating views..."        && run_sql "$DIR/views/05_views.sql"
echo "► 06 Creating triggers..."     && run_sql "$DIR/triggers/06_triggers.sql"
echo "► 07 Creating procedures..."   && run_sql "$DIR/procedures/07_procedures.sql"
echo "► 08 Creating functions..."    && run_sql "$DIR/functions/08_functions.sql"
echo ""
echo "✅  Database ready. Run: python app.py"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
