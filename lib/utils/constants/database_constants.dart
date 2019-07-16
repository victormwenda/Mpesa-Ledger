final List<String> schema = [
  '''
  CREATE TABLE IF NOT EXISTS transactions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    timestamp INTEGER NOT NULL,
    mpesa_balance REAL,
    amount REAL NOT NULL,
    is_deposit INTEGER NOT NULL CHECK(is_deposit = 0 or is_deposit = 1),
    transaction_cost REAL NOT NULL,
    transaction_id TEXT
  );
  ''',
  '''
  CREATE TABLE IF NOT EXISTS unknown_transactions (
    id INTEGER PRIMAMRY KEY,
    body TEXT NOT NULL,
    timestamp INTEGER NOT NULL,
    mpesa_balance REAL NOT NUll,
    amounts TEXT,
    transaction_cost REAL NOT NULL,
    transaction_id TEXT
  );
  ''',
  '''
  CREATE TABLE IF NOT EXISTS unrecorded_transactions (
    id INTEGER PRIMARY KEY,
    timestamp INTEGER NOT NULL,
    body TEXT NOT NULL
  );
  ''',
  '''
  CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    keywords TEXT NOT NULL,
    show_keywords INTEGER NOT NULL CHECK(show_keywords = 0 or show_keywords = 1),
    can_delete INTEGER NOT NULL CHECK(can_delete = 0 or can_delete = 1),
    number_of_transactions INTEGER NOT NULL,
    created_on INTEGER NOT NULL
  );
  ''',
  '''
  CREATE TABLE transaction_category (
    id INTEGER PRIMARY KEY,
    transaction_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
  );
  ''',
  '''
  CREATE TABLE summary (
    id INTEGER PRIMARY KEY,
    month TEXT NOT NULL,
    year INTEGER NOT NULL,
    deposits REAL NOT NULL,
    withdrawals REAL NOT NULL,
    transaction_cost REAL NOT NULL
  );
  ''',
  '''
  INSERT INTO categories (title, description, keywords, show_keywords, can_delete,  number_of_transactions, created_on) 
    VALUES 
    ("Airtime", "Airtime Description", "[]", 0, 0, 0, strftime('%s', 'now')),
    ("People", "Peeple Transactions Description", "[]", 0, 0, 0, strftime('%s', 'now')),
    ("Paybill", "Paybill Description", "[]", 0, 0, 0, strftime('%s', 'now')),
    ("Buy Goods", "Buy Goods Description", "[]", 0, 0, 0, strftime('%s', 'now')),
    ("Agent Transactions", "Agent Transactions Description", "[]", 0, 0, 0, strftime('%s', 'now')),
    ("Reversals", "Reversals Description", "[]", 0, 0, 0, strftime('%s', 'now'))
  '''
];

final String databaseName = "MpesaLedger.db";
