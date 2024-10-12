from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
import models
import database

app = FastAPI()

# Create the database tables
models.Base.metadata.create_all(bind=database.engine)

# Dependency to get the database session
def get_db():
    db = database.SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Create User (POST request)
@app.post("/users/", response_model=models.UserResponse)
def create_user(user: models.UserCreate, db: Session = Depends(get_db)):
    db_user = models.User(
        id=user.id, 
        first_name=user.first_name,
        last_name=user.last_name,
        email=user.email,
        phone_number=user.phone_number
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

# Get User by ID (GET request)
@app.get("/users/{user_id}", response_model=models.UserResponse)
def read_user(user_id: str, db: Session = Depends(get_db)):
    user = db.query(models.User).filter(models.User.id == user_id).first()
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return user

# Get all Users (GET request)
@app.get("/users/", response_model=list[models.UserResponse])
def read_users(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    users = db.query(models.User).offset(skip).limit(limit).all()
    return users

# Create Donor (POST request)
@app.post("/donors/", response_model=models.DonorResponse)
def create_donor(donor: models.DonorCreate, db: Session = Depends(get_db)):
    db_donor = models.Donor(
        id=donor.id,
        blood_group=donor.blood_group,
        gender=donor.gender,
        state=donor.state,
        district=donor.district,
        pin_code=donor.pin_code,
        address=donor.address,
        contact_number=donor.contact_number
    )
    db.add(db_donor)
    db.commit()
    db.refresh(db_donor)
    return db_donor

# Get Donor by ID (GET request)
@app.get("/donors/{donor_id}", response_model=models.DonorResponse)
def read_donor(donor_id: str, db: Session = Depends(get_db)):
    donor = db.query(models.Donor).filter(models.Donor.id == donor_id).first()
    if donor is None:
        raise HTTPException(status_code=404, detail="Donor not found")
    return donor

# Get all Donors (GET request)
@app.get("/donors/", response_model=list[models.DonorResponse])
def read_donors(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    donors = db.query(models.Donor).offset(skip).limit(limit).all()
    return donors

# Get all Donors with User's first name (GET request)
@app.get("/donors_with_user/", response_model=list[models.DonorWithUserResponse])
def read_donors_with_user(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    # Join Donor and User tables on the 'id' field
    donors = (
        db.query(models.Donor, models.User.first_name)
        .join(models.User, models.Donor.id == models.User.id)  # Perform join on the 'id' field
        .offset(skip)
        .limit(limit)
        .all()
    )

    # Process results to return in the required format
    donor_with_user = [
        models.DonorWithUserResponse(
            id=donor.id,
            blood_group=donor.blood_group,
            gender=donor.gender,
            state=donor.state,
            district=donor.district,
            pin_code=donor.pin_code,
            address=donor.address,
            contact_number=donor.contact_number,
            first_name=user_first_name  # Extract user's first name
        )
        for donor, user_first_name in donors
    ]
    return donor_with_user

# Create Recipient (POST request)
@app.post("/recipients/", response_model=models.RecipientResponse)
def create_recipient(recipient: models.RecipientCreate, db: Session = Depends(get_db)):
    db_recipient = models.Recipient(
        id=recipient.id,
        blood_group=recipient.blood_group,
        patient_name=recipient.patient_name,
        attendee_name=recipient.attendee_name,
        attendee_contact_number=recipient.attendee_contact_number,
        required_date=recipient.required_date,
        selected_units=recipient.selected_units,
        location=recipient.location
    )
    db.add(db_recipient)
    db.commit()
    db.refresh(db_recipient)
    return db_recipient

# Get Recipient by ID (GET request)
@app.get("/recipients/{recipient_id}", response_model=models.RecipientResponse)
def read_recipient(recipient_id: str, db: Session = Depends(get_db)):
    recipient = db.query(models.Recipient).filter(models.Recipient.id == recipient_id).first()
    if recipient is None:
        raise HTTPException(status_code=404, detail="Recipient not found")
    return recipient

# Get all Recipients (GET request)
@app.get("/recipients/", response_model=list[models.RecipientResponse])
def read_recipients(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    recipients = db.query(models.Recipient).offset(skip).limit(limit).all()
    return recipients

@app.get("/search_donors/", response_model=list[models.DonorWithUserResponse])
def search_donors(location: str, skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    # Join Donor and User tables on the 'id' field
    donors = (
        db.query(models.Donor, models.User.first_name)
        .join(models.User, models.Donor.id == models.User.id)  # Perform join on the 'id' field
        .filter(
            models.Donor.state.ilike(f'%{location}%') | 
            models.Donor.district.ilike(f'%{location}%')
        )  # Apply filter here
        .offset(skip)
        .limit(limit)
        .all()  # Retrieve results
    )

    # Process results to return in the required format
    donor_with_user = [
        models.DonorWithUserResponse(
            id=donor.id,
            blood_group=donor.blood_group,
            gender=donor.gender,
            state=donor.state,
            district=donor.district,
            pin_code=donor.pin_code,
            address=donor.address,
            contact_number=donor.contact_number,
            first_name=user_first_name  # Extract user's first name
        )
        for donor, user_first_name in donors
    ]
    
    return donor_with_user


@app.get("/search_bloodgroup/", response_model=list[models.DonorWithUserResponse])
def search_donors(bloodgroup: str, skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    print(f"Searching for donors with blood group: {bloodgroup}")
    # Perform a query to get donors based on blood group
    donors = (
        db.query(models.Donor, models.User.first_name)
        .join(models.User, models.Donor.id == models.User.id)  # Join Donor and User tables
        .filter(models.Donor.blood_group.ilike(f'%{bloodgroup}%'))  # Filter by blood group
        .offset(skip)
        .limit(limit)
        .all()  # Retrieve results
    )

    # Process results to return in the required format
    donor_with_user = [
        models.DonorWithUserResponse(
            id=donor.id,
            blood_group=donor.blood_group,
            gender=donor.gender,
            state=donor.state,
            district=donor.district,
            pin_code=donor.pin_code,
            address=donor.address,
            contact_number=donor.contact_number,
            first_name=user_first_name  # Extract user's first name
        )
        for donor, user_first_name in donors
    ]
    
    return donor_with_user

@app.get("/search_donors_loc_bgp/", response_model=list[models.DonorWithUserResponse])
def search_donors(location: str = None, blood_group: str = None, skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    # Start building the query
    query = db.query(models.Donor, models.User.first_name).join(models.User, models.Donor.id == models.User.id)
    location = location.strip() if location else None
    blood_group = blood_group.strip() if blood_group else None

    # Apply filters for both location and blood group
    if location and blood_group:
        query = query.filter(
            (models.Donor.state.ilike(f'%{location}%') | models.Donor.district.ilike(f'%{location}%')) &
            models.Donor.blood_group.ilike(f'%{blood_group}%')
        )
    elif location:
        query = query.filter(
            models.Donor.state.ilike(f'%{location}%') | models.Donor.district.ilike(f'%{location}%')
        )
    elif blood_group:
        query = query.filter(models.Donor.blood_group.ilike(f'%{blood_group}%'))

    # Execute the query with pagination
    donors = query.offset(skip).limit(limit).all()

    # Process results to return in the required format
    donor_with_user = [
        models.DonorWithUserResponse(
            id=donor.id,
            blood_group=donor.blood_group,
            gender=donor.gender,
            state=donor.state,
            district=donor.district,
            pin_code=donor.pin_code,
            address=donor.address,
            contact_number=donor.contact_number,
            first_name=user_first_name  # Extract user's first name
        )
        for donor, user_first_name in donors
    ]
    
    return donor_with_user

# Update Recipient Information (PUT request)
@app.put("/recipients/{recipient_id}", response_model=models.RecipientResponse)
def update_recipient(recipient_id: str, updated_data: models.RecipientUpdate, db: Session = Depends(get_db)):
    # Fetch the recipient by ID
    recipient = db.query(models.Recipient).filter(models.Recipient.id == recipient_id).first()
    if not recipient:
        raise HTTPException(status_code=404, detail="Recipient not found")

    # Update recipient fields
    recipient.attendee_contact_number = updated_data.attendee_contact_number or recipient.attendee_contact_number
    recipient.location = updated_data.location or recipient.location
    recipient.selected_units = updated_data.selected_units or recipient.selected_units
    recipient.required_date = updated_data.required_date or recipient.required_date

    # Save the changes to the database
    db.commit()
    db.refresh(recipient)

    return recipient

# Delete Recipient by ID (DELETE request)
@app.delete("/recipients/{recipient_id}", response_model=models.RecipientResponse)
def delete_recipient(recipient_id: str, db: Session = Depends(get_db)):
    # Fetch the recipient by ID
    recipient = db.query(models.Recipient).filter(models.Recipient.id == recipient_id).first()
    if not recipient:
        raise HTTPException(status_code=404, detail="Recipient not found")

    # Delete the recipient
    db.delete(recipient)
    db.commit()
    
    return recipient

# Update User Information (PUT request)
@app.put("/users/{user_id}", response_model=models.UserResponse)
def update_user(user_id: str, updated_data: models.UserUpdate, db: Session = Depends(get_db)):
    user = db.query(models.User).filter(models.User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    # Update user fields if new data is provided
    user.first_name = updated_data.first_name or user.first_name
    user.last_name = updated_data.last_name or user.last_name
    user.email = updated_data.email or user.email
    user.phone_number = updated_data.phone_number or user.phone_number

    # Save the changes to the database
    db.commit()
    db.refresh(user)

    return user

