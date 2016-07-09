Member.create(name:  "adminuser",
  user_name: "admin01",
  email: "aprisun@gmail.com",
  password:              "redhat123",
  password_confirmation: "redhat123",
  #admin:     true,
  activated: true,
  activated_at: Time.zone.now)

Member.create(name:  "test01",
    user_name:  "test01",
    email: "test01@example.com",
    password:              "redhat123",
    password_confirmation: "redhat123",
    #admin:     true,
    activated: true,
    activated_at: Time.zone.now)

Member.create(name:  "test02",
    user_name: "test02",
    email: "test02@example.com",
    password:              "redhat123",
    password_confirmation: "redhat123",
    #admin:     true,
    activated: true,
    activated_at: Time.zone.now)

Member.create(name:  "test03",
    user_name: "test03",
    email: "test03@example.com",
    password:              "redhat123",
    password_confirmation: "redhat123",
    #admin:     true,
    activated: true,
    activated_at: Time.zone.now)

Member.create(name:  "test04",
    user_name: "test04",
    email: "test04@example.com",
    password:              "redhat123",
    password_confirmation: "redhat123",
    #admin:     true,
    activated: true,
    activated_at: Time.zone.now)

Member.create(name:  "mcampadmin",
      user_name: "mcampadmin",
      email: "mcamp2100@gmail.com",
      password:              "a@Aqwer0987",
      password_confirmation: "a@Aqwer0987",
      authority_id:     2,
      activated: true,
      activated_at: Time.zone.now,
      admin:     true)
