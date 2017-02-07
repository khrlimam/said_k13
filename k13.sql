SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema k13baru
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `k13baru` DEFAULT CHARACTER SET utf8 ;
USE `k13baru` ;

-- -----------------------------------------------------
-- Table `k13baru`.`mapel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `k13baru`.`mapel` (
  `id` VARCHAR(50) NOT NULL,
  `nama` VARCHAR(50) NULL,
  `status` ENUM('k13','mulok','ekstra') NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `k13baru`.`guru`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `k13baru`.`guru` (
  `nik` VARCHAR(50) NOT NULL,
  `nama` VARCHAR(50) NULL,
  `alamat` TEXT NULL,
  `telp` VARCHAR(45) NULL,
  `jabatan` VARCHAR(45) NULL,
  `jk` ENUM('L','P') NULL,
  `mapel_id` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`nik`),
  INDEX `fk_guru_mapel1_idx` (`mapel_id` ASC),
  CONSTRAINT `fk_guru_mapel1`
    FOREIGN KEY (`mapel_id`)
    REFERENCES `k13baru`.`mapel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `k13baru`.`kelas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `k13baru`.`kelas` (
  `id` INT NOT NULL,
  `kelas` VARCHAR(12) NULL,
  `guru_nik` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_kelas_guru1_idx` (`guru_nik` ASC),
  CONSTRAINT `fk_kelas_guru1`
    FOREIGN KEY (`guru_nik`)
    REFERENCES `k13baru`.`guru` (`nik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `k13baru`.`siswa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `k13baru`.`siswa` (
  `nis` INT NULL,
  `nama` VARCHAR(50) NULL,
  `alamat` VARCHAR(45) NULL,
  `jk` ENUM('L','P') NULL,
  `nama_ortu` VARCHAR(45) NULL,
  `agama` VARCHAR(45) NULL,
  `telp` VARCHAR(45) NULL,
  `kelas_id` INT NOT NULL,
  PRIMARY KEY (`nis`),
  INDEX `fk_siswa_kelas1_idx` (`kelas_id` ASC),
  CONSTRAINT `fk_siswa_kelas1`
    FOREIGN KEY (`kelas_id`)
    REFERENCES `k13baru`.`kelas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `k13baru`.`sikap`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `k13baru`.`sikap` (
  `id` INT NOT NULL,
  `observasi` TEXT NULL,
  `penilaian_diri` TEXT NULL,
  `penilaian_teman` TEXT NULL,
  `jurnal` TEXT NULL,
  `rata_rata` TEXT NULL,
  `konversi` TEXT NULL,
  `deskripsi` TEXT NULL,
  `siswa_nis` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sikap_siswa1_idx` (`siswa_nis` ASC),
  CONSTRAINT `fk_sikap_siswa1`
    FOREIGN KEY (`siswa_nis`)
    REFERENCES `k13baru`.`siswa` (`nis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `k13baru`.`pengetahuan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `k13baru`.`pengetahuan` (
  `id` INT NOT NULL,
  `ulangan_harian` TEXT NULL,
  `tugas` TEXT NULL,
  `uts` TEXT NULL,
  `uas` TEXT NULL,
  `rata_rata` TEXT NULL,
  `konversi` TEXT NULL,
  `deskripsi` TEXT NULL,
  `siswa_nis` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pengetahuan_siswa1_idx` (`siswa_nis` ASC),
  CONSTRAINT `fk_pengetahuan_siswa1`
    FOREIGN KEY (`siswa_nis`)
    REFERENCES `k13baru`.`siswa` (`nis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `k13baru`.`keterampilan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `k13baru`.`keterampilan` (
  `id` INT NOT NULL,
  `unjuk_kerja` TEXT NULL,
  `projek` TEXT NULL,
  `portofolio` TEXT NULL,
  `rata_rata` TEXT NULL,
  `konversi` TEXT NULL,
  `deskripsi` TEXT NULL,
  `siswa_nis` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_keterampilan_siswa1_idx` (`siswa_nis` ASC),
  CONSTRAINT `fk_keterampilan_siswa1`
    FOREIGN KEY (`siswa_nis`)
    REFERENCES `k13baru`.`siswa` (`nis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `k13baru`.`absen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `k13baru`.`absen` (
  `id` INT NOT NULL,
  `kelas` VARCHAR(12) NULL,
  `sakit` VARCHAR(10) NULL,
  `ijin` VARCHAR(10) NULL,
  `tanpa_keterangan` VARCHAR(10) NULL,
  `total_kehadiran` TEXT NULL,
  `siswa_nis` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_absen_siswa1_idx` (`siswa_nis` ASC),
  CONSTRAINT `fk_absen_siswa1`
    FOREIGN KEY (`siswa_nis`)
    REFERENCES `k13baru`.`siswa` (`nis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `k13baru`.`siswa_mapel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `k13baru`.`siswa_mapel` (
  `siswa_nis` INT NOT NULL,
  `mapel_id` VARCHAR(50) NOT NULL,
  INDEX `fk_siswa_mapel_siswa_idx` (`siswa_nis` ASC),
  INDEX `fk_siswa_mapel_mapel1_idx` (`mapel_id` ASC),
  CONSTRAINT `fk_siswa_mapel_siswa`
    FOREIGN KEY (`siswa_nis`)
    REFERENCES `k13baru`.`siswa` (`nis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_siswa_mapel_mapel1`
    FOREIGN KEY (`mapel_id`)
    REFERENCES `k13baru`.`mapel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
