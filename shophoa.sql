-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1:3307
-- Thời gian đã tạo: Th10 26, 2025 lúc 11:15 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `shophoa`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `banner`
--

CREATE TABLE `banner` (
  `id` int(11) NOT NULL,
  `tieu_de` varchar(200) NOT NULL,
  `hinh_anh` varchar(255) NOT NULL,
  `trang_thai` enum('SHOW','HIDE') DEFAULT 'SHOW',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `banner`
--

INSERT INTO `banner` (`id`, `tieu_de`, `hinh_anh`, `trang_thai`, `ngay_tao`) VALUES
(2, 'Sockk', 'shock.jpg', 'SHOW', '2025-11-20 06:01:56'),
(3, 'Banner 3 - Mừng ngày nhà giáo Việt Nam', 'banner3.png', 'SHOW', '2025-11-20 06:14:02'),
(4, 'Banner 2 - Mừng ngày phụ nữ Việt Nam', 'banner2.png', 'SHOW', '2025-11-20 06:15:06'),
(5, 'Banner 1- shop hoa', 'banner4.png', 'SHOW', '2025-11-20 06:15:55');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chi_tiet_don_hang`
--

CREATE TABLE `chi_tiet_don_hang` (
  `id_don_hang` int(11) NOT NULL,
  `id_hoa` int(11) NOT NULL,
  `so_luong` int(11) DEFAULT 1,
  `don_gia` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `chi_tiet_don_hang`
--

INSERT INTO `chi_tiet_don_hang` (`id_don_hang`, `id_hoa`, `so_luong`, `don_gia`) VALUES
(1, 213, 1, 910000),
(2, 220, 1, 1500000),
(3, 213, 1, 910000),
(4, 218, 2, 690000),
(4, 230, 1, 1450000),
(4, 232, 1, 890000),
(4, 238, 1, 590000),
(5, 213, 1, 910000),
(5, 220, 1, 1500000),
(6, 213, 1, 910000),
(6, 234, 1, 640000),
(7, 220, 1, 1500000),
(7, 221, 1, 880000),
(8, 232, 1, 890000),
(8, 233, 2, 950000),
(9, 230, 1, 1450000),
(10, 230, 1, 1450000),
(11, 237, 1, 730000),
(12, 218, 1, 690000),
(12, 229, 2, 720000),
(13, 218, 1, 690000),
(13, 224, 1, 620000),
(13, 235, 1, 710000),
(14, 232, 1, 890000),
(15, 220, 1, 1500000),
(16, 222, 1, 700000),
(17, 228, 1, 660000),
(18, 212, 1, 660000),
(19, 213, 1, 910000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `don_hang`
--

CREATE TABLE `don_hang` (
  `id` int(11) NOT NULL,
  `id_nguoi_dung` int(11) NOT NULL,
  `ho_ten_nhan` varchar(100) NOT NULL,
  `dien_thoai_nhan` varchar(20) NOT NULL,
  `dia_chi_nhan` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `ngay_lap` datetime DEFAULT current_timestamp(),
  `trang_thai` enum('PENDING','CONFIRMED','SHIPPING','CANCELLED','DONE') NOT NULL DEFAULT 'PENDING',
  `tong_tien` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `don_hang`
--

INSERT INTO `don_hang` (`id`, `id_nguoi_dung`, `ho_ten_nhan`, `dien_thoai_nhan`, `dia_chi_nhan`, `email`, `ngay_lap`, `trang_thai`, `tong_tien`) VALUES
(1, 1, 'Nguyen Ngoc Minh', '0981460503', 'Tan Mai - Hoang Mai - Ha Noi', '06052003nnm@gmail.com', '2025-11-14 04:47:54', 'CANCELLED', 910000.00),
(2, 1, 'Nguyen Ngoc Minh', '0981460503', 'hn\r\nhn', '06052003nnm@gmail.com', '2025-11-14 14:20:07', 'CANCELLED', 1500000.00),
(3, 1, 'Nguyen Ngoc Minh', '0981460503', 'Thị Trấn Lập Thạch - Lập Thạch - Vĩnh Phúc', '06052003nnm@gmail.com', '2025-11-15 13:23:02', 'CANCELLED', 910000.00),
(4, 1, 'Nguyen Ngoc Minh', '0981460503', 'Hoàng Liệt - Hoàng Mai - Hà Nội\r\nHa noi', '06052003nnm@gmail.com', '2025-11-15 16:15:06', 'CANCELLED', 4310000.00),
(5, 1, 'Nguyen Ngoc Minh', '0981460503', 'Thị Trấn Lập Thạch - Lập Thạch - Vĩnh Phúc', '06052003nnm@gmail.com', '2025-11-18 01:42:40', 'CANCELLED', 2410000.00),
(6, 1, 'Nguyen Ngoc Minh', '0981460503', 'Tan Mai - Hoang Mai - Ha Noi', '06052003nnm@gmail.com', '2025-11-18 01:43:30', 'CANCELLED', 1550000.00),
(7, 1, 'Nguyen Ngoc Minh', '0981460503', 'Thị Trấn Lập Thạch - Lập Thạch - Vĩnh Phúc', '06052003nnm@gmail.com', '2025-11-19 09:10:06', 'CONFIRMED', 2380000.00),
(8, 1, 'Nguyen Ngoc Minh', '0981460503', 'Thị Trấn Lập Thạch - Lập Thạch - Vĩnh Phúc', '06052003nnm@gmail.com', '2025-11-19 09:11:46', 'DONE', 2790000.00),
(9, 1, 'Nguyen Ngoc Minh', '0981460503', 'Thị Trấn Lập Thạch - Lập Thạch - Vĩnh Phúc', '06052003nnm@gmail.com', '2025-11-19 09:13:09', 'CANCELLED', 1450000.00),
(10, 1, 'Nguyen Ngoc Minh', '0981460503', 'Thị Trấn Lập Thạch - Lập Thạch - Vĩnh Phúc', '06052003nnm@gmail.com', '2025-11-19 09:13:41', 'SHIPPING', 1450000.00),
(11, 1, 'Nguyen Ngoc Minh', '0981460503', 'Tan Mai - Hoang Mai - Ha Noi', '06052003nnm@gmail.com', '2025-11-19 09:19:43', 'CONFIRMED', 730000.00),
(12, 9, 'chomeil', '0909090909', 'Cho meo\r\n          ', 'chomeo@chomeo.com', '2025-11-20 07:50:02', 'CONFIRMED', 2130000.00),
(13, 7, 'Nguyen Ngoc Minh', '0981460503', 'Tan Mai - Hoang Mai - Ha Noi\r\n          ', 'cubi123456@gmail.com', '2025-11-20 07:53:15', 'DONE', 2020000.00),
(14, 7, 'Nguyen Ngoc Minh', '0981460503', 'Tan Mai - Hoang Mai - Ha Noi', 'cubi123456@gmail.com', '2025-11-21 03:00:58', 'PENDING', 890000.00),
(15, 8, 'Nguyen Ngoc Minh', '0981460503', 'Tan Mai - Hoang Mai - Ha Noi', 'cub123456@gmail.com', '2025-11-21 03:03:16', 'PENDING', 1500000.00),
(16, 9, 'chomeil', '0909090909', 'Cho meo', 'chomeo@chomeo.com', '2025-11-21 03:40:55', 'CANCELLED', 700000.00),
(17, 9, 'chomeil', '090909090966', 'Cho meo', 'chomeo@chomeo.com', '2025-11-23 09:50:44', 'PENDING', 660000.00),
(18, 9, 'chomeil', '0909090909', 'Cho meo', 'chomeo@a.com', '2025-11-24 10:40:06', 'DONE', 660000.00),
(19, 8, 'Nguyen Ngoc Minh', '0981460503', 'Tan Mai - Hoang Mai - Ha Noi', 'cub123456@gmail.co', '2025-11-24 10:44:49', 'CONFIRMED', 910000.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `gio_hang`
--

CREATE TABLE `gio_hang` (
  `id_nguoi_dung` int(11) NOT NULL,
  `id_hoa` int(11) NOT NULL,
  `so_luong` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `hoa`
--

CREATE TABLE `hoa` (
  `id` int(11) NOT NULL,
  `ten_hoa` varchar(200) NOT NULL,
  `id_loai` int(11) NOT NULL,
  `gia` decimal(10,2) NOT NULL,
  `gia_goc` decimal(10,2) DEFAULT NULL,
  `anh` varchar(255) DEFAULT NULL,
  `mo_ta` text DEFAULT NULL,
  `so_luong` int(11) DEFAULT 0,
  `is_recommended` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `hoa`
--

INSERT INTO `hoa` (`id`, `ten_hoa`, `id_loai`, `gia`, `gia_goc`, `anh`, `mo_ta`, `so_luong`, `is_recommended`) VALUES
(211, 'Nồng Nàn Tình Yêu', 2, 610000.00, 700000.00, 'hoa1.jpg', 'Hoa hồng đỏ nổi bật cho ngày tình yêu', 10, 1),
(212, 'My Girl', 2, 660000.00, 800000.00, 'hoa2.jpg', 'Hoa pastel nhẹ nhàng cho người thương', 7, 0),
(213, 'Điều Hạnh Phúc', 1, 910000.00, 1110000.00, 'hoa3.jpg', 'Hoa sinh nhật tông xanh tinh tế', 11, 0),
(214, 'Caffeine', 1, 530000.00, 590000.00, 'hoa4.jpg', 'Hoa sinh nhật hồng cam vintage', 15, 1),
(215, 'Hạnh Phúc Trọn Vẹn', 3, 720000.00, 720000.00, 'hoa5.jpg', 'Chúc mừng khai trương thành công', 10, 0),
(216, 'Chào Ngày Mới', 3, 580000.00, 580000.00, 'hoa6.jpg', 'Giỏ hoa chúc mừng đầy năng lượng', 9, 0),
(217, 'Forever Love', 2, 850000.00, 900000.00, 'hoa7.jpg', 'Tình yêu vĩnh cửu với hoa hồng nhập', 6, 0),
(218, 'Tinh Tế', 4, 690000.00, 790000.00, 'hoa8.jpg', 'Hoa lan trắng thanh lịch cho khai trương', 8, 0),
(219, 'Ánh Dương', 4, 740000.00, 740000.00, 'hoa9.jpg', 'Hoa mặt trời rực rỡ thành công', 5, 0),
(220, 'Vĩnh Cửu', 5, 1500000.00, 1700000.00, 'hoa10.jpg', 'Bó hoa cưới tinh khôi và sang trọng', 3, 1),
(221, 'Duyên Dáng', 5, 880000.00, 880000.00, 'hoa11.jpg', 'Hoa cầm tay cô dâu nhẹ nhàng', 5, 0),
(222, 'An Nhiên', 6, 700000.00, 700000.00, 'hoa12.jpg', 'Hoa tang lễ trắng tinh tế, trang trọng', 4, 0),
(223, 'Nhớ Mãi', 6, 820000.00, 850000.00, 'hoa13.jpg', 'Vòng hoa chia buồn lịch sự', 3, 0),
(224, 'Tình Đầu', 7, 620000.00, 750000.00, 'hoa14.jpg', 'Hoa tình yêu cho Valentine đầu tiên', 8, 0),
(225, 'Lãng Mạn Nhẹ Nhàng', 7, 700000.00, 700000.00, 'hoa15.jpg', 'Tông hồng dịu dàng cho ngày yêu', 6, 0),
(226, 'Gửi Mẹ', 8, 560000.00, 600000.00, 'hoa16.jpg', 'Tặng mẹ ngày đặc biệt nhất', 10, 0),
(227, 'Yêu Dấu', 8, 750000.00, 750000.00, 'hoa17.jpg', 'Hoa hồng cam tình cảm', 8, 0),
(228, 'Tốt Nghiệp Vinh Quang', 9, 660000.00, 760000.00, 'hoa18.jpg', 'Tặng bạn bè ngày tốt nghiệp', 10, 0),
(229, 'Bước Tiến', 9, 720000.00, 720000.00, 'hoa19.jpg', 'Mừng bạn bước sang chặng mới', 8, 0),
(230, 'Luxury Bloom', 10, 1450000.00, 1700000.00, 'hoa20.jpg', 'Hoa tươi nhập khẩu cao cấp', 2, 0),
(231, 'Nhập Khẩu Đặc Biệt', 10, 1380000.00, 1380000.00, 'hoa21.jpg', 'Độc quyền từ Hà Lan', 3, 0),
(232, 'Combo Hồng Gấu Bông', 11, 890000.00, 1050000.00, 'hoa22.jpg', 'Tặng cả hoa lẫn quà dễ thương', 7, 0),
(233, 'Combo Chocolate + Hoa', 11, 950000.00, 950000.00, 'hoa23.jpg', 'Combo siêu ngọt ngào', 6, 0),
(234, 'Hoa Mùa Thu', 12, 640000.00, 690000.00, 'hoa24.jpg', 'Tông màu trầm ấm của thu', 5, 0),
(235, 'Sắc Xuân', 12, 710000.00, 710000.00, 'hoa25.jpg', 'Hoa theo mùa xuân nhẹ nhàng', 5, 0),
(236, 'Chúc Mừng Thành Tích', 3, 670000.00, 670000.00, 'hoa26.jpg', 'Bó hoa trao tay chúc mừng', 9, 0),
(237, 'Love Box', 2, 730000.00, 820000.00, 'hoa27.jpg', 'Hộp hoa tình yêu độc đáo', 3, 0),
(238, 'Sweet Pink', 1, 590000.00, 590000.00, 'hoa28.jpg', 'Sinh nhật bé gái dễ thương', 5, 0),
(239, 'Bình Yên', 6, 750000.00, 820000.00, 'hoa29.jpg', 'Vòng hoa đơn giản mà sang trọng', 2, 0),
(240, 'Elegant Mix', 10, 1100000.00, 1250000.00, 'hoa30.jpg', 'Mix nhiều loại hoa nhập sang trọng', 3, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `lien_he`
--

CREATE TABLE `lien_he` (
  `id` int(11) NOT NULL,
  `ho_ten` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `so_dien_thoai` varchar(20) DEFAULT NULL,
  `tieu_de` varchar(200) DEFAULT NULL,
  `noi_dung` text NOT NULL,
  `trang_thai` enum('NEW','REPLIED') NOT NULL DEFAULT 'NEW',
  `ngay_gui` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `lien_he`
--

INSERT INTO `lien_he` (`id`, `ho_ten`, `email`, `so_dien_thoai`, `tieu_de`, `noi_dung`, `trang_thai`, `ngay_gui`) VALUES
(1, 'Nguyen Ngoc Minh', 'minhnn.amber@gmail.com', '0981460503', 'Hoa dep', 'hoa đẹp đấy', 'REPLIED', '2025-11-13 08:02:27'),
(2, 'Nguyen Ngoc Minh', 'seiiryu2003@gmail.com', '09123123213', 'Shop đẳng cấp quá', 'quá là đẳng cấp luôn', 'REPLIED', '2025-11-14 11:01:43'),
(3, 'Jewel Klocko', '05016294@sfcollege.edu', '', 'Thực sự để mà lói', 'Website này quá là đẳng cấp, tôi chỉ muốn test độ dài nội dung, này quá là đẳng cấp, tôi chỉ muốn test độ dài nội dung, này quá là đẳng cấp, tôi chỉ muốn test độ dài nội dung, này quá là đẳng cấp, tôi chỉ muốn test độ dài nội dung, này quá là đẳng cấp, tôi chỉ muốn test độ dài nội dung', 'NEW', '2025-11-20 14:52:36'),
(4, 'docgia01', 'minhnn.amber@gmail.com', '0981460503', 'Website này quá là đẳng cấp, tôi chỉ muốn test độ dài nội dung, này quá là đẳng cấp, tôi chỉ muốn test độ dài nội dung, này quá là đẳng cấp, tôi chỉ m', 'Website này quá là đẳng cấp, tôi chỉ muốn test độ dài nội dung, này quá là đẳng cấp, tôi chỉ muốn test độ dài nội dung, này quá là đẳng cấp, tôi chỉ muốn test độ dài nội dung, này quá là đẳng cấp, tôi chỉ muốn test độ dài nội dung, này quá là đẳng cấp, tôi chỉ muốn test độ dài nội dung', 'REPLIED', '2025-11-20 14:55:15'),
(5, 'docgia01', 'magnoliar39@helpnow.live', '0373964444', 'Vạn sự tùy duyên', 'Hoa rơi cửa phật', 'NEW', '2025-11-21 10:38:25'),
(6, 'docgia01', 'magnoliar39@helpnow.live', '0373964444', 'Vạn sự tùy duyên', 'Hoa rơi cửa phật', 'NEW', '2025-11-21 10:40:03'),
(7, 'docgia01', 'magnoliar39@helpnow.live', '0373964444', 'just test', 'Mieo meow', 'NEW', '2025-11-21 10:40:22'),
(8, 'Nguyen Ngoc Minh', 'minhnn.amber@gmail.com', '0981460503', 'ALO', 'aloaloalaolo', 'NEW', '2025-11-24 09:45:34'),
(9, 'Nguyen Ngoc Minh', 'minhnn.amber@gmail.com', '0981460503', 'aaaaaaa', 'aaaaaaaaaa', 'NEW', '2025-11-24 16:14:08'),
(10, 'Nguyen Ngoc Minh', 'minhnn.amber@gmail.com', '098146050333', 'ahaha', 'ạbkjkdsashjkds', 'NEW', '2025-11-24 16:56:53'),
(11, 'Jewel Klocko', '05016294@sfcollege.', '', 'ád', 'adasdasdsa', 'NEW', '2025-11-24 16:59:07');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `loai_hoa`
--

CREATE TABLE `loai_hoa` (
  `id` int(11) NOT NULL,
  `ten_loai` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `loai_hoa`
--

INSERT INTO `loai_hoa` (`id`, `ten_loai`) VALUES
(1, 'Hoa Sinh Nhật'),
(2, 'Hoa Tình Yêu'),
(3, 'Hoa Chúc Mừng'),
(4, 'Hoa Khai Trương'),
(5, 'Hoa Cưới'),
(6, 'Hoa Tang Lễ'),
(7, 'Hoa Valentine'),
(8, 'Hoa Ngày Của Mẹ'),
(9, 'Hoa Tốt Nghiệp'),
(10, 'Hoa Tươi Nhập Khẩu'),
(11, 'Combo Hoa & Quà'),
(12, 'Hoa Theo Mùa');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nguoi_dung`
--

CREATE TABLE `nguoi_dung` (
  `id` int(11) NOT NULL,
  `ten` varchar(100) NOT NULL,
  `mat_khau` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `dien_thoai` varchar(20) DEFAULT NULL,
  `dia_chi` varchar(255) DEFAULT NULL,
  `quyen` enum('admin','khachhang') DEFAULT 'khachhang'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `nguoi_dung`
--

INSERT INTO `nguoi_dung` (`id`, `ten`, `mat_khau`, `email`, `dien_thoai`, `dia_chi`, `quyen`) VALUES
(1, 'Nguyen Ngoc Minh', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '06052003nnm@gmail.com', '0981460503', 'Tan Mai - Hoang Mai - Ha Noi', 'khachhang'),
(5, 'admin2', '1c142b2d01aa34e9a36bde480645a57fd69e14155dacfab5a3f9257b77fdc8d8', 'admin2@gmail.com', '0912345666', 'SG', 'admin'),
(6, 'Admin Minh', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'admin@gmail.com', '09814600000', 'Hn', 'admin'),
(7, 'Nguyen Ngoc Minh', '2da6b8469bef50bac52c74a888801564739c60191cebcd404b00d23e11e4aeaf', 'cubi123456@gmail.com', '0981460503', 'Tan Mai - Hoang Mai - Ha Noi', 'khachhang'),
(8, 'Nguyen Ngoc Minh', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'cub123456@gmail.com', '0981460503', 'Tan Mai - Hoang Mai - Ha Noi', 'khachhang'),
(9, 'chomeil', 'cc1adb07bc18b8a92b1faa2fdd4585e274d01ee968fefc28648464092ccf8367', 'chomeo@chomeo.com', '0909090909', 'Cho meo', 'khachhang'),
(10, 'Nguyen Ngoc Minh', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'admin@gmai.com', '0981460503', 'Tan Mai - Hoang Mai - Ha Noi', 'khachhang');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `banner`
--
ALTER TABLE `banner`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  ADD PRIMARY KEY (`id_don_hang`,`id_hoa`),
  ADD KEY `id_hoa` (`id_hoa`);

--
-- Chỉ mục cho bảng `don_hang`
--
ALTER TABLE `don_hang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_nguoi_dung` (`id_nguoi_dung`);

--
-- Chỉ mục cho bảng `gio_hang`
--
ALTER TABLE `gio_hang`
  ADD PRIMARY KEY (`id_nguoi_dung`,`id_hoa`),
  ADD KEY `id_hoa` (`id_hoa`);

--
-- Chỉ mục cho bảng `hoa`
--
ALTER TABLE `hoa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_loai` (`id_loai`);

--
-- Chỉ mục cho bảng `lien_he`
--
ALTER TABLE `lien_he`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `loai_hoa`
--
ALTER TABLE `loai_hoa`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `banner`
--
ALTER TABLE `banner`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `don_hang`
--
ALTER TABLE `don_hang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT cho bảng `hoa`
--
ALTER TABLE `hoa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=248;

--
-- AUTO_INCREMENT cho bảng `lien_he`
--
ALTER TABLE `lien_he`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT cho bảng `loai_hoa`
--
ALTER TABLE `loai_hoa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT cho bảng `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_1` FOREIGN KEY (`id_don_hang`) REFERENCES `don_hang` (`id`),
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_2` FOREIGN KEY (`id_hoa`) REFERENCES `hoa` (`id`);

--
-- Các ràng buộc cho bảng `don_hang`
--
ALTER TABLE `don_hang`
  ADD CONSTRAINT `don_hang_ibfk_1` FOREIGN KEY (`id_nguoi_dung`) REFERENCES `nguoi_dung` (`id`);

--
-- Các ràng buộc cho bảng `gio_hang`
--
ALTER TABLE `gio_hang`
  ADD CONSTRAINT `gio_hang_ibfk_1` FOREIGN KEY (`id_nguoi_dung`) REFERENCES `nguoi_dung` (`id`),
  ADD CONSTRAINT `gio_hang_ibfk_2` FOREIGN KEY (`id_hoa`) REFERENCES `hoa` (`id`);

--
-- Các ràng buộc cho bảng `hoa`
--
ALTER TABLE `hoa`
  ADD CONSTRAINT `hoa_ibfk_1` FOREIGN KEY (`id_loai`) REFERENCES `loai_hoa` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
