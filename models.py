from sqlalchemy import Column, String, ForeignKey
from database import Base
from pydantic import BaseModel, validator

# SQLAlchemy User model
class User(Base):
    __tablename__ = "users"

    id = Column(String, primary_key=True, index=True)
    first_name = Column(String, index=True)
    last_name = Column(String, index=True)
    email = Column(String, unique=True, index=True)
    phone_number = Column(String, index=True)

# SQLAlchemy Donor model with foreign key to User
class Donor(Base):
    __tablename__ = "donors"

    id = Column(String, ForeignKey('users.id'), primary_key=True, index=True)
    blood_group = Column(String, index=True)
    gender = Column(String, index=True)
    state = Column(String, index=True)
    district = Column(String, index=True)
    pin_code = Column(String, index=True)
    address = Column(String, index=True)
    contact_number = Column(String, index=True)

# Pydantic model for creating a user
class UserCreate(BaseModel):
    id: str
    first_name: str
    last_name: str
    email: str
    phone_number: str

    @validator('email')
    def validate_email(cls, v):
        if '@' not in v:
            raise ValueError('Email must be valid')
        return v

# Pydantic response model for a user
class UserResponse(UserCreate):
    class Config:
        from_attributes = True

# Pydantic model for creating a donor
class DonorCreate(BaseModel):
    id: str
    blood_group: str
    gender: str
    state: str
    district: str
    pin_code: str
    address: str
    contact_number: str

    class Config:
        from_attributes = True

# Pydantic response model for a donor
class DonorResponse(DonorCreate):
    pass

# Pydantic response model for a donor with user details
class DonorWithUserResponse(BaseModel):
    id: str
    blood_group: str
    gender: str
    state: str
    district: str
    pin_code: str
    address: str
    contact_number: str
    first_name: str  # To include the user's first name

    class Config:
        from_attributes = True

# SQLAlchemy Recipient model with foreign key to User
class Recipient(Base):
    __tablename__ = "recipients"

    id = Column(String, ForeignKey('users.id'), primary_key=True, index=True)
    blood_group = Column(String, index=True)
    patient_name = Column(String, index=True)
    attendee_name = Column(String, index=True)
    attendee_contact_number = Column(String, index=True)
    selected_units = Column(String, index=True)
    required_date = Column(String, index=True)
    location = Column(String, index=True)

# Pydantic model for creating a recipient
class RecipientCreate(BaseModel):
    id: str
    blood_group: str
    patient_name: str
    attendee_name: str
    attendee_contact_number: str
    required_date: str
    selected_units: str
    location: str


    class Config:
        from_attributes = True

# Pydantic response model for a recipient
class RecipientResponse(RecipientCreate):
    pass


# Pydantic model for updating a recipient
class RecipientUpdate(BaseModel):
    attendee_contact_number: str = None
    location: str = None
    selected_units: str = None
    required_date: str = None

    class Config:
        from_attributes = True


# Pydantic model for updating a user
class UserUpdate(BaseModel):
    first_name: str = None
    last_name: str = None
    email: str = None
    phone_number: str = None

    @validator('email', always=True)
    def validate_email(cls, v):
        if v is not None and '@' not in v:
            raise ValueError('Email must be valid')
        return v
