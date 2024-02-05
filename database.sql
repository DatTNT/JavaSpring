CREATE DATABASE shopapp;
USE shopapp;

--khách hàng khi muốn mua hàng => phải đăng ký tài khoản => bảng users

CREATE TABLE users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    fullname VARCHAR(100) DEFAULT '',
    phone_number VARCHAR(10) NOT NULL,
    address VARCHAR(200) DEFAULT '',
    password VARCHAR(100) NOT NULL DEFAULT '',
    created_at DATETIME,
    updated_at DATETIME,
    is_active TINYINT(1) DEFAULT 1,
    date_of_birth DATE,
    facebook_account_id INT DEFAULT 0,
    google_account_id INT DEFAULT 0
);

--Nếu không có default này thì giá trị của chúng bị null và trong quá trình code java 
--khi gọi đến câu lệnh đọc dữ liệu ra mà có giá trị null này thì rất dễ xảy ra lỗi exception
--password VARCHAR(100) NOT NULL DEFAULT '',--DÙNG SA256 ĐỂ MÃ HÓA PASSWORD()
--is_active TINYINT(1) DEFAULT 1, --xóa mềm
--Trong trường hợp đăng nhập bằng fb hoặc gg thì ta không thể nào lấy được password của fb hoặc gg nên password có thêm 1 thuộc tính default bằng ''

CREATE TABLE tokens(
    id int PRIMARY KEY AUTO_INCREMENT,
    token VARCHAR(225) UNIQUE NOT NULL,
    token_type VARCHAR(50) NOT NULL,
    expiration_date DATETIME,
    revoked TINYINT(1) NOT NULL,
    expired TINYINT(1) NOT NULL,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

--token gồm 1 chuỗi ký tự có chứa các ký tự abc, xyz từ token này ta có thể xuất thoogn tin token email, username dc gọi là claim
-- expiration_date DATETIMe thoi han cua token
-- user_id lien  --FOREIGN KEY
-- 1 user cos nhieuef tokens


CREATE TABLE social_accounts(
    id INT PRIMARY KEY AUTO_INCREMENT,
    provider VARCHAR(20) NOT NULL COMMENT 'Tên nhà social network',
    provider_id VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL COMMENT 'Email tài khoản',
    name VARCHAR(100) NOT NULL COMMENT 'Tên người dùng',
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id)
 )

--Danh mục sản phẩm 
 CREATE TABLE categories(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'Tên danh mục, vd: đồ điện tử'
 );

-- Bảng chứa sản phẩm
CREATE TABLE products(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(350) COMMENT 'Tên sản phẩm',
    price FLOAT NOT NULL CHECK(price >= 0),
    thumbnail VARCHAR(300) DEFAULT '',
    description LONGTEXT DEFAULT '',
    created_at DATETIME,
    updated_at DATETIME,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Đường link sản phẩm gọi à thumbnail VARCHAR(300) DEFAULT '',

CREATE TABLE orders(
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id),
    fullname VARCHAR(100) DEFAULT '',
    email VARCHAR(100) DEFAULT '',
    phone_number VARCHAR(20) NOT NULL,
    address VARCHAR(200) NOT NULL,
    note VARCHAR(100) DEFAULT
)