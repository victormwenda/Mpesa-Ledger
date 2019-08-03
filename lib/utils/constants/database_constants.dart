final String databaseName = "MpesaLedger.db";

final String transactionsTable = "transactions";
final String unrecordedTransactionsTable = "unrecordedTransactions";
final String categoriesTable = "categories";
final String transactionCategoryTable = "transactionCategory";
final String summaryTable = "summary";
final String mpesaBalanceTable = "mpesaBalance";

final List<String> schema = [
  '''
  CREATE TABLE IF NOT EXISTS $mpesaBalanceTable (
    id INTEGER PRIMARY KEY,
    mpesaBalance REAL NOT NULL DEFAULT 0.0
  );
  ''',
  '''
  CREATE TABLE IF NOT EXISTS $transactionsTable (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    timestamp INTEGER NOT NULL,
    mpesaBalance REAL,
    amount REAL NOT NULL,
    isDeposit INTEGER NOT NULL CHECK(isDeposit = 0 or isDeposit = 1),
    transactionCost REAL NOT NULL,
    transactionId TEXT
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
    showKeywords INTEGER NOT NULL CHECK(showKeywords = 0 or showKeywords = 1),
    canDelete INTEGER NOT NULL CHECK(canDelete = 0 or canDelete = 1),
    numberOfTransactions INTEGER NOT NULL,
    createdOn INTEGER NOT NULL
  );
  ''',
  '''
  CREATE TABLE $transactionCategoryTable (
    id INTEGER PRIMARY KEY,
    transactionId INTEGER NOT NULL,
    categoryId INTEGER NOT NULL,
    FOREIGN KEY (transactionId) REFERENCES transactions(id) ON DELETE CASCADE,
    FOREIGN KEY (categoryId) REFERENCES categories(id) ON DELETE CASCADE
  );
  ''',
  '''
  CREATE TABLE $summaryTable (
    id TEXT PRIMARY KEY,
    month TEXT NOT NULL,
    monthInt TEXT NOT NULL,
    year INTEGER NOT NULL,
    deposits REAL NOT NULL,
    withdrawals REAL NOT NULL,
    transactionCost REAL NOT NULL
  );
  ''',
  '''
  INSERT INTO $mpesaBalanceTable (mpesaBalance)
    VALUES
    (0.0);
  ''',
  '''
  INSERT INTO $categoriesTable (title, description, keywords, showKeywords, canDelete,  numberOfTransactions, createdOn) 
    VALUES 
    ("Airtime", "Airtime Description", "['airtime_transaction']", 0, 0, 0, strftime('%s', 'now')),
    ("People", "People Transactions Description", "['people_transaction']", 0, 0, 0, strftime('%s', 'now')),
    ("Paybill", "Paybill Description", "['paybill_transaction']", 0, 0, 0, strftime('%s', 'now')),
    ("Buy Goods", "Buy Goods Description", "['buy_goods_transaction']", 0, 0, 0, strftime('%s', 'now')),
    ("Agent Transactions", "Agent Transactions Description", "['agent_transaction']", 0, 0, 0, strftime('%s', 'now')),
    ("Reversals", "Reversals Description", "['reversal_transaction']", 0, 0, 0, strftime('%s', 'now')),
    ("Other", "These are unknown transactions that were not identified", "['other_transaction']", 0, 0, 0, strftime('%s', 'now')),
    ("M-shwari", "Mshwari Description", "['M-shwari']", 0, 0, 0, strftime('%s', 'now'));
  '''
];