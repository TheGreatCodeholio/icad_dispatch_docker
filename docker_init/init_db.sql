-- create table users
CREATE TABLE `users`
(
    `user_id`       int(11) AUTO_INCREMENT PRIMARY KEY,
    `user_username` varchar(255) NOT NULL,
    `user_password` varchar(255) NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

-- create app configuration table --
CREATE TABLE IF NOT EXISTS `app_config`
(
    `config_id`    int(11) AUTO_INCREMENT PRIMARY KEY,
    `config_key`   varchar(64) DEFAULT NULL,
    `config_value` varchar(64) DEFAULT NULL,
    `description`  TEXT        DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `api_tokens`
(
    `token_id`    int(11) AUTO_INCREMENT PRIMARY KEY,
    `token`       varchar(64) DEFAULT NULL,
    `expiration`  bigint(20)  DEFAULT 0
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

-- create radio system table
CREATE TABLE IF NOT EXISTS `radio_systems`
(
    `radio_system_id`   int(11) AUTO_INCREMENT PRIMARY KEY,
    `system_decimal`         int(11) UNIQUE NOT NULL,
    `system_name`       varchar(255) DEFAULT NULL,
    `stream_url`        varchar(255) DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `system_api_tokens`
(
    `id`          int(11) AUTO_INCREMENT PRIMARY KEY,
    `token_id`    int(11) NOT NULL,
    `system_decimal`   int(11) NOT NULL,
    FOREIGN KEY (`system_decimal`) REFERENCES `radio_systems` (`system_decimal`) ON DELETE CASCADE,
    FOREIGN KEY (`token_id`) REFERENCES `api_tokens` (`token_id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

-- create radio system table
CREATE TABLE IF NOT EXISTS `radio_system_talkgroups`
(
    `talkgroup_id`             int(11) AUTO_INCREMENT PRIMARY KEY,
    `radio_system_id`          int(11) NOT NULL,
    `talkgroup_decimal`        bigint(20) NOT NULL,
    `talkgroup_description`    varchar(255) DEFAULT NULL,
    `talkgroup_alpha_tag`      varchar(255) DEFAULT NULL,
    `talkgroup_service_tag`    varchar(255) DEFAULT NULL,
    FOREIGN KEY (`radio_system_id`) REFERENCES `radio_systems` (`radio_system_id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `radio_system_tone_settings`
(
    `tone_settings_id`         int(11) AUTO_INCREMENT PRIMARY KEY,
    `radio_system_id`          int(11) NOT NULL,
    `tone_finder_enabled`              tinyint(1) DEFAULT 0,
    `matching_threshold`       decimal(6, 2) DEFAULT 2.0,
    `tone_a_min_length`        decimal(6, 2) DEFAULT 0.7,
    `tone_b_min_length`        decimal(6, 2) DEFAULT 2.6,
    `hi_low_interval`          decimal(6, 2) DEFAULT 0.2,
    `hi_low_min_alternations`  int(11) DEFAULT 6,
    `long_tone_min_length`     decimal(6, 2) DEFAULT 1.8,
    FOREIGN KEY (`radio_system_id`) REFERENCES `radio_systems` (`radio_system_id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;