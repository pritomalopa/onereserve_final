from datetime import datetime
from database import db
from flask_login import UserMixin

class User(UserMixin, db.Model):
    __tablename__ = "users"
    user_id    = db.Column(db.Integer, primary_key=True, autoincrement=True)
    full_name  = db.Column(db.String(100), nullable=False)
    email      = db.Column(db.String(150), unique=True, nullable=False)
    password   = db.Column(db.String(255), nullable=False)
    phone      = db.Column(db.String(20))
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    is_active  = db.Column(db.Boolean, default=True)
    bookings   = db.relationship("Booking", backref="user", lazy="dynamic")
    reviews    = db.relationship("Review", backref="user", lazy="dynamic")
    wishlists  = db.relationship("Wishlist", backref="user", lazy="dynamic")
    def get_id(self): return str(self.user_id)
    def to_dict(self):
        return {"user_id":self.user_id,"full_name":self.full_name,"email":self.email,"phone":self.phone,"created_at":self.created_at.isoformat() if self.created_at else None,"is_active":self.is_active}

class District(db.Model):
    __tablename__ = "districts"
    district_id   = db.Column(db.Integer, primary_key=True, autoincrement=True)
    district_name = db.Column(db.String(100), unique=True, nullable=False)
    places = db.relationship("Place", backref="district", lazy="dynamic")
    def to_dict(self): return {"district_id":self.district_id,"district_name":self.district_name}

class Place(db.Model):
    __tablename__ = "places"
    place_id       = db.Column(db.Integer, primary_key=True, autoincrement=True)
    district_id    = db.Column(db.Integer, db.ForeignKey("districts.district_id"), nullable=False)
    place_name     = db.Column(db.String(150), nullable=False)
    description    = db.Column(db.Text)
    image_path     = db.Column(db.String(255))
    latitude       = db.Column(db.Numeric(10,8))
    longitude      = db.Column(db.Numeric(11,8))
    google_map_url = db.Column(db.Text)
    category       = db.Column(db.String(60))
    is_featured    = db.Column(db.Boolean, default=False)
    schedules = db.relationship("Schedule", backref="place", lazy="dynamic")
    hotels    = db.relationship("Hotel", backref="place", lazy="dynamic")
    reviews   = db.relationship("Review", backref="place", lazy="dynamic")
    wishlists = db.relationship("Wishlist", backref="place", lazy="dynamic")
    def avg_rating(self):
        r=[x.rating for x in self.reviews]; return round(sum(r)/len(r),1) if r else 0.0
    def review_count(self): return self.reviews.count()
    def to_dict(self, detail=False):
        d={"place_id":self.place_id,"place_name":self.place_name,"description":self.description,
           "image_path":self.image_path,"category":self.category,"is_featured":self.is_featured,
           "district_id":self.district_id,"district_name":self.district.district_name if self.district else None,
           "avg_rating":self.avg_rating(),"review_count":self.review_count()}
        if detail:
            d.update({"latitude":float(self.latitude) if self.latitude else None,
                      "longitude":float(self.longitude) if self.longitude else None,
                      "google_map_url":self.google_map_url,"wishlist_count":self.wishlists.count()})
        return d

class BusCompany(db.Model):
    __tablename__ = "bus_companies"
    company_id   = db.Column(db.Integer, primary_key=True, autoincrement=True)
    company_name = db.Column(db.String(100), unique=True, nullable=False)
    contact_no   = db.Column(db.String(20))
    logo_path    = db.Column(db.String(255))
    is_active    = db.Column(db.Boolean, default=True)
    buses = db.relationship("Bus", backref="company", lazy="dynamic")
    def to_dict(self): return {"company_id":self.company_id,"company_name":self.company_name,"contact_no":self.contact_no,"logo_path":self.logo_path}

class Bus(db.Model):
    __tablename__ = "buses"
    bus_id          = db.Column(db.Integer, primary_key=True, autoincrement=True)
    company_id      = db.Column(db.Integer, db.ForeignKey("bus_companies.company_id", ondelete="CASCADE"), nullable=False)
    bus_name        = db.Column(db.String(100), nullable=False)
    bus_type        = db.Column(db.String(50), nullable=False)
    seat_capacity   = db.Column(db.Integer, nullable=False)
    available_seats = db.Column(db.Integer, nullable=False, default=0)
    schedules = db.relationship("Schedule", backref="bus", lazy="dynamic")
    def to_dict(self): return {"bus_id":self.bus_id,"company_id":self.company_id,"company_name":self.company.company_name if self.company else None,"bus_name":self.bus_name,"bus_type":self.bus_type,"seat_capacity":self.seat_capacity,"available_seats":self.available_seats}

class Schedule(db.Model):
    __tablename__ = "schedules"
    schedule_id    = db.Column(db.Integer, primary_key=True, autoincrement=True)
    bus_id         = db.Column(db.Integer, db.ForeignKey("buses.bus_id", ondelete="CASCADE"), nullable=False)
    place_id       = db.Column(db.Integer, db.ForeignKey("places.place_id", ondelete="CASCADE"), nullable=False)
    departure_city = db.Column(db.String(100), nullable=False, default="Dhaka")
    departure_time = db.Column(db.DateTime, nullable=False)
    arrival_time   = db.Column(db.DateTime, nullable=False)
    fare           = db.Column(db.Numeric(10,2), nullable=False)
    is_active      = db.Column(db.Boolean, default=True)
    bus_bookings   = db.relationship("BookingBus", backref="schedule", lazy="dynamic")
    def journey_hours(self):
        if self.departure_time and self.arrival_time:
            return int((self.arrival_time-self.departure_time).total_seconds()//3600)
        return None
    def to_dict(self):
        return {"schedule_id":self.schedule_id,"bus_id":self.bus_id,
                "bus_name":self.bus.bus_name if self.bus else None,
                "bus_type":self.bus.bus_type if self.bus else None,
                "available_seats":self.bus.available_seats if self.bus else 0,
                "company_name":self.bus.company.company_name if (self.bus and self.bus.company) else None,
                "company_logo":self.bus.company.logo_path if (self.bus and self.bus.company) else None,
                "place_id":self.place_id,
                "place_name":self.place.place_name if self.place else None,
                "district_name":self.place.district.district_name if (self.place and self.place.district) else None,
                "departure_city":self.departure_city,
                "departure_time":self.departure_time.isoformat() if self.departure_time else None,
                "arrival_time":self.arrival_time.isoformat() if self.arrival_time else None,
                "journey_hours":self.journey_hours(),"fare":float(self.fare),"is_active":self.is_active}

class Hotel(db.Model):
    __tablename__ = "hotels"
    hotel_id   = db.Column(db.Integer, primary_key=True, autoincrement=True)
    place_id   = db.Column(db.Integer, db.ForeignKey("places.place_id", ondelete="CASCADE"), nullable=False)
    hotel_name = db.Column(db.String(150), nullable=False)
    address    = db.Column(db.Text)
    rating     = db.Column(db.Numeric(2,1), default=0.0)
    image_path = db.Column(db.String(255))
    is_active  = db.Column(db.Boolean, default=True)
    room_types = db.relationship("RoomType", backref="hotel", lazy="dynamic")
    def min_price(self):
        p=[float(rt.room_price) for rt in self.room_types]; return min(p) if p else 0.0
    def to_dict(self, include_rooms=False):
        d={"hotel_id":self.hotel_id,"hotel_name":self.hotel_name,"address":self.address,
           "rating":float(self.rating) if self.rating else 0.0,"image_path":self.image_path,
           "place_id":self.place_id,"place_name":self.place.place_name if self.place else None,
           "district_name":self.place.district.district_name if (self.place and self.place.district) else None,
           "min_price":self.min_price(),"total_available":sum(rt.available_rooms for rt in self.room_types)}
        if include_rooms: d["room_types"]=[rt.to_dict() for rt in self.room_types]
        return d

class RoomType(db.Model):
    __tablename__ = "room_types"
    room_type_id    = db.Column(db.Integer, primary_key=True, autoincrement=True)
    hotel_id        = db.Column(db.Integer, db.ForeignKey("hotels.hotel_id", ondelete="CASCADE"), nullable=False)
    room_name       = db.Column(db.String(100), nullable=False)
    room_price      = db.Column(db.Numeric(10,2), nullable=False)
    room_capacity   = db.Column(db.Integer, nullable=False, default=2)
    available_rooms = db.Column(db.Integer, nullable=False, default=0)
    amenities       = db.Column(db.Text)
    hotel_bookings  = db.relationship("BookingHotel", backref="room_type", lazy="dynamic")
    def to_dict(self): return {"room_type_id":self.room_type_id,"hotel_id":self.hotel_id,"hotel_name":self.hotel.hotel_name if self.hotel else None,"room_name":self.room_name,"room_price":float(self.room_price),"room_capacity":self.room_capacity,"available_rooms":self.available_rooms,"amenities":self.amenities}

class Booking(db.Model):
    __tablename__ = "bookings"
    booking_id     = db.Column(db.Integer, primary_key=True, autoincrement=True)
    user_id        = db.Column(db.Integer, db.ForeignKey("users.user_id", ondelete="RESTRICT"), nullable=False)
    booking_date   = db.Column(db.DateTime, default=datetime.utcnow)
    total_amount   = db.Column(db.Numeric(12,2), nullable=False, default=0.00)
    booking_status = db.Column(db.String(30), nullable=False, default="pending")
    notes          = db.Column(db.Text)
    bus_bookings   = db.relationship("BookingBus", backref="booking", lazy="select", cascade="all, delete-orphan")
    hotel_bookings = db.relationship("BookingHotel", backref="booking", lazy="select", cascade="all, delete-orphan")
    payments       = db.relationship("Payment", backref="booking", lazy="dynamic", cascade="all, delete-orphan")
    logs           = db.relationship("BookingLog", backref="booking", lazy="dynamic")
    def to_dict(self, detail=False):
        d={"booking_id":self.booking_id,"user_id":self.user_id,"booking_date":self.booking_date.isoformat() if self.booking_date else None,"total_amount":float(self.total_amount),"booking_status":self.booking_status,"notes":self.notes}
        if detail:
            d["bus_booking"]=self.bus_bookings[0].to_dict() if self.bus_bookings else None
            d["hotel_booking"]=self.hotel_bookings[0].to_dict() if self.hotel_bookings else None
            d["payment"]=self.payments.first().to_dict() if self.payments.first() else None
        return d

class BookingBus(db.Model):
    __tablename__ = "booking_bus"
    id            = db.Column(db.Integer, primary_key=True, autoincrement=True)
    booking_id    = db.Column(db.Integer, db.ForeignKey("bookings.booking_id", ondelete="CASCADE"), nullable=False)
    schedule_id   = db.Column(db.Integer, db.ForeignKey("schedules.schedule_id", ondelete="RESTRICT"), nullable=False)
    seat_quantity = db.Column(db.Integer, nullable=False, default=1)
    fare          = db.Column(db.Numeric(10,2), nullable=False)
    def to_dict(self):
        s=self.schedule
        return {"id":self.id,"booking_id":self.booking_id,"schedule_id":self.schedule_id,"seat_quantity":self.seat_quantity,"fare":float(self.fare),
                "destination":s.place.place_name if s and s.place else None,
                "district":s.place.district.district_name if s and s.place and s.place.district else None,
                "bus_name":s.bus.bus_name if s and s.bus else None,
                "bus_type":s.bus.bus_type if s and s.bus else None,
                "company_name":s.bus.company.company_name if s and s.bus and s.bus.company else None,
                "departure_time":s.departure_time.isoformat() if s else None,
                "arrival_time":s.arrival_time.isoformat() if s else None}

class BookingHotel(db.Model):
    __tablename__ = "booking_hotel"
    id            = db.Column(db.Integer, primary_key=True, autoincrement=True)
    booking_id    = db.Column(db.Integer, db.ForeignKey("bookings.booking_id", ondelete="CASCADE"), nullable=False)
    room_type_id  = db.Column(db.Integer, db.ForeignKey("room_types.room_type_id", ondelete="RESTRICT"), nullable=False)
    checkin_date  = db.Column(db.Date, nullable=False)
    checkout_date = db.Column(db.Date, nullable=False)
    nights        = db.Column(db.Integer, nullable=False)
    room_cost     = db.Column(db.Numeric(10,2), nullable=False)
    def to_dict(self):
        rt=self.room_type
        return {"id":self.id,"booking_id":self.booking_id,"room_type_id":self.room_type_id,
                "room_name":rt.room_name if rt else None,"room_price":float(rt.room_price) if rt else None,
                "hotel_name":rt.hotel.hotel_name if rt and rt.hotel else None,
                "checkin_date":self.checkin_date.isoformat() if self.checkin_date else None,
                "checkout_date":self.checkout_date.isoformat() if self.checkout_date else None,
                "nights":self.nights,"room_cost":float(self.room_cost)}

class Payment(db.Model):
    __tablename__ = "payments"
    payment_id      = db.Column(db.Integer, primary_key=True, autoincrement=True)
    booking_id      = db.Column(db.Integer, db.ForeignKey("bookings.booking_id", ondelete="RESTRICT"), nullable=False)
    amount          = db.Column(db.Numeric(12,2), nullable=False)
    payment_method  = db.Column(db.String(50), nullable=False)
    payment_status  = db.Column(db.String(30), nullable=False, default="pending")
    payment_date    = db.Column(db.DateTime, default=datetime.utcnow)
    transaction_ref = db.Column(db.String(100))
    def to_dict(self): return {"payment_id":self.payment_id,"booking_id":self.booking_id,"amount":float(self.amount),"payment_method":self.payment_method,"payment_status":self.payment_status,"payment_date":self.payment_date.isoformat() if self.payment_date else None,"transaction_ref":self.transaction_ref}

class BookingLog(db.Model):
    __tablename__ = "booking_logs"
    log_id       = db.Column(db.Integer, primary_key=True, autoincrement=True)
    booking_id   = db.Column(db.Integer, db.ForeignKey("bookings.booking_id"), nullable=True)
    action_type  = db.Column(db.String(50), nullable=False)
    old_status   = db.Column(db.String(30))
    new_status   = db.Column(db.String(30))
    performed_by = db.Column(db.String(100))
    action_time  = db.Column(db.DateTime, default=datetime.utcnow)
    remarks      = db.Column(db.Text)
    def to_dict(self): return {"log_id":self.log_id,"booking_id":self.booking_id,"action_type":self.action_type,"old_status":self.old_status,"new_status":self.new_status,"performed_by":self.performed_by,"action_time":self.action_time.isoformat() if self.action_time else None,"remarks":self.remarks}

class Review(db.Model):
    __tablename__ = "reviews"
    review_id   = db.Column(db.Integer, primary_key=True, autoincrement=True)
    user_id     = db.Column(db.Integer, db.ForeignKey("users.user_id", ondelete="CASCADE"), nullable=False)
    place_id    = db.Column(db.Integer, db.ForeignKey("places.place_id", ondelete="CASCADE"), nullable=False)
    rating      = db.Column(db.Integer, nullable=False)
    review_text = db.Column(db.Text)
    review_date = db.Column(db.DateTime, default=datetime.utcnow)
    __table_args__ = (db.UniqueConstraint("user_id","place_id",name="uq_reviews_user_place"),)
    def to_dict(self): return {"review_id":self.review_id,"user_id":self.user_id,"user_name":self.user.full_name if self.user else None,"place_id":self.place_id,"place_name":self.place.place_name if self.place else None,"rating":self.rating,"review_text":self.review_text,"review_date":self.review_date.isoformat() if self.review_date else None}

class Wishlist(db.Model):
    __tablename__ = "wishlist"
    wishlist_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    user_id     = db.Column(db.Integer, db.ForeignKey("users.user_id", ondelete="CASCADE"), nullable=False)
    place_id    = db.Column(db.Integer, db.ForeignKey("places.place_id", ondelete="CASCADE"), nullable=False)
    added_at    = db.Column(db.DateTime, default=datetime.utcnow)
    __table_args__ = (db.UniqueConstraint("user_id","place_id",name="uq_wishlist_user_place"),)
    def to_dict(self): return {"wishlist_id":self.wishlist_id,"user_id":self.user_id,"place_id":self.place_id,"place_name":self.place.place_name if self.place else None,"place_image":self.place.image_path if self.place else None,"place_category":self.place.category if self.place else None,"district_name":self.place.district.district_name if (self.place and self.place.district) else None,"avg_rating":self.place.avg_rating() if self.place else None,"added_at":self.added_at.isoformat() if self.added_at else None}
