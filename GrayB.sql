USE master
GO

-- Drop the database if it already exists
IF  EXISTS (
	SELECT name 
		FROM sys.databases 
		WHERE name = N'GrayB'
)
DROP DATABASE GrayB
GO

CREATE DATABASE GrayB
GO

USE GrayB
GO

create table Category(
	CategoryID		int identity(1,1) primary key,
	CategoryName	nvarchar(50) not null,
)

create table Product(
	ProductID	int identity(1,1) primary key,
	ProductName	nvarchar(200) not null,
	CategoryID	int foreign key references Category(CategoryID) on delete cascade on update cascade,
	Descriptions	nvarchar(500),
	Price	money not null,
	DateCreate datetime not null,
	DateUpdate	datetime not null
)


create table ImageProduct(
	ImageID	int identity(1,1) primary key,
	Images nvarchar(300),
	ProductID	int foreign key references Product(ProductID) on delete cascade on update cascade,
)

--drop table ChiTietAnh
---------------------------------
create table ProductDetail(
	ImageID	int foreign key(ImageID) references ImageProduct(ImageID) on delete cascade on update cascade,
	Size	int,
	primary key(Size,ImageID),
)

--drop table PickSP
create table Roles(
	RoleID		int identity(1,1) not null primary key,
	RoleName	nvarchar(100) not null
)
create table Users(
	UserID		int identity(1,1) not null primary key,
	UserName	nvarchar(50) not null,
	Password	varchar(50) not null,
	Name		nvarchar(100) not null,
	Phone		varchar(20) not null,
	Address		nvarchar(500) not null,
	Email		varchar(50),
	Status		bit not null,
	RoleID	int foreign key(RoleID) references Roles(RoleID) on delete cascade on update cascade,
	
)


create table Orders(
	OrderID			int identity(1,1) not null primary key,
	UserID			int foreign key references Users(UserID) on delete cascade on update cascade,
	UserName		nvarchar(50) not null,
	Phone			varchar(20) not null,
	Address			nvarchar(100) not null,
	Email			varchar(50),
	DateCreate		datetime,
	Status			bit,
	Note			nvarchar(50),
)
--drop table HoaDon
create table OrderDetail(
	OrderID		int foreign key references Orders(OrderID) on delete cascade on update cascade,
	ImageID		int,
	Size		int,
	foreign key (Size,ImageID) references ProductDetail(Size,ImageID) on delete cascade on update cascade,
	primary key (OrderID,Size,ImageID),
	Amount		int not null,
)

create table BlogCategory(
	BlogCategoryID int identity(1,1) primary key,
	BlogCategoryName nvarchar(500)
)
Create table Blog(
	BlogID		int identity(1,1) primary key,
	BlogName	nvarchar(100),
	DateCreate	datetime,
	Content		ntext,
	Images		nvarchar(300),
	BlogCategoryID		int foreign key references BlogCategory(BlogCategoryID) on delete cascade on update cascade,
	
)
create table Contact(
	ContactID	int identity(1,1) primary key,
	CustomerName	nvarchar(100),
	Subject nvarchar(200),
	Content nvarchar(500),
	Email	varchar(50),
	Phone	varchar(20),
	Status	bit,
	DateContact	datetime
)

create table Introduce(
	Introduce int identity(1,1) primary key,
	Detail ntext
)

----------------------insert----------------------
insert into Category(CategoryName) values
(N'Giày Nike'),
(N'Giày Adias'),
(N'Giày Vans'),
(N'Giày Converse'),
(N'Giày Puma'),
(N'Giày Balenciaga')


insert into Product(ProductName, CategoryID, Descriptions, Price, DateCreate, DateUpdate) values
(N'Giày Thể Thao XSPORT Ni.ke air force 1 Rep 1:1 HFV753',1,N'Giày Thể Thao XSPORT Ni.ke air force 1 Rep 1:1 thiết kế đẹp mắt, kiểu dáng hiện đại. Với đôi giày thời trang này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','550000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao XSPORT Ni.ke Jordan 1 F1 Running',1,N'Giày Thể Thao XSPORT Ni.ke Jordan 1 F1 chất liệu cao cấp, bền đẹp theo thời gian. Thiết kế thời trang. Kiểu dáng phong cách.Phối màu tinh tế và đẹp mắt. Độ bền cao. Dễ phối đồ. Với đôi giày thời trang này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','350000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao XSPORT Ni.ke Jordan Low REP Running',1,N'Giày Thể Thao XSPORT Ni.ke Jordan Low REP có thiết kế trẻ trung, năng động đến từ thương hiệu Nike nổi tiếng của Mỹ được làm từ chất liệu cao cấp, bền đẹp trong suốt quá trình sử dụng.','750000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Nike Air Max Verona Running',1,N'Giày Thể Thao Nike Air Max Verona Pink/Black Màu Đen Hồng thiết kế đẹp mắt, kiểu dáng hiện đại. Với đôi giày thời trang này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','325000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Nike Air Force 1 Shadow Crimson Tint',1,N'Giày Thể Thao Nike Air Force 1 Shadow Crimson Tint CI0919-107 với thiết kế thời trang từ thương hiệu Nike nổi tiếng của Mỹ. Giày Thể Thao Nike Air Force 1 Shadow Crimson Tint CI0919-107  sở hữu gam màu trẻ trung cùng chất liệu cao cấp sẽ cho bạn trải nghiệm tuyệt vời khi đi lên chân.','330000','10-12-2021','10-12-2021'),
(N'Giày Nike Jordan 1 Mid University 76WBFHW',1,N'Giày Thể Thao Nike Air Jordan 1 Mid GS  554725-175 có thiết kế trẻ trung, năng động đến từ thương hiệu Nike nổi tiếng của Mỹ. Giày Nike Air Jordan 1 Mid GS  554725-175 được làm từ chất liệu cao cấp, bền đẹp trong suốt quá trình sử dụng.','550000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Nike Air Jordan 1 HG9WEFRHW',1,N'Giày Thể Thao Nike Air Jordan 1 có thiết kế trẻ trung, năng động đến từ thương hiệu Nike nổi tiếng của Mỹ được làm từ chất liệu cao cấp, bền đẹp trong suốt quá trình sử dụng.','5900000','10-12-2021','10-12-2021'),
(N'Giày Nike Air Jordan 1 Mid Se Union Black Toe',1,N'Giày Nike Air Jordan 1 Mid Se Union Black Toe có thiết kế trẻ trung, năng động đến từ thương hiệu Nike nổi tiếng của Mỹ được làm từ chất liệu cao cấp, bền đẹp trong suốt quá trình sử dụng.','590000','10-12-2021','10-12-2021'),
(N'Giày Nike Dunk Low SE Multi Camo 97HFSJGW',1,N'Giày Nike Dunk Low SE Multi Camocó thiết kế trẻ trung, năng động đến từ thương hiệu Nike nổi tiếng của Mỹ được làm từ chất liệu cao cấp, bền đẹp trong suốt quá trình sử dụng.','720000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Nike Air Max 1 Se Volt Rush',1,N'Giày Thể Thao Nike Air Max 1 Se Volt Rush có thiết kế trẻ trung, năng động đến từ thương hiệu Nike nổi tiếng của Mỹ được làm từ chất liệu cao cấp, bền đẹp trong suốt quá trình sử dụng.','320000','10-12-2021','10-12-2021'),
(N'GiàyThể Thao Nike Air Zoom Structure GHKS97463',1,N'GiàyThể Thao Nike Air Zoom Structure có thiết kế trẻ trung, năng động đến từ thương hiệu Nike nổi tiếng của Mỹ được làm từ chất liệu cao cấp, bền đẹp trong suốt quá trình sử dụng.','340000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Nike Downshifter 10 Running SHGFSK963',1,N'Giày Thể Thao Nike Downshifter 10 Running có thiết kế trẻ trung, năng động đến từ thương hiệu Nike nổi tiếng của Mỹ được làm từ chất liệu cao cấp, bền đẹp trong suốt quá trình sử dụng.','170000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Nike Epic React Infinity Fk Phối Màu',1,N'Giày Thể Thao Nike Epic React Infinity Fk Phối Màu có thiết kế trẻ trung, năng động đến từ thương hiệu Nike nổi tiếng của Mỹ được làm từ chất liệu cao cấp, bền đẹp trong suốt quá trình sử dụng.','350000','10-12-2021','10-12-2021'),

(N'Giày Thể Thao XSPORT Adi.das Alpha.bounce Instinct M',2,N'Giày Thể Thao XSPORT Adi.das Alpha.bounce Instinct M Phối Màu là đôi giày dành cho các chàng trai đam mê thể thao được thiết kế vô cùng hiện đại đến từ thương hiệu Adidas nổi tiếng. Sở hữu gam màu nổi bật cùng chất liệu cao cấp Adidas Harden Vol5 Futurenatural White FZ1071 mang lại cảm giác thoải mái khi vận động, chạy nhảy nhiều.','350000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao XSPORT Prophere Rep 1:1 57GFH',2,N'Giày Thể Thao XSPORT Prophere Replà mẫu giày hoài niệm phong cách hầm hố lấy cảm hứng từ nền văn hóa đại chúng của thập niên 90 của thương hiệu Adidas nổi tiếng.','500000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao XSPORT Ultra Boost 74321',3,N'Giày Thể Thao XSPORT Ultra Boost là đôi giày cao cấp đến từ thương hiệu Adias nổi tiếng của nước Mỹ. Với đôi giày Vans Classic Sk8-Hi Black/White này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','1600000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Adidas Runfalcon 125473',2,N'Giày Thể Thao Adidas Runfalcon Màu Đen Trắng là đôi giày thể thao dành cho nam đến từ thương hiệu Adidas nổi tiếng của Đức. Adidas Runfalcon được thiết kế mang nét thể thao phóng đại, khỏe khoắn mang đầy nét năng động.','1600000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Adidas Original Stan Smith',2,N'Giày Thể Thao Adidas Original Stan Smith M20324 Màu Trắng đến từ thương hiệu Adidas nổi tiếng của Đức. Adidas Original Stan Smith được thiết kế mang nét thể thao khỏe khoắn, năng động cho bạn trải nghiệm tuyệt vời khi đi lên chân.','1600000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Adidas Neo Cloudfoam Lite Racer Olive',2,N'Giày Thể Thao Adidas Neo Cloudfoam Lite Racer Olive Màu Xanh Green là một trong những sản phẩm nổi tiếng của Adidas với thiết kế được tính toán tốt nhất dành cho người dùng: mềm mại, thoải mái, kiểu dáng thể thao trẻ trung, chất liệu bền đẹp. Với đôi giày thời trang này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','1500000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Adidas Ultraboost 20 USA',2,N'Giày Thể Thao Adidas Ultraboost 20 USA Màu Trắng đến từ thương hiệu Adidas nổi tiếng của Đức. Adidas Ultraboost 20 USA được thiết kế mang nét thể thao khỏe khoắn, năng động cho bạn trải nghiệm tuyệt vời nhất khi đi lên chân.','2500000','10-12-2021','10-12-2021'),
(N'Giày Bóng Rổ Adidas Harden Vol5 Futurenatural',2,N'Giày Bóng Rổ Adidas Harden Vol5 Futurenatural White FZ1071 Phối Màu là đôi giày dành cho các chàng trai đam mê thể thao được thiết kế vô cùng hiện đại đến từ thương hiệu Adidas nổi tiếng. Sở hữu gam màu nổi bật cùng chất liệu cao cấp Adidas Harden Vol5 Futurenatural White FZ1071 mang lại cảm giác thoải mái khi vận động, chạy nhảy nhiều.','3500000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Adidas Falcon Lite Racer Olive',2,N'Giày Thể Thao Adidas Falcon Grey Pink D96698 Màu Xám là mẫu giày hoài niệm phong cách hầm hố lấy cảm hứng từ nền văn hóa đại chúng của thập niên 90 của thương hiệu Adidas nổi tiếng.','1650000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Adidas D Rose 11 Lite Racer Olive',2,N'Giày Thể Thao Adidas D Rose 11 FY9988 Màu Xanh được thiết kế hiện đại đến từ thương hiệu Adidas nổi tiếng. Với gam màu thanh lịch Adidas D Rose 11 FY9988 Màu Xanh cho bạn trở nên sành điệu và thật phong cách khi đi lên chân.','2600000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Adidas D Rose 12Lite Racer Olive',2,N'Giày Thể Thao Adidas D Rose 12 FY9988 Màu Xanh được thiết kế hiện đại đến từ thương hiệu Adidas nổi tiếng. Với gam màu thanh lịch Adidas D Rose 11 FY9988 Màu Xanh cho bạn trở nên sành điệu và thật phong cách khi đi lên chân.','2600000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Adidas Pro Bounce 2019',2,N'Giày Thể Thao Adidas Pro Bounce 2019 EE3898 Màu Đỏ được thiết kế hiện đại đến từ thương hiệu Adidas nổi tiếng. Với gam màu thanh lịch Adidas Pro Bounce 2019 EE3898 Màu Đỏ cho bạn trở nên sành điệu và thật phong cách khi đi lên chân.','1790000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Adidas X9000L3 H.RDY M',2,N'Giày Thể Thao Adidas X9000L3 H.RDY M FY0798 Màu Trắng được thiết kế hiện đại đến từ thương hiệu Adidas nổi tiếng. Với gam màu thanh lịch Adidas X9000L3 H.RDY M FY0798 cho bạn trở nên sành điệu và thật phong cách khi đi lên chân.','1680000','10-12-2021','10-12-2021'),

(N'Giày Vans Mule Checkerboard GHJGBAK7463',3,N'Giày Vans Mule Checkerboard Màu Xanh Navy là đôi giày Unisex dành cho cả nam và nữ đến từ thương hiệu Vans nổi tiếng của nước Mỹ. Với đôi giày Vans thời trang này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','500000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Vans Classic SGHBSJ8752',3,N'Giày Thể Thao Vans Classic Sk8-Hi Black/White Màu Đen là đôi giày cao cấp đến từ thương hiệu Vans nổi tiếng của nước Mỹ. Với đôi giày Vans Classic Sk8-Hi Black/White này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','1600000','10-12-2021','10-12-2021'),
(N'Giày Vans Old Skool X J.Crew SDHGA8735',3,N'Giày Vans Old Skool X J.Crew Reflecting Pond Màu Xanh là đôi giày cao cấp đến từ thương hiệu Vans nổi tiếng của nước Mỹ. Với đôi giày Vans Old Skool X J.Crew Reflecting Pond này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','1900000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Vans Checkerboard Slip On',3,N'Với kiểu dáng Style trẻ trung, đẹp mắt, mang đậm phong cách, cá tính cho người mang. Phần đế giày có độ ma sát cao hạn chế trơn trượt cho người sử dụng.Không chỉ dành cho người yêu sneaker, đôi giày còn phù hợp với những tín đồ đam mê thể thao với phong cách thời trang năng động, đậm nét cá tính.','1300000','10-12-2021','10-12-2021'),
(N'Giày Vans Asher All White FHSJFB8W4T6',3,N'Giày Vans Ward Triple White Màu Trắng là đôi giày cao cấp đến từ thương hiệu Vans nổi tiếng của nước Mỹ. Với đôi giày Vans Ward Triple White này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','1400000','10-12-2021','10-12-2021'),
(N'Giày Sneakers Vans Style 36 Marshmallow Blue Màu Trắng',3,N'Giày Sneaker Vans Style 36 Marshmallow Blue Màu Trắng Size 41 đến từ thương hiệu Vans nổi tiếng của nước Mỹ. Với đôi giày Sneaker Vans thời trang này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','2400000','10-12-2021','10-12-2021'),
(N'Giày Vans Ward Triple White Màu Trắng',3,N'Giày Vans Ward Triple White Màu Trắng là đôi giày cao cấp đến từ thương hiệu Vans nổi tiếng của nước Mỹ. Với đôi giày Vans Ward Triple White này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','1500000','10-12-2021','10-12-2021'),
(N'Giày Vans Vault Old Skool – Marshmallow Multicolor Màu Trắng',3,N'Giày Vans Vault Old Skool – Marshmallow Multicolor Màu Trắng đến từ thương hiệu Vans nổi tiếng của nước Mỹ, với thiết kế thời trang đôi giày sẽ cho bạn trải nghiệm tuyệt vời nhất khi đi lên chân.','2600000','10-12-2021','10-12-2021'),

(N'Giày Thể Thao Converse All-Court - 168785C Màu Đen',4,N'Giày Thể Thao Converse All-Court - 168785C Màu Đen sản phẩm đến từ thương hiệu Converse nổi tiếng của Mỹ. Với thiết kế thời trang, đôi giày đang nhận được sự yêu thích của rất nhiều bạn trẻ.','1800000','10-12-2021','10-12-2021'),
(N'Giày Converse Chuck Taylor All Star Lift Leather Low 561680C',4,N'Giày Converse Chuck Taylor All Star Lift Leather Low 561680C Màu Trắng là sản phẩm đến từ thương hiệu Converse nổi tiếng của Mỹ. Với thiết kế thời trang cùng màu sắc thanh lịch đôi giày đang nhận được sự yêu thích của rất nhiều bạn trẻ.','2400000','10-12-2021','10-12-2021'),
(N'Giày Converse Chuck Taylor All Star 1970s',4,N'Giày Converse Chuck Taylor All Star 1970s Colors Vintage Canvas - 168504V Màu Nâu Nhạt với thiết kế Độc - Lạ - Phá cách đến từ thương hiệu Converse nổi tiếng của Mỹ. Với gam màu thanh lịch Converse Chuck Taylor đang là item HOT được nhiều bạn trẻ săn đón.','2500000','10-12-2021','10-12-2021'),
(N'Giày Converse Chuck Taylor All Star CX 168566C Màu Xanh Navy',4,N'Giày Converse Chuck Taylor All Star CX 168566C Màu Xanh Navy sản phẩm đến từ thương hiệu Converse nổi tiếng của Mỹ. Với thiết kế Độc - Lạ - Phá cách, cùng gam màu nổi bật đôi giày đang nhận được sự quan tâm từ rất nhiều các bạn trẻ.','2600000','10-12-2021','10-12-2021'),
(N'Giày Converse Chuck Taylor All Star 1970s Renew - 168615C Màu Vàng',4,N'Giày Converse Chuck Taylor All Star 1970s Renew - 168615C Màu Vàng với thiết kế Độc - Lạ - Phá cách đến từ thương hiệu Converse nổi tiếng của Mỹ. Với gam màu nổi bật Converse Chuck Taylor đang là item HOT được nhiều bạn trẻ săn đón.','2450000','10-12-2021','10-12-2021'),
(N'Giày Converse Chuck Taylor All Star CX 168568C ',4,'Giày Converse Chuck Taylor All Star CX 168568C Màu Đen sản phẩm đến từ thương hiệu Converse nổi tiếng của Mỹ. Với thiết kế thời trang, đôi giày đang nhận được sự yêu thích của rất nhiều bạn trẻ.','2450000','10-12-2021','10-12-2021'),
(N'Giày Converse Chuck Taylor All Star Renew - 168593V Màu Xanh Green',4,N'Giày Converse Chuck Taylor All Star Renew - 168593V Màu Xanh Green sản phẩm đến từ thương hiệu Converse nổi tiếng của Mỹ. Với thiết kế Độc - Lạ - Phá cách, cùng gam màu nổi bật đôi giày đang nhận được sự quan tâm từ rất nhiều các bạn trẻ.','1850000','10-12-2021','10-12-2021'),
(N'Giày Converse CDG Play X Chuck Taylor 1970s Cream White',4,N'Giày Converse CDG Play X Chuck Taylor 1970s Cream White 70 Low 150207C Màu Trắng với thiết kế Độc - Lạ - Phá cách đến từ thương hiệu Converse nổi tiếng của Mỹ. Với gam màu thanh lịch Converse CDG Play X Chuck Taylor 1970s Cream White 70 Low 150207C  đang là item HOT được nhiều bạn trẻ săn đón.','3450000','10-12-2021','10-12-2021'),
(N'Giày Converse Chuck Taylor All Star CX - 168570C Màu Vàng',4,N'Giày Converse Chuck Taylor All Star CX - 168570C Màu Vàng sản phẩm đến từ thương hiệu Converse nổi tiếng của Mỹ. Với thiết kế thời trang cùng màu sắc nổi bật đôi giày đang nhận được sự yêu thích của rất nhiều bạn trẻ.','2500000','10-12-2021','10-12-2021'),
(N'Giày Converse Chuck Taylor All Star CX - 168570C Màu Vàng',4,N'Giày Thể Thao Converse 1970s High Black Fire Màu Đen Đỏ sản phẩm đến từ thương hiệu Converse nổi tiếng của Mỹ. Với thiết kế Độc - Lạ - Phá cách,  đôi giày đang nhận được sự quan tâm từ rất nhiều các bạn trẻ.','2700000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Puma RS-X X3 Puzzle Multi 371570-04',5,N'Giày Thể Thao Puma RS-X X3 Puzzle Multi 371570-04 với thiết kế trẻ trung đến từ thương hiệu Puma nổi tiếng của Đức. Giày Puma RS-X X3 sẽ cho bạn những trải nghiệm tuyệt vời khi đi lên chân.','2000000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Puma Muse X2 Metallic 37083802 Màu Trắng',5,N'Giày Thể Thao Puma Muse X2 Metallic 37083802 Màu Trắng với thiết kế trẻ trung đến từ thương hiệu Puma nổi tiếng của Đức. Giày Puma Muse X2 Metallic Màu Trắng sẽ cho bạn những trải nghiệm tuyệt vời khi đi lên chân.','1700000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Puma Oslo-City Lux Màu Trắng',5,N'Giày Thể Thao Puma Oslo-City Lux Màu Trắng với thiết kế trẻ trung đến từ thương hiệu Puma nổi tiếng của Đức. Giày Puma Oslo-City Lux được làm từ chất liệu cao cấp sẽ cho bạn trải nghiệm tuyệt vời khi đi lên chân.','1990000','10-12-2021','10-12-2021'),
(N'Giày Puma Ralph Sampson Màu Trắng ',5,N'Giày Puma Ralph Sampson Màu TrắngSize 41 với thiết kế trẻ trung được nhiều tín đồ thời trang săn đón. Với gam màu sang trọng PPuma Ralph Sampson cho bạn thêm năng động và nổi bật.','1700000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Puma Caracal Suede Màu Đen',5,N'Giày Thể Thao Puma Caracal Suede Màu Đen','1700000','12-12-2020','12-12-2020'),
(N'Giày Thể Thao Puma Smash V2 Black Màu Đen Trắng ',5,N'Giày Thể Thao Puma Smash V2 Black Màu Đen Trắng là mẫu giày mới nhất được đông đảo tín đồ thời trang yêu thích trong thời gian gần đây. Đôi giày được thiết kế kiểu dáng thời trang và được làm từ chất liệu cao cấp bền đẹp trong suốt quá trình sử dụng.','1900000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Puma Roma Scuderia Ferrari',5,N'Giày Thể Thao Puma Roma Scuderia Ferrari Size 38.5 (Trắng) là mẫu giày nổi bật của hãng Puma phù hợp với các quý ông năng động, trẻ trung.Giày Puma Roma Scuderia Ferrari được thiết kế với phong cách hoàn toàn mới: thanh thoát và giản dị nhưng có nét độc đáo riêng. Sản phẩm kết hợp giữa Puma và Ferrari, những thương hiệu mà tất cả chúng ta đều biết và yêu thích.','1990000','10-12-2021','10-12-2021'),
(N'Giày Puma Bari Mule Men',5,N'Giày Puma Bari Mule Mens Shoes Màu Đen với thiết kế đẹp - độc đáo đến từ thương hiệu Puma nổi tiếng của Đức. Với những tín đồ mê giày hở gót thì Puma Mule Pink sẽ không còn là cái tên xa lạ nữa.','1340000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Puma Scuderia Ferrari Speed HYBRID Running',5,N'Giày Thể Thao Puma Scuderia Ferrari Speed HYBRID Running Màu Trắng là đôi giàythời trang dành cho nam đến từ thương hiệu Puma nổi tiếng. Với thiết kế hiện đại đôi giày Puma Scuderia Ferrari Speed HYBRID Running sẽ cho bạn trải nghiệm tuyệt vời nhất khi đi lên chân.','1990000','10-12-2021','10-12-2021'),
(N'Giày Thể Thao Puma Basket 90680 Lux Màu Trắng ',5,N'Giày Thể Thao Puma Basket 90680 Lux Màu Trắng Size 40.5 được thiết kế trẻ trung, khỏe khoắn mang đậm phong cách của thương hiệu Puma. Giày Puma Basket 90680 Lux sẽ cho bạn trải nghiệm tuyệt vời nhất khi đi lên chân.','1970000','12-12-2020','12-12-2020')

insert into ImageProduct(ProductID,Images)values
(1,N'nikeairforcexanh.PNG'),
(1,N'nikeairforcehong.PNG'),
(1,N'nikeairforcexam.PNG'),
(2,N'jordancam.PNG'),
(2,N'jordanden.PNG'),
(2,N'jordando.PNG'),
(2,N'jordantim.PNG'),
(3,N'jordanlowxanhden.PNG'),
(3,N'jordanlowxam.PNG'),
(3,N'jordanlowtrang.PNG'),
(4,N'NIKE1.jpg'),
(5,N'NIKE2.jpg'),
(6,N'NIKE3.jpg'),
(7,N'NIKE4.jpg'),
(8,N'NIKE5.jpg'),
(9,N'NIKE6.jpg'),
(10,N'NIKE7.jpg'),
(11,N'NIKE8.jpg'),
(12,N'NIKE9.jpg'),
(13,N'NIKE10.jpg'),
(14,N'adiasalphaden.PNG'),
(14,N'adiasalphado.PNG'),
(14,N'adiasalphaxam.PNG'),
(14,N'adiasalphaxamden.PNG'),
(15,N'prophexanhduong.PNG'),
(15,N'prophehong.PNG'),
(15,N'prophexanhreu.PNG'),
(15,N'prophedo.PNG'),
(15,N'propheden.PNG'),
(15,N'prophekecam.PNG'),

(16,N'ultrahong.PNG'),
(16,N'ultratrang.PNG'),
(16,N'ultraxam.PNG'),
(16,N'ultraden.PNG'),
(17,N'AD1.jpg'),
(18,N'AD2.jpg'),
(19,N'AD3.jpg'),
(20,N'AD4.jpg'),
(21,N'AD5.jpg'),
(22,N'AD6.jpg'),
(23,N'AD7.jpg'),
(24,N'AD8.jpg'),
(25,N'AD9.jpg'),
(26,N'AD10.jpg'),

(27,N'VA1.jpg'),
(27,N'VA1.1.jpg'),
(28,N'VA2.jpg'),
(29,N'VA3.jpg'),
(29,N'VA3.1.jpg'),
(30,N'VA4.jpg'),
(30,N'VA4.1.jpg'),
(31,N'VA5.jpg'),
(32,N'VA6.jpg'),
(32,N'VA6.1.jpg'),
(33,N'VA7.jpg'),
(34,N'VA8.jpg'),

(35,N'CV1.jpg'),
(36,N'CV2.jpg'),
(37,N'CV3.jpg'),
(37,N'CV3.1.jpg'),
(37,N'CV3.2.jpg'),
(38,N'CV4.jpg'),
(39,N'CV5.jpg'),
(40,N'CV6.jpg'),
(41,N'CV8.jpg'),
(42,N'CV9.jpg'),
(43,N'CV10.jpg'),
(44,N'CV9.jpg'),

(45,N'PA1.jpg'),
(46,N'PA2.jpg'),
(47,N'PA3.jpg'),
(48,N'PA4.jpg'),
(49,N'PA5.jpg'),
(50,N'PA6.jpg'),
(51,N'PA7.jpg'),
(52,N'PA8.jpg'),
(53,N'PA9.jpg'),
(54,N'PA10.jpg')

insert into ProductDetail(ImageID,Size) values
(1,35),(1,36),(1,37),(1,38),(1,40),
(2,35),(2,36),(2,37),(2,38),(2,40),
(3,35),(3,36),(3,37),(3,38),(3,40),
(4,36),(4,37),(4,38),(4,39),
(5,36),(5,37),(5,38),(5,39),
(6,36),(6,37),(6,38),(6,39),
(7,36),(7,37),(7,38),(7,39),
(8,36),(8,37),(8,38),(8,39),
(9,36),(9,37),(9,38),(9,39),
(10,36),(10,37),(10,38),(10,39),
(11,37),(11,38),(11,39),(11,40),(11,41),(11,42),(11,43),
(12,37),(12,38),(12,39),(12,40),(12,41),(12,42),(12,43),
(13,37),(13,38),(13,39),(13,40),(13,41),(13,42),(13,43),
(14,37),(14,38),(14,39),(14,40),(14,41),(14,42),(14,43),
(15,37),(15,38),(15,39),(15,40),(15,41),(15,42),(15,43),
(16,36),(16,37),(16,38),(16,39),(16,40),(16,41),
(17,36),(17,37),(17,38),(17,39),(17,40),(17,41),
(18,36),(18,37),(18,38),(18,39),(18,40),(18,41),
(19,36),(19,37),(19,38),(19,39),(19,40),(19,41),
(20,36),(20,37),(20,38),(20,39),(20,40),(20,41),
(21,36),(21,37),(21,38),(21,39),(21,40),(21,41),
(22,36),(22,37),(22,38),(22,39),(22,40),(22,41),
(23,36),(23,37),(23,38),(23,39),(23,40),(23,41),
(24,36),(24,37),(24,38),(24,39),(24,40),(24,41),
(25,36),(25,37),(25,38),(25,39),
(26,36),(26,37),(26,38),(26,39),
(27,36),(27,37),(27,38),(27,39),
(28,36),(28,37),(28,38),(28,39),
(29,36),(29,37),(29,38),(29,39),
(30,36),(30,37),(30,38),(30,39),
(31,35),(31,36),(31,37),(31,38),(31,40),
(32,35),(32,36),(32,37),(32,38),(32,40),
(33,35),(33,36),(33,37),(33,38),(33,40),
(34,35),(34,36),(34,37),(34,38),(34,40),
(35,35),(35,36),(35,37),(35,38),(35,40),
(36,35),(36,36),(36,37),(36,38),(36,40),
(37,35),(37,36),(37,37),(37,38),(37,40),
(38,35),(38,36),(38,37),(38,38),(38,40),
(39,35),(39,36),(39,37),(39,38),(39,40),
(40,36),(40,37),(40,38),(40,39),
(41,36),(41,37),(41,38),(41,39),
(42,36),(42,37),(42,38),(42,39),
(43,36),(43,37),(43,38),(43,39),
(44,36),(44,37),(44,38),(44,39),
(45,36),(45,37),(45,38),(45,39),
(46,36),(46,37),(46,38),(46,39),
(47,36),(47,37),(47,38),(47,39),
(48,36),(48,37),(48,38),(48,39),
(49,36),(49,37),(49,38),(49,39),
(50,37),(50,38),(50,39),(50,40),
(51,37),(51,38),(51,39),(51,40),
(52,37),(52,38),(52,39),(52,40),
(53,37),(53,38),(53,39),(53,40),
(54,37),(54,38),(54,39),(54,40),
(55,37),(55,38),(55,39),(55,41),
(56,36),(56,38),(56,39),(56,40),
(57,37),(57,38),(57,39),(57,40),
(58,37),(58,38),
(59,39),(59,40),
(60,37),(60,38),(60,39),(60,40),
(61,37),(61,38),(61,39),(61,40),
(62,36),(62,38),(62,39),(62,40),
(63,37),(63,38),(63,39),(63,40),
(64,36),(64,37),(64,39),(64,40),
(65,37),(65,38),(65,39),(65,40),
(66,37),(66,38),(66,39),
(67,37),(67,38),(67,39),
(68,37),(68,38),(68,39),
(69,37),(69,38),(69,39),
(70,37),(70,38),(70,39),(70,40),
(71,37),(71,38),(71,39),(71,40),
(72,37),(72,38),(72,39),(72,40),
(73,37),(73,38),(73,39),(73,40),
(74,37),(74,38),(74,39),(74,40),
(75,37),(75,38),(75,39),(75,40),(75,41),
(76,37),(76,38),(76,39),(76,40),(76,41),
(77,37),(77,38),(77,39),(77,40),(77,41),
(78,37),(78,38),(78,39),(78,40),(78,41)

insert into Roles(RoleName) values
(N'Admin'),(N'Nhân viên'),(N'Khách hàng')

insert into Users(UserName,Password,RoleID,Name,Phone,Address,Email,Status) values
(N'Admin',N'123',1,N'Phạm Thị Thanh','0987654321',N'Hà Nội','thanhpham@gmail.com','1'),
(N'NamTran',N'123',2,N'Trần Văn Nam','0987654321',N'Hà Nội','namtran@gmail.com','1'),
(N'NguyenA',N'123',3,N'Nguyễn Văn A','0987654321',N'Hà Nội','nguyena@gmail.com','1')