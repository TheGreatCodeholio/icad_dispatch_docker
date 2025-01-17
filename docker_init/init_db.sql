-- create table users
CREATE TABLE `users`
(
    `user_id`       int(11) AUTO_INCREMENT PRIMARY KEY,
    `user_email`    varchar(255) NOT NULL,
    `user_username` varchar(32)  NOT NULL,
    `user_password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- create user profile table --
CREATE TABLE `user_profile`
(
    `user_profile_id`    int(11) AUTO_INCREMENT PRIMARY KEY,
    `user_id`            int(11) NOT NULL,
    `ip_address`         varchar(128) NOT NULL,
    `timezone`           varchar(50)  DEFAULT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- create user security table --
CREATE TABLE `user_security`
(
    `user_security_id`             int(11) AUTO_INCREMENT PRIMARY KEY,
    `user_id`                      int(11) NOT NULL,
    `is_active`                    tinyint(1) NOT NULL DEFAULT 0,
    `email_verified`               tinyint(1) NOT NULL DEFAULT 0,
    `activation_token`             varchar(64) DEFAULT NULL,
    `activation_token_expires`     bigint(20) DEFAULT 0,
    `privilege_level`              enum('USER','MODERATOR','ADMIN','') NOT NULL DEFAULT 'USER',
    `password_reset_token`         varchar(64) DEFAULT NULL,
    `password_reset_token_expires` bigint(20) DEFAULT 0,
    `last_login_date`              bigint(20) NOT NULL DEFAULT 0,
    `failed_login_attempts`        int(11) NOT NULL DEFAULT 0,
    `account_locked_until`         bigint(20) NOT NULL DEFAULT 0,
    FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;