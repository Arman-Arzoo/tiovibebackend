-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 07, 2023 at 10:36 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tiovibe`
--

-- --------------------------------------------------------

--
-- Table structure for table `hosts_packages`
--

CREATE TABLE `hosts_packages` (
  `id` int(11) NOT NULL,
  `packages_name` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `comission` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hosts_packages`
--

INSERT INTO `hosts_packages` (`id`, `packages_name`, `price`, `comission`) VALUES
(1, 'Free Host Plan', 0, 13),
(2, 'Premium Vibe Host Plan', 499, 0);

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `code` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`) VALUES
(1, 'English', 'En'),
(4, 'Spanish', 'Es'),
(5, 'French', 'Fr'),
(7, 'Potuguse', 'Pr');

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE `profiles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `languages` int(11) NOT NULL,
  `services` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `profiles`
--

INSERT INTO `profiles` (`id`, `user_id`, `languages`, `services`) VALUES
(1, 1, 1, 1),
(2, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

CREATE TABLE `properties` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `longitude` float NOT NULL,
  `bedrooms` int(11) NOT NULL,
  `washrooms` int(11) NOT NULL,
  `wifi` tinyint(1) NOT NULL,
  `check_in` time NOT NULL,
  `check_out` time NOT NULL,
  `created_by_user` int(11) NOT NULL,
  `night_rate` int(11) NOT NULL,
  `pool` tinyint(1) NOT NULL,
  `laundary` tinyint(1) NOT NULL,
  `latitude` float NOT NULL,
  `created_at` datetime NOT NULL,
  `modified_at` datetime NOT NULL,
  `post_status` varchar(50) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `type` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `contact` varchar(50) NOT NULL,
  `street` varchar(255) NOT NULL,
  `zipcode` varchar(50) NOT NULL,
  `pets` tinyint(1) NOT NULL,
  `tags` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `property_img` text NOT NULL,
  `booking_note` text NOT NULL,
  `booking_offset` int(11) NOT NULL,
  `booking_window` int(11) NOT NULL,
  `minimum_booking_duration` int(11) NOT NULL,
  `maximum_booking_duration` int(11) NOT NULL,
  `booking_import_url` text NOT NULL,
  `manual` tinyint(1) NOT NULL,
  `currency` varchar(10) NOT NULL,
  `continent` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `property_comment`
--

CREATE TABLE `property_comment` (
  `id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `rating` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `property_images`
--

CREATE TABLE `property_images` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `property_img` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property_images`
--

INSERT INTO `property_images` (`id`, `property_id`, `property_img`) VALUES
(1, 9, 'Screenshot (3).png'),
(2, 9, 'Screenshot (12).png'),
(3, 9, 'Screenshot (14).png'),
(4, 10, './public/data/property/Screenshot (3).png'),
(5, 10, './public/data/property/Screenshot (12).png'),
(6, 10, './public/data/property/Screenshot (14).png');

-- --------------------------------------------------------

--
-- Table structure for table `property_pics`
--

CREATE TABLE `property_pics` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `pic_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `property_reviews`
--

CREATE TABLE `property_reviews` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property_reviews`
--

INSERT INTO `property_reviews` (`id`, `property_id`, `user_id`, `comment`, `created_at`, `modified_at`, `is_active`) VALUES
(1, 1, 4, 'Very good property.', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `service_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `service_name`) VALUES
(1, 'Experience'),
(2, 'Rent'),
(3, 'Transport'),
(4, 'Transport');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `phone_number` int(30) DEFAULT NULL,
  `verification_token` varchar(255) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `reset_password_token` varchar(500) DEFAULT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `profile_info` text NOT NULL,
  `country` varchar(255) NOT NULL,
  `profile_pic` varchar(255) DEFAULT NULL,
  `identification_doc` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `is_active`, `is_deleted`, `is_verified`, `phone_number`, `verification_token`, `is_admin`, `password`, `created_at`, `last_login`, `reset_password_token`, `first_name`, `last_name`, `profile_info`, `country`, `profile_pic`, `identification_doc`) VALUES
(1, 'admin1', 'admin1@gmail.com', 1, 0, 0, NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImNzLm11aGFtbWFkYWRuYW5AZ21haWwuY29tIiwiaWF0IjoxNjg2NTA4NzIwfQ.1fdVSxVfor_yKmCb3V6aMaMPji0kdDbf8AlyC60MeHg', 0, '$2a$10$4f34CDjJcSOFlIyrH8pdauvkT73BM43p.aq065p8nGlt9JokGPOy.', '2023-06-11 23:38:40', '2023-06-21 02:33:46', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImNzLm11aGFtbWFkYWRuYW5AZ21haWwuY29tIiwiaWF0IjoxNjg3Mjk2NTM0LCJleHAiOjE2ODcyOTY4MzR9.F0DEcpzW_TRZJ1Zi02V3L9IHdayyuaO3Iux01sEVviM', '', '', '', '', 'WhatsApp Image 2023-01-09 at 21.46.59.jpg', ''),
(3, 'MOSN', 'mohsin70009@gmail.com', 1, 0, 1, 123123123, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1vaHNpbjcwMDA5QGdtYWlsLmNvbSIsImlhdCI6MTY4NjUyMzg1M30.9XZNbyD5yILfkDWOe4oinK0BKRGZlGNT3d-sKQxok38', 0, '$2a$10$uw1rHZbaq7rTeVxvEzCoNOwZ98dsycxI/GsmIKAMgdaLutaFOBr/W', '2023-06-12 03:50:53', '2023-06-12 04:01:47', NULL, '', '', '', '', NULL, ''),
(4, 'admin', 'admin@gmail.com', 1, 0, 1, 1234567890, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFzZGZAZ21haWwuY29tIiwiaWF0IjoxNjg4MTA3ODQ4fQ.EmAUai41b_-SMKdkqIrdXpRRCLSO3aVlsxSe_EtoN_s', 0, '$2a$10$K6MCn1EWB8ipo.WkYHxRN.UZe1pr8m60QAjdesNdfSSmXoWo74J0y', '2023-06-30 11:50:48', '2023-07-07 02:41:31', NULL, 'John', 'Player', '', 'Turks and Caicos Islands', './public/data/profile_pic/Snake.gif', './public/data/profile_pic/Snake.gif');

-- --------------------------------------------------------

--
-- Table structure for table `user_attachments`
--

CREATE TABLE `user_attachments` (
  `id` int(11) NOT NULL,
  `profile_image` varchar(255) NOT NULL,
  `profile_doc` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_favourite_property`
--

CREATE TABLE `user_favourite_property` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `modified_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_languages`
--

CREATE TABLE `user_languages` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_languages`
--

INSERT INTO `user_languages` (`id`, `user_id`, `language_id`) VALUES
(20, 1, 1),
(21, 1, 4),
(26, 4, 1),
(27, 4, 1),
(32, 4, 1),
(33, 4, 1),
(34, 4, 1),
(35, 4, 1),
(36, 4, 1),
(37, 4, 1),
(38, 4, 1),
(39, 4, 1),
(42, 4, 1),
(43, 4, 4),
(44, 4, 1),
(45, 4, 5),
(46, 4, 1),
(47, 4, 5),
(48, 4, 1),
(49, 4, 4),
(50, 4, 5),
(51, 4, 7),
(52, 4, 1),
(53, 4, 4),
(54, 4, 5),
(55, 4, 7),
(56, 4, 1),
(57, 4, 4),
(58, 4, 5),
(59, 4, 7),
(60, 4, 1),
(61, 4, 4),
(62, 4, 5),
(63, 4, 7);

-- --------------------------------------------------------

--
-- Table structure for table `user_packages`
--

CREATE TABLE `user_packages` (
  `id` int(11) NOT NULL,
  `package_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `modified_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_properties`
--

CREATE TABLE `user_properties` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_properties`
--

INSERT INTO `user_properties` (`id`, `user_id`, `property_id`) VALUES
(1, 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_services`
--

CREATE TABLE `user_services` (
  `id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_services`
--

INSERT INTO `user_services` (`id`, `service_id`, `user_id`) VALUES
(21, 1, 1),
(22, 2, 1),
(23, 1, 4),
(24, 2, 4),
(25, 1, 4),
(26, 1, 4),
(27, 1, 4),
(28, 1, 4),
(29, 1, 4),
(30, 1, 4),
(31, 1, 4),
(32, 1, 4),
(33, 1, 4),
(34, 2, 4),
(35, 1, 4),
(36, 2, 4),
(37, 1, 4),
(38, 2, 4),
(39, 1, 4),
(40, 2, 4),
(41, 1, 4),
(42, 2, 4),
(43, 1, 4),
(44, 2, 4),
(45, 1, 4),
(46, 2, 4),
(47, 1, 4),
(48, 2, 4),
(49, 1, 4),
(50, 2, 4),
(51, 3, 4),
(52, 1, 4),
(53, 2, 4),
(54, 3, 4),
(55, 1, 4),
(56, 2, 4),
(57, 3, 4),
(58, 1, 4),
(59, 2, 4),
(60, 3, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hosts_packages`
--
ALTER TABLE `hosts_packages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by_user` (`created_by_user`);

--
-- Indexes for table `property_comment`
--
ALTER TABLE `property_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `post_id` (`post_id`);

--
-- Indexes for table `property_images`
--
ALTER TABLE `property_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `property_pics`
--
ALTER TABLE `property_pics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indexes for table `property_reviews`
--
ALTER TABLE `property_reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone_number` (`phone_number`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `user_attachments`
--
ALTER TABLE `user_attachments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_favourite_property`
--
ALTER TABLE `user_favourite_property`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user_languages`
--
ALTER TABLE `user_languages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `language_id` (`language_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user_properties`
--
ALTER TABLE `user_properties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user_services`
--
ALTER TABLE `user_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `service_id` (`service_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hosts_packages`
--
ALTER TABLE `hosts_packages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `property_comment`
--
ALTER TABLE `property_comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `property_images`
--
ALTER TABLE `property_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `property_pics`
--
ALTER TABLE `property_pics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `property_reviews`
--
ALTER TABLE `property_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_attachments`
--
ALTER TABLE `user_attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_favourite_property`
--
ALTER TABLE `user_favourite_property`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_languages`
--
ALTER TABLE `user_languages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `user_properties`
--
ALTER TABLE `user_properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_services`
--
ALTER TABLE `user_services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `profiles`
--
ALTER TABLE `profiles`
  ADD CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `properties`
--
ALTER TABLE `properties`
  ADD CONSTRAINT `properties_ibfk_1` FOREIGN KEY (`created_by_user`) REFERENCES `users` (`id`);

--
-- Constraints for table `property_comment`
--
ALTER TABLE `property_comment`
  ADD CONSTRAINT `property_comment_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `property_comment_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `properties` (`id`);

--
-- Constraints for table `property_pics`
--
ALTER TABLE `property_pics`
  ADD CONSTRAINT `property_pics_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `properties` (`id`);

--
-- Constraints for table `user_favourite_property`
--
ALTER TABLE `user_favourite_property`
  ADD CONSTRAINT `user_favourite_property_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`),
  ADD CONSTRAINT `user_favourite_property_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_languages`
--
ALTER TABLE `user_languages`
  ADD CONSTRAINT `user_languages_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`),
  ADD CONSTRAINT `user_languages_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_properties`
--
ALTER TABLE `user_properties`
  ADD CONSTRAINT `user_properties_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`),
  ADD CONSTRAINT `user_properties_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_services`
--
ALTER TABLE `user_services`
  ADD CONSTRAINT `user_services_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_services_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
