Table "address" {
  "id" serial [pk]
  "street" varchar(255)
  "street_number" int
  "city" varchar(255)
  "zip_code" varchar(6)
}

Table "doctor" {
  "id" serial [pk]
  "name" varchar(255)
  "surname" varchar(255)
  "address_id" bigint
  "phone_number" varchar(20)
  "email" varchar(255)
}

Table "patient" {
  "id" serial [pk]
  "name" varchar(255)
  "surname" varchar(255)
  "address_id" bigint
  "insurance_company" varchar(255)
}

Table "medicament" {
  "id" serial [pk]
  "name" varchar(255)
  "price_insurance" float
  "price_patient" float
  "unit" varchar(10)
}

Table "prescription" {
  "id" serial [pk]
  "doctor_id" bigint
  "patient_id" bigint
  "valid_from" datetime
  "valid_to" datetime
  "is_released" boolean
}

Table "list_of_medicaments" {
  "prescription_id" bigint
  "medicament_id" bigint
  "amount" int

Indexes {
  (prescription_id, medicament_id) [pk]
}
}

Ref:"address"."id" < "doctor"."address_id"

Ref:"address"."id" < "patient"."address_id"

Ref:"doctor"."id" < "prescription"."doctor_id"

Ref:"patient"."id" < "prescription"."patient_id"

Ref:"prescription"."id" < "list_of_medicaments"."prescription_id"

Ref:"medicament"."id" < "list_of_medicaments"."medicament_id"
