final String databaseName = "MpesaLedger.db";

final String transactionsTable = "transactions";
final String unknownTransactionsTable = "unknownTransactions";
final String unrecordedTransactionsTable = "unrecordedTransactions";
final String categoriesTable = "categories";
final String transactionCategoryTable = "transactionCategory";
final String summaryTable = "summary";

final List<String> schema = [
  '''
  CREATE TABLE IF NOT EXISTS $transactionsTable (
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
  CREATE TABLE IF NOT EXISTS $unknownTransactionsTable (
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
  CREATE TABLE IF NOT EXISTS $unrecordedTransactionsTable (
    id INTEGER PRIMARY KEY,
    timestamp INTEGER NOT NULL,
    body TEXT NOT NULL
  );
  ''',
  '''
  CREATE TABLE IF NOT EXISTS $categoriesTable (
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
  CREATE TABLE $transactionCategoryTable (
    id INTEGER PRIMARY KEY,
    transaction_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
  );
  ''',
  '''
  CREATE TABLE $summaryTable (
    id INTEGER PRIMARY KEY,
    month TEXT NOT NULL,
    year INTEGER NOT NULL,
    deposits REAL NOT NULL,
    withdrawals REAL NOT NULL,
    transaction_cost REAL NOT NULL
  );
  ''',
  '''
  INSERT INTO $categoriesTable (title, description, keywords, show_keywords, can_delete,  number_of_transactions, created_on) 
    VALUES 
    ("Airtime", "Airtime Description", "["airtime_transaction"]", 0, 0, 0, strftime('%s', 'now')),
    ("People", "People Transactions Description", "["people_transaction"]", 0, 0, 0, strftime('%s', 'now')),
    ("Paybill", "Paybill Description", "["paybill_transaction"]", 0, 0, 0, strftime('%s', 'now')),
    ("Buy Goods", "Buy Goods Description", "["buy_goods_transaction"]", 0, 0, 0, strftime('%s', 'now')),
    ("Agent Transactions", "Agent Transactions Description", "["agent_transaction"]", 0, 0, 0, strftime('%s', 'now')),
    ("Reversals", "Reversals Description", "["reversal_transaction"]", 0, 0, 0, strftime('%s', 'now')),
    ("Other", "These are unknown transactions, that were not identified", "["other_transaction"]", 0, 0, 0, strftime('%s', 'now'))
  '''
];
