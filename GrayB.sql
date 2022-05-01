USE master
GO

-- Drop the database if it already exists
IF  EXISTS (
	SELECT name 
		FROM sys.databases 
		WHERE name = N'GrayB'
)
DROP DATABASE GrayB
CREATE DATABASE GrayB
GO
USE GrayB
GO

create table Category(
	CategoryID		varchar(20) not null primary key,
	CategoryName	nvarchar(50) not null,
)
create table Sale(
	SaleID int identity(1,1) primary key,
	SaleName nvarchar(200),
	SalePercent int not null,
	DateStart datetime not null,
	DateFinish	datetime not null
)
create table Product(
	ProductID	varchar(20) not null primary key,
	ProductName	nvarchar(200) not null,
	CategoryID	varchar(20) foreign key references Category(CategoryID) on delete cascade on update cascade,
	SaleID	int foreign key references Sale(SaleID) on delete set null,
	
	Descriptions	nvarchar(500),
	Price	money not null,
	DateCreate datetime not null,
	DateUpdate	datetime not null,
	AmountInput int not null
)

create table ImageProduct(
	ImageID	int identity(1,1) primary key,
	Images nvarchar(300),
	ProductID	varchar(20) foreign key references Product(ProductID) on delete cascade on update cascade,
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
	Status			nvarchar(50),
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
insert into Category(CategoryID, CategoryName) values
('DM01', N'Giày Nike'),
('DM02', N'Giày Adias'),
('DM03', N'Giày Vans'),
('DM04', N'Giày Converse'),
('DM05', N'Giày Puma'),
('DM06', N'Giày Balenciaga')
insert into Sale(SaleName,SalePercent, DateStart,DateFinish) values
(N'BlackFriday',30,'3-12-2022','3-31-2022'),
(null,25,'4-12-2022','4-30-2022')
insert into Product(ProductID, ProductName, CategoryID, Descriptions, Price, DateCreate, DateUpdate,AmountInput,SaleID) values
('SP001', N'Giày Thể Thao XSPORT Ni.ke air force 1 Rep 1:1 HFV753','DM01',N'Giày Thể Thao XSPORT Ni.ke air force 1 Rep 1:1 thiết kế đẹp mắt, kiểu dáng hiện đại. Với đôi giày thời trang này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','550000','10-12-2021','10-12-2021',10,null),
('SP002', N'Giày Thể Thao XSPORT Ni.ke Jordan 1 F1 Running','DM01',N'Giày Thể Thao XSPORT Ni.ke Jordan 1 F1 chất liệu cao cấp, bền đẹp theo thời gian. Thiết kế thời trang. Kiểu dáng phong cách.Phối màu tinh tế và đẹp mắt. Độ bền cao. Dễ phối đồ. Với đôi giày thời trang này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','350000','10-12-2021','10-12-2021',10,1),
('SP003', N'Giày Thể Thao XSPORT Ni.ke Jordan Low REP Running','DM01',N'Giày Thể Thao XSPORT Ni.ke Jordan Low REP có thiết kế trẻ trung, năng động đến từ thương hiệu Nike nổi tiếng của Mỹ được làm từ chất liệu cao cấp, bền đẹp trong suốt quá trình sử dụng.','750000','10-12-2021','10-12-2021',8,2),
('SP004', N'Giày Thể Thao Nike Air Max Verona Running','DM01',N'Giày Thể Thao Nike Air Max Verona Pink/Black Màu Đen Hồng thiết kế đẹp mắt, kiểu dáng hiện đại. Với đôi giày thời trang này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','325000','10-12-2021','10-12-2021',5,null),
('SP005', N'Giày Thể Thao Nike Air Force 1 Shadow Crimson Tint','DM01',N'Giày Thể Thao Nike Air Force 1 Shadow Crimson Tint CI0919-107 với thiết kế thời trang từ thương hiệu Nike nổi tiếng của Mỹ. Giày Thể Thao Nike Air Force 1 Shadow Crimson Tint CI0919-107  sở hữu gam màu trẻ trung cùng chất liệu cao cấp sẽ cho bạn trải nghiệm tuyệt vời khi đi lên chân.','330000','10-12-2021','10-12-2021',5,null),
('SP006', N'Giày Nike Jordan 1 Mid University 76WBFHW','DM01',N'Giày Thể Thao Nike Air Jordan 1 Mid GS  554725-175 có thiết kế trẻ trung, năng động đến từ thương hiệu Nike nổi tiếng của Mỹ. Giày Nike Air Jordan 1 Mid GS  554725-175 được làm từ chất liệu cao cấp, bền đẹp trong suốt quá trình sử dụng.','550000','10-12-2021','10-12-2021',6,2),
('SP007', N'Giày Thể Thao Nike Air Jordan 1 HG9WEFRHW','DM01',N'Giày Thể Thao Nike Air Jordan 1 có thiết kế trẻ trung, năng động đến từ thương hiệu Nike nổi tiếng của Mỹ được làm từ chất liệu cao cấp, bền đẹp trong suốt quá trình sử dụng.','5900000','10-12-2021','10-12-2021',9,1),
('SP008', N'Giày Nike Air Jordan 1 Mid Se Union Black Toe','DM01',N'Giày Nike Air Jordan 1 Mid Se Union Black Toe có thiết kế trẻ trung, năng động đến từ thương hiệu Nike nổi tiếng của Mỹ được làm từ chất liệu cao cấp, bền đẹp trong suốt quá trình sử dụng.','590000','10-12-2021','10-12-2021',5,null),
('SP009', N'Giày Nike Dunk Low SE Multi Camo 97HFSJGW','DM01',N'Giày Nike Dunk Low SE Multi Camocó thiết kế trẻ trung, năng động đến từ thương hiệu Nike nổi tiếng của Mỹ được làm từ chất liệu cao cấp, bền đẹp trong suốt quá trình sử dụng.','720000','10-12-2021','10-12-2021',10,2),
('SP010', N'Giày Thể Thao Nike Air Max 1 Se Volt Rush','DM01',N'Giày Thể Thao Nike Air Max 1 Se Volt Rush có thiết kế trẻ trung, năng động đến từ thương hiệu Nike nổi tiếng của Mỹ được làm từ chất liệu cao cấp, bền đẹp trong suốt quá trình sử dụng.','320000','10-12-2021','10-12-2021',10,1),
('SP011', N'GiàyThể Thao Nike Air Zoom Structure GHKS97463','DM01',N'GiàyThể Thao Nike Air Zoom Structure có thiết kế trẻ trung, năng động đến từ thương hiệu Nike nổi tiếng của Mỹ được làm từ chất liệu cao cấp, bền đẹp trong suốt quá trình sử dụng.','340000','10-12-2021','10-12-2021',12,2),
('SP012', N'Giày Thể Thao Nike Downshifter 10 Running SHGFSK963','DM01',N'Giày Thể Thao Nike Downshifter 10 Running có thiết kế trẻ trung, năng động đến từ thương hiệu Nike nổi tiếng của Mỹ được làm từ chất liệu cao cấp, bền đẹp trong suốt quá trình sử dụng.','170000','10-12-2021','10-12-2021',20,1),
('SP013', N'Giày Thể Thao Nike Epic React Infinity Fk Phối Màu','DM01',N'Giày Thể Thao Nike Epic React Infinity Fk Phối Màu có thiết kế trẻ trung, năng động đến từ thương hiệu Nike nổi tiếng của Mỹ được làm từ chất liệu cao cấp, bền đẹp trong suốt quá trình sử dụng.','350000','10-12-2021','10-12-2021',20,1),

('SP014', N'Giày Thể Thao XSPORT Adi.das Alpha.bounce Instinct M','DM02',N'Giày Thể Thao XSPORT Adi.das Alpha.bounce Instinct M Phối Màu là đôi giày dành cho các chàng trai đam mê thể thao được thiết kế vô cùng hiện đại đến từ thương hiệu Adidas nổi tiếng. Sở hữu gam màu nổi bật cùng chất liệu cao cấp Adidas Harden Vol5 Futurenatural White FZ1071 mang lại cảm giác thoải mái khi vận động, chạy nhảy nhiều.','350000','10-12-2021','10-12-2021',20,2),
('SP015', N'Giày Thể Thao XSPORT Prophere Rep 1:1 57GFH','DM02',N'Giày Thể Thao XSPORT Prophere Replà mẫu giày hoài niệm phong cách hầm hố lấy cảm hứng từ nền văn hóa đại chúng của thập niên 90 của thương hiệu Adidas nổi tiếng.','500000','10-12-2021','10-12-2021',10,1),
('SP016', N'Giày Thể Thao XSPORT Ultra Boost 74321','DM03',N'Giày Thể Thao XSPORT Ultra Boost là đôi giày cao cấp đến từ thương hiệu Adias nổi tiếng của nước Mỹ. Với đôi giày Vans Classic Sk8-Hi Black/White này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','1600000','10-12-2021','10-12-2021',10,2),
('SP017', N'Giày Thể Thao Adidas Runfalcon 125473','DM02',N'Giày Thể Thao Adidas Runfalcon Màu Đen Trắng là đôi giày thể thao dành cho nam đến từ thương hiệu Adidas nổi tiếng của Đức. Adidas Runfalcon được thiết kế mang nét thể thao phóng đại, khỏe khoắn mang đầy nét năng động.','1600000','10-12-2021','10-12-2021',10,1),
('SP018', N'Giày Thể Thao Adidas Original Stan Smith','DM02',N'Giày Thể Thao Adidas Original Stan Smith M20324 Màu Trắng đến từ thương hiệu Adidas nổi tiếng của Đức. Adidas Original Stan Smith được thiết kế mang nét thể thao khỏe khoắn, năng động cho bạn trải nghiệm tuyệt vời khi đi lên chân.','1600000','10-12-2021','10-12-2021',20,1),
('SP019', N'Giày Thể Thao Adidas Neo Cloudfoam Lite Racer Olive','DM02',N'Giày Thể Thao Adidas Neo Cloudfoam Lite Racer Olive Màu Xanh Green là một trong những sản phẩm nổi tiếng của Adidas với thiết kế được tính toán tốt nhất dành cho người dùng: mềm mại, thoải mái, kiểu dáng thể thao trẻ trung, chất liệu bền đẹp. Với đôi giày thời trang này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','1500000','10-12-2021','10-12-2021',30,null),
('SP020', N'Giày Thể Thao Adidas Ultraboost 20 USA','DM02',N'Giày Thể Thao Adidas Ultraboost 20 USA Màu Trắng đến từ thương hiệu Adidas nổi tiếng của Đức. Adidas Ultraboost 20 USA được thiết kế mang nét thể thao khỏe khoắn, năng động cho bạn trải nghiệm tuyệt vời nhất khi đi lên chân.','2500000','10-12-2021','10-12-2021',5,2),
('SP021', N'Giày Bóng Rổ Adidas Harden Vol5 Futurenatural','DM02',N'Giày Bóng Rổ Adidas Harden Vol5 Futurenatural White FZ1071 Phối Màu là đôi giày dành cho các chàng trai đam mê thể thao được thiết kế vô cùng hiện đại đến từ thương hiệu Adidas nổi tiếng. Sở hữu gam màu nổi bật cùng chất liệu cao cấp Adidas Harden Vol5 Futurenatural White FZ1071 mang lại cảm giác thoải mái khi vận động, chạy nhảy nhiều.','3500000','10-12-2021','10-12-2021',10,2),
('SP022', N'Giày Thể Thao Adidas Falcon Lite Racer Olive','DM02',N'Giày Thể Thao Adidas Falcon Grey Pink D96698 Màu Xám là mẫu giày hoài niệm phong cách hầm hố lấy cảm hứng từ nền văn hóa đại chúng của thập niên 90 của thương hiệu Adidas nổi tiếng.','1650000','10-12-2021','10-12-2021',10,1),
('SP023', N'Giày Thể Thao Adidas D Rose 11 Lite Racer Olive','DM02',N'Giày Thể Thao Adidas D Rose 11 FY9988 Màu Xanh được thiết kế hiện đại đến từ thương hiệu Adidas nổi tiếng. Với gam màu thanh lịch Adidas D Rose 11 FY9988 Màu Xanh cho bạn trở nên sành điệu và thật phong cách khi đi lên chân.','2600000','10-12-2021','10-12-2021',20,2),
('SP024', N'Giày Thể Thao Adidas D Rose 12Lite Racer Olive','DM02',N'Giày Thể Thao Adidas D Rose 12 FY9988 Màu Xanh được thiết kế hiện đại đến từ thương hiệu Adidas nổi tiếng. Với gam màu thanh lịch Adidas D Rose 11 FY9988 Màu Xanh cho bạn trở nên sành điệu và thật phong cách khi đi lên chân.','2600000','10-12-2021','10-12-2021',10,1),
('SP025', N'Giày Thể Thao Adidas Pro Bounce 2019','DM02',N'Giày Thể Thao Adidas Pro Bounce 2019 EE3898 Màu Đỏ được thiết kế hiện đại đến từ thương hiệu Adidas nổi tiếng. Với gam màu thanh lịch Adidas Pro Bounce 2019 EE3898 Màu Đỏ cho bạn trở nên sành điệu và thật phong cách khi đi lên chân.','1790000','10-12-2021','10-12-2021',5,null),
('SP026', N'Giày Thể Thao Adidas X9000L3 H.RDY M','DM02',N'Giày Thể Thao Adidas X9000L3 H.RDY M FY0798 Màu Trắng được thiết kế hiện đại đến từ thương hiệu Adidas nổi tiếng. Với gam màu thanh lịch Adidas X9000L3 H.RDY M FY0798 cho bạn trở nên sành điệu và thật phong cách khi đi lên chân.','1680000','10-12-2021','10-12-2021',5,null),

('SP027', N'Giày Vans Mule Checkerboard GHJGBAK7463','DM03',N'Giày Vans Mule Checkerboard Màu Xanh Navy là đôi giày Unisex dành cho cả nam và nữ đến từ thương hiệu Vans nổi tiếng của nước Mỹ. Với đôi giày Vans thời trang này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','500000','10-12-2021','10-12-2021',10,1),
('SP028', N'Giày Thể Thao Vans Classic SGHBSJ8752','DM03',N'Giày Thể Thao Vans Classic Sk8-Hi Black/White Màu Đen là đôi giày cao cấp đến từ thương hiệu Vans nổi tiếng của nước Mỹ. Với đôi giày Vans Classic Sk8-Hi Black/White này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','1600000','10-12-2021','10-12-2021',10,2),
('SP029', N'Giày Vans Old Skool X J.Crew SDHGA8735','DM03',N'Giày Vans Old Skool X J.Crew Reflecting Pond Màu Xanh là đôi giày cao cấp đến từ thương hiệu Vans nổi tiếng của nước Mỹ. Với đôi giày Vans Old Skool X J.Crew Reflecting Pond này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','1900000','10-12-2021','10-12-2021',10,1),
('SP030', N'Giày Thể Thao Vans Checkerboard Slip On','DM03',N'Với kiểu dáng Style trẻ trung, đẹp mắt, mang đậm phong cách, cá tính cho người mang. Phần đế giày có độ ma sát cao hạn chế trơn trượt cho người sử dụng.Không chỉ dành cho người yêu sneaker, đôi giày còn phù hợp với những tín đồ đam mê thể thao với phong cách thời trang năng động, đậm nét cá tính.','1300000','10-12-2021','10-12-2021',10,null),
('SP031', N'Giày Vans Asher All White FHSJFB8W4T6','DM03',N'Giày Vans Ward Triple White Màu Trắng là đôi giày cao cấp đến từ thương hiệu Vans nổi tiếng của nước Mỹ. Với đôi giày Vans Ward Triple White này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','1400000','10-12-2021','10-12-2021',10,2),
('SP032', N'Giày Sneakers Vans Style 36 Marshmallow Blue Màu Trắng','DM03',N'Giày Sneaker Vans Style 36 Marshmallow Blue Màu Trắng Size 41 đến từ thương hiệu Vans nổi tiếng của nước Mỹ. Với đôi giày Sneaker Vans thời trang này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','2400000','10-12-2021','10-12-2021',10,1),
('SP033', N'Giày Vans Ward Triple White Màu Trắng','DM03',N'Giày Vans Ward Triple White Màu Trắng là đôi giày cao cấp đến từ thương hiệu Vans nổi tiếng của nước Mỹ. Với đôi giày Vans Ward Triple White này chắc chắn bạn sẽ trở nên nổi bật và cuốn hút hơn.','1500000','10-12-2021','10-12-2021',20,1),
('SP034', N'Giày Vans Vault Old Skool – Marshmallow Multicolor Màu Trắng','DM03',N'Giày Vans Vault Old Skool – Marshmallow Multicolor Màu Trắng đến từ thương hiệu Vans nổi tiếng của nước Mỹ, với thiết kế thời trang đôi giày sẽ cho bạn trải nghiệm tuyệt vời nhất khi đi lên chân.','2600000','10-12-2021','10-12-2021',5,2),

('SP035', N'Giày Thể Thao Converse All-Court - 168785C Màu Đen','DM04',N'Giày Thể Thao Converse All-Court - 168785C Màu Đen sản phẩm đến từ thương hiệu Converse nổi tiếng của Mỹ. Với thiết kế thời trang, đôi giày đang nhận được sự yêu thích của rất nhiều bạn trẻ.','1800000','10-12-2021','10-12-2021',6,null),
('SP036', N'Giày Converse Chuck Taylor All Star Lift Leather Low 561680C','DM04',N'Giày Converse Chuck Taylor All Star Lift Leather Low 561680C Màu Trắng là sản phẩm đến từ thương hiệu Converse nổi tiếng của Mỹ. Với thiết kế thời trang cùng màu sắc thanh lịch đôi giày đang nhận được sự yêu thích của rất nhiều bạn trẻ.','2400000','10-12-2021','10-12-2021',10,null),
('SP037', N'Giày Converse Chuck Taylor All Star 1970s','DM04',N'Giày Converse Chuck Taylor All Star 1970s Colors Vintage Canvas - 168504V Màu Nâu Nhạt với thiết kế Độc - Lạ - Phá cách đến từ thương hiệu Converse nổi tiếng của Mỹ. Với gam màu thanh lịch Converse Chuck Taylor đang là item HOT được nhiều bạn trẻ săn đón.','2500000','10-12-2021','10-12-2021',10,null),
('SP038', N'Giày Converse Chuck Taylor All Star CX 168566C Màu Xanh Navy','DM04',N'Giày Converse Chuck Taylor All Star CX 168566C Màu Xanh Navy sản phẩm đến từ thương hiệu Converse nổi tiếng của Mỹ. Với thiết kế Độc - Lạ - Phá cách, cùng gam màu nổi bật đôi giày đang nhận được sự quan tâm từ rất nhiều các bạn trẻ.','2600000','10-12-2021','10-12-2021',10,null),
('SP039', N'Giày Converse Chuck Taylor All Star 1970s Renew - 168615C Màu Vàng','DM04',N'Giày Converse Chuck Taylor All Star 1970s Renew - 168615C Màu Vàng với thiết kế Độc - Lạ - Phá cách đến từ thương hiệu Converse nổi tiếng của Mỹ. Với gam màu nổi bật Converse Chuck Taylor đang là item HOT được nhiều bạn trẻ săn đón.','2450000','10-12-2021','10-12-2021',6,1),
('SP040', N'Giày Converse Chuck Taylor All Star CX 168568C ','DM04','Giày Converse Chuck Taylor All Star CX 168568C Màu Đen sản phẩm đến từ thương hiệu Converse nổi tiếng của Mỹ. Với thiết kế thời trang, đôi giày đang nhận được sự yêu thích của rất nhiều bạn trẻ.','2450000','10-12-2021','10-12-2021',10,2),
('SP041', N'Giày Converse Chuck Taylor All Star Renew - 168593V Màu Xanh Green','DM04',N'Giày Converse Chuck Taylor All Star Renew - 168593V Màu Xanh Green sản phẩm đến từ thương hiệu Converse nổi tiếng của Mỹ. Với thiết kế Độc - Lạ - Phá cách, cùng gam màu nổi bật đôi giày đang nhận được sự quan tâm từ rất nhiều các bạn trẻ.','1850000','10-12-2021','10-12-2021',10,1),
('SP042', N'Giày Converse CDG Play X Chuck Taylor 1970s Cream White','DM04',N'Giày Converse CDG Play X Chuck Taylor 1970s Cream White 70 Low 150207C Màu Trắng với thiết kế Độc - Lạ - Phá cách đến từ thương hiệu Converse nổi tiếng của Mỹ. Với gam màu thanh lịch Converse CDG Play X Chuck Taylor 1970s Cream White 70 Low 150207C  đang là item HOT được nhiều bạn trẻ săn đón.','3450000','10-12-2021','10-12-2021',5,1),
('SP043', N'Giày Converse Chuck Taylor All Star CX - 168570C Màu Vàng','DM04',N'Giày Converse Chuck Taylor All Star CX - 168570C Màu Vàng sản phẩm đến từ thương hiệu Converse nổi tiếng của Mỹ. Với thiết kế thời trang cùng màu sắc nổi bật đôi giày đang nhận được sự yêu thích của rất nhiều bạn trẻ.','2500000','10-12-2021','10-12-2021',10,2),
('SP044', N'Giày Converse Chuck Taylor All Star CX - 168570C Màu Vàng','DM04',N'Giày Thể Thao Converse 1970s High Black Fire Màu Đen Đỏ sản phẩm đến từ thương hiệu Converse nổi tiếng của Mỹ. Với thiết kế Độc - Lạ - Phá cách,  đôi giày đang nhận được sự quan tâm từ rất nhiều các bạn trẻ.','2700000','10-12-2021','10-12-2021',10,2),

('SP045', N'Giày Thể Thao Puma RS-X X3 Puzzle Multi 371570-04','DM05',N'Giày Thể Thao Puma RS-X X3 Puzzle Multi 371570-04 với thiết kế trẻ trung đến từ thương hiệu Puma nổi tiếng của Đức. Giày Puma RS-X X3 sẽ cho bạn những trải nghiệm tuyệt vời khi đi lên chân.','2000000','10-12-2021','10-12-2021',20,1),
('SP046', N'Giày Thể Thao Puma Muse X2 Metallic 37083802 Màu Trắng','DM05',N'Giày Thể Thao Puma Muse X2 Metallic 37083802 Màu Trắng với thiết kế trẻ trung đến từ thương hiệu Puma nổi tiếng của Đức. Giày Puma Muse X2 Metallic Màu Trắng sẽ cho bạn những trải nghiệm tuyệt vời khi đi lên chân.','1700000','10-12-2021','10-12-2021',10,1),
('SP047', N'Giày Thể Thao Puma Oslo-City Lux Màu Trắng','DM05',N'Giày Thể Thao Puma Oslo-City Lux Màu Trắng với thiết kế trẻ trung đến từ thương hiệu Puma nổi tiếng của Đức. Giày Puma Oslo-City Lux được làm từ chất liệu cao cấp sẽ cho bạn trải nghiệm tuyệt vời khi đi lên chân.','1990000','10-12-2021','10-12-2021',10,2),
('SP048', N'Giày Puma Ralph Sampson Màu Trắng ','DM05',N'Giày Puma Ralph Sampson Màu TrắngSize 41 với thiết kế trẻ trung được nhiều tín đồ thời trang săn đón. Với gam màu sang trọng PPuma Ralph Sampson cho bạn thêm năng động và nổi bật.','1700000','10-12-2021','10-12-2021',10,2),
('SP049', N'Giày Thể Thao Puma Caracal Suede Màu Đen','DM05',N'Giày Thể Thao Puma Caracal Suede Màu Đen','1700000','12-12-2020','12-12-2020',10,null),
('SP050', N'Giày Thể Thao Puma Smash V2 Black Màu Đen Trắng ','DM05',N'Giày Thể Thao Puma Smash V2 Black Màu Đen Trắng là mẫu giày mới nhất được đông đảo tín đồ thời trang yêu thích trong thời gian gần đây. Đôi giày được thiết kế kiểu dáng thời trang và được làm từ chất liệu cao cấp bền đẹp trong suốt quá trình sử dụng.','1900000','10-12-2021','10-12-2021',10,null),
('SP051', N'Giày Thể Thao Puma Roma Scuderia Ferrari','DM05',N'Giày Thể Thao Puma Roma Scuderia Ferrari Size 38.5 (Trắng) là mẫu giày nổi bật của hãng Puma phù hợp với các quý ông năng động, trẻ trung.Giày Puma Roma Scuderia Ferrari được thiết kế với phong cách hoàn toàn mới: thanh thoát và giản dị nhưng có nét độc đáo riêng. Sản phẩm kết hợp giữa Puma và Ferrari, những thương hiệu mà tất cả chúng ta đều biết và yêu thích.','1990000','10-12-2021','10-12-2021',10,2),
('SP052', N'Giày Puma Bari Mule Men','DM05',N'Giày Puma Bari Mule Mens Shoes Màu Đen với thiết kế đẹp - độc đáo đến từ thương hiệu Puma nổi tiếng của Đức. Với những tín đồ mê giày hở gót thì Puma Mule Pink sẽ không còn là cái tên xa lạ nữa.','1340000','10-12-2021','10-12-2021',10,null),
('SP053', N'Giày Thể Thao Puma Scuderia Ferrari Speed HYBRID Running','DM05',N'Giày Thể Thao Puma Scuderia Ferrari Speed HYBRID Running Màu Trắng là đôi giàythời trang dành cho nam đến từ thương hiệu Puma nổi tiếng. Với thiết kế hiện đại đôi giày Puma Scuderia Ferrari Speed HYBRID Running sẽ cho bạn trải nghiệm tuyệt vời nhất khi đi lên chân.','1990000','10-12-2021','10-12-2021',10,1),
('SP054', N'Giày Thể Thao Puma Basket 90680 Lux Màu Trắng ','DM05',N'Giày Thể Thao Puma Basket 90680 Lux Màu Trắng Size 40.5 được thiết kế trẻ trung, khỏe khoắn mang đậm phong cách của thương hiệu Puma. Giày Puma Basket 90680 Lux sẽ cho bạn trải nghiệm tuyệt vời nhất khi đi lên chân.','1970000','12-12-2020','12-12-2020',10,1)

insert into ImageProduct(ProductID,Images)values
('SP001',N'nikeairforcexanh.PNG'),
('SP001',N'nikeairforcehong.PNG'),
('SP001',N'nikeairforcexam.PNG'),
('SP002',N'jordancam.PNG'),
('SP002',N'jordanden.PNG'),
('SP002',N'jordando.PNG'),
('SP002',N'jordantim.PNG'),
('SP003',N'jordanlowxanhden.PNG'),
('SP003',N'jordanlowxam.PNG'),
('SP003',N'jordanlowtrang.PNG'),
('SP004',N'NIKE1.jpg'),
('SP005',N'NIKE2.jpg'),
('SP006',N'NIKE3.jpg'),
('SP007',N'NIKE4.jpg'),
('SP008',N'NIKE5.jpg'),
('SP009',N'NIKE6.jpg'),
('SP010',N'NIKE7.jpg'),
('SP011',N'NIKE8.jpg'),
('SP012',N'NIKE9.jpg'),
('SP013',N'NIKE10.jpg'),
('SP014',N'adiasalphaden.PNG'),
('SP014',N'adiasalphado.PNG'),
('SP014',N'adiasalphaxam.PNG'),
('SP014',N'adiasalphaxamden.PNG'),
('SP015',N'prophexanhduong.PNG'),
('SP015',N'prophehong.PNG'),
('SP015',N'prophexanhreu.PNG'),
('SP015',N'prophedo.PNG'),
('SP015',N'propheden.PNG'),
('SP015',N'prophekecam.PNG'),

('SP016',N'ultrahong.PNG'),
('SP016',N'ultratrang.PNG'),
('SP016',N'ultraxam.PNG'),
('SP016',N'ultraden.PNG'),
('SP017',N'AD1.jpg'),
('SP018',N'AD2.jpg'),
('SP019',N'AD3.jpg'),
('SP020',N'AD4.jpg'),
('SP021',N'AD5.jpg'),
('SP022',N'AD6.jpg'),
('SP023',N'AD7.jpg'),
('SP024',N'AD8.jpg'),
('SP025',N'AD9.jpg'),
('SP026',N'AD10.jpg'),

('SP027',N'VA1.jpg'),
('SP027',N'VA1.1.jpg'),
('SP028',N'VA2.jpg'),
('SP029',N'VA3.jpg'),
('SP029',N'VA3.1.jpg'),
('SP030',N'VA4.jpg'),
('SP030',N'VA4.1.jpg'),
('SP031',N'VA5.jpg'),
('SP032',N'VA6.jpg'),
('SP032',N'VA6.1.jpg'),
('SP033',N'VA7.jpg'),
('SP034',N'VA8.jpg'),

('SP035',N'CV1.jpg'),
('SP036',N'CV2.jpg'),
('SP037',N'CV3.jpg'),
('SP037',N'CV3.1.jpg'),
('SP037',N'CV3.2.jpg'),
('SP038',N'CV4.jpg'),
('SP039',N'CV5.jpg'),
('SP040',N'CV6.jpg'),
('SP041',N'CV8.jpg'),
('SP042',N'CV9.jpg'),
('SP043',N'CV10.jpg'),
('SP044',N'CV9.jpg'),

('SP045',N'PA1.jpg'),
('SP046',N'PA2.jpg'),
('SP047',N'PA3.jpg'),
('SP048',N'PA4.jpg'),
('SP049',N'PA5.jpg'),
('SP050',N'PA6.jpg'),
('SP051',N'PA7.jpg'),
('SP052',N'PA8.jpg'),
('SP053',N'PA9.jpg'),
('SP054',N'PA10.jpg')

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
/*(79,37),(79,38),(79,39),(79,40),(79,41),
(80,37),(80,38),(80,39),(80,40),(80,41),
(81,37),(81,38),(81,39),(81,40),(81,41),
(82,37),(82,38),(82,39),(82,40),(82,41),
(83,37),(83,38),(83,39),(83,40),(83,41),
(84,37),(84,38),(84,39),(84,40),(84,41),
(85,37),(85,38),(85,39),(85,40),(85,41),
(86,37),(86,38),(86,39),(86,40),(86,41),
(87,37),(87,38),(87,39),(87,40),
(88,37),(88,38),(88,39),(88,40),(88,41),
(89,37),(89,38),(89,39),
(90,37),(90,38),
(91,37)*/

insert into Roles(RoleName) values
(N'Admin'),(N'Nhân viên'),(N'Khách hàng')

insert into Users(UserName,Password,RoleID,Name,Phone,Address,Email,Status) values
(N'Admin',N'123',1,N'Phạm Thị Thanh','0987654321',N'Hà Nội','thanhpham@gmail.com','1'),
(N'NamTran',N'123',2,N'Trần Văn Nam','0987654321',N'Hà Nội','namtran@gmail.com','1'),
(N'NguyenA',N'123',3,N'Nguyễn Văn A','0987654321',N'Hà Nội','nguyena@gmail.com','1')

insert into BlogCategory(BlogCategoryName) values
(N'Bảo quản giày'),(N'Làm đẹp')

insert into Blog(BlogName,Images,DateCreate,Content,BlogCategoryID) values
(N'Mua giày ở đâu?',N'tintuc1.jpg','2/3/2020',N'<h2 style="font-style:normal; text-align:left">1 SneakerLand</h2>
<p style="margin-left:0px; margin-right:0px; text-align:left"><span style="font-size:16px"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="background-color:#ffffff">Nằm tr&ecirc;n phố Thịnh Y&ecirc;n, Sneaker Land&nbsp;được nhiều bạn trẻ biết đến l&agrave; cửa h&agrave;ng chuy&ecirc;n b&aacute;n v&agrave; order gi&agrave;y sneakers v&agrave; phụ kiện. Sneaker Land cam k&ecirc;t mang đến cho kh&aacute;ch h&agrave;ng c&aacute;c sản phẩm gi&agrave;y ch&iacute;nh h&atilde;ng, 100% authentic, US shipped. Rất nhiều kh&aacute;ch h&agrave;ng đ&atilde; mua, trải nghiệm v&agrave; đ&aacute;nh gi&aacute; về nguồn gốc của h&agrave;ng n&ecirc;n bạn kh&ocirc;ng cần phải lo lắng ch&uacute;t n&agrave;o khi mua gi&agrave;y tại đ&acirc;y. Điều đặc biệt khiến SneakerLand được nhiều người biết đến bởi tại đ&acirc;y cung cấp nhiều mẫu m&atilde; gi&agrave;y đa dạng k&egrave;m c&aacute;c loại phụ kiện ph&ugrave; hợp với c&aacute; t&iacute;nh ri&ecirc;ng của từng kh&aacute;ch h&agrave;ng. Từ những mẫu gi&agrave;y basic đến những chiếc gi&agrave;y c&aacute; t&iacute;nh, ph&aacute; c&aacute;ch, cửa h&agrave;ng lu&ocirc;n update v&agrave; đưa đến cho kh&aacute;ch h&agrave;ng những mẫu gi&agrave;y mới thường xuy&ecirc;n n&ecirc;n bạn c&oacute; thể t&igrave;m được mẫu gi&agrave;y mới, ưng &yacute; v&agrave; chất lượng nhất tại đ&acirc;y.</span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px; text-align:left"><span style="font-size:16px"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="background-color:#ffffff"><img alt="địa chỉ bán giày nam" src="https://mcdn.coolmate.me/image/December2020/just4-min.jpg" style="border-radius:20px; border-style:none; box-sizing:border-box; color:rgba(0, 0, 0, 0); display:block; height:auto; image-rendering:-webkit-optimize-contrast; margin-left:auto; margin-right:auto; max-width:100%; vertical-align:middle; width:500px" /></span></span></span></span></p>
<div class="info-box" style="-webkit-text-stroke-width:0px; border-radius:16px; padding:24px; text-align:left">
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Địa chỉ:&nbsp;2H Thịnh Y&ecirc;n, P. Phố Huế, Hai B&agrave; Trưng, H&agrave; Nội.</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Hotline:&nbsp;0918361962</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Facebook:&nbsp;https://www.facebook.com/sneakerlandshop</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Instagram:&nbsp;https://www.instagram.com/sneakerland.hn/</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Website:&nbsp;http://sneakerland-shop.com/</span></span></span></span></span></p>
</div>
<p style="margin-left:0px; margin-right:0px; text-align:left">&nbsp;</p>
<h2 style="font-style:normal; text-align:left">2 Authentic Shoes</h2>
<p style="margin-left:0px; margin-right:0px; text-align:left"><span style="font-size:16px"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="background-color:#ffffff">Authentic Shoes kh&ocirc;ng chỉ giới hạn ở việc b&aacute;n những mẫu gi&agrave;y sneaker ch&iacute;nh h&atilde;ng m&agrave; c&ograve;n chuy&ecirc;n order quần &aacute;o v&agrave; phụ kiện. Cửa h&agrave;ng c&oacute; mặt bằng nằm tại phố T&acirc;y Sơn, l&agrave; con phố mua sắm sầm uất với nhiều shop quần &aacute;o, gi&agrave;y d&eacute;p nổi tiếng.&nbsp;Với quy m&ocirc; mẫu m&atilde; v&ocirc; c&ugrave;ng phong ph&uacute; với h&agrave;ng trăm mẫu Sneaker cực đa dạng đến từ c&aacute;c brands nổi tiếng tr&ecirc;n thế giới như: Nike, Adidas, Converse, Vans, Fila,....,&nbsp;Authentic Shoes&nbsp;mang đến cho bạn những nguồn h&agrave;ng, sẩn phẩm chất lượng từ c&aacute;c thương hiệu đ&igrave;nh đ&aacute;m, đồng thời tự tin c&oacute; thể lu&ocirc;n lu&ocirc;n khiến bạn h&agrave;i l&ograve;ng khi sử dụng dịch vụ của cửa h&agrave;ng. Tất cả sản phẩm&nbsp;Authentic Shoes&nbsp;được cam kết ch&iacute;nh h&atilde;ng, 100% Authentic với nguồn gốc từ c&aacute;c cửa h&agrave;ng tr&ecirc;n thế giới, vậy n&ecirc;n c&aacute;c ch&agrave;ng nếu muốn t&igrave;m kiếm những cửa h&agrave;ng gi&agrave;y sneaker ch&iacute;nh h&atilde;ng th&igrave; đừng bỏ qua Authentic Shoes.</span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px; text-align:left"><span style="font-size:16px"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="background-color:#ffffff"><img alt="giày thể thao nam chính hãng" src="https://mcdn.coolmate.me/image/December2020/unnamed_37.jpg" style="border-radius:20px; border-style:none; box-sizing:border-box; color:rgba(0, 0, 0, 0); display:block; height:auto; image-rendering:-webkit-optimize-contrast; margin-left:auto; margin-right:auto; max-width:100%; vertical-align:middle; width:500px" /></span></span></span></span></p>
<div class="info-box" style="-webkit-text-stroke-width:0px; border-radius:16px; padding:24px; text-align:left">
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Địa chỉ:&nbsp;Tầng 4 số 70-72 T&acirc;y Sơn, Quận Đống Đa, H&agrave; Nội, Việt Nam</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Hotline:&nbsp;0913576123</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Facebook:&nbsp;https://www.facebook.com/NXHsneakerstore/</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Website:&nbsp;https://authentic-shoes.com/</span></span></span></span></span></p>
</div>
<h2 style="font-style:normal; text-align:left">3 HNM Sneaker</h2>
<p style="margin-left:0px; margin-right:0px; text-align:left"><span style="font-size:16px"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="background-color:#ffffff">HNM Sneaker&nbsp;được coi l&agrave; một trong những của h&agrave;ng nổi tiếng chuy&ecirc;n gi&agrave;y tại H&agrave; Nội. C&oacute; địa chỉ tại 212 phố Huế l&agrave; một trong những con phố sầm uất bậc nhất H&agrave; Nội, HNM Sneaker chuy&ecirc;n cung cấp tất cả c&aacute;c mẫu gi&agrave;y độc, đẹp v&agrave; chất lượng của c&aacute;c cả c&aacute;c h&atilde;ng gi&agrave;y thể thao lớn. HNM khiến kh&aacute;ch h&agrave;ng tin tưởng v&agrave; ủng hộ bởi c&aacute;c dịch vụ hậu đ&atilde;i tuyệt vời. Điều tuyệt vời m&agrave; HNM mang lại cho kh&aacute;ch h&agrave;ng đ&oacute; l&agrave; sự bảo đảm tuyệt đối cho c&aacute;c sản phẩm. B&ecirc;n cạnh sự phong ph&uacute; v&agrave; chuy&ecirc;n nghiệp trong c&aacute;c sản phẩm gi&agrave;y m&agrave; HNM mang lại, bạn cũng c&oacute; thể tham khảo v&ocirc; v&agrave;n sản phẩm kh&aacute;c, từ c&aacute;c loại phụ kiện tới quần &aacute;o với thiết kế v&ocirc; c&ugrave;ng &quot;chất&quot;.</span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px; text-align:left"><span style="font-size:16px"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="background-color:#ffffff"><img alt="nên mua giày nam chính hãng ở đâu" src="https://mcdn.coolmate.me/image/December2020/shop-giay-sneaker-da-nang-7.1.jpg" style="border-radius:20px; border-style:none; box-sizing:border-box; color:rgba(0, 0, 0, 0); display:block; height:auto; image-rendering:-webkit-optimize-contrast; margin-left:auto; margin-right:auto; max-width:100%; vertical-align:middle; width:500px" /></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px; text-align:left"><span style="font-size:16px"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="background-color:#ffffff">Đặc biệt hơn, khi mua sắm, trở th&agrave;nh kh&aacute;ch h&agrave;ng của HNM, kh&aacute;ch h&agrave;ng sẽ nhận được ưu đ&atilde;i ri&ecirc;ng, quyền lợi m&agrave; chỉ kh&aacute;ch h&agrave;ng của HNM nhận được như g&oacute;i bảo vệ đế gi&agrave;y, vệ sinh gi&agrave;y free c&ugrave;ng c&aacute;c dịch vụ đi k&egrave;m như hỗ trợ đổi trả, l&ecirc;n đời, thay thế model&hellip; c&ugrave;ng với đ&oacute; l&agrave; dịch vụ chăm s&oacute;c kh&aacute;ch h&agrave;ng nhiệt t&igrave;nh, chuy&ecirc;n nghiệp</span></span></span></span></p>
<div class="info-box" style="-webkit-text-stroke-width:0px; border-radius:16px; padding:24px; text-align:left">
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Địa chỉ:&nbsp;212 Ph&ocirc;́ Huế, phường Ng&ocirc; Thì Nh&acirc;̣m, qu&acirc;̣n Hai Bà Trưng, Hà N&ocirc;̣i</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Hotline:&nbsp;0981462410</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Facebook:&nbsp;www.facebook.com/hnmsneaker.UK/</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Instagram:&nbsp;www.instagram.com/hnmsneaker/</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Website:&nbsp;hnmsneaker.com.vn/</span></span></span></span></span></p>
</div>
<h2 style="font-style:normal; text-align:left">4 Just Sneaker Store - JSS</h2>
<p style="margin-left:0px; margin-right:0px; text-align:left"><span style="font-size:16px"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="background-color:#ffffff">Just Sneaker Store c&oacute; lẽ l&agrave; c&aacute;i t&ecirc;n qu&aacute; quen thuộc v&agrave; nổi tiếng khu vực quận Ho&agrave;n Kiếm n&oacute;i ri&ecirc;ng v&agrave; H&agrave; Nội n&oacute;i chung. Kh&ocirc;ng giống với c&aacute;c store kh&aacute;c, bạn c&oacute; thể t&igrave;m kiếm cả những mẫu quần &aacute;o hay phụ kiện đi k&egrave;m tại c&aacute;c store gi&agrave;y b&igrave;nh thường, tuy nhi&ecirc;n ở Just Sneaker Store, đ&uacute;ng như t&ecirc;n gọi bạn sẽ chỉ thấy ở đ&acirc;y chỉ chuy&ecirc;n gi&agrave;y với đủ loại mẫu m&atilde;, m&agrave;u sắc, thương hiệu. JSS hoạt động kinh doanh dưới cả 2 h&igrave;nh thực b&aacute;n trực tiếp tại cửa h&agrave;ng v&agrave; nhận order. C&aacute;c mẫu sẵn tại shop đều l&agrave; c&aacute;c mẫu chọn lọc, casual, dễ đi với cả nam v&agrave; nữ. Những c&aacute;i t&ecirc;n quen thuộc như Van Vault OG Old Skool, Adidas Original Sand Smith, Puma flatfom&hellip; chuẩn auth đều c&oacute; tại&nbsp;JSS&nbsp;cho c&aacute;c bạn thỏa sức lựa chọn.</span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px; text-align:left"><span style="font-size:16px"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="background-color:#ffffff"><img alt="mua giày sneaker cho nam chính hãng" src="https://mcdn.coolmate.me/image/December2020/Footlocker-Sneaker-Resale-GQ-02082019_3x2.jpg" style="border-radius:20px; border-style:none; box-sizing:border-box; color:rgba(0, 0, 0, 0); display:block; height:auto; image-rendering:-webkit-optimize-contrast; margin-left:auto; margin-right:auto; max-width:100%; vertical-align:middle; width:500px" /></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px; text-align:left"><span style="font-size:16px"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="background-color:#ffffff">Ngo&agrave;i ra,&nbsp;JSS&nbsp;c&ograve;n v&ocirc; c&ugrave;ng t&acirc;m l&yacute; khi b&aacute;n k&egrave;m cả những đồ l&agrave;m sạch gi&agrave;y, khi&ecirc;n đ&ocirc;i gi&agrave;y của bạn lu&ocirc;n lu&ocirc;n trong trạng th&aacute;i tuyệt vời nhất.&nbsp;JSS&nbsp;c&ograve;n kh&aacute; l&agrave; đầu tư về mặt h&igrave;nh ảnh v&agrave; lu&ocirc;n update li&ecirc;n tục l&ecirc;n website của shop, gi&uacute;p mọi người cập nhật c&aacute;c mẫu h&agrave;ng mới v&ocirc; c&ugrave;ng nhanh v&agrave; dễ d&agrave;ng.</span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px; text-align:left">&nbsp;</p>
<div class="info-box" style="-webkit-text-stroke-width:0px; border-radius:16px; padding:24px; text-align:left">
<p style="margin-left:0px; margin-right:0px">&nbsp;</p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Địa chỉ:&nbsp;32b Nh&agrave; Chung, Ho&agrave;n Kiếm, H&agrave; Nội</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Hotline&nbsp;: 097 666 0268</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Instagram:&nbsp;www.instagram.com/justsneakerstore/</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Facebook:&nbsp;www.facebook.com/JustSneakerStore/</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Website:&nbsp;justsneakerstore.com</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px">&nbsp;</p>
</div>
<p style="margin-left:0px; margin-right:0px; text-align:left">&nbsp;</p>
<h2 style="font-style:normal; text-align:left">5 Crown King Shop</h2>
<p style="margin-left:0px; margin-right:0px; text-align:left"><span style="font-size:16px"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="background-color:#ffffff">B&ecirc;n tr&ecirc;n l&agrave; những shop gi&agrave;y được đ&aacute;nh gi&aacute; uy t&iacute;n tại H&agrave; Nội. C&ograve;n ở TPHCM Crown King Shop được biết đến l&agrave; một trong c&aacute;c cửa h&agrave;ng kinh doanh Sneaker l&acirc;u đời với nhiều năm kinh nghiệm trong việc nhận c&aacute;c đơn đặt h&agrave;ng gi&agrave;y d&eacute;p, quần &aacute;o, phụ kiện thời trang từ H&agrave;n Quốc, Mỹ, Singapore,&hellip; Rất nhiều kh&aacute;ch h&agrave;ng đ&atilde; tin tường v&agrave; lựa chọn Crown King Shop l&agrave; địa điểm để sắm những đ&ocirc;i gi&agrave;y cho m&igrave;nh. Đồng thời ở đ&acirc;y cũng được đ&aacute;nh gi&aacute; l&agrave; chất lượng thuộc nh&oacute;m cửa h&agrave;ng uy t&iacute;n, cực k&igrave; tốt. B&ecirc;n cạnh đ&oacute; shop c&ograve;n c&oacute; dịch vụ chăm s&oacute;c kh&aacute;ch h&agrave;ng sau khi mua h&agrave;ng. Một điểm kh&aacute;c với những shop kh&aacute;c m&agrave; bạn cần lưu &yacute; đ&oacute; l&agrave; Crown King Shop kh&ocirc;ng cung cấp h&agrave;ng sẵn m&agrave; chỉ nhận order h&agrave;ng của kh&aacute;ch cho n&ecirc;n rất ph&ugrave; hợp cho bạn n&agrave;o muốn c&oacute; đ&ocirc;i gi&agrave;y độc-lạ-chất.</span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px; text-align:left"><span style="font-size:16px"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="background-color:#ffffff"><img alt="địa chỉ mua sneaker chính hãng ở sài gòn" src="https://mcdn.coolmate.me/image/December2020/88eb8da8719d48f39bc970a33e2fef1c.jpg" style="border-radius:20px; border-style:none; box-sizing:border-box; color:rgba(0, 0, 0, 0); display:block; height:auto; image-rendering:-webkit-optimize-contrast; margin-left:auto; margin-right:auto; max-width:100%; vertical-align:middle; width:500px" /></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px; text-align:left">&nbsp;</p>
<div class="info-box" style="-webkit-text-stroke-width:0px; border-radius:16px; padding:24px; text-align:left">
<p style="margin-left:0px; margin-right:0px">&nbsp;</p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Th&ocirc;ng tin li&ecirc;n hệ<br />
FB:&nbsp;facebook.com/CrownKingShop.<br />
Address:&nbsp;18A/1 Nguyễn Thị Minh Khai, P.Đakao, Q.1, TPHCM.</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px">&nbsp;</p>
</div>
<p style="margin-left:0px; margin-right:0px; text-align:left">&nbsp;</p>
<h2 style="font-style:normal; text-align:left">6 Authenticity</h2>
<p style="margin-left:0px; margin-right:0px; text-align:left"><span style="font-size:16px"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="background-color:#ffffff">Authenticity c&oacute; t&ecirc;n gọi cũ l&agrave; Nguyen K Huan Shop. Mặc d&ugrave; c&oacute; gia nhập v&agrave;o thị trường gi&agrave;y sneaker sau Crown King Shop nhưng Authenticity với số lượng mẫu m&atilde; sản phẩm phong ph&uacute; c&ugrave;ng dịch vụ chăm s&oacute;c kh&aacute;ch h&agrave;ng cực tốt đ&atilde; trở th&agrave;nh một địa điểm đ&aacute;ng tin cậy cho t&iacute;n đồ Sneaker. B&ecirc;n cạnh đ&oacute; th&igrave; c&aacute;ch thức hoạt đ&ocirc;ng của Authenticity cũng c&oacute; kh&aacute;c biệt so với Crown King Shop ở chỗ: Authenticity ngo&agrave;i nhận c&aacute;c order c&ograve;n c&oacute; h&igrave;nh thức b&aacute;n trực tiếp tại cửa h&agrave;ng c&aacute;c mẫu gi&agrave;y mới, đẹp.</span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px; text-align:left"><span style="font-size:16px"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="background-color:#ffffff"><img alt="nên mua giày nam chính hãng ở đâu uy tín" src="https://mcdn.coolmate.me/image/December2020/moda3-1024x683.jpg" style="border-radius:20px; border-style:none; box-sizing:border-box; color:rgba(0, 0, 0, 0); display:block; height:auto; image-rendering:-webkit-optimize-contrast; margin-left:auto; margin-right:auto; max-width:100%; vertical-align:middle; width:500px" /></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px; text-align:left">&nbsp;</p>
<div class="info-box" style="-webkit-text-stroke-width:0px; border-radius:16px; padding:24px; text-align:left">
<p style="margin-left:0px; margin-right:0px">&nbsp;</p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Th&ocirc;ng tin li&ecirc;n hệ<br />
FB: facebook.com/authenticitystore.<br />
Address: Ngay nh&agrave; thờ Hạnh Th&ocirc;ng T&acirc;y &ndash; Quang Trung &ndash; P.10 &ndash; Q. G&ograve; Vấp &ndash;HCM.</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px">&nbsp;</p>
</div>
<p style="margin-left:0px; margin-right:0px; text-align:left">&nbsp;</p>
<h2 style="font-style:normal; text-align:left">7 G-Lap</h2>
<p style="margin-left:0px; margin-right:0px; text-align:left"><span style="font-size:16px"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="background-color:#ffffff">Đ&acirc;y c&oacute; lẽ l&agrave; c&aacute;i t&ecirc;n kh&aacute; quen thuộc với giới trẻ, đặc biệt l&agrave; d&acirc;n thể thao b&oacute;ng rổ. G &ndash; Lap mang đến cho bạn những sản phẩm chất lượng. G &ndash; Lap lu&ocirc;n nỗ lực x&acirc;y dựng văn ho&aacute; gi&agrave;y đa dạng, đặc sắc từ c&aacute;c thương hiệu uy t&iacute;n, nổi tiếng tr&ecirc;n thế giới như Adidas, Jordan, Nike,&hellip; Với lợi thế, shop c&oacute; nguồn gi&agrave;y kh&aacute; dồi d&agrave;o v&agrave; đa dạng, n&ecirc;n kh&aacute;ch h&agrave;ng khi đến đ&acirc;y c&oacute; thể chọn cho m&igrave;nh một đ&ocirc;i gi&agrave;y với k&iacute;ch thước như &yacute;, kh&ocirc;ng phải tốn qu&aacute; nhiều thời gian sau order. T&ugrave;y thuộc v&agrave;o mục đ&iacute;ch sử dụng, tại đ&acirc;y kh&aacute;ch h&agrave;ng sẽ c&oacute; những mẫu gi&agrave;y kh&aacute;c nhau.</span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px; text-align:left"><span style="font-size:16px"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="background-color:#ffffff"><img alt="mua giày tại store chính hãng" src="https://mcdn.coolmate.me/image/December2020/shop-giay-nam-1-1200x868.jpg" style="border-radius:20px; border-style:none; box-sizing:border-box; color:rgba(0, 0, 0, 0); display:block; height:auto; image-rendering:-webkit-optimize-contrast; margin-left:auto; margin-right:auto; max-width:100%; vertical-align:middle; width:500px" /></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px; text-align:left">&nbsp;</p>
<div class="info-box" style="-webkit-text-stroke-width:0px; border-radius:16px; padding:24px; text-align:left">
<p style="margin-left:0px; margin-right:0px">&nbsp;</p>
<p style="margin-left:0px; margin-right:0px"><span style="font-size:16px"><span style="background-color:#f1f1f1"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="font-size:16px">Th&ocirc;ng tin li&ecirc;n hệ<br />
FB: facebook.com/glab.vn<br />
Address:&nbsp;135/58 Trần Hưng Đạo, Q.1, TPHCM.</span></span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px">&nbsp;</p>
</div>
<p style="margin-left:0px; margin-right:0px; text-align:left">&nbsp;</p>
<h2 style="font-style:normal; text-align:left">8 S&agrave;i G&ograve;n Sneaker Store</h2>
<p style="margin-left:0px; margin-right:0px; text-align:left"><span style="font-size:16px"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="background-color:#ffffff">L&agrave; shop chuy&ecirc;n kinh doanh gi&agrave;y sneaker v&agrave; l&agrave; địa điểm y&ecirc;u th&iacute;ch của nhiều người khi t&igrave;m kiếm cho m&igrave;nh những đ&ocirc;i sneaker ch&iacute;nh h&atilde;ng. S&agrave;i G&ograve;n Sneaker Store được tin tưởng v&agrave; lựa chọn l&agrave;m điểm mua sắm cho m&igrave;nh bởi tại đ&acirc;y bạn c&oacute; thể t&igrave;m cho m&igrave;nh những đ&ocirc;i gi&agrave;y với đa dạng mẫu m&atilde; của c&aacute;c thương hiệu nổi tiếng như: Adidas, Nike, Puma,&hellip; Phương ch&acirc;m &ldquo;chất lượng &ndash; uy t&iacute;n&rdquo; đặt l&ecirc;n h&agrave;ng đầu, v&igrave; vậy, shop rất ch&uacute; trọng đến chất lượng dịch vụ, hỗ trợ v&agrave; cung cấp th&ocirc;ng tin cho kh&aacute;ch h&agrave;ng. Hiện nay, Saigon Sneaker Store c&oacute; nhận cả c&aacute;c đơn h&agrave;ng từ USA, &Uacute;c v&agrave; c&aacute;c nước trong khu vực với gi&aacute; cả phải chăng.</span></span></span></span></p>
<p style="margin-left:0px; margin-right:0px; text-align:left"><span style="font-size:16px"><span style="color:#231f20"><span style="font-family:Pangea,sans-serif"><span style="background-color:#ffffff"><img alt="top địa chỉ mua sneaker uy tín" src="https://mcdn.coolmate.me/image/December2020/ed8daf975ef1c4d4f8f8f276c06d0303.jpg" style="border-radius:20px; border-style:none; box-sizing:border-box; color:rgba(0, 0, 0, 0); display:block; height:auto; image-rendering:-webkit-optimize-contrast; margin-left:auto; margin-right:auto; max-width:100%; vertical-align:middle; width:500px" /></span></span></span></span></p>
',1),
(N'Giữ phong độ cho sneaker trắng ra sao',N'tintuc2.jpg','2/3/2020',N'<h2>Những c&aacute;ch bảo quản gi&agrave;y trắng</h2>
<h3>Tr&aacute;nh &aacute;nh s&aacute;ng trực tiếp của mặt trời</h3>
<p>Với những đ&ocirc;i gi&agrave;y Sneaker m&agrave;u th&igrave; &aacute;nh s&aacute;ng mặt trời ch&iacute;nh l&agrave; thủ phạm hằng đầu khiến cho m&agrave;u phai nhanh. C&ograve;n đối với những chiếc gi&agrave;y trắng th&igrave; &aacute;nh nắng lại khiến khả năng bị ố v&agrave;ng trở n&ecirc;n cao hơn. V&igrave; vậy kh&ocirc;ng phải nhắc nhở bạn l&agrave; kh&ocirc;ng được đeo gi&agrave;y trắng v&agrave;o ng&agrave;y nắng, m&agrave; việc bạn cất giữ đ&ocirc;i gi&agrave;y l&agrave;m sao để &aacute;nh nắng kh&ocirc;ng chiếu v&agrave;o khi kh&ocirc;ng sử dụng nh&eacute;.</p>
<h3>Tuyệt đối kh&ocirc;ng giặt gi&agrave;y bằng m&aacute;y giặt</h3>
<p>Gi&agrave;y trắng hay bất kể đ&ocirc;i gi&agrave;y n&agrave;o kh&aacute;c bạn cũng kh&ocirc;ng được lười v&agrave; bỏ ch&uacute;ng v&agrave;o m&aacute;y giặt. Như vậy l&agrave; khiến cho gi&agrave;y bị mất form, vải sẽ bị sờn, c&ograve;n đối với loại gi&agrave;y da, da sẽ bị bong tr&oacute;c. Kh&ocirc;ng kể tới việc gi&agrave;y c&oacute; đế cứng sẽ l&agrave;m cho m&aacute;y giặt nh&agrave; bạn phải chật vật đấy. Tốt nhất lu&ocirc;n n&oacute;i kh&ocirc;ng với giặt gi&agrave;y trắng bằng m&aacute;y giặt nh&eacute;.</p>
<h3>Giặt gi&agrave;y bằng nước ấm</h3>
<p>Nhiệt độ ấm vừa phải l&agrave; th&iacute;ch hợp nhất để bạn giặt gi&agrave;y. Đối với những sợi d&acirc;y gi&agrave;y th&igrave; bạn n&ecirc;n ng&acirc;m ch&uacute;ng v&agrave;o nước ầm pha bột giặt v&agrave; v&ograve; bằng tay. C&ograve;n với đ&ocirc;i d&agrave;y của bạn th&igrave; d&ugrave;ng b&agrave;n chải thấm nước giặt rồi ch&agrave; nhẹ nh&agrave;ng.</p>
<h3>D&ugrave;ng b&agrave;n chải đ&aacute;nh răng</h3>
<p><img alt="Dùng bàn chải đánh răng" src="https://moitruongdeal.vn/ckfinder/userfiles/images/bao-quan-giay-trang-3.jpg" /></p>
<p>&nbsp;</p>
<p>Với những vị tr&iacute; kh&oacute; ch&agrave; rửa tới bằng chiếc b&agrave;n chải to th&igrave; sử dụng b&agrave;n chải đ&aacute;nh răng ch&iacute;nh l&agrave; c&aacute;ch gi&uacute;p bạn. Bạn cũng l&agrave;m tương tự, nh&uacute;ng b&agrave;n chải đ&aacute;nh răng v&agrave;o nước pha bột giặt rồi ch&agrave; l&ecirc;n những khu vực kh&oacute; như mu gi&agrave;y v&agrave; b&ecirc;n trong gi&agrave;y.</p>
<h3>L&agrave;m sạch vết dầu mỡ tr&ecirc;n gi&agrave;y bằng dầu gội</h3>
<p>Nếu bạn chẳng may khiến cho đ&ocirc;i gi&agrave;y trắng của m&igrave;nh bị d&iacute;nh vết dầu mỡ thức ăn th&igrave; phải l&agrave;m sao? Việc sử dụng bột hay nước giặt dường như kh&ocirc;ng mang lại hiệu quả cao. Dầu gội ch&iacute;nh l&agrave; sản phẩm thay thế ho&agrave;n hảo. Bạn chỉ cần pha dầu gội v&agrave;o nước rồi ch&agrave; nhẹ nh&agrave;ng l&ecirc;n gi&agrave;y. Chiếc gi&agrave;y sẽ trở n&ecirc;n sạch sẽ v&agrave; trắng s&aacute;ng trở lại.</p>
<h3>Chữa vết xước tr&ecirc;n gi&agrave;y bằng nước sơn m&oacute;ng tay</h3>
<p>Gi&agrave;y trắng bị xước ở phần đế thường để lại hậu quả đ&oacute; l&agrave; khu vực l&otilde;m v&agrave;o trở n&ecirc;n đen khiến chiếc gi&agrave;y trở n&ecirc;n xấu x&iacute;. Để giải quyết bạn c&oacute; thể l&agrave;m như sau, d&ugrave;ng kem đ&aacute;nh răng v&agrave; b&agrave;n chải đ&aacute;nh răng ch&agrave; l&ecirc;n khu vực bị xước cho thật sạch bụi bẩn b&ecirc;n trong. Tiến h&agrave;nh lau sạch đi rồi tiếp đ&oacute; phết một ch&uacute;t nước sơn m&oacute;ng tay l&ecirc;n tr&ecirc;n khu vực xước. Kết quả l&agrave; vết xước l&otilde;m bị lấp đầy v&agrave; bạn kh&ocirc;ng lo bị bụi bẩn lẻn v&agrave;o l&agrave;m xấu gi&agrave;y nữa.</p>
<h3>D&ugrave;ng g&ocirc;m để l&agrave;m sạch vết bẩn</h3>
<p>Bạn c&oacute; thể d&ugrave;ng tẩy để tẩy vết ố tr&ecirc;n gi&agrave;y trắng. Đặc biệt khi sử dụng gi&agrave;y l&agrave;m từ chất liệu cao su, da PU hay da lộn th&igrave; cục tẩy sẽ tẩy sạch mọi vết bẩn. Tuy nhi&ecirc;n, c&aacute;ch n&agrave;y chỉ ph&ugrave; hợp với những đ&ocirc;i gi&agrave;y hầu như kh&ocirc;ng c&oacute; vết bẩn hoặc trầy xước nhẹ.</p>
<h3>Xịt nano</h3>
<p>Đối với gi&agrave;y da lộn, da Nubuck v&agrave; c&aacute;c loại vải, sử dụng b&igrave;nh xịt nano l&agrave; c&aacute;ch bảo quản gi&agrave;y trắng l&yacute; tưởng. B&igrave;nh xịt nano gi&uacute;p tạo th&agrave;nh một lớp mỏng trong suốt gi&uacute;p nước kh&ocirc;ng d&iacute;nh v&agrave;o bề mặt gi&agrave;y trắng. Đặc biệt, khi được phun nhiều lớp tr&ecirc;n bề mặt da, đ&ocirc;i gi&agrave;y sẽ c&oacute; khả năng chống thấm nước tốt.</p>
<h3>Cất gi&agrave;y v&agrave;o hộp khi kh&ocirc;ng sử dụng</h3>
<p>Khi bảo quản v&agrave; giữ g&igrave;n gi&agrave;y sạch sẽ, bạn kh&ocirc;ng được bỏ qua những chiếc hộp đựng gi&agrave;y tiện lợi n&agrave;y. Trước khi cho gi&agrave;y v&agrave;o hộp, bạn n&ecirc;n l&oacute;t những mảnh giấy b&aacute;o để giữ nguy&ecirc;n h&igrave;nh d&aacute;ng của đ&ocirc;i gi&agrave;y, đồng thời th&ecirc;m chất h&uacute;t ẩm để loại bỏ hơi ẩm trong gi&agrave;y.</p>
<p>&nbsp;</p>
<p>Tốt nhất, g&oacute;i h&uacute;t ẩm n&ecirc;n được đặt v&agrave;o trong gi&agrave;y hoặc hộp đựng gi&agrave;y. Nếu c&oacute; điều kiện hơn, bạn c&oacute; thể mua hộp đựng gi&agrave;y h&uacute;t ch&acirc;n kh&ocirc;ng.</p>
',1),
(N'Cách buộc dây giày',N'tintuc3.jpg','2/3/2020',N'<h2><strong>I. C&aacute;ch buộc d&acirc;y gi&agrave;y converse cổ thấp</strong></h2>
<p>Ngo&agrave;i những c&aacute;ch buộc d&acirc;y gi&agrave;y truyền thống, m&agrave;&nbsp;<strong>MrBo</strong>&nbsp;đ&atilde; c&oacute; dịp chia sẻ với c&aacute;c bạn trước đ&acirc;y. H&ocirc;m nay m&igrave;nh sẽ mang đến cho c&aacute;c bạn những c&aacute;ch buộc d&acirc;y mới với gi&agrave;y cổ thấp.</p>
<p>Những c&aacute;ch n&agrave;y c&oacute; thể &aacute;p dụng cho&nbsp;buộc d&acirc;y gi&agrave;y converse 5 lỗ, 6 lỗ, hoặc 7 lỗ t&ugrave;y theo đ&ocirc;i gi&agrave;y của bạn.</p>
<p><strong>Video cach buoc day giay converse truyen thong</strong></p>
<h3>1. Thắt d&acirc;y kiểu zipper</h3>
<p>Phương ph&aacute;p n&agrave;y &ldquo;kho&aacute;&rdquo; d&acirc;y gi&agrave;y ở phần giữa mỗi cặp lỗ x&acirc;u, tạo n&ecirc;n những n&uacute;t thắt tr&ocirc;ng kh&aacute; th&uacute; vị, nh&igrave;n qua tr&ocirc;ng như một chiếc kh&oacute;a k&eacute;o hạy dọc đ&ocirc;i gi&agrave;y.</p>
<p>Với những t&iacute;n đồ y&ecirc;u th&iacute;ch m&ocirc;n trượt v&aacute;n, c&aacute;ch thắt n&agrave;y l&agrave; sự lựa chọn l&yacute; tưởng v&igrave; phần d&acirc;y gi&agrave;y ở ph&iacute;a gần mũi gi&agrave;y được thắt rất chặt. (Kết quả đẹp nhất với gi&agrave;y converse 7 lỗ)</p>
<p><strong>Th&agrave;nh quả khi thắt xong</strong></p>
<p><img alt="Thắt dây converse kiểu zipper" src="https://kiza.vn/blog/wp-content/uploads/2018/06/cach-that-day-giay-kieu-zipper.jpeg" style="height:360px; width:640px" /></p>
<p>Thắt d&acirc;y converse kiểu zipper</p>
<p><strong>C&aacute;c bước thực hiện</strong></p>
<p><img alt="" src="https://kiza.vn/blog/wp-content/uploads/2018/06/kieu-zipper-buoc-1.png" style="height:320px; width:197px" /></p>
<p><img alt="" src="https://kiza.vn/blog/wp-content/uploads/2018/06/kieu-zipper-buoc-2.png" style="height:319px; width:198px" /></p>
<ul>
	<li>Xỏ hai d&acirc;y v&agrave;o lỗ x&acirc;u cao hơn kế tiếp v&agrave; tiếp tục.</li>
	<li>Lặp lại v&ograve;ng lặp cho đến khi kết th&uacute;c.</li>
</ul>
<p><em><strong>Đặc điểm của c&aacute;ch thắt kh&oacute;a:</strong></em></p>
<ul>
	<li>C&oacute; t&aacute;c dụng rang tr&iacute;</li>
	<li>D&acirc;y thắt kh&ocirc;ng bị xộc xệch.</li>
	<li>Kh&oacute; thắt chặt.</li>
	<li>Ngắn hơn 3% (kết th&uacute;c).</li>
</ul>
<p><strong>Lưu &yacute; :</strong></p>
<p>Một trong những kh&oacute; khăn lớn nhất khi thắt chặt d&acirc;y gi&agrave;y kiểu n&agrave;y l&agrave; giữ chặt c&aacute;c phần dưới trong khi phải l&agrave;m việc với phần tr&ecirc;n.</p>
<p>Thắt d&acirc;y kiểu kh&oacute;a k&eacute;o giữ d&acirc;y gi&agrave;y thắt chặt tại mỗi mắt lưới. Điều n&agrave;y khiến n&oacute; trở th&agrave;nh n&uacute;t thắt tuyệt vời nhất đối với gi&agrave;y trượt băng, ủng, gi&agrave;y leo n&uacute;i, hoặc bất kỳ gi&agrave;y d&eacute;p m&agrave; cần hỗ trợ vững chắc.</p>
<h3>2. Kiểu buộc d&acirc;y gi&agrave;y converse Loop Back</h3>
<p>Kiểu buộc d&acirc;y gi&agrave;y Loop Back v&ocirc; c&ugrave;ng ấn tượng bởi những n&uacute;t xoắn ở giữa th&acirc;n tr&ecirc;n của gi&agrave;y, tạo cho đ&ocirc;i gi&agrave;y d&aacute;ng khỏe khoắn, năng động nhưng kh&ocirc;ng k&eacute;m phần nổi bật.</p>
<h4>H&igrave;nh ảnh thực tế sau khi&nbsp;đan d&acirc;y gi&agrave;y</h4>
<p><img alt="Cách thắt dây giày converse cổ thấp 6 lỗ" src="https://kiza.vn/blog/wp-content/uploads/2018/06/buoc-day-giay-converse-kiey-loopback-look.jpeg" style="height:600px; width:600px" /></p>
<p>C&aacute;ch thắt d&acirc;y gi&agrave;y converse cổ thấp 6 lỗ</p>
<p>C&aacute;c bước thực hiện thắt d&acirc;y&nbsp;<strong>Loop Back</strong></p>
<h4><strong>C&aacute;c bước thực hiện x&acirc;u d&acirc;y gi&agrave;y</strong></h4>
<p><img alt="Thắt dây giày converse đẹp đơn giản" src="https://kiza.vn/blog/wp-content/uploads/2018/06/kieu-buoc-day-giay-converse-loop-back.gif" style="height:322px; width:199px" /></p>
<p>Thắt d&acirc;y gi&agrave;y converse đẹp đơn giản</p>
<ul>
	<li><strong>Bước 1</strong>: Xỏ d&acirc;y v&agrave;o 2 lỗ xỏ h&agrave;ng ngang đầu ti&ecirc;n sao cho phần d&acirc;y thừa nằm b&ecirc;n ngo&agrave;i gi&agrave;y (xỏ từ dưới l&ecirc;n tr&ecirc;n).</li>
	<li><strong>Bước 2</strong>: Vắt ch&eacute;o hai phần d&acirc;y với Đưa phần d&acirc;y m&agrave;u xanh xỏ v&agrave;o lỗ thứ 2 b&ecirc;n tr&aacute;i, đưa phần d&acirc;y m&agrave;u v&agrave;ng xỏ v&agrave;o lỗ thứ 2 b&ecirc;n phải.</li>
	<li><strong>Bước 3</strong>: Tiếp tục như vậy cho đến hết th&igrave; buộc lại.</li>
</ul>
<h3>3. Kiểu buộc d&acirc;y gi&agrave;y zig-zag</h3>
<p>Kỹ thuật x&acirc;u d&acirc;y gi&agrave;y converse n&agrave;y &iacute;t bạn trẻ biết đến, v&agrave; thực hiện được. Tuy nhi&ecirc;n, nếu th&agrave;nh c&ocirc;ng th&igrave; sẽ tạo n&ecirc;n sự kh&aacute;c biệt rất lớn đ&oacute; c&aacute;c bạn.</p>
<p>C&aacute;c bạn tham khảo video c&aacute;ch xỏ d&acirc;y gi&agrave;y zig-zag dưới đ&acirc;y nh&eacute;!</p>
<h4>Th&agrave;nh quả sau khi cột d&acirc;y gi&agrave;y xong</h4>
<p><img alt="cách xỏ dây giày converse" src="https://kiza.vn/blog/wp-content/uploads/2018/06/cach-that-day-giay-converse-kieu-Zig-zag.jpeg" style="height:260px; width:665px" /></p>
<p>Thắt d&acirc;y gi&agrave;y converse zig zag</p>
<p>C&oacute; thể bạn chưa thực hiện được ngay trong lần đầu ti&ecirc;n. H&atilde;y ki&ecirc;n tr&igrave; bạn nh&eacute;, kiza sẽ hướng dẫn bạn thực hiện qua từng bước dưới đ&acirc;y.</p>
<h4>C&aacute;c bước thực hiện</h4>
<p><img alt="xỏ dây giày converse" src="https://kiza.vn/blog/wp-content/uploads/2018/06/tung-buoc-thuc-hien-buoc-day-giay-kieu-Zig-zag.gif" style="height:319px; width:200px" /></p>
<p>C&aacute;ch thắt d&acirc;y gi&agrave;y converse kiểu zig zag</p>
<ul>
	<li><strong>Bước 1</strong>: Xỏ d&acirc;y gi&agrave;y từ lỗ xỏ b&ecirc;n tr&aacute;i (xỏ từ dưới l&ecirc;n tr&ecirc;n) sang lỗ xỏ b&ecirc;n phải (xỏ từ dưới l&ecirc;n)</li>
	<li><strong>Bước 2</strong>: Đưa phần d&acirc;y b&ecirc;n tr&aacute;i (m&agrave;u xanh) xỏ v&agrave;o lỗ xỏ kế b&ecirc;n ở h&agrave;ng dưới (xỏ từ dưới l&ecirc;n tr&ecirc;n)</li>
	<li><strong>Bước 3</strong>: Đưa phần d&acirc;y b&ecirc;n phải (m&agrave;u v&agrave;ng) qua lỗ được tạo bởi bước 2 v&agrave; xỏ sang lỗ xỏ h&agrave;ng thứ 2 c&ograve;n lại.</li>
	<li><strong>Bước 4</strong>: Đưa phần d&acirc;y m&agrave;u v&agrave;ng xỏ qua lỗ xỏ thứ 3 kế b&ecirc;n (xỏ từ dưới l&ecirc;n tr&ecirc;n)</li>
	<li><strong>Bước 5</strong>: Đưa phần d&acirc;y m&agrave;u xanh xỏ qua lỗ được tạo bởi bước 4 v&agrave; xỏ sang lỗ xỏ h&agrave;ng thứ 4</li>
	<li><strong>Bước 6</strong>: Lặp lại c&aacute;c bước với từng b&ecirc;n d&acirc;y cho đến hết th&igrave; buộc lại.</li>
</ul>
',1)

insert into Orders (UserID,Address,Email,UserName,Note,DateCreate,Phone,Status) VALUES
(3,N'Cầu Giấy, Hà Nội','hgfeafhkj@gmail.com',N'Nguyễn Văn Nam',N'Nhận hàng vào 1/20/2022','12/12/2021','09876543',N'Đã giao hàng'),
(3,N'Cầu Giấy, Hà Nội','hgfeafhkj@gmail.com',N'Nguyễn Văn Nam',N'Nhận hàng vào 3/29/2022','3/12/2022','09876543',N'Đang chuẩn bị'),
(3,N'Cầu Giấy, Hà Nội','hgfeafhkj@gmail.com',N'Nguyễn Văn Nam',N'Nhận hàng vào 4/20/2022','4/10/2022','09876543',N'Đang giao hàng')

insert into  OrderDetail(OrderID, ImageID,Size , Amount) VALUES
(1,1,37,1),
(1,8,37,1),
(1,10,37,1),
(2,1,37,1),
(3,1,37,1),
(3,8,37,1),
(3,5,37,1)