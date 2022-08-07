/*
  Warnings:

  - Added the required column `address` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `icon_url` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `password` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `publishing_setting` to the `User` table without a default value. This is not possible if the table is not empty.
  - Made the column `name` on table `User` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE `User` ADD COLUMN `address` VARCHAR(191) NOT NULL,
    ADD COLUMN `icon_url` VARCHAR(191) NOT NULL,
    ADD COLUMN `password` VARCHAR(191) NOT NULL,
    ADD COLUMN `publishing_setting` ENUM('OPEN', 'ONLY_COMPANY_USER', 'CLOSE') NOT NULL,
    ADD COLUMN `user_type` ENUM('GENERAL_USER', 'COMPANY_USER') NOT NULL DEFAULT 'GENERAL_USER',
    MODIFY `name` VARCHAR(255) NOT NULL;

-- CreateTable
CREATE TABLE `Company` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `profile` VARCHAR(191) NOT NULL,
    `logo_url` VARCHAR(191) NOT NULL,
    `company_url` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NOT NULL,
    `phone_number` INTEGER NOT NULL,
    `business` INTEGER NOT NULL,
    `employee_token` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UserCompanyBelong` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `company_id` INTEGER NOT NULL,

    UNIQUE INDEX `UserCompanyBelong_user_id_key`(`user_id`),
    UNIQUE INDEX `UserCompanyBelong_company_id_key`(`company_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Recipe` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `enabled` BOOLEAN NOT NULL,
    `title_name` VARCHAR(191) NOT NULL,
    `taste_comment` VARCHAR(191) NOT NULL,
    `rate` INTEGER NOT NULL,
    `view_count` INTEGER NOT NULL,
    `grind_level` INTEGER NOT NULL,
    `coffee_water_rate` VARCHAR(191) NOT NULL,
    `water_temperature` INTEGER NOT NULL,
    `dripper_name` VARCHAR(191) NOT NULL,
    `brew_time` TIME(0) NOT NULL,
    `media_url` VARCHAR(191) NOT NULL,
    `origin_story` VARCHAR(191) NOT NULL,
    `distribution_channel` VARCHAR(191) NOT NULL,
    `roast_date` DATE NOT NULL,
    `water_description` VARCHAR(191) NOT NULL,
    `grinder` VARCHAR(191) NOT NULL,
    `user_id` INTEGER NOT NULL,
    `coffee_id` INTEGER NOT NULL,

    UNIQUE INDEX `Recipe_coffee_id_key`(`coffee_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Coffee` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `region` VARCHAR(191) NOT NULL,
    `variety` VARCHAR(191) NOT NULL,
    `processing` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `RoastLevel` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `level` ENUM('LIGHT_ROASTED', 'MEDIUM_LIGHT_ROASTED', 'MEDIUM_ROASTED', 'MEDIUM_DARK_ROASTED', 'DARK_ROASTED') NOT NULL,
    `user_id` INTEGER NOT NULL,
    `coffee_id` INTEGER NOT NULL,

    UNIQUE INDEX `RoastLevel_user_id_key`(`user_id`),
    UNIQUE INDEX `RoastLevel_coffee_id_key`(`coffee_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `UserCompanyBelong` ADD CONSTRAINT `UserCompanyBelong_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserCompanyBelong` ADD CONSTRAINT `UserCompanyBelong_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `Company`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Recipe` ADD CONSTRAINT `Recipe_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Recipe` ADD CONSTRAINT `Recipe_coffee_id_fkey` FOREIGN KEY (`coffee_id`) REFERENCES `Coffee`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RoastLevel` ADD CONSTRAINT `RoastLevel_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RoastLevel` ADD CONSTRAINT `RoastLevel_coffee_id_fkey` FOREIGN KEY (`coffee_id`) REFERENCES `Coffee`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
