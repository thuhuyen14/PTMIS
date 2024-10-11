create database QLCF
go
use QLCF
go

-- BẢNG Nhân viên
create table nhanvien (
	manv char(20) primary key,
	tennv nvarchar(50) not null,
	gioitinh nvarchar(10) not null check (gioitinh in ('Nam','Nữ')),
	sdt varchar(20) not null,
	diachi nvarchar(50) not null
)

-- Bảng Nhà cung cấp
create table ncc (
	mancc char(20) primary key,
	tenncc nvarchar(50) not null,
	sdt varchar(20) not null,
	diachi nvarchar(50),
	email nvarchar(50) 
)

-- Bảng Nguyên liệu
create table nguyenlieu (
	manl char(20) primary key,
	tennl nvarchar(50) not null,
	ton nvarchar(50) not null
)

-- Bảng Hóa đơn nhập
create table hdnhap (
	mahdn char(20) primary key,
	ngaynhap date not null,
	ptttoan nvarchar(50) check (ptttoan in ('TM','CK')) not null,
	manv char(20) foreign key references nhanvien(manv),
	mancc char(20) foreign key references ncc(mancc)
)

-- Bảng Chi tiết hóa đơn nhập
create table cthdnhap(
	mahdn char(20) foreign key references hdnhap(mahdn),
	manl char(20) foreign key references nguyenlieu(manl),
	soluong nvarchar(20) not null,
	dongia nvarchar(20) not null
)

-- Bảng Tích điểm: bảng này dùng cho bảng Khách hàng để tích điểm
create table tichdiem(
	matd char(20) primary key,
	tentichdiem nvarchar(50) not null,
	dieukientd nvarchar(50) not null,
	giamgia nvarchar(50) not null
)

-- Bảng Khách hàng
create table khachhang(
	makh char(20) primary key,
	tenkh nvarchar(50) not null,
	sdt varchar(20) not null,
	matd char(20) foreign key references tichdiem(matd)
)

-- Bảng Bàn
create table ban (
	maban  char(20) primary key,
	tenban nvarchar(50) not null
)

-- Bảng Loại sản phẩm : cafe, trà hoa quả, trà trái cây,..
create table loai (
	maloai  char(20) primary key,
	tenloai nvarchar(50) not null
)

-- Bảng thực đơn
create table thucdon (
   	masp char(20) primary key,
   	tensp nvarchar(50) not null,
   	maloai char(20) foreign key references loai(maloai),
   	dongia money
)

-- Bảng công thức 
create table congthuc(
	mact char(20) primary key,
	masp char(20) foreign key references thucdon(masp)
)

-- Bảng Chi tiết công thức
create table ctcongthuc(
	mact char(20) foreign key references congthuc(mact),
	manl char(20) foreign key references nguyenlieu(manl),
	hamluong int not null,
	dvtinh nvarchar(10) not null
)

-- Bảng Hóa đơn
create table hoadon(
	mahd char(20) primary key,
	ngaytao date not null,
	ptttoan nvarchar(20) check (ptttoan in ('TM','CK')) not null,
	manv char(20) foreign key references nhanvien(manv),
	maban char(20) foreign key references ban(maban),
	makh char(20) foreign key references khachhang(makh),
	matd char(20) not null foreign key references tichdiem(matd)
)

-- Bảng Chi tiết hóa đơn
create table cthoadon(
	mahd char(20) foreign key references hoadon(mahd),
	masp char(20) foreign key references thucdon(masp),
	soluong nvarchar(20) not null,
	dongia money not null
)

