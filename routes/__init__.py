from flask import Blueprint, request, jsonify
from flask_login import login_required, current_user, login_user, logout_user
from utils.response import success, error
import services as svc

# ── Auth API ──────────────────────────────────────────────────
auth_bp = Blueprint("auth_api", __name__)

@auth_bp.route("/register", methods=["POST"])
def api_register():
    d = request.get_json(silent=True) or {}
    user, err = svc.register_user(d.get("full_name",""), d.get("email",""), d.get("password",""), d.get("phone",""))
    if err: return error(err, 409 if "registered" in err else 400)
    login_user(user)
    return success(user.to_dict(), "Registration successful.", 201)

@auth_bp.route("/login", methods=["POST"])
def api_login():
    d = request.get_json(silent=True) or {}
    user, err = svc.login_user_service(d.get("email",""), d.get("password",""))
    if err: return error(err, 401)
    login_user(user)
    return success(user.to_dict(), "Login successful.")

@auth_bp.route("/logout", methods=["POST"])
@login_required
def api_logout():
    logout_user()
    return success(None, "Logged out.")

@auth_bp.route("/me", methods=["GET"])
@login_required
def api_me():
    return success(current_user.to_dict())

# ── Places API ────────────────────────────────────────────────
places_bp = Blueprint("places_api", __name__)

@places_bp.route("/", methods=["GET"])
def api_places():
    r = svc.get_all_places(category=request.args.get("category"), district_id=request.args.get("district_id",type=int), featured_only=request.args.get("featured","false")=="true", page=request.args.get("page",1,type=int), per_page=min(request.args.get("per_page",12,type=int),50))
    return success(r)

@places_bp.route("/search", methods=["GET"])
def api_search():
    q = request.args.get("q","").strip()
    if not q: return error("Query required.", 400)
    return success(svc.search_places(q))

@places_bp.route("/featured", methods=["GET"])
def api_featured():
    return success(svc.get_featured_places(request.args.get("limit",6,type=int)))

@places_bp.route("/<int:place_id>", methods=["GET"])
def api_place_detail(place_id):
    return success(svc.get_place_detail(place_id))

# ── Bus API ───────────────────────────────────────────────────
buses_bp = Blueprint("buses_api", __name__)

@buses_bp.route("/schedules", methods=["GET"])
def api_schedules():
    r = svc.get_schedules(place_id=request.args.get("place_id",type=int), travel_date=request.args.get("date"), bus_type=request.args.get("bus_type"), page=request.args.get("page",1,type=int), per_page=20)
    return success(r)

@buses_bp.route("/companies", methods=["GET"])
def api_companies():
    return success(svc.get_companies())

# ── Hotels API ────────────────────────────────────────────────
hotels_bp = Blueprint("hotels_api", __name__)

@hotels_bp.route("/", methods=["GET"])
def api_hotels():
    r = svc.get_hotels(place_id=request.args.get("place_id",type=int), min_rating=request.args.get("min_rating",type=float), max_price=request.args.get("max_price",type=float), page=request.args.get("page",1,type=int))
    return success(r)

@hotels_bp.route("/<int:hotel_id>", methods=["GET"])
def api_hotel(hotel_id):
    return success(svc.get_hotel_detail(hotel_id))

@hotels_bp.route("/<int:hotel_id>/rooms", methods=["GET"])
def api_rooms(hotel_id):
    return success(svc.get_room_types(hotel_id))

# ── Bookings API ──────────────────────────────────────────────
bookings_bp = Blueprint("bookings_api", __name__)

@bookings_bp.route("/calculate", methods=["POST"])
@login_required
def api_calculate():
    d = request.get_json(silent=True) or {}
    for f in ["schedule_id","seat_quantity","room_type_id","checkin","checkout"]:
        if f not in d: return error(f"'{f}' required.", 400)
    result, err = svc.calculate_trip_cost(int(d["schedule_id"]),int(d["seat_quantity"]),int(d["room_type_id"]),d["checkin"],d["checkout"])
    if err: return error(err, 400)
    return success(result)

@bookings_bp.route("/", methods=["POST"])
@login_required
def api_book():
    d = request.get_json(silent=True) or {}
    booking, msg = svc.create_booking(current_user.user_id, int(d.get("schedule_id",0)), int(d.get("seat_quantity",1)), int(d.get("room_type_id",0)), d.get("checkin",""), d.get("checkout",""), d.get("notes",""))
    if not booking: return error(msg, 400)
    return success(booking.to_dict(detail=True), msg, 201)

@bookings_bp.route("/", methods=["GET"])
@login_required
def api_my_bookings():
    return success(svc.get_user_bookings(current_user.user_id, page=request.args.get("page",1,type=int)))

# ── User API ──────────────────────────────────────────────────
user_bp = Blueprint("user_api", __name__)

@user_bp.route("/reviews", methods=["GET"])
@login_required
def api_my_reviews():
    return success(svc.get_user_reviews(current_user.user_id))

@user_bp.route("/reviews", methods=["POST"])
@login_required
def api_post_review():
    d = request.get_json(silent=True) or {}
    r, err = svc.add_review(current_user.user_id, int(d.get("place_id",0)), int(d.get("rating",0)), d.get("review_text",""))
    if err: return error(err, 400)
    return success(r.to_dict(), "Review submitted.", 201)

@user_bp.route("/wishlist", methods=["GET"])
@login_required
def api_wishlist():
    return success(svc.get_user_wishlist(current_user.user_id))

@user_bp.route("/wishlist/toggle", methods=["POST"])
@login_required
def api_toggle_wishlist():
    d = request.get_json(silent=True) or {}
    added, msg = svc.toggle_wishlist(current_user.user_id, int(d.get("place_id",0)))
    return success({"added": added}, msg)

# ── Admin API ─────────────────────────────────────────────────
admin_bp = Blueprint("admin_api", __name__)

@admin_bp.route("/dashboard", methods=["GET"])
@login_required
def api_dashboard():
    return success(svc.get_dashboard_stats())

@admin_bp.route("/reports/popular-destinations", methods=["GET"])
@login_required
def api_popular():
    from database.db_utils import popular_destination_report
    return success(popular_destination_report())

@admin_bp.route("/reports/monthly-revenue", methods=["GET"])
@login_required
def api_revenue():
    from database.db_utils import monthly_revenue_report
    year = request.args.get("year", 2026, type=int)
    return success(monthly_revenue_report(year))


def register_blueprints(app):
    app.register_blueprint(auth_bp,     url_prefix="/api/auth")
    app.register_blueprint(places_bp,   url_prefix="/api/places")
    app.register_blueprint(buses_bp,    url_prefix="/api/buses")
    app.register_blueprint(hotels_bp,   url_prefix="/api/hotels")
    app.register_blueprint(bookings_bp, url_prefix="/api/bookings")
    app.register_blueprint(user_bp,     url_prefix="/api/user")
    app.register_blueprint(admin_bp,    url_prefix="/api/admin")
