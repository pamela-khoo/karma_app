-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 29, 2022 at 11:12 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `karma_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `status`) VALUES
(1, 'Planet', 1),
(2, 'Health', 1),
(3, 'Environment', 0),
(4, 'Test 1', 1),
(5, 'Environment', 1),
(6, 'Test 1', 1),
(7, 'Test 1', 1),
(9, 'Sample', 1),
(10, 'Phase 1', 1),
(11, 'New Category', 1),
(13, 'm', 1),
(14, 'm', 1),
(15, 'Civil Engineering', 0),
(21, 'Civil Engineering', 0),
(22, 'Sample 12355', 1),
(23, 'Volunteeer ', 1);

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(8) NOT NULL,
  `name` varchar(50) NOT NULL,
  `start_date` varchar(255) NOT NULL,
  `end_date` varchar(255) NOT NULL,
  `start_time` varchar(255) NOT NULL,
  `end_time` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `venue` varchar(255) NOT NULL,
  `category` int(11) NOT NULL,
  `organization` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `limit_registration` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `name`, `start_date`, `end_date`, `start_time`, `end_time`, `description`, `status`, `venue`, `category`, `organization`, `points`, `image_url`, `limit_registration`) VALUES
(2, 'Save the Trees', '2022-09-08', '2022-09-08', '3PM', '5PM', '<p>The description of the event1</p>\r\n', 1, 'Event venue', 1, 1, 10, 'trees.jpg', 50),
(3, 'Soup Kitchen', '2022-09-14', '2022-09-14', '5PM', '9PM', 'Soup kitchen event description test', 1, 'Event venue soup kitchen', 1, 1, 0, 'soup.jpg', 0),
(4, 'Recycling', '2022-10-20', '2022-10-20', '3PM', '5PM', 'Description of event ', 1, 'Recycling Center', 1, 1, 0, 'recycle.jpg', 0),
(6, 'Waste Management', '2022-10-29', '2022-10-29', '4:20 AM', '4:20 AM', '', 1, '32, Jalan ', 1, 1, 0, 'waste.jpg', 100),
(7, 'Volunteeer ', '2022-10-29', '2022-10-29', '1:37 PM', '2:37 PM', '<p>12345</p>\r\n', 1, 'Venue description', 1, 1, 100, 'recycle.jpg', 100);

-- --------------------------------------------------------

--
-- Table structure for table `mission`
--

CREATE TABLE `mission` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mission`
--

INSERT INTO `mission` (`id`, `user_id`, `event_id`, `status`) VALUES
(2, 1, 4, 0),
(4, 1, 3, 0),
(5, 1, 2, 0),
(20, 4, 3, 0),
(23, 4, 4, 0),
(24, 4, 6, 0);

-- --------------------------------------------------------

--
-- Table structure for table `organization`
--

CREATE TABLE `organization` (
  `id` int(11) NOT NULL,
  `org_name` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `logo_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `organization`
--

INSERT INTO `organization` (`id`, `org_name`, `status`, `description`, `logo_url`) VALUES
(1, 'Tree Huggers', 1, '<p>we love trees</p>\r\n', 'trees.jpg'),
(2, 'Sunshine Home', 1, '<p>12344</p>\r\n', 'recycle.jpg'),
(5, 'River Heros', 1, '<p>123gsd r w4tw&nbsp;</p>\r\n', 'waste.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `contact_no` varchar(255) NOT NULL,
  `points` int(11) NOT NULL,
  `role` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `password`, `contact_no`, `points`, `role`, `status`) VALUES
(1, 'John', 'Smith', 'johnsmith@email.com', '12345', '60145890898', 0, 1, 1),
(3, 'Ali', 'Baba', 'ab@email.com', '12345', '6018082357', 0, 0, 0),
(4, 'J', 'S', 'js@email.com', '12345', '0194728462', 10, 1, 0),
(5, 'A', 'A', 'a@email.com', '12345', '0170898164', 20, 0, 0),
(6, 'Test', 'Test', 'testing@test.com', '12345', '01923842347', 0, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category` (`category`),
  ADD KEY `organization` (`organization`);

--
-- Indexes for table `mission`
--
ALTER TABLE `mission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `organization`
--
ALTER TABLE `organization`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `mission`
--
ALTER TABLE `mission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `organization`
--
ALTER TABLE `organization`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`category`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `events_ibfk_2` FOREIGN KEY (`organization`) REFERENCES `organization` (`id`);

--
-- Constraints for table `mission`
--
ALTER TABLE `mission`
  ADD CONSTRAINT `mission_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `mission_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
