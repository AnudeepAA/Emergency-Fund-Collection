CREATE TABLE "users" (
    "id" INTEGER AUTOINCREMENT,
    "id_no" TEXT NOT NULL UNIQUE,
    "username" TEXT NOT NULL UNIQUE,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "mobile" TEXT NOT NULL,
    "mail" TEXT NOT NULL,
    "designation" TEXT NOT NULL,
    "password" TEXT NOT NULL,

    PRIMARY KEY("id")
);

CREATE TABLE "volunteers" (
    "id" INTEGER,
    "id_no" TEXT NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "batch" TEXT NOT NULL,
    "dpt" TEXT NOT NULL,
    "sec" TEXT NOT NULL,
    "mobile" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "mail" TEXT NOT NULL,

    PRIMARY KEY("id")
);

CREATE TABLE "representatives" (
    "id" INTEGER NOT NULL,
    "id_no" TEXT NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "batch" TEXT NOT NULL,
    "dpt" TEXT NOT NULL,
    "sec" TEXT NOT NULL,
    "mobile" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "mail" TEXT NOT NULL,

    PRIMARY KEY("id")
);

CREATE TABLE "fund_rising_requests" (
    "id" INTEGER,
    "id_no" TEXT NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "batch" TEXT NOT NULL,
    "branch" TEXT NOT NULL,
    "sec" TEXT NOT NULL,
    "purpose" TEXT NOT NULL,
    "amount" NUMERIC NOT NULL,
    
    PRIMARY KEY("id")
);

CREATE TABLE "accepted_fund_risings" (
    "id" INTEGER,
    "id_no" TEXT NOT NULL,
    "recipent" TEXT NOT NULL,
    "date" NUMERIC DEFAULT CURRENT_DATE NOT NULL,
    "amount" NUMERIC NOT NULL CHECK("amount" > 0),
    "purpose" TEXT NOT NULL,

    PRIMARY KEY("id")
);

CREATE TABLE "monthly_collections" (
    "id" INTEGER,
    "batch" TEXT NOT NULL,
    "branch" TEXT NOT NULL,
    "sec" TEXT NOT NULL,
    "date" TEXT NOT NULL DEFAULT CURRENT_DATE,
    "amount" NUMERIC NOT NULL,

    PRIMARY KEY("id")
);

CREATE TABLE "finance_history" (
    "id" INTEGER,
    "amount" NUMERIC NOT NULL,
    "purpose" TEXT,
    "transaction_type" TEXT NOT NULL,
    "date" NOT NULL DEFAULT CURRENT_DATE,

    PRIMARY KEY("id")
);

CREATE TABLE "upcoming_events" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "venue" TEXT NOT NULL,
    "date" NUMERIC NOT NULL,
    "description" TEXT,
    "image" BLOB NOT NULL,

    PRIMARY KEY("id")
);

CREATE TABLE "past_events" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "venue" TEXT NOT NULL,
    "date" NUMERIC NOT NULL,
    "description" TEXT,
    "image" BLOB NOT NULL,

    PRIMARY KEY("id")
);

CREATE TABLE "core_members" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "id_no" TEXT NOT NULL,
    "mobile" TEXT NOT NULL,
    "mail" TEXT,
    "batch" TEXT,
    "role" TEXT,

    PRIMARY KEY("id")
);