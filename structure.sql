-- MySQL dump 10.13  Distrib 5.6.33, for debian-linux-gnu (x86_64)
--
-- Host: rm-aa.mysql.rds.aliyuncs.com    Database: hft
-- ------------------------------------------------------
-- Server version 5.6.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup
--
CREATE SCHEMA IF NOT EXISTS `hft` DEFAULT CHARACTER SET utf8 ;
USE `hft` ;
--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5001 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `address_obs`
--

DROP TABLE IF EXISTS `address_obs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_obs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4688 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_method`
--

DROP TABLE IF EXISTS `auth_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_method` (
  `name` varchar(5) CHARACTER SET ascii NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_request`
--

DROP TABLE IF EXISTS `auth_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `request_type` varchar(5) CHARACTER SET ascii NOT NULL,
  `method` varchar(5) CHARACTER SET ascii NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `secret_id` int(10) unsigned DEFAULT NULL,
  `parameter` varchar(255) DEFAULT NULL,
  `counter` tinyint(3) unsigned DEFAULT '0',
  `state` varchar(5) CHARACTER SET ascii NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_auth_request_user_idx` (`user_id`),
  KEY `fk_auth_request_method_idx` (`method`),
  KEY `fk_auth_request_type_idx` (`request_type`),
  KEY `fk_auth_request_state_idx` (`state`),
  KEY `fk_auth_request_secret_idx` (`secret_id`),
  CONSTRAINT `fk_auth_request_method` FOREIGN KEY (`method`) REFERENCES `auth_method` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_auth_request_secret` FOREIGN KEY (`secret_id`) REFERENCES `auth_secret` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_auth_request_state` FOREIGN KEY (`state`) REFERENCES `auth_request_state` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_auth_request_type` FOREIGN KEY (`request_type`) REFERENCES `auth_request_type` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_auth_request_user` FOREIGN KEY (`user_id`) REFERENCES `hft_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1474 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_request_state`
--

DROP TABLE IF EXISTS `auth_request_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_request_state` (
  `name` varchar(5) CHARACTER SET ascii NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_request_type`
--

DROP TABLE IF EXISTS `auth_request_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_request_type` (
  `name` varchar(5) CHARACTER SET ascii NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_rule`
--

DROP TABLE IF EXISTS `auth_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(10) unsigned DEFAULT NULL,
  `request_type` varchar(5) CHARACTER SET ascii NOT NULL,
  `auth_method` varchar(5) CHARACTER SET ascii NOT NULL,
  `secret` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_auth_rule_request_type_idx` (`request_type`),
  KEY `fk_auth_rule_auth_method_idx` (`auth_method`),
  KEY `fk_auth_rule_secret_idx` (`secret`),
  KEY `fk_auth_rule_user_idx` (`user`),
  CONSTRAINT `fk_auth_rule_user` FOREIGN KEY (`user`) REFERENCES `hft_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_auth_rule_request_type` FOREIGN KEY (`request_type`) REFERENCES `auth_request_type` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_auth_rule_auth_method` FOREIGN KEY (`auth_method`) REFERENCES `auth_method` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_auth_rule_secret` FOREIGN KEY (`secret`) REFERENCES `auth_secret` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=544 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_secret`
--

DROP TABLE IF EXISTS `auth_secret`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_secret` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `secret` varchar(255) COLLATE ascii_bin NOT NULL,
  `salt` varchar(255) COLLATE ascii_bin NOT NULL DEFAULT '',
  `algorithm` varchar(45) COLLATE ascii_bin NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1491 DEFAULT CHARSET=ascii COLLATE=ascii_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_tfa`
--

DROP TABLE IF EXISTS `auth_tfa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_tfa` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `key` varchar(32) NOT NULL,
  `enabled` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_tfa_unique_user` (`user_id`),
  CONSTRAINT `auth_tfa_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `hft_user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_user_methods`
--

DROP TABLE IF EXISTS `auth_user_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_methods` (
  `user` int(10) unsigned NOT NULL,
  `method` varchar(5) CHARACTER SET ascii NOT NULL,
  `parameter` varchar(255) DEFAULT NULL,
  `secret` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`user`,`method`),
  KEY `fk_auth_user_methods_method_idx` (`method`),
  KEY `auth_user_method_secret` (`secret`),
  CONSTRAINT `auth_user_methods_ibfk_1` FOREIGN KEY (`secret`) REFERENCES `auth_secret` (`id`),
  CONSTRAINT `fk_auth_user_methods_method` FOREIGN KEY (`method`) REFERENCES `auth_method` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_auth_user_methods_user` FOREIGN KEY (`user`) REFERENCES `hft_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_action_attempt`
--

DROP TABLE IF EXISTS `hft_action_attempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_action_attempt` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(20) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1316 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_apikey`
--

DROP TABLE IF EXISTS `hft_apikey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_apikey` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `apikey` varchar(32) CHARACTER SET ascii NOT NULL,
  `signature` varchar(255) CHARACTER SET ascii NOT NULL,
  `default_api_key` varchar(32) CHARACTER SET ascii NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `blocked` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_hft_deposit_address_user_idx` (`user_id`),
  CONSTRAINT `fk_hft_apikey_user` FOREIGN KEY (`user_id`) REFERENCES `hft_user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_app_release`
--

DROP TABLE IF EXISTS `hft_app_release`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_app_release` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `version_name` varchar(20) NOT NULL,
  `release_name` varchar(20) DEFAULT NULL,
  `platform` varchar(20) NOT NULL,
  `force` tinyint(3) unsigned NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_asset`
--

DROP TABLE IF EXISTS `hft_asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_asset` (
  `symbol` varchar(3) CHARACTER SET ascii NOT NULL,
  `decimals` tinyint(3) unsigned NOT NULL,
  `type` varchar(4) NOT NULL DEFAULT 'COIN',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`symbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_balance`
--

DROP TABLE IF EXISTS `hft_balance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_balance` (
  `trader_default_apikey` varchar(32) CHARACTER SET ascii NOT NULL,
  `asset` varchar(3) CHARACTER SET ascii NOT NULL,
  `available` bigint(20) NOT NULL,
  `frozen` bigint(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`trader_default_apikey`,`asset`),
  KEY `fk_hft_balance_asset` (`asset`),
  CONSTRAINT `fk_hft_balance_asset` FOREIGN KEY (`asset`) REFERENCES `hft_asset` (`symbol`) ON UPDATE CASCADE,
  CONSTRAINT `fk_hft_balance_user` FOREIGN KEY (`trader_default_apikey`) REFERENCES `hft_user` (`trader_default_apikey`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_bank_account`
--

DROP TABLE IF EXISTS `hft_bank_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_bank_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `type` varchar(45) CHARACTER SET ascii NOT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `number` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `enable_withdrawal` tinyint(3) NOT NULL DEFAULT '0',
  `enable_deposit` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_hft_bank_account_user_idx` (`user_id`),
  KEY `fk_hft_bank_account_type_idx` (`type`),
  CONSTRAINT `fk_hft_bank_account_user` FOREIGN KEY (`user_id`) REFERENCES `hft_user` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_hft_bank_account_type` FOREIGN KEY (`type`) REFERENCES `hft_bank_account_type` (`name`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_bank_account_group`
--

DROP TABLE IF EXISTS `hft_bank_account_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_bank_account_group` (
  `name` varchar(10) CHARACTER SET ascii NOT NULL,
  `bank_account_type` varchar(45) CHARACTER SET ascii NOT NULL,
  PRIMARY KEY (`name`,`bank_account_type`),
  KEY `fk_hft_bank_account_group_account_type_idx` (`bank_account_type`),
  KEY `idx_hft_bank_account_group_name` (`name`),
  CONSTRAINT `fk_hft_bank_account_group_account_type` FOREIGN KEY (`bank_account_type`) REFERENCES `hft_bank_account_type` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_bank_account_type`
--

DROP TABLE IF EXISTS `hft_bank_account_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_bank_account_type` (
  `name` varchar(45) CHARACTER SET ascii NOT NULL,
  `asset` varchar(3) CHARACTER SET ascii NOT NULL,
  PRIMARY KEY (`name`),
  KEY `fk_hft_bank_account_type_asset_idx` (`asset`),
  CONSTRAINT `fk_hft_bank_account_type_asset` FOREIGN KEY (`asset`) REFERENCES `hft_asset` (`symbol`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_bank_transfer`
--

DROP TABLE IF EXISTS `hft_bank_transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_bank_transfer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bank_account_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `type` varchar(10) CHARACTER SET ascii DEFAULT NULL,
  `value` bigint(20) NOT NULL,
  `fee` bigint(20) DEFAULT NULL,
  `currency` varchar(3) CHARACTER SET ascii NOT NULL DEFAULT 'CNY',
  `state` varchar(10) CHARACTER SET ascii NOT NULL,
  `transfer_code` varchar(32) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `method` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_hft_bank_transfer_bank_account_idx` (`bank_account_id`),
  KEY `fk_hft_bank_transfer_user_idx` (`user_id`),
  KEY `fk_hft_bank_transfer_state_idx` (`state`),
  CONSTRAINT `fk_hft_bank_transfer_bank_account` FOREIGN KEY (`bank_account_id`) REFERENCES `hft_bank_account` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_hft_bank_transfer_state` FOREIGN KEY (`state`) REFERENCES `hft_bank_transfer_state` (`name`) ON UPDATE CASCADE,
  CONSTRAINT `fk_hft_bank_transfer_user` FOREIGN KEY (`user_id`) REFERENCES `hft_user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=354 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_bank_transfer_state`
--

DROP TABLE IF EXISTS `hft_bank_transfer_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_bank_transfer_state` (
  `name` varchar(10) CHARACTER SET ascii NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_blockchain_transcations`
--

DROP TABLE IF EXISTS `hft_blockchain_transcations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_blockchain_transcations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `address` varchar(128) NOT NULL,
  `addr_type` varchar(3) NOT NULL,
  `amount` char(30) DEFAULT NULL,
  `tran_time` bigint(20) DEFAULT NULL,
  `blockheight` int(11) NOT NULL,
  `confirmations` int(11) NOT NULL,
  `txid` char(100) DEFAULT NULL,
  `is_add` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_correction`
--

DROP TABLE IF EXISTS `hft_correction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_correction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `asset` varchar(3) CHARACTER SET ascii NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `type` varchar(10) CHARACTER SET ascii NOT NULL,
  `state` varchar(10) CHARACTER SET ascii NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_transfer_asset_idx` (`asset`),
  KEY `fk_hft_transfer_user_idx` (`user_id`),
  KEY `fk_hft_correction_type_idx` (`type`),
  KEY `fk_hft_correction_state_idx` (`state`),
  CONSTRAINT `fk_transfer_asset` FOREIGN KEY (`asset`) REFERENCES `hft_asset` (`symbol`) ON UPDATE CASCADE,
  CONSTRAINT `fk_hft_correction_user` FOREIGN KEY (`user_id`) REFERENCES `hft_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_hft_correction_type` FOREIGN KEY (`type`) REFERENCES `hft_correction_type` (`name`) ON UPDATE CASCADE,
  CONSTRAINT `fk_hft_correction_state` FOREIGN KEY (`state`) REFERENCES `hft_transfer_state` (`name`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_correction_type`
--

DROP TABLE IF EXISTS `hft_correction_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_correction_type` (
  `name` varchar(10) CHARACTER SET ascii NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_data_sync`
--

DROP TABLE IF EXISTS `hft_data_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_data_sync` (
  `trading_pair` varchar(6) CHARACTER SET ascii NOT NULL,
  `last_sync_id` bigint(20) NOT NULL,
  PRIMARY KEY (`trading_pair`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_deposit`
--

DROP TABLE IF EXISTS `hft_deposit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_deposit` (
  `id` int(10) unsigned NOT NULL,
  `address` varchar(255) CHARACTER SET ascii NOT NULL,
  `asset` varchar(3) CHARACTER SET ascii NOT NULL,
  `amount` bigint(20) unsigned NOT NULL,
  `status` varchar(10) CHARACTER SET ascii NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`asset`),
  KEY `fk_hft_deposit_state_idx` (`status`),
  KEY `fk_hft_deposit_deposit_address_idx` (`address`,`asset`),
  CONSTRAINT `fk_hft_deposit_deposit_address` FOREIGN KEY (`address`, `asset`) REFERENCES `hft_deposit_address` (`address`, `asset`) ON UPDATE CASCADE,
  CONSTRAINT `fk_hft_deposit_state` FOREIGN KEY (`status`) REFERENCES `hft_transfer_state` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Single deposit data from the wallet service. Id is generated by the wallet service as well.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_deposit_address`
--

DROP TABLE IF EXISTS `hft_deposit_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_deposit_address` (
  `address` varchar(255) CHARACTER SET ascii NOT NULL,
  `asset` varchar(3) CHARACTER SET ascii NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`address`,`asset`),
  KEY `fk_hft_deposit_address_asset_idx` (`asset`),
  KEY `fk_hft_deposit_address_user_idx` (`user_id`),
  CONSTRAINT `fk_hft_deposit_address_asset` FOREIGN KEY (`asset`) REFERENCES `hft_asset` (`symbol`) ON UPDATE CASCADE,
  CONSTRAINT `fk_hft_deposit_address_user` FOREIGN KEY (`user_id`) REFERENCES `hft_user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_deposit_code`
--

DROP TABLE IF EXISTS `hft_deposit_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_deposit_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_hash` varchar(255) DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `amount` bigint(20) NOT NULL,
  `symbol` varchar(3) CHARACTER SET ascii NOT NULL DEFAULT 'CNY',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code_hash`),
  KEY `fk_hft_bank_transfer_user_idx` (`user_id`),
  CONSTRAINT `fk_hft_deposit_code_user` FOREIGN KEY (`user_id`) REFERENCES `hft_user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_kyc`
--

DROP TABLE IF EXISTS `hft_kyc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_kyc` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `id_no` varchar(50) CHARACTER SET ascii DEFAULT NULL,
  `id_type` varchar(50) CHARACTER SET ascii DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `approved_by` int(10) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `level` tinyint(10) DEFAULT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '实名状态:1表示1级认证成功,0表示认证失败，2表示2级认证成功',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `fk_hft_kyc_user_idx` (`user_id`),
  CONSTRAINT `fk_hft_kyc_user` FOREIGN KEY (`user_id`) REFERENCES `hft_user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1087 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_kyc_image`
--

DROP TABLE IF EXISTS `hft_kyc_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_kyc_image` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `type` varchar(10) CHARACTER SET ascii NOT NULL,
  `source` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_hft_kyc_image_user_idx` (`user_id`),
  CONSTRAINT `fk_hft_kyc_image_user` FOREIGN KEY (`user_id`) REFERENCES `hft_user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_lock`
--

DROP TABLE IF EXISTS `hft_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_lock` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `asset` varchar(3) CHARACTER SET ascii NOT NULL,
  `amount` bigint(20) unsigned NOT NULL,
  `profit` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lock_days` mediumint(8) unsigned NOT NULL,
  `executed_at` timestamp NULL DEFAULT NULL,
  `status` varchar(10) DEFAULT 'LOCKED',
  PRIMARY KEY (`id`),
  KEY `fk_hft_lock_user_idx` (`user_id`),
  KEY `fk_hft_lock_asset_idx` (`asset`),
  CONSTRAINT `fk_hft_lock_asset` FOREIGN KEY (`asset`) REFERENCES `hft_asset` (`symbol`) ON UPDATE CASCADE,
  CONSTRAINT `fk_hft_lock_user` FOREIGN KEY (`user_id`) REFERENCES `hft_user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=341 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_lock_profit_map`
--

DROP TABLE IF EXISTS `hft_lock_profit_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_lock_profit_map` (
  `asset` varchar(3) CHARACTER SET ascii NOT NULL,
  `lock_days` mediumint(8) unsigned NOT NULL,
  `annual_profit_rate` decimal(5,2) unsigned NOT NULL,
  `active` tinyint(3) unsigned DEFAULT '0',
  PRIMARY KEY (`asset`,`lock_days`),
  KEY `fk_hft_lock_profit_map_asset_idx` (`asset`),
  CONSTRAINT `fk_hft_lock_profit_map_asset` FOREIGN KEY (`asset`) REFERENCES `hft_asset` (`symbol`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_log`
--

DROP TABLE IF EXISTS `hft_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(10) CHARACTER SET ascii NOT NULL,
  `auth_request_id` int(10) unsigned DEFAULT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_auth_request_id` (`auth_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3571 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_news`
--

DROP TABLE IF EXISTS `hft_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `topic` varchar(50) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `content` text,
  `language` varchar(4) DEFAULT NULL,
  `publication_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `visible` tinyint(3) unsigned NOT NULL,
  `listed` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_order`
--

DROP TABLE IF EXISTS `hft_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_order` (
  `id` bigint(20) unsigned NOT NULL,
  `trading_pair` varchar(6) CHARACTER SET ascii NOT NULL,
  `quantity` bigint(20) unsigned NOT NULL,
  `limit` bigint(20) unsigned NOT NULL,
  `fee` decimal(2,2) unsigned NOT NULL,
  `min_fee` bigint(20) NOT NULL,
  `created_by` varchar(32) CHARACTER SET ascii NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `side` varchar(1) CHARACTER SET ascii NOT NULL,
  PRIMARY KEY (`id`,`trading_pair`),
  KEY `fk_order_idx` (`id`),
  KEY `fk_order_creator_idx` (`created_by`),
  KEY `fk_order_trading_pair_idx` (`trading_pair`),
  CONSTRAINT `fk_order_creator` FOREIGN KEY (`created_by`) REFERENCES `hft_user` (`trader_default_apikey`) ON UPDATE CASCADE,
  CONSTRAINT `fk_order_trading_pair` FOREIGN KEY (`trading_pair`) REFERENCES `hft_trading_pair` (`name`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_order_status`
--

DROP TABLE IF EXISTS `hft_order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_order_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `trading_pair` varchar(6) CHARACTER SET ascii NOT NULL,
  `new_order_state` varchar(6) NOT NULL,
  `rest` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_order_modification_order_idx` (`order_id`,`trading_pair`),
  CONSTRAINT `fk_order_modification_order` FOREIGN KEY (`order_id`, `trading_pair`) REFERENCES `hft_order` (`id`, `trading_pair`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=30231193 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_trade`
--

DROP TABLE IF EXISTS `hft_trade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_trade` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `trading_pair` varchar(6) CHARACTER SET ascii NOT NULL,
  `ask_order` bigint(20) unsigned NOT NULL,
  `bid_order` bigint(20) unsigned NOT NULL,
  `quantity` bigint(20) unsigned NOT NULL,
  `price` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`trading_pair`),
  KEY `fk_transaction_ask_order_idx` (`ask_order`,`trading_pair`),
  KEY `fk_transaction_bid_order_idx` (`bid_order`,`trading_pair`),
  CONSTRAINT `fk_transaction_ask_order` FOREIGN KEY (`ask_order`, `trading_pair`) REFERENCES `hft_order` (`id`, `trading_pair`) ON UPDATE CASCADE,
  CONSTRAINT `fk_transaction_bid_order` FOREIGN KEY (`bid_order`, `trading_pair`) REFERENCES `hft_order` (`id`, `trading_pair`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8182820 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_trading_fee`
--

DROP TABLE IF EXISTS `hft_trading_fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_trading_fee` (
  `trading_pair` varchar(6) CHARACTER SET ascii NOT NULL,
  `vip_level` varchar(10) CHARACTER SET ascii NOT NULL,
  `bid_fee` decimal(2,2) DEFAULT NULL,
  `bid_min_fee` bigint(20) DEFAULT NULL,
  `ask_fee` decimal(2,2) DEFAULT NULL,
  `ask_min_fee` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`trading_pair`,`vip_level`),
  KEY `fk_hft_trading_fee_vip_level_idx` (`vip_level`),
  CONSTRAINT `fk_hft_trading_fee_trading_pair` FOREIGN KEY (`trading_pair`) REFERENCES `hft_trading_pair` (`bid_asset`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_hft_trading_fee_vip_level` FOREIGN KEY (`vip_level`) REFERENCES `hft_vip_level` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_trading_pair`
--

DROP TABLE IF EXISTS `hft_trading_pair`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_trading_pair` (
  `name` varchar(6) CHARACTER SET ascii NOT NULL,
  `bid_asset` varchar(3) CHARACTER SET ascii NOT NULL,
  `ask_asset` varchar(3) CHARACTER SET ascii NOT NULL,
  `chart_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `fk_trading_pair_ask_idx` (`ask_asset`),
  KEY `fk_trading_pair_bid_idx` (`bid_asset`),
  CONSTRAINT `fk_trading_pair_ask` FOREIGN KEY (`ask_asset`) REFERENCES `hft_asset` (`symbol`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_trading_pair_bid` FOREIGN KEY (`bid_asset`) REFERENCES `hft_asset` (`symbol`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_trading_pair_group`
--

DROP TABLE IF EXISTS `hft_trading_pair_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_trading_pair_group` (
  `name` varchar(10) CHARACTER SET ascii NOT NULL,
  `trading_pair` varchar(6) CHARACTER SET ascii NOT NULL,
  PRIMARY KEY (`name`,`trading_pair`),
  KEY `fk_trading_pair_group_pair_idx` (`trading_pair`),
  CONSTRAINT `fk_trading_pair_group_pair` FOREIGN KEY (`trading_pair`) REFERENCES `hft_trading_pair` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_transfer_state`
--

DROP TABLE IF EXISTS `hft_transfer_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_transfer_state` (
  `name` varchar(10) CHARACTER SET ascii NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_user`
--

DROP TABLE IF EXISTS `hft_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(255) NOT NULL,
  `algorithm` varchar(255) NOT NULL,
  `trader_default_apikey` varchar(32) CHARACTER SET ascii NOT NULL,
  `bank_account_group` varchar(10) CHARACTER SET ascii DEFAULT NULL,
  `can_trade_trading_pairs` varchar(10) CHARACTER SET ascii NOT NULL,
  `blocked` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `vip_level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `auth_level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `auth_status` varchar(10) NOT NULL DEFAULT 'APPROVED',
  PRIMARY KEY (`id`),
  UNIQUE KEY `trader_default_apikey_UNIQUE` (`trader_default_apikey`),
  UNIQUE KEY `phone_UNIQUE` (`phone`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `fk_hft_user_tradable_pairs_idx` (`can_trade_trading_pairs`),
  KEY `fk_hft_user_bank_account_group_idx` (`bank_account_group`),
  KEY `fk_hft_user_vip_level_idx` (`vip_level`),
  CONSTRAINT `fk_hft_user_tradable_pairs` FOREIGN KEY (`can_trade_trading_pairs`) REFERENCES `hft_trading_pair_group` (`name`) ON UPDATE CASCADE,
  CONSTRAINT `fk_hft_user_bank_account_group` FOREIGN KEY (`bank_account_group`) REFERENCES `hft_bank_account_group` (`name`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12400 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_withdrawal`
--

DROP TABLE IF EXISTS `hft_withdrawal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_withdrawal` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `withdrawal_address_id` int(10) unsigned NOT NULL,
  `amount` bigint(20) unsigned NOT NULL,
  `fee` bigint(20) unsigned NOT NULL,
  `status` varchar(10) CHARACTER SET ascii NOT NULL DEFAULT 'PENDING',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `approved_by` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_hft_withdrawal_withdrawal_address_idx` (`withdrawal_address_id`),
  KEY `fk_hft_withdrawal_state_idx` (`status`),
  CONSTRAINT `fk_hft_withdrawal_withdrawal_address` FOREIGN KEY (`withdrawal_address_id`) REFERENCES `hft_withdrawal_address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_hft_withdrawal_state` FOREIGN KEY (`status`) REFERENCES `hft_transfer_state` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hft_withdrawal_address`
--

DROP TABLE IF EXISTS `hft_withdrawal_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hft_withdrawal_address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `address` varchar(255) CHARACTER SET ascii NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `asset` varchar(3) CHARACTER SET ascii NOT NULL,
  `deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `address_part_two` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_hft_withdrawal_address_user_idx` (`user_id`),
  KEY `fk_hft_withdrawal_address_asset` (`asset`),
  CONSTRAINT `fk_hft_withdrawal_address_asset` FOREIGN KEY (`asset`) REFERENCES `hft_asset` (`symbol`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_hft_withdrawal_address_user` FOREIGN KEY (`user_id`) REFERENCES `hft_user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tx`
--

DROP TABLE IF EXISTS `tx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tx` (
  `id` int(11) NOT NULL,
  `tx_id` int(11) DEFAULT NULL,
  `amount` decimal(38,18) DEFAULT NULL,
  `asset` varchar(8) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tx_id` (`tx_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tx_obs`
--

DROP TABLE IF EXISTS `tx_obs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tx_obs` (
  `id` int(11) NOT NULL,
  `tx_id` int(11) DEFAULT NULL,
  `amount` decimal(38,18) DEFAULT NULL,
  `asset` varchar(8) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tx_id` (`tx_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-17 11:51:00

START TRANSACTION;

grant all privileges on hft.* to 'hft'@'%' identified by 'hft123';


FLUSH PRIVILEGES;
COMMIT;
