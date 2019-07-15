String date = "\\d{1,2}/\\d{1,2}/\\d{2,4}";
String time = "\\d{1,2}:\\d{1,2}\\s?([Aa][Mm]|[Pp][Mm])";
String amount = "\\d+\\.\\d{1,2}";
String currency = "[Kk][Ss][Hh]\\s?";
String mpesaBalance = "(?<=M-PESA\\s?(account\\s?)?(balance\\s?)?(was|is)\\s?$currency)$amount";
String tranactionCost = "(?<=[Tt]ransaction\\s?cost,?\\s?$currency)$amount";
String transactionId = "[A-Z0-9]+(?=\\s?[Cc]onfirmed)";
String phoneNumber = "(254\\s?|0)?7\\d{8}";

// AIRTIME REGEX
String buyAirtimeForMyself = "(?<=[Yy]ou\\s?bought\\s?$currency)$amount(?=\\s?of\\s?airtime\\s?on)";
String buyAirtimeForSomeone = "(?<=[Yy]ou\\s?bought\\s?$currency)$amount(?=\\s?of\\s?airtime\\s?for\\s?$phoneNumber)";

// SEND AND RECEIVE MONEY TO AND FROM PEOPLE REGEX
String sendToPerson = "(?<=$currency)$amount(?=\\s?sent\\s?to\\s?.*\\s?$phoneNumber)";
String sentToPersonName = "(?<=sent\\s?to\\s?).*(?=\\s?$phoneNumber)"; // <- pass the actual phone number
String receiveFromPerson = "(?<=received(\\s+)?$currency)$amount(?=\\s?from\\s?.*\\s?$phoneNumber)";
String receiveFromPersonName = "(?<=from\\s?) .*(?=\\s?$phoneNumber)"; // <- pass the actual phone number

// PAYBILL REGEX
String sendToPaybill = "(?<=$currency)$amount(?=\\s?sent\\s?to\\s?.*\\s?for\\s?account)";
String sendToPaybillBusinessName = "(?<=sent\\s?to\\s?).*(?=\\s?for\\s?account)";
String receiveFromPaybill = "(?<=received(\\s+)?$currency)$amount(?=\\s?from\\s?.*\\s?on)";
String receiveFromPaybillBusinessName = "(?<=from\\s?).*(?=\\s?on\\s?$date)";

// BUY GOODS REGEX
String sendToBuyGoods = "(?<=$currency)$amount(?=\\s?paid\\s?to)";
String sendToBuyGoodsBusinessName = "(?<=paid\\s?to\\s?).*(?=\\s?on\\s?$date)";

// SEND AND RECEIVE TO AND FROM AGENT REGEX
String sendToAgent = "(?<=[Gg]ive\\s?$currency)$amount(?=\\s?cash\\s?to)";
String sendToAgentBusinessName = "(?<=cash\\s?to\\s?).*(?=\\s?New\\s?M-PESA)";
String receiveFromAgent = "(?<=[Ww]ithdraw\\s?$currency)$amount(?=\\s?from)";
String receiveFromAgentBusinessName = "(?<=from\\s?\\d+\\s?-\\s?).*(?=\\s?New\\s?M-PESA)";

// REVERSAL REGEX
String reversalToAccount = "(?<=reversed\\s?on\\s?$date\\s?at\\s?$time\\s?and\\s?$currency)$amount(?=\\s?is\\s?credited)";
String reversalFromAccount = "(?<=reversed\\s?on\\s?$date\\s?at\\s?$time\\s?and\\s?$currency)$amount(?=\\s?is\\s?debited)";