-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 10, 2019 at 02:52 PM
-- Server version: 10.1.28-MariaDB
-- PHP Version: 7.1.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `office_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `billing_details`
--

CREATE TABLE `billing_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `billing_master_id` int(11) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` double(8,2) NOT NULL,
  `discount` double(8,2) NOT NULL,
  `action_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `billing_details`
--

INSERT INTO `billing_details` (`id`, `billing_master_id`, `description`, `unit`, `rate`, `discount`, `action_type`, `user_code`, `created_at`, `updated_at`) VALUES
(1, 3, 'invoice', '1', 10000.00, 100.00, 'delete', '32', '2019-10-02 01:14:34', '2019-10-05 03:32:25'),
(2, 3, 'invoice', '2', 10000.00, 200.00, 'delete', '32', '2019-10-02 01:14:34', '2019-10-05 03:32:25'),
(3, 5, 'invoice', '4', 444.00, 0.00, 'delete', '32', '2019-10-02 01:22:47', '2019-10-05 07:23:33'),
(4, 6, '---', '1', 111.00, 0.00, 'delete', '32', '2019-10-02 01:25:28', '2019-10-05 03:30:40'),
(5, 7, '----', '1', 10000.00, 0.00, 'insert', '32', '2019-10-05 05:05:38', '2019-10-05 05:05:38'),
(6, 7, 'kgasjgdjagjdgjagdjgajdgjagdagdjagdgjhgjagdjgad', '2', 10000.00, 0.00, 'insert', '32', '2019-10-05 05:05:38', '2019-10-05 05:05:38');

-- --------------------------------------------------------

--
-- Table structure for table `billing_masters`
--

CREATE TABLE `billing_masters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` int(11) NOT NULL,
  `invoice_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `payment_due_date` date NOT NULL,
  `action_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `billing_masters`
--

INSERT INTO `billing_masters` (`id`, `client_id`, `invoice_no`, `date`, `payment_due_date`, `action_type`, `user_code`, `created_at`, `updated_at`) VALUES
(3, 2, '321', '2019-10-09', '2019-10-15', 'delete', '32', '2019-10-02 01:14:34', '2019-10-05 03:32:25'),
(5, 3, '444', '2019-10-16', '2019-10-21', 'delete', '32', '2019-10-02 01:22:47', '2019-10-05 07:23:33'),
(6, 3, '33', '2019-10-09', '2019-09-30', 'delete', '32', '2019-10-02 01:25:28', '2019-10-05 03:30:40'),
(7, 2, '444', '2019-10-16', '2019-10-22', 'insert', '32', '2019-10-05 05:05:38', '2019-10-05 05:05:38');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mbl_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `nationality` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_mbl_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city_country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `website` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `action_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `name`, `address`, `mbl_no`, `birth_date`, `nationality`, `company_name`, `company_address`, `company_mbl_no`, `city_country`, `email`, `website`, `status`, `action_type`, `user_code`, `created_at`, `updated_at`) VALUES
(1, 'John Doe', 'Ctg', '01891111111', '2019-09-05', 'Bangladesh', 'SUNSHINE ACCESSORIES MFC. BD. LTD.', 'Ctg', '01891111111', 'Ctg', 'admin@admin.com', 'http://sunshineinterlining.com', 0, 'delete', '32', '2019-09-30 06:51:27', '2019-10-01 00:34:34'),
(2, 'John Doe', 'Ctg', '01891111111', '2019-09-11', 'Bangladesh', 'Sunshine Accessories Mfc. Bd. Ltd. test', 'Ctg', '01891111111', 'Ctg', 'sanmarmega@admin.com', 'http://sunshineinterlining.com', 1, 'update', '32', '2019-09-30 06:52:16', '2019-10-01 00:20:38'),
(3, 'Peter Smith', 'Ctg', '01891111111', '2019-10-08', 'Bangladesh', 'Sunshine Accessories Mfc. Bd. Ltd.', 'Ctg', '01891111111', 'Ctg', 'johndoe@admin.com', 'http://sunshineinterlining.com', 1, 'insert', '32', '2019-09-30 23:29:17', '2019-09-30 23:29:17'),
(4, 'Md. Amanat Ullah Juwel', 'Ctg', '01891111111', '2019-10-17', 'Bangladesh', 'SUNSHINE ACCESSORIES MFC. BD. LTD.', 'Ctg', '01891111111', 'Ctg', 'shoilpik@admin.com', 'http://sunshineinterlining.com', 1, 'insert', '32', '2019-09-30 23:42:19', '2019-09-30 23:42:19'),
(5, 'John Doe', 'Ctg', '01891111111', '2019-10-10', 'Bangladesh', 'SUNSHINE ACCESSORIES MFC. BD. LTD.', 'Ctg', '01891111111', 'Ctg', 'sanmarmegrra@admin.com', 'http://sunshineinterlining.com', 1, 'update', '32', '2019-10-01 00:48:02', '2019-10-01 00:51:19');

-- --------------------------------------------------------

--
-- Table structure for table `item_types`
--

CREATE TABLE `item_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `item_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `item_types`
--

INSERT INTO `item_types` (`id`, `item_name`, `action_type`, `user_code`, `created_at`, `updated_at`) VALUES
(1, 'Custome Modules', 'delete', '32', '2019-10-06 01:07:16', '2019-10-06 01:07:46'),
(2, 'Test', 'insert', '32', '2019-10-06 01:08:00', '2019-10-06 01:08:00'),
(3, 'Custome Module', 'update', '32', '2019-10-06 01:09:53', '2019-10-09 05:38:08');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_03_02_115320_create_tasks_table', 2),
(4, '2016_06_01_000001_create_oauth_auth_codes_table', 3),
(5, '2016_06_01_000002_create_oauth_access_tokens_table', 3),
(6, '2016_06_01_000003_create_oauth_refresh_tokens_table', 3),
(7, '2016_06_01_000004_create_oauth_clients_table', 3),
(8, '2016_06_01_000005_create_oauth_personal_access_clients_table', 3),
(9, '2019_09_29_101618_create_clients_table', 4),
(10, '2019_10_01_080045_create_billing_masters_table', 5),
(11, '2019_10_01_080358_create_billing_details_table', 5),
(14, '2019_10_05_112206_create_project_categories_table', 6),
(15, '2019_10_05_112508_create_item_types_table', 6),
(20, '2019_10_06_075610_create_project_masters_table', 7),
(21, '2019_10_06_080051_create_project_details_table', 7);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('76c90c08fb2b2ea4f3af31aba9cfca76db6ead8ca32782561786a5655820293c9cab0a6c31bc2508', 31, 1, 'test', '[]', 1, '2019-05-21 02:57:14', '2019-05-21 02:57:14', '2020-05-21 08:57:14'),
('7b1105395d324bc7ba868dd5b4947c493eb31ae3637b2f918b4338a5181a57b3c04ece80f3f7a26d', 32, 1, 'Taiser', '[]', 0, '2019-09-19 06:35:25', '2019-09-19 06:35:25', '2020-09-19 12:35:25'),
('7e3aa54be6d015e556ed44c39284a29c85e9a736ab6a2df707cdbac29155635006e202979964bc2f', 31, 1, 'SM Hamid', '[]', 1, '2019-05-21 02:51:36', '2019-05-21 02:51:36', '2020-05-21 08:51:36'),
('afe4c75460e001c08afaea2c195e9dbe99281d250a9576bf996edc434a345f07a329fc000fbc0d07', 31, 1, 'hhh', '[]', 1, '2019-05-21 02:57:03', '2019-05-21 02:57:03', '2020-05-21 08:57:03'),
('d1d0c67217fe64a0796341728bcbed47d6ef2a4bfbde961f6e314ff495928c13d0ef89831772b768', 31, 1, 'SM Hamid', '[]', 1, '2019-05-21 02:52:58', '2019-05-21 02:52:58', '2020-05-21 08:52:58');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel_vue Personal Access Client', 'e3hjs9xkDBhBOe2TUekDgKI0SToGpWtUbGblFwGJ', 'http://localhost', 1, 0, 0, '2019-05-21 01:17:34', '2019-05-21 01:17:34'),
(2, NULL, 'Laravel_vue Password Grant Client', 'Na1KG98Tr2HBmuosPAwxadpVt4vWsgBu3ug0Ifyt', 'http://localhost', 0, 1, 0, '2019-05-21 01:17:34', '2019-05-21 01:17:34'),
(3, 31, 'Test', '7sMrExYmWISw3uidwDChzuM35TCjxagWQsjo74Gb', 'http://localhost/app', 0, 0, 0, '2019-05-21 03:00:51', '2019-05-21 03:02:38');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2019-05-21 01:17:34', '2019-05-21 01:17:34');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_categories`
--

CREATE TABLE `project_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cata_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `action_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_categories`
--

INSERT INTO `project_categories` (`id`, `cata_name`, `description`, `action_type`, `user_code`, `created_at`, `updated_at`) VALUES
(1, 'Software', 'Test', 'update', '32', '2019-10-05 07:11:41', '2019-10-05 07:18:16'),
(2, 'Website', 'Website', 'delete', '32', '2019-10-05 07:24:41', '2019-10-05 07:25:35'),
(3, 'Website', 'Website', 'insert', '32', '2019-10-06 00:25:07', '2019-10-06 00:25:07');

-- --------------------------------------------------------

--
-- Table structure for table `project_details`
--

CREATE TABLE `project_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_master_id` int(11) NOT NULL,
  `item_type_id` int(11) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double(8,2) NOT NULL,
  `start_date` date NOT NULL,
  `next_billing_date` date NOT NULL,
  `number_of_month` int(11) NOT NULL,
  `is_billable` tinyint(4) DEFAULT '0',
  `action_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_details`
--

INSERT INTO `project_details` (`id`, `project_master_id`, `item_type_id`, `description`, `amount`, `start_date`, `next_billing_date`, `number_of_month`, `is_billable`, `action_type`, `user_code`, `created_at`, `updated_at`) VALUES
(1, 1, 3, '---test', 2000.00, '2019-10-01', '2019-10-01', 1, 1, 'delete', '32', '2019-10-09 04:46:11', '2019-10-09 06:33:06'),
(2, 1, 3, '---', 3000.00, '2019-10-10', '2019-10-10', 1, 1, 'insert', '32', '2019-10-09 04:46:11', '2019-10-09 04:46:11'),
(3, 1, 3, 'Test', 10000.00, '2019-10-10', '2019-10-10', 2, 0, 'insert', '32', '2019-10-09 04:52:19', '2019-10-09 04:52:19'),
(4, 1, 3, '---', 2000.00, '2019-10-01', '2019-10-01', 1, 1, 'delete', '32', '2019-10-09 05:25:04', '2019-10-09 06:32:24');

-- --------------------------------------------------------

--
-- Table structure for table `project_masters`
--

CREATE TABLE `project_masters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_id` int(11) NOT NULL,
  `project_category_id` int(11) NOT NULL,
  `installment_charge` double(8,2) NOT NULL,
  `service_charge` double(8,2) NOT NULL DEFAULT '0.00',
  `start_date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `action_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_masters`
--

INSERT INTO `project_masters` (`id`, `name`, `client_id`, `project_category_id`, `installment_charge`, `service_charge`, `start_date`, `status`, `action_type`, `user_code`, `created_at`, `updated_at`) VALUES
(1, 'Shoilpik ERP', 2, 1, 10000.00, 5000.00, '2019-10-09', 1, 'update', '32', '2019-10-09 04:46:11', '2019-10-09 07:08:02');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `title`, `status`, `created_at`, `updated_at`) VALUES
(31, 'test', '1', '2019-03-03 07:19:22', '2019-03-03 07:19:22'),
(32, 'test1', '2', '2019-03-03 07:20:09', '2019-03-03 07:20:09'),
(33, 'ddd', 'ddd', '2019-03-03 07:25:09', '2019-03-03 07:25:09');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `role`, `bio`, `photo`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(29, 'Album 2', 'al@admin.com', 'admin', NULL, NULL, NULL, '$2y$10$.8VPeciN7Z3QtxsMNGG.NuzILX78mBNCWSeufsr9YO35CqZl1ppMm', NULL, '2019-05-19 04:19:31', '2019-10-10 02:16:50'),
(31, 'SM Hamid', 'admin@gmail.com', 'admin', NULL, '1568790074.jpeg', NULL, '$2y$10$J2G4LUMWh2s46Z8lYB0Xd.Gb1gxubFNZfaQ1.laMnmWqWwYshDAH6', NULL, '2019-05-20 02:35:44', '2019-09-18 03:23:31'),
(32, 'SM Taiser', 'admin@admin.com', 'admin', 'Tests', '/public/img/profile/1570707401.jpeg', NULL, '$2y$10$aABN8nxlflAdl9DbuU9Jn.nn/0dRHDN0eBVef8.aRMJn.5L0.0Lxi', NULL, '2019-05-21 00:27:36', '2019-10-10 05:36:42'),
(33, 'John Doe', 'admin@user.com', 'user', NULL, NULL, NULL, '$2y$10$CELNDEAmTZWJ659lU.m3.ueWJ7LMxQv6F/gcSlDknz8SVJdaUMOZa', NULL, '2019-09-30 02:34:27', '2019-09-30 02:34:27'),
(34, 'John Doe', 'test@admin.com', 'admin', NULL, NULL, NULL, '$2y$10$xs/1GvftcGSDuLLL3aswO.u7ru4x0pJOElPGxbcua7.zQWzwYwbvG', NULL, '2019-09-30 23:31:58', '2019-09-30 23:31:58');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `billing_details`
--
ALTER TABLE `billing_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `billing_masters`
--
ALTER TABLE `billing_masters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item_types`
--
ALTER TABLE `item_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `project_categories`
--
ALTER TABLE `project_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_details`
--
ALTER TABLE `project_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_masters`
--
ALTER TABLE `project_masters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `billing_details`
--
ALTER TABLE `billing_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `billing_masters`
--
ALTER TABLE `billing_masters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `item_types`
--
ALTER TABLE `item_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `project_categories`
--
ALTER TABLE `project_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `project_details`
--
ALTER TABLE `project_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `project_masters`
--
ALTER TABLE `project_masters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
