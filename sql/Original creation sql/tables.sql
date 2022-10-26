USE VideoStore

CREATE TABLE address(
    street varchar(100),
    zipcode varchar(10),
    state varchar(100),
    city varchar(100),
    country varchar(100) not null,
    primary key(street,zipcode)
)

CREATE TABLE store(
    storeId int NOT NULL identity(1,1),
    location varchar(100),
    street varchar(100),
    zipCode varchar(10) not null,
    primary key(storeId),
    foreign key(street,zipcode) references address(street,zipcode)
)

CREATE TABLE employee(
    employeeId int NOT NULL identity(1,1),
    type varchar(40) not null,
    firstName varchar(40),
    lastName varchar(40),
    salary decimal(8,2) not null,
    street varchar(100) not null,
    zipCode varchar(10) not null,
    title varchar(4) not null,
    storeId int not null,
    primary key(employeeId),
    foreign key(storeId) references store(storeId),
    foreign key(street,zipcode) references address(street,zipcode)
)

CREATE TABLE lateCharge(
    categoryName varchar(20),
    lateCharge DECIMAL(6,2) not null,
    primary key(categoryName)
)

CREATE TABLE itemCatalog(
    itemId int NOT NULL identity(1,1),
    itemName varchar(255) not null,
    chargeDaily decimal(6,2) not null,
    purchaseDate date not null,
    categoryName varchar(20) not null,
    imageUrl varchar(500),
    primary key(itemId),
    foreign key(categoryName) references lateCharge(categoryName)
)

CREATE TABLE videoCamera(
    itemId int not null,
    brand varchar(40) not null,
    madeBy varchar(200),
    primary key(itemId),
    foreign key(itemId) references itemCatalog(itemId)
)

CREATE TABLE vcr(
    itemId int not null,
    type varchar(10) not null,
    brand varchar(40) not null,
    madeBy varchar(200),
    primary key(itemId),
    foreign key(itemId) references itemCatalog(itemId)
)

CREATE TABLE movieDetails(
    movieId int NOT NULL identity(1,1),
    movieTitle varchar(100) not null,
    director varchar(100) not null,
    producer varchar(100) not null,
    actor varchar(100) not null,
    actor2 varchar(100),
    releaseDate date not null,
    primary key(movieId),
)

CREATE TABLE movieItem(
    itemId int not null,
    movieId int not null,
    type varchar(3) not null,
    primary key(itemId),
    foreign key(itemId) references itemCatalog(itemId),
    foreign key(movieId) references movieDetails(movieId)
)

CREATE TABLE maxItems(
    storeId int not null,
    itemId int not null,
    maxItems INT not null,
    primary key(storeId,itemId),
    foreign key(storeId) references store(storeId),
    foreign key(itemId) references itemCatalog(itemId)
)

CREATE TABLE inventory(
    invId int not null identity(1,1),
    itemId int not null,
    storeId int not null,
    status BIT not null,
    primary key(invId),
    foreign key(itemId) references itemCatalog(itemId),
    foreign key(storeId) references store(storeId)
)

CREATE TABLE customer(
    customerId int NOT NULL identity(1,1),
    title varchar(4) not null,
    firstName varchar(40) not null,
    lastName varchar(40) not null,
    password varchar(200) not null,
    phone varchar(12) not null,
    zipcode varchar(10),
    street varchar(100),
    driverLicense varchar(50),
    cardNo varchar(50),
    cardType varchar(50),
    primary key(customerId),
    foreign key(street,zipcode) references address(street,zipcode)
)

CREATE TABLE transactions(
    transId int NOT NULL identity(1,1),
    storeId int not null,
    customerId int not null,
    type varchar(10) not null,
    startDate date not null,
    dueDate date not null,
    primary key(transId),
    foreign key(storeId) references store(storeId),
    foreign key(customerId) references customer(customerId)
)

CREATE TABLE rentPayment(
    paymentId int NOT NULL identity(1,1),
    transId int not null,
    returnDate date,
    primary key(paymentId),
    foreign key(transId) references transactions(transId)
)

CREATE TABLE transItems(
    transId int not null,
    invId int not null,
    primary key(transId,invId),
    foreign key(transId) references transactions(transId),
    foreign key(invId) references inventory(invId)
)