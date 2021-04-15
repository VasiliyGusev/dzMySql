/*
* Создание БД для ВКонтакте на вебинаре
*/

drop database if exists vk;
create database vk;

use vk;

drop table if exists users;
create table users (
	id bigint unsigned not null auto_increment primary key,
	firstname varchar(100),
	lastname varchar(100),
	email varchar(120) unique,
	password_hash varchar(100),
	phone bigint unsigned unique,
	
	index users_firstname_lastname_idx(firstname, lastname)
);

drop table if exists profiles;
create table profiles(
	user_id bigint unsigned not null unique,
	gender char(1),
	birthday date,
	hometoun varchar(50),
	photo_id bigint unsigned,
	created_at datetime default now()
);

alter table profiles add constraint fk_user_id
	foreign key (user_id) references users(id)
	on update cascade
	on delete restrict;

drop table if exists massages;
create table massages(
# serial = unsigned not null auto_increment unique
	id serial,
	from_user_id bigint unsigned not null,
	to_user_id bigint unsigned not null,
	body text,
	created_at datetime default now(),

	foreign key (from_user_id) references users(id),
	foreign key (to_user_id) references users(id)
);
/*
 *       Далее следует ДЗ
 * 1. Добавить можно многое. Музыку, новости и т.д.
 */
drop table if exists news;
create table news(
	id serial,
	author_id bigint unsigned not null,
	body text,
	created_at datetime default now(),

	foreign key (author_id) references users(id)
);
# Создаём таблицу Лайков
drop table if exists likes;
create table likes (
	id serial primary key,
	uslike_id bigint unsigned,
	meslike_id bigint unsigned,
    news_id bigint unsigned
);

alter table likes add constraint fk_uslike_id
	foreign key (uslike_id) references users(id)
	on delete set null
	on update cascade;
alter table likes add constraint fk_meslike_id
	foreign key (meslike_id) references massages(id)
	on delete set null
	on update cascade;
alter table likes add constraint fk_newslike_id
	foreign key (news_id) references users(id)
	on delete set null
	on update cascade;
alter table likes add unique index (uslike_id, meslike_id, news_id);

# Заполнение таблиц рандомными данными
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('101', 'Freeman', 'Eichmann', 'blueilwitz@example.org', 'ec93673cd90c943cd1fa23c92ee106eddcc60e07', '0');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('102', 'Dallas', 'Boyle', 'ukunde@example.org', '345dc770891b1c597d93dbf691e61033f0afbb97', '1');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('105', 'Vincenza', 'Schimmel', 'pollich.ola@example.com', '5cffe3b342b9aaf5e5966fc48e9b5e955e2f6a28', '650298');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('107', 'Raul', 'Fay', 'bogan.kailee@example.com', '39fa6fc83399ebac2b0617f75c3f37cbd0c40d53', '3690882992');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('113', 'Keira', 'Hauck', 'qoberbrunner@example.com', '5cbab5db9034ad1fe82f69fd02f99ffa7e23b0c2', '484604');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('117', 'Conor', 'Lynch', 'umurazik@example.org', '54dd921511ad24816e6889d98b69eec3a31b86c0', '2548453748');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('118', 'Marlin', 'Wiza', 'buckridge.grace@example.com', '685b2b352658d5c7e6cadfd4c90f39794cc70790', '690923');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('121', 'Alyson', 'Hauck', 'kennedy76@example.net', '49bfe65baa9f488bb0e031db930dc5164b1f0433', '858116');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('122', 'Ernest', 'Wolff', 'jena55@example.net', '39573e20493ca68613b2d964f20091541928c23b', '388');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('123', 'Prince', 'O\'Hara', 'kennedi42@example.com', '08dd37c91b1d1deaa633395d07ad1bfdf2b32ada', '13');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('125', 'Mattie', 'Bins', 'magnolia.wiza@example.com', '8f566d940c75874c06d90f5c0936abbf249ac4f1', '3640649508');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('128', 'Dakota', 'Block', 'jennyfer.d\'amore@example.net', '639ba4c276ca8f0b3067395be10d699ca3b6283b', '528');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('131', 'Zackery', 'Herzog', 'cortez.abshire@example.net', '4143f3ab962409b1ec37c698544d62c91e01bf9e', '665');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('132', 'Seamus', 'Schaden', 'kale89@example.com', '52148ae940aabf42dac28e5e568c4ba10c48a4a8', '225');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('135', 'Thaddeus', 'Johnson', 'brisa.quigley@example.com', 'd2ad75d2689f641c7f3652865f90bcf2560d6a58', '15');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('137', 'Marcella', 'Green', 'morissette.mozelle@example.net', '241635495eaf48fc57fb7bde29ca7d7b181822a8', '6744781675');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('139', 'Fiona', 'Rodriguez', 'harvey.felicity@example.org', '41d40d3ae9ed9c761bd09b70841310e9e17fe24d', '1995165290');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('140', 'Alia', 'Wolf', 'boehm.romaine@example.org', '7a68c21c2d1480d55a9d7cb3dc352634f8f82f03', '352601');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('141', 'Mable', 'Ziemann', 'bailey.friesen@example.net', '912ad7dcc452a9b3076dad251e3cf9106f8f746b', '324');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('142', 'Maximus', 'Swift', 'merritt35@example.com', '17e96b1fb7dcebb82ae15c7a2fe6356700a11aaf', '553825');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('145', 'Marjory', 'Dickens', 'rowe.andreane@example.org', '4235154bddf8bdbd4460678eb502c898d8d8e153', '2087486811');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('146', 'Shayna', 'Grant', 'go\'hara@example.com', 'deb83d4f83b5f052545133669731f9a3ef03f91a', '377149');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('147', 'Justyn', 'Greenholt', 'mabelle73@example.net', 'c729c74955011b37eca7e7b886488522af5d67f4', '8989024853');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('149', 'Chelsea', 'Langworth', 'amira.fritsch@example.com', 'c93812b85d6cd08ee79779bde7a01eaa5d819fde', '7');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('152', 'Lemuel', 'Purdy', 'dubuque.adrienne@example.net', '6fc93454c2d75abb78bc2273b2418911bcc77907', '939');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('156', 'Alvah', 'Dickinson', 'sunny.bayer@example.org', 'e050ddebe2ad9a9366f4dd3bca80376b2a661f64', '4462435526');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('157', 'Nayeli', 'Kautzer', 'sfranecki@example.org', 'a06f68e1e8a5e1717704a7936b2e570bbc7520ba', '303');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('158', 'Gonzalo', 'Mitchell', 'roberts.lola@example.org', '2f814cf525f161eb4f4711eb3e1bdc7bbbf95332', '272361');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('162', 'Ramiro', 'Muller', 'abechtelar@example.net', 'e3aa3c98dcea8e61cfad2b0f31a5452b307d20e3', '110307');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('164', 'Kelly', 'Powlowski', 'bjohnson@example.net', 'd2b727118b632a9e8e1b5c0f37a8df459750ce8f', '6549817416');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('165', 'Trenton', 'Kassulke', 'khyatt@example.net', '7f7ea543bc8ebc39a810de02e83a50a504477b1c', '747');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('168', 'Alexzander', 'Lehner', 'powlowski.eulalia@example.com', 'fe75889f8ab196ecfc1305781a54b8499bb2762c', '652565');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('170', 'Benedict', 'Altenwerth', 'wdaniel@example.net', 'c64d3eadd22a4822df2c580797be1268b2c354be', '148242');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('171', 'Abdul', 'Rolfson', 'fhackett@example.com', 'fe1759aab8b4d35e3282c64f586a137fe75146a4', '801178');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('172', 'Destini', 'Anderson', 'ladarius79@example.org', 'f98560118051fc8ef58e2e72566941a98110a527', '3870407614');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('173', 'Ruthie', 'Kreiger', 'lesch.murphy@example.net', 'cb661c9de909f2c7c46c422768e77713abc424f6', '257');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('175', 'Alysson', 'Simonis', 'iondricka@example.com', '08c6af2bf9109dd847bfe546ebb97744fc438ba6', '676601');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('176', 'Betsy', 'Aufderhar', 'eadams@example.org', '8f216deff31601281083593e37ac40ddda3ccb1e', '582663');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('178', 'Emmalee', 'Hane', 'marquis54@example.net', 'f047a21caeb42544b14eaaa758aa5f5537440c8c', '46');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('183', 'Jaqueline', 'Christiansen', 'kertzmann.tyree@example.org', 'd7c5be91d47c8e3413e6de7e391b6a61979958ba', '553');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('186', 'Jadon', 'Bayer', 'gleason.hellen@example.org', '94973552935a37711c0fbc3dfa9832acae710d3c', '70');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('187', 'Candido', 'Gerhold', 'camylle.abernathy@example.com', '6c8d4ac783510bcf487a8b2e8ae27f84b954e413', '5911119878');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('189', 'Giovani', 'Larson', 'lauryn.cronin@example.com', '876afcdba4c6151d567985d49aa5586e8b7887be', '677');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('191', 'Vivianne', 'Ledner', 'rgutmann@example.org', 'c50cea65e6a243e899fb07944467d72965916ee2', '32');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('197', 'Katherine', 'Koepp', 'laurianne67@example.org', '390095df6516d58996f8f0ee85a1a39727f107df', '791');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('199', 'Sabryna', 'Zemlak', 'sspinka@example.com', '9eb8bca933e96d132a59fbea790e72922610e17d', '504');
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`) VALUES ('200', 'Damion', 'Gutmann', 'loy31@example.net', 'c4c9b477325be5c328836d762327b3fffd85023e', '3725567994');


INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('101', 'D', '1994-02-03', 'Agnesville', '2', '2013-04-21 02:16:27');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('102', 'P', '1988-06-05', 'East Sydniestad', '9', '2012-05-03 15:21:22');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('105', 'P', '1996-06-04', 'Darylport', '7', '2008-01-31 23:18:20');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('107', 'D', '2020-07-15', 'South Botown', '9', '1972-09-19 10:27:16');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('113', 'P', '1987-10-25', 'Julesshire', '3', '2013-07-26 01:00:38');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('117', 'D', '2009-09-21', 'South Omafort', '8', '1992-09-29 05:44:06');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('118', 'M', '1979-11-22', 'Port Allyberg', '3', '1972-12-19 23:05:49');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('121', 'P', '1993-07-30', 'Predovicview', '2', '1984-07-17 01:18:32');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('122', 'M', '1996-05-02', 'Port Otha', '3', '1982-01-08 04:09:32');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('123', 'M', '1984-03-14', 'South Tod', '6', '1980-09-29 00:25:32');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('125', 'M', '1972-01-26', 'Faustinofurt', '4', '1987-08-10 09:51:58');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('128', 'M', '1972-07-08', 'Lake Marieburgh', '6', '1974-06-05 16:59:00');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('131', 'M', '1973-07-06', 'Lake Josieside', '3', '1973-01-19 01:28:52');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('132', 'M', '1991-07-05', 'New Darianaside', '1', '1993-11-14 12:01:18');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('135', 'P', '1988-05-23', 'Berniermouth', '5', '1996-01-10 00:42:13');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('137', 'D', '1984-11-01', 'South Dayna', '2', '1981-06-04 14:34:14');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('139', 'D', '2005-10-07', 'Lake Emmettburgh', '6', '1994-03-08 17:28:06');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('140', 'D', '1977-12-29', 'Port Matildeview', '1', '2018-06-04 23:37:14');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('141', 'P', '1975-11-23', 'Port Dandre', '9', '1983-08-15 12:27:00');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('142', 'M', '2019-03-02', 'North Ryan', '8', '1998-03-24 15:14:43');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('145', 'M', '1985-06-23', 'Rogahnside', '6', '2000-02-13 16:42:40');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('146', 'M', '1984-07-16', 'New Sebastian', '3', '1982-04-27 05:27:39');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('147', 'P', '2005-04-03', 'Lake Americoshire', '1', '1977-09-08 15:34:42');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('149', 'P', '1992-07-09', 'Wittington', '8', '2016-12-10 23:48:19');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('152', 'P', '1999-03-27', 'Mariahstad', '2', '2014-03-21 23:49:01');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('156', 'M', '1978-09-09', 'Lake Osborneberg', '3', '1995-03-23 05:27:42');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('157', 'P', '1981-03-05', 'New Edenstad', '1', '2019-12-21 13:05:26');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('158', 'M', '2001-04-23', 'Almouth', '6', '2011-04-24 04:18:28');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('162', 'D', '2015-10-21', 'North Domingo', '5', '2014-03-17 11:48:43');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('164', 'D', '2015-05-19', 'Maximilliafort', '3', '1985-11-12 10:29:53');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('165', 'P', '2002-10-15', 'Bonitaville', '3', '2013-08-09 02:57:58');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('168', 'D', '1999-04-18', 'Lake Cornelius', '9', '1979-10-23 01:15:22');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('170', 'M', '1974-02-28', 'Adalbertoberg', '1', '1975-10-02 17:56:50');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('171', 'D', '2018-03-19', 'North Rickeychester', '1', '1991-02-26 13:59:01');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('172', 'M', '1988-01-08', 'Marcellusstad', '4', '2007-06-19 09:01:53');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('173', 'D', '1975-03-17', 'Robertsland', '6', '2011-10-17 21:45:32');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('175', 'M', '1998-12-07', 'West Charleneville', '4', '2015-10-12 13:08:02');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('176', 'M', '2016-02-24', 'Walshborough', '1', '2000-05-27 19:23:02');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('178', 'D', '2016-11-29', 'Cooperfurt', '7', '1981-03-13 21:57:19');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('183', 'P', '1982-11-26', 'Shanahanborough', '1', '2020-09-27 14:30:12');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('186', 'D', '2013-08-02', 'West Kendall', '9', '2014-08-01 17:13:55');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('187', 'M', '1978-09-05', 'New Annette', '2', '1992-12-01 10:05:59');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('189', 'P', '2013-10-27', 'South Emil', '1', '2001-04-03 20:40:41');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('191', 'D', '1981-03-07', 'North Robbfurt', '8', '2007-10-14 06:24:38');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('197', 'M', '1976-02-04', 'Sipeschester', '7', '2001-09-12 13:42:35');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('199', 'P', '1979-01-09', 'Lake Leann', '6', '2006-07-19 20:57:51');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `hometoun`, `photo_id`, `created_at`) VALUES ('200', 'P', '1979-09-03', 'New Lysanne', '1', '1992-08-07 11:21:39');


INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('1', '101', 'Inventore deserunt quo tenetur facilis deleniti. Aut modi qui consectetur aut labore. Ratione et magni vitae est sed. Et quia voluptatum natus sed.', '2014-12-01 13:48:40');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('2', '102', 'Quibusdam autem nisi est saepe consequatur est. Ut voluptatem ut cum ut eum. Velit ut quia neque consequatur.', '1990-11-14 11:08:01');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('3', '105', 'Hic vel et cumque quia repudiandae sunt modi. Laboriosam ex doloremque est quam. Laboriosam quidem qui quod quisquam.', '1999-06-07 16:57:00');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('4', '107', 'Veritatis et rem quos exercitationem blanditiis quam. Eos aut et et fugiat consequatur. Molestiae voluptatem animi voluptatem molestiae voluptatum quasi.', '2001-05-25 09:49:08');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('5', '113', 'Quam quae consectetur dolores amet. Rem labore harum dolorem eveniet modi quis ab explicabo. Repellendus et a aut ratione omnis animi omnis. Voluptas nesciunt hic numquam explicabo omnis. Omnis explicabo ea soluta sunt.', '2007-06-21 07:20:38');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('6', '117', 'Et deleniti non et incidunt quae quos. Eum enim voluptas ratione odit odit. Qui quasi et et sed. Culpa et asperiores repellendus voluptatem nostrum.', '1970-09-28 08:34:23');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('7', '118', 'Vitae similique ut culpa et quas. Soluta odit aperiam facilis. Excepturi esse sint veritatis. Occaecati id fugiat suscipit.', '2004-05-30 10:58:53');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('8', '121', 'Ut quo sequi eum aut odio maxime. Quos magnam neque ratione voluptate et sunt. Quisquam mollitia qui alias quia ipsam dolor.', '1985-08-03 02:54:42');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('9', '122', 'Perspiciatis dolorem voluptate eius autem et consequatur quia. Non laboriosam non aut libero. Voluptatibus sit officia perferendis voluptas dolorem est rerum. Amet et possimus aliquid illum iste repellendus repudiandae.', '1988-06-01 01:22:37');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('10', '123', 'Nihil cupiditate eveniet recusandae aut ut quis. Deleniti praesentium corporis quia eos et ea nulla. Tempore corporis perferendis deleniti assumenda necessitatibus iusto neque.', '1998-06-16 19:20:10');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('11', '125', 'Est blanditiis quod est adipisci velit eos. Sunt porro est blanditiis voluptatem amet deleniti dolorem. Voluptatum aut labore a.', '2018-09-09 02:52:25');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('12', '128', 'Quam sed rerum officiis. Quis molestiae quidem iusto officia omnis sed. Sit dolores saepe quis nostrum tenetur.', '2011-04-19 22:33:58');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('13', '131', 'Quia nam voluptatem sed neque aspernatur debitis fugiat. Molestiae suscipit velit rerum quia est atque odit. Qui enim iure dolorem earum perspiciatis libero veniam.', '2012-11-30 02:25:19');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('14', '132', 'Ipsa sed et excepturi accusamus. Vel nesciunt nobis quos aperiam est est rerum. Explicabo nihil sed temporibus et. At excepturi voluptatibus qui nobis consequatur enim laudantium.', '2016-08-23 02:52:43');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('15', '135', 'Non sint sit temporibus sit. Odit in cupiditate dicta. Voluptates molestias deleniti quaerat iure laudantium iusto nobis. Delectus placeat tenetur et fugit aliquid saepe et.', '2013-03-07 22:04:16');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('16', '137', 'Fugit reprehenderit voluptas rerum voluptate itaque suscipit. Sequi dolor quaerat voluptas illo vel earum quo. Voluptatibus amet debitis numquam ratione voluptatibus doloremque.', '1982-12-12 10:32:08');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('17', '139', 'Voluptas repellat repellat et neque id et. Dolorem incidunt illo voluptas doloremque sunt praesentium illo molestias. Vel ab dolorem dolor delectus ab. Vero expedita atque qui pariatur voluptas velit et.', '2019-01-09 11:52:31');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('18', '140', 'Totam et provident ea non accusamus. Ut voluptatem qui non quaerat unde deserunt. Esse ducimus quo et aliquid quasi sapiente. Beatae eveniet labore atque mollitia eligendi aut.', '1996-07-06 04:44:52');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('19', '141', 'Et enim id excepturi voluptatem qui maxime voluptatibus. Consequatur consequatur rem temporibus sint voluptate. Eum tempore quaerat voluptatum eos vitae et provident doloremque.', '1996-12-23 21:22:40');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('20', '142', 'Fuga corporis cum inventore est esse ullam. Sequi reprehenderit est sit magni ab voluptas et. Aliquam ea ullam voluptatem et repellat. Voluptatem ut exercitationem et aut laboriosam.', '1993-12-24 14:33:37');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('21', '145', 'Pariatur assumenda distinctio sit nemo aut officia pariatur. Quod in nihil qui placeat. Nihil neque dicta placeat beatae est ut mollitia culpa.', '1983-04-25 21:48:02');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('22', '146', 'Quia voluptate dignissimos explicabo quam saepe voluptatem facere quam. Hic unde libero nostrum culpa aut necessitatibus. Error saepe a sed recusandae sunt. Voluptatum qui quis nisi totam.', '2003-09-09 13:54:39');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('23', '147', 'Praesentium recusandae facilis nisi aut voluptatem. Et asperiores corporis aut amet consectetur eius. Aut sed porro nesciunt deserunt. Culpa soluta ea veritatis vel laborum temporibus omnis.', '1978-02-03 08:33:07');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('24', '149', 'Ratione blanditiis consequatur et magnam veniam distinctio. Odit earum ad sed soluta. Vel ipsa placeat consequuntur pariatur. Tempora voluptatem esse quo excepturi ad tempore. Ipsa qui quia et repellat voluptatem.', '2017-08-29 03:17:07');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('25', '152', 'Blanditiis expedita debitis dicta tenetur sint laborum. Sequi unde provident quod illo aspernatur dolorem architecto. Eos modi mollitia numquam vitae.', '1989-01-11 23:15:28');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('26', '156', 'Laboriosam molestiae aut et voluptatibus non. Animi eum totam qui numquam dolor. Asperiores consequuntur atque dolorem. Officiis consequuntur expedita et nam laudantium quasi sed magnam.', '1973-02-19 19:45:34');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('27', '157', 'Pariatur magnam est repellat fugiat. Consequatur aliquid voluptatum rerum. Quisquam sunt velit sit accusamus dolorum.', '2002-09-02 23:14:19');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('28', '158', 'Consequatur temporibus doloremque ea qui maiores accusantium exercitationem. Aut quia sunt nihil vel voluptas. Soluta sunt assumenda enim rerum.', '2018-03-21 21:39:45');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('29', '162', 'Nulla vel voluptas quibusdam sed. Saepe ratione odit provident rem. Quam aperiam magni enim ea eos occaecati alias. Aut quisquam velit numquam ad.', '1971-01-31 17:41:12');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('30', '164', 'Qui magni temporibus quaerat laudantium. Voluptas voluptas nemo voluptas quas quaerat eligendi odio. Aut voluptatibus laborum voluptate iste aut. Magni voluptas rerum aut aut.', '1985-05-06 13:07:21');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('31', '165', 'Tempora dolore ipsa officia alias et aperiam. Soluta sunt facilis vero aliquam consequatur velit molestiae. Quis libero suscipit et debitis ut. Et quia dolorum earum voluptatem eveniet voluptatum excepturi numquam.', '2001-06-14 06:19:05');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('32', '168', 'Sed dolores sed quos. Facere quis est nisi eum iure voluptatem aliquam.', '1972-01-04 02:33:55');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('33', '170', 'Quasi non eos nisi. Illo et ut earum ut accusantium. Quos est est commodi possimus voluptatem. Iusto minus et voluptatem sint.', '1970-11-05 12:06:17');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('34', '171', 'Velit quae voluptatem voluptatibus. Et et et corrupti aperiam. Sed aut enim velit mollitia qui dolorem.', '1984-01-19 09:49:03');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('35', '172', 'Velit voluptates quam molestiae voluptate earum autem. Tempore est deleniti et iusto. Hic sed maiores nobis deserunt aut dolore. Labore ut animi qui error.', '2016-10-14 17:31:23');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('36', '173', 'Magni eos maiores esse dolorum quisquam. Rem ut est natus ducimus. In aut rem consequatur ut excepturi ut rem. Doloribus quae dolorum ut est ducimus enim consequuntur beatae.', '1978-12-18 04:14:44');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('37', '175', 'Dignissimos est unde sed impedit est. Totam eos amet et. Sit aut autem et sequi iure vitae sunt. Repellendus nisi qui ullam nobis.', '1993-07-17 17:15:04');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('38', '176', 'Qui quia velit ut aut. Minus vel in eaque quod reprehenderit omnis.', '2013-03-28 00:23:18');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('39', '178', 'Velit quis soluta vel perferendis voluptas illum consequatur. Excepturi quia eligendi nostrum eum nam est. Sed quia perferendis necessitatibus itaque commodi ipsa. Molestiae quae corrupti sunt vel provident.', '1988-08-06 10:55:45');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('40', '183', 'Eaque asperiores possimus in molestiae quibusdam fuga et. Delectus temporibus molestiae beatae id illum. Aperiam doloremque nostrum non in et voluptatem.', '1999-12-15 00:31:16');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('41', '186', 'Eum temporibus velit saepe et facere architecto beatae eligendi. Inventore asperiores sit quisquam saepe sit consequatur. A temporibus at labore ut facere quo.', '1999-03-22 14:13:30');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('42', '187', 'Earum quia beatae laudantium modi quis nihil. Nobis laboriosam eos quo qui qui doloremque voluptatem. Dolore voluptatem et ab id praesentium. In fugiat ipsa iusto id vel velit quis.', '1999-08-14 10:57:47');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('43', '189', 'Quas sed ducimus atque. Nobis expedita soluta praesentium inventore sint.', '2017-06-04 13:50:43');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('44', '191', 'Repellat optio consequatur inventore. Quo deserunt ut incidunt necessitatibus. Quo eveniet qui omnis ab recusandae corporis voluptatem. Aut optio dolorum veniam repudiandae tempore voluptatibus.', '1995-03-21 05:14:02');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('45', '197', 'Voluptatem iste rem vel. Ut dolorem et omnis fugiat autem voluptate incidunt. Earum facere illo id quis facilis et. Et debitis laboriosam accusantium et expedita aut.', '1999-03-09 01:57:36');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('46', '199', 'Neque aperiam non veniam repellat. Unde esse hic eius eum sequi exercitationem perspiciatis. Laboriosam nemo unde praesentium ut. Est molestias reprehenderit veritatis autem sit iste.', '2012-03-10 05:17:19');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('47', '200', 'Sit dolor quam aliquam voluptates molestiae eos. Ut non temporibus ex ut debitis ex. Velit quaerat quo reprehenderit. Placeat eos architecto vel quaerat. Dicta qui deleniti suscipit cum dignissimos voluptate et itaque.', '1997-06-04 04:14:37');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('48', '101', 'Reprehenderit aut voluptas sit aut. Qui nisi illum nobis quo. Debitis quo voluptas molestiae et qui accusantium. Nesciunt vero occaecati aut ducimus sint dolore totam.', '2001-10-01 02:11:33');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('49', '102', 'Quas eaque recusandae dicta reiciendis quasi. Quae dicta sit harum voluptatem. Modi ea explicabo deserunt. Omnis dignissimos quia qui nesciunt. Libero voluptas laborum est dolores quo inventore.', '2014-10-18 09:53:10');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('50', '105', 'Aliquam beatae animi autem officiis est distinctio. Et fuga quas culpa dolor debitis temporibus quis. Temporibus ea enim quia adipisci sit asperiores.', '2001-12-08 00:06:08');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('51', '107', 'Facere nihil repudiandae ducimus excepturi et temporibus corrupti. Non corrupti tenetur harum reiciendis. Et odit consectetur sed non architecto.', '2014-05-01 15:54:19');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('52', '113', 'Excepturi ratione et ut. Qui magnam doloremque quam nulla et earum et. Dignissimos distinctio nemo aut est. Omnis rerum explicabo omnis a et pariatur cum.', '1994-05-09 07:24:33');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('53', '117', 'Cupiditate ut sed excepturi impedit enim distinctio. Eos provident voluptate dolorum omnis ex recusandae. Itaque quo in rerum.', '1983-05-11 18:00:42');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('54', '118', 'Dolore fugit autem perferendis consequatur sequi. Quidem molestiae possimus totam nihil iure autem iure vel. Esse enim accusantium eveniet aut nemo repudiandae eveniet commodi. Quas consectetur vel ea error.', '1998-03-17 12:29:40');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('55', '121', 'Consequatur repudiandae necessitatibus tenetur nihil est corporis. Molestiae harum cupiditate error unde mollitia accusantium porro eaque. Ipsum est suscipit enim voluptas voluptatem.', '2002-04-04 10:18:16');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('56', '122', 'Sint mollitia possimus alias inventore qui ab. Voluptas sed aut deleniti id qui quibusdam eos. Est porro est eligendi sint quisquam.', '1972-01-11 19:13:25');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('57', '123', 'Assumenda assumenda nobis ex et voluptas omnis debitis. Porro sunt eum rem quaerat qui molestias. Autem rerum autem fuga facilis non non. Aliquam rerum eaque unde quas.', '1979-07-22 06:07:08');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('58', '125', 'Similique velit quia voluptates eos necessitatibus. Quas ut eum labore voluptate quaerat. Eos odit ullam ut sunt. Cum eius fugit est itaque nihil laudantium.', '1988-03-21 06:09:13');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('59', '128', 'Libero accusantium sit id et aut. Nemo sapiente vel architecto et nisi. Sed soluta optio exercitationem est est aut consequatur.', '1999-09-24 02:18:04');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('60', '131', 'Excepturi delectus in nam aut. Sunt eum hic quo facere sed modi eius totam. Qui nihil repellat voluptatibus.', '2020-12-13 08:52:44');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('61', '132', 'Est natus cumque vel ipsam sunt. Et ducimus velit nihil ipsa labore nostrum dolor. Voluptatem voluptatem enim dolorem.', '1988-03-27 13:08:04');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('62', '135', 'Animi facere provident fugiat qui consequatur. Alias quidem iure accusantium eos adipisci. Consequatur et laborum suscipit eos ea eius nihil.', '2003-07-31 16:51:46');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('63', '137', 'Non quisquam eos aliquam et qui quia consectetur. Asperiores facere sunt rerum quis nemo fugiat nam. Nisi illo temporibus ullam et natus alias.', '1999-10-18 08:15:36');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('64', '139', 'Aut fugiat minus nobis eum. Consectetur reiciendis nulla ut laborum quo. Velit voluptatum corrupti distinctio tempore sed totam non. Possimus aut porro ullam voluptas nisi voluptatem eos. Et molestiae ut voluptate sit sed.', '1998-02-19 15:46:32');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('65', '140', 'Aut laborum omnis quo. Qui qui similique asperiores quae maiores dolor eos. Fugiat tempore enim consequatur culpa deleniti possimus.', '1994-01-31 13:52:47');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('66', '141', 'Vitae sed autem voluptas quia enim assumenda fugiat facere. Autem aut ratione itaque sed. Sit perspiciatis ut recusandae nihil impedit.', '2016-08-24 09:29:56');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('67', '142', 'Et dolores eum dolore ea ea aut et non. Quis corrupti inventore autem et recusandae quos. Quos sed velit molestiae voluptas excepturi dolorem. Consequatur vel voluptatem porro reprehenderit. Perferendis quis aperiam fugiat architecto quis culpa.', '1991-08-30 14:29:46');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('68', '145', 'Fugiat ea et illum quasi. Nesciunt dignissimos omnis quia. Id saepe ut voluptates et. Cum facilis sit vel praesentium nobis.', '2016-09-16 22:54:01');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('69', '146', 'Magnam cupiditate perferendis perspiciatis dolorum quia ex. Laudantium rerum maxime est vel.', '2015-01-31 21:01:21');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('70', '147', 'Unde vel molestias minima sint perferendis nisi voluptatibus. Illo et nesciunt voluptatem omnis. Ipsam velit quos et reprehenderit. Et soluta dolorem facere soluta repudiandae dolores velit.', '1983-03-18 16:51:55');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('71', '149', 'Omnis et vel omnis accusamus sed. Et enim quo magni eveniet.', '1992-08-24 12:11:32');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('72', '152', 'Ut temporibus quo expedita libero. Quia sed fuga quia blanditiis vero. In saepe consequatur debitis ratione.', '2007-01-27 13:50:30');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('73', '156', 'Cupiditate ad architecto natus. Molestias quos exercitationem nesciunt alias voluptas facere enim.', '1988-01-29 05:42:50');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('74', '157', 'Dolorum consequatur amet id aut. Ea sit et ratione dicta possimus. Quas possimus asperiores atque voluptatem reprehenderit. Corporis dolores maxime omnis provident illo vel ut assumenda.', '1970-08-05 17:08:53');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('75', '158', 'Amet nihil nam asperiores architecto odio nesciunt est provident. Possimus consequatur inventore nobis dolorem occaecati ab. Consequatur cum commodi non est modi enim hic. Autem nam quasi eos dolorem cumque et quia ipsum.', '2020-04-20 16:27:59');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('76', '162', 'Quaerat corporis vel a exercitationem. Ex tempore iste delectus perspiciatis voluptatibus aut. Explicabo temporibus qui soluta. Ab eum cumque laudantium corrupti maiores assumenda corporis.', '1988-03-29 00:46:53');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('77', '164', 'Sunt et sunt voluptatem aut eveniet. Deserunt accusantium ab architecto occaecati impedit eaque vel quia.', '2018-10-22 00:45:32');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('78', '165', 'Sed odio nostrum iusto doloremque aperiam numquam rerum. Deleniti dolorum et magni molestiae culpa. Sed qui est dolorem quis.', '2007-09-28 18:12:11');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('79', '168', 'Sit dolor laudantium alias ratione eligendi cum distinctio aut. Enim vel dolores non repudiandae exercitationem possimus. Veniam eum commodi laudantium veniam ut. Ut recusandae odio impedit veritatis tenetur fugiat.', '2005-07-02 20:50:45');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('80', '170', 'Quia non et dolorem quam voluptates maxime totam. A optio illum enim nemo corrupti. Repellendus sit qui quia omnis molestiae commodi.', '2017-05-05 05:13:47');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('81', '171', 'Et nihil suscipit suscipit dolorem provident. Et quibusdam distinctio ipsa consectetur. A occaecati repudiandae voluptatum nihil enim corporis.', '2017-07-03 04:57:18');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('82', '172', 'Fugiat dolor et autem. Voluptate et fuga sint eveniet nostrum dolores quos. Sit delectus ut voluptatem sequi aut aspernatur. Cumque blanditiis sed fugiat repellendus odit.', '1972-08-18 15:21:00');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('83', '173', 'Nesciunt a dolores beatae cumque sunt voluptas ipsum. Voluptatem possimus harum magnam quos sed cum sint. Quia reprehenderit aut voluptas voluptatem. Incidunt quia et dolorem occaecati reprehenderit iure voluptas beatae.', '2012-06-08 02:03:32');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('84', '175', 'Qui iusto ducimus veritatis culpa dolore facilis id. Dicta soluta eaque adipisci nostrum earum ratione voluptatem. Et ipsum deserunt ut voluptatem officiis consectetur. At velit quas laboriosam.', '1988-12-30 07:54:01');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('85', '176', 'Et excepturi consequuntur consequatur commodi et. Esse iste accusamus itaque tempore doloremque. Eos cupiditate sit voluptatem et.', '2016-02-02 02:51:42');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('86', '178', 'Sit doloribus dolore delectus eveniet blanditiis illo voluptatibus. Ut est animi rerum enim et repellat. Optio amet eveniet autem alias sed maxime.', '1970-01-05 10:41:52');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('87', '183', 'Aliquam non voluptatem eos maiores. Nulla deserunt non voluptatem et nulla nemo. Nihil qui occaecati temporibus voluptatum voluptas voluptatum.', '1975-08-15 21:40:05');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('88', '186', 'Corrupti vel inventore voluptatem beatae odit aut. Hic molestiae adipisci a autem quas architecto.', '1998-12-18 14:58:06');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('89', '187', 'Ea sunt dolores soluta. Est cupiditate est modi facere rerum. Veniam minima sint nihil dignissimos qui consectetur.', '1998-11-26 02:35:26');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('90', '189', 'Fuga laborum et voluptatem deserunt eaque at suscipit. Dolor laudantium quam maxime consequuntur fugit soluta quidem nobis. Provident voluptatum est est et deleniti amet facere. Dolor dignissimos sit earum et similique ea.', '1977-05-27 06:08:50');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('91', '191', 'Facilis placeat laborum numquam quo animi et inventore. Aliquam reiciendis consectetur ut ipsa rerum enim tempora omnis. Omnis ratione explicabo ipsam fugiat consectetur est vero.', '1991-11-18 08:56:49');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('92', '197', 'Ex praesentium dolor magnam magnam voluptas dolorem. Id tempora recusandae aut ab harum vel. Quia sit sed expedita velit.', '2018-05-11 15:28:07');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('93', '199', 'Ratione similique quam fugiat perferendis quam. Sed eum in asperiores accusantium consequatur. Eos explicabo velit asperiores cupiditate laborum.', '1999-02-15 12:55:38');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('94', '200', 'Est minus veniam rerum sunt aut voluptas iure. Nulla autem sit ea voluptatibus dolore. Similique nisi accusantium sunt tenetur optio odit voluptatem suscipit.', '1997-11-30 21:21:29');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('95', '101', 'Doloremque sed beatae et sit. Enim deserunt et est sit cumque atque et. Voluptatem libero eum voluptatem sapiente. Velit repudiandae nobis tempora.', '1990-09-27 09:33:55');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('96', '102', 'Quo esse et ad voluptatem non architecto omnis. Error earum sed voluptate architecto similique corrupti. Rerum repudiandae est laborum consequatur pariatur qui. Dolores quisquam sapiente repellat officiis eligendi sequi.', '2010-08-20 23:46:13');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('97', '105', 'Et occaecati consequuntur aut deleniti magni quas quidem. Dignissimos aut est quia et voluptates. Vel voluptatem aperiam libero eius earum voluptas sequi.', '1975-12-11 15:22:15');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('98', '107', 'Omnis eum dicta quibusdam dolore repudiandae asperiores. Et maiores facere excepturi numquam. Molestias rerum nihil magni excepturi voluptatem nihil. Aut enim dolores provident et omnis ut.', '1978-03-04 14:30:25');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('99', '113', 'Quia perferendis est velit tempore assumenda. Natus aperiam in voluptates quo quidem deleniti a. Eum voluptatem dolor voluptate cumque aperiam vitae. Veniam nemo et id quam atque. Perferendis id sed necessitatibus temporibus quae consequatur iste.', '1989-04-09 20:33:16');
INSERT INTO `news` (`id`, `author_id`, `body`, `created_at`) VALUES ('100', '117', 'Nemo nesciunt eveniet officiis nihil consequuntur asperiores quod. Voluptatibus et aliquam molestiae architecto. Cupiditate facilis non qui repellendus architecto. Earum est tempora ex aliquam sequi est.', '1981-10-22 05:16:35');


INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('1', '101', '101', 'Molestiae odio voluptate et debitis. Voluptates officiis error neque voluptatibus aut nesciunt. Dolorum deserunt voluptas architecto. Ut animi et itaque est eos. Commodi occaecati quae ad cupiditate natus saepe quia aliquam.', '2018-11-06 02:30:00');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('2', '102', '102', 'Est omnis voluptatem quisquam blanditiis aut commodi voluptatem. Explicabo ipsa perferendis dolorem qui optio non qui.', '2017-08-09 09:16:17');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('3', '105', '105', 'Voluptatem nesciunt voluptatem quisquam harum omnis eum cupiditate in. Minus necessitatibus ea blanditiis aut voluptas. Temporibus architecto et atque. Quisquam nihil velit ipsum enim.', '2000-07-16 21:12:22');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('4', '107', '107', 'Doloribus cumque et assumenda blanditiis autem inventore. Voluptatibus molestiae sed qui. Sit quaerat id accusamus alias et. Perspiciatis at quia est aut cumque.', '1979-08-14 11:11:44');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('5', '113', '113', 'Vel a praesentium quia necessitatibus at. Dolorem omnis perspiciatis non sit ipsa. At tempora aut facilis odit error id. Quam consequuntur dolorem maxime et ut amet dicta labore.', '1997-01-04 02:01:57');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('6', '117', '117', 'Atque qui a maxime est. Amet repellat culpa veritatis. Quis voluptatum non et quaerat ut adipisci non.', '1978-06-18 12:31:22');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('7', '118', '118', 'Dolore recusandae magni ad ut. Necessitatibus velit molestiae dolorem nam. Est aut quibusdam reiciendis placeat. Quis vitae error vitae quidem rerum omnis repellat. Neque itaque consequatur id sed consequatur.', '2010-12-29 07:30:42');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('8', '121', '121', 'Possimus libero pariatur voluptates qui vel rem. Autem nobis non blanditiis quod. Accusamus odit velit incidunt vitae. Molestias error nihil ipsum consequatur deleniti.', '1989-01-30 16:44:43');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('9', '122', '122', 'Ducimus repellendus delectus doloremque occaecati autem. Veritatis voluptas impedit quis quidem aut. Qui laboriosam voluptate consequatur.', '1996-08-23 18:30:23');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('10', '123', '123', 'Voluptate repudiandae iure quam fuga aut nesciunt magni. Iste eos aperiam totam ipsam doloribus optio. Assumenda eum enim omnis.', '2000-07-25 08:25:29');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('11', '125', '125', 'Quo ipsum veritatis similique. Quaerat quia esse rerum facere rerum. Sapiente vitae dignissimos aperiam est minima soluta et.', '1976-09-18 18:39:29');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('12', '128', '128', 'Corrupti aut in deleniti amet deleniti. Facere sit in neque et qui consequatur. Numquam eum deleniti tempore et maxime eveniet occaecati.', '2015-01-05 05:02:10');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('13', '131', '131', 'Facere nihil aliquam ut debitis. Est quo in commodi. Repellendus sed dolor fugit in numquam.', '1989-01-18 11:04:57');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('14', '132', '132', 'Est ipsa assumenda maxime iusto asperiores aliquam maiores. Voluptatem culpa possimus tempore alias voluptatem adipisci. Atque explicabo praesentium eos fuga quia.', '2017-03-04 10:31:34');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('15', '135', '135', 'Minima sapiente debitis porro cupiditate nulla. Et nemo eligendi voluptatum dolor sapiente dignissimos. Consectetur quis accusantium mollitia. Minus est consequatur ad aut sequi autem ex.', '1982-11-27 09:16:13');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('16', '137', '137', 'Nulla accusantium similique reiciendis ullam fuga. Blanditiis ea ex eveniet sed. Omnis tempore incidunt et qui dolores. Voluptatum earum tenetur distinctio delectus dolore repudiandae sit.', '1976-03-21 14:20:58');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('17', '139', '139', 'In voluptas mollitia et neque aut nulla. Sit nostrum officia in dolore. Accusantium sint deserunt magnam voluptatem tenetur omnis.', '1980-05-01 19:50:12');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('18', '140', '140', 'Omnis ipsum architecto cum illum voluptas quibusdam consequatur. Suscipit id repellendus voluptatem rem praesentium unde rerum. Illo voluptas laborum magni maxime molestiae dolorem.', '1989-04-11 16:51:29');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('19', '141', '141', 'Nihil nihil quia at consequuntur non dolorem. Animi sunt et vel eos nobis voluptatem nulla. Eum eum omnis aut sunt est et qui. Inventore beatae natus minus quae praesentium aperiam.', '1987-11-17 04:41:05');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('20', '142', '142', 'Ut est in quaerat et. Aut iure maiores deserunt minima est mollitia.', '1974-04-22 05:32:49');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('21', '145', '145', 'Quae fugiat fuga distinctio eum modi. Corrupti et sit magnam neque officia cumque a.', '2015-03-11 06:32:31');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('22', '146', '146', 'In non non at et labore tempore. Tenetur possimus consectetur minima. Qui et occaecati necessitatibus quos dignissimos dignissimos eum.', '2018-03-07 00:56:52');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('23', '147', '147', 'Eum aperiam et provident. Similique ad nihil harum dolores.', '1976-09-29 05:47:02');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('24', '149', '149', 'Mollitia minima esse non architecto quia assumenda. Dolor asperiores rerum officia atque. Quia et explicabo ipsum deleniti corporis voluptas autem quia.', '1983-03-07 05:01:28');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('25', '152', '152', 'Beatae quisquam omnis beatae ducimus voluptatem. Eos dolore assumenda dolore sunt recusandae quia veniam. Sed et est ut fuga omnis aliquid.', '1974-08-03 07:45:05');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('26', '156', '156', 'In omnis quas ab est omnis. Molestiae ut itaque aut culpa dolor saepe soluta. Nam eum ipsam magni laudantium quae possimus ut nulla.', '1970-03-03 15:17:51');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('27', '157', '157', 'Numquam necessitatibus iste nesciunt et aliquid id. Incidunt exercitationem adipisci qui nihil. Expedita qui reiciendis ab tempora. Corrupti doloribus cumque et ipsa.', '2016-10-08 00:41:16');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('28', '158', '158', 'Rerum et est at. Omnis vel quis voluptatem asperiores aut. Ut cupiditate hic culpa eaque sit ut. Quos occaecati fugit quos quam consequatur in.', '1978-12-23 06:57:40');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('29', '162', '162', 'Ut molestiae sit quia omnis unde quia quae. Totam eligendi enim corrupti porro. Incidunt dolores consequatur eos. Quibusdam tenetur libero voluptatem error qui. Delectus tenetur quae eligendi nam voluptas.', '2005-02-10 17:35:57');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('30', '164', '164', 'Occaecati quam aut animi nostrum rerum. Excepturi ea consequatur animi architecto. Dolor qui veniam inventore sunt laudantium nostrum. Eum qui corrupti est sint.', '1992-03-02 14:32:08');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('31', '165', '165', 'Sit deleniti dolorem totam. Et explicabo explicabo ut tempora aut.', '2013-01-21 10:22:01');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('32', '168', '168', 'Harum ex dolores ut sed. Voluptatem facere quisquam quia iure ea. Ut itaque ullam veritatis natus velit odit voluptatem. Tempora saepe rerum sit qui quo qui voluptas consequatur.', '1971-06-19 22:35:33');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('33', '170', '170', 'Debitis provident accusantium rerum. Corporis qui cumque expedita sit quo commodi sint. Natus cupiditate id non non.', '1985-11-27 00:25:30');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('34', '171', '171', 'Laboriosam nihil magnam magni maiores. Quo ut hic quibusdam ut nam et. Sit fugiat similique culpa. Consequuntur nihil numquam ratione animi. Blanditiis et ad est.', '2004-01-03 15:56:41');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('35', '172', '172', 'Quasi animi dolor velit non. Repellat dolores quisquam eaque quis et sed dolores. Dolores vero quisquam quod animi quod.', '1985-02-10 05:02:33');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('36', '173', '173', 'Consequatur enim incidunt aliquid in aliquid tempora aliquam. Voluptas voluptatibus harum molestiae. Quae beatae doloribus voluptate sint et atque.', '2011-04-05 05:24:12');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('37', '175', '175', 'Dolorum voluptatibus minus placeat dolore. Omnis labore perferendis voluptas deserunt. Suscipit deserunt suscipit rerum debitis nihil molestiae quasi. Optio vel eaque ipsum incidunt.', '1976-08-21 05:40:48');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('38', '176', '176', 'Sint error nostrum optio reprehenderit earum sit. Id ducimus dicta enim nisi a voluptatum. Eum qui rerum sit adipisci facere possimus voluptatem explicabo. Ullam sit recusandae esse sunt.', '1978-01-18 02:06:02');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('39', '178', '178', 'Distinctio ut non magni nemo. Modi dolores ducimus molestias cupiditate et quisquam et. Sit cupiditate id cupiditate et non maxime aut.', '2012-07-16 09:55:16');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('40', '183', '183', 'Nemo fugit odio est soluta. Dolores consequuntur pariatur ipsam dolor enim. Consequatur mollitia eius dignissimos aut sint.', '2002-04-01 19:09:20');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('41', '186', '186', 'Aspernatur aut tempora aliquam aliquam aliquid dolores. Eum tenetur cumque unde occaecati dolorem et alias eveniet. Aut sed eligendi optio enim aperiam et. Ut necessitatibus beatae qui.', '1986-11-03 06:24:47');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('42', '187', '187', 'Possimus qui molestiae rerum omnis ea quasi laboriosam iste. Unde omnis laudantium natus labore et laboriosam aliquam. Eos ratione consequuntur distinctio. Non tenetur aperiam explicabo.', '2003-08-17 20:49:32');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('43', '189', '189', 'Qui sunt illum qui non suscipit est culpa. Consectetur est perferendis illum. Laboriosam aperiam nulla et earum.', '2007-08-20 03:37:37');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('44', '191', '191', 'Nobis beatae et nihil. Quibusdam vero quis eligendi sint. Quidem enim ut esse mollitia minus. Maxime quis culpa sed alias aut. Nam delectus hic voluptatem omnis et.', '1986-07-29 16:46:42');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('45', '197', '197', 'Voluptatem architecto necessitatibus dignissimos quia nisi occaecati. Quia ipsum quae quisquam qui amet. Provident voluptas aut voluptas aut.', '1989-01-12 03:20:11');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('46', '199', '199', 'Dolore iure odio quia necessitatibus voluptatibus dolor. Aliquam adipisci corporis quibusdam aut. Quia et sit facilis alias beatae libero vero. Quia at doloribus quae labore.', '1975-07-29 06:49:28');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('47', '200', '200', 'Eaque qui earum culpa et aliquid repellat aut. Dolor voluptas nam magnam omnis numquam porro. Doloribus delectus vel accusantium iusto perferendis eos.', '1974-09-15 16:39:33');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('48', '101', '101', 'Molestiae ipsam ab quia aut qui minima est. Est voluptate sint explicabo dolorum. Veniam dignissimos quia quas dolores non. Eum quae explicabo ullam ut soluta.', '2002-10-03 21:45:08');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('49', '102', '102', 'Alias eligendi delectus libero in porro ut. Aut rerum non nostrum excepturi voluptas et distinctio est. Dolorum repudiandae consequatur officia reiciendis sit. Eos optio numquam assumenda est eaque voluptatum et. Sed architecto praesentium eum atque odio.', '1985-05-24 20:37:56');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('50', '105', '105', 'Voluptatem saepe vero amet in tempore at. Reiciendis eveniet officiis alias repellendus praesentium. Non libero corporis nesciunt nobis ut.', '2005-10-04 17:46:12');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('51', '107', '107', 'Velit non eligendi officiis odit eius. Rerum deleniti est repellat facilis omnis. Harum sapiente temporibus unde asperiores debitis iusto tempora.', '1985-12-14 09:28:53');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('52', '113', '113', 'Illum labore pariatur ea fugiat. Dolorem non laborum vero ut accusantium sapiente cum. Esse omnis hic corporis voluptatem in corporis.', '2011-06-15 14:24:29');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('53', '117', '117', 'Alias et nostrum ipsam eveniet. Incidunt atque eligendi temporibus eum sed architecto cumque.', '1994-09-23 16:50:20');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('54', '118', '118', 'Non enim esse non qui non dolores. Velit et fuga ipsa et soluta vitae nisi. Voluptatem et cupiditate porro est in.', '2008-03-05 16:22:26');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('55', '121', '121', 'Voluptates sit laudantium aliquid ut enim unde voluptatem culpa. Voluptatem totam voluptas qui error. Optio veritatis optio officia suscipit est quibusdam.', '1982-05-11 09:05:38');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('56', '122', '122', 'Totam corporis hic qui aliquid vero. Et et quo et. Maxime doloremque officia voluptatem minus et totam.', '2012-03-02 22:44:36');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('57', '123', '123', 'Exercitationem iure eos voluptas aut dolor consequatur qui non. Vel alias laboriosam qui quos. Vel quis quaerat quibusdam occaecati odit aspernatur odit. Possimus ea optio sit id ullam consequatur laboriosam minus.', '1975-09-29 04:32:24');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('58', '125', '125', 'Eos quibusdam qui cupiditate et a. Temporibus ea perspiciatis quo nesciunt. Minus iure aspernatur unde repudiandae quod quisquam consequatur.', '2002-01-25 12:58:33');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('59', '128', '128', 'Quis impedit fugiat fugit asperiores. Ratione deserunt consectetur ab possimus facere.', '1977-12-29 13:53:40');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('60', '131', '131', 'Placeat dolor neque quisquam qui. Minus sit doloremque eligendi in voluptas. Qui hic sint aliquid sit. Deserunt saepe vel et tempora vel aliquid debitis assumenda.', '1991-02-12 19:49:01');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('61', '132', '132', 'Sed quis est voluptate est. Odit pariatur nemo id doloribus nihil et. Fugit aut et impedit eos. Fuga et facilis ipsum pariatur aspernatur aut dolore.', '1986-10-26 14:55:29');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('62', '135', '135', 'Aut est odio quidem est eaque. Nam sunt eaque earum eaque. Laborum sed necessitatibus non nesciunt.', '2000-10-25 16:06:42');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('63', '137', '137', 'Sed quidem omnis non. Eos doloremque est distinctio dolorem odit quaerat amet. Voluptatem quos velit consequuntur voluptatem similique earum.', '1979-08-17 01:08:51');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('64', '139', '139', 'Harum sequi aut rerum quae. Laudantium inventore error asperiores sapiente et. Et consectetur totam qui. Maiores velit nihil dolorum quis et dolorem dolorem temporibus.', '1973-09-26 08:00:55');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('65', '140', '140', 'Non quisquam eaque sed ullam nemo neque excepturi architecto. Odit quidem voluptatem illo repellat. Sit ullam ea odio quam ipsa et. Nihil voluptas et ducimus aut cupiditate aliquid.', '1996-04-08 16:47:14');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('66', '141', '141', 'Repellendus est natus eveniet. Sapiente aut beatae beatae aliquam laboriosam porro. Voluptatibus dolorum autem et aspernatur autem facere qui sed.', '2011-02-20 05:19:59');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('67', '142', '142', 'Doloremque ut dolorum excepturi sit dolorem. Non at autem vel vel pariatur. Temporibus dolor animi molestiae beatae dolores ipsum.', '1982-06-18 00:59:40');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('68', '145', '145', 'Vel inventore nostrum non totam corporis est. Nihil officiis ut hic commodi deserunt ratione voluptatem maiores. Tenetur cupiditate delectus corrupti atque magni maxime et.', '2019-01-26 18:19:12');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('69', '146', '146', 'Similique eius voluptatem aut nemo. Mollitia tempora doloribus sit omnis. Et repellat a quis iure. Corrupti natus itaque ut veniam. Ducimus maxime molestias eum.', '1975-07-09 21:48:14');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('70', '147', '147', 'Ut reiciendis blanditiis et. Corporis quasi itaque nam dolor eveniet qui est id. Dolorum omnis harum impedit sed adipisci nulla.', '1973-10-17 04:07:18');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('71', '149', '149', 'Incidunt quam repellat excepturi fugiat earum quam consequatur. Voluptatem soluta sed libero dicta aliquam maiores veritatis. Dolorum molestiae repellat enim quidem.', '1973-10-03 14:10:39');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('72', '152', '152', 'Voluptatum sunt vel facilis. At suscipit magnam eligendi vero sunt excepturi aut. Natus praesentium possimus odio perspiciatis reiciendis voluptatem consequuntur. Ea velit placeat eum porro possimus.', '2019-08-23 23:11:30');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('73', '156', '156', 'Inventore et non unde cumque. Debitis autem et ut corporis corrupti. Harum explicabo quia recusandae a. Dolorum et autem est voluptas porro enim consequuntur.', '1990-07-23 10:48:29');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('74', '157', '157', 'Debitis consequatur suscipit cum veniam est consequatur. Id omnis ut ut nobis illum doloribus quisquam quia. Sequi quo quod nisi voluptatibus aliquam.', '2004-01-29 03:03:15');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('75', '158', '158', 'Deleniti debitis est incidunt. Architecto sapiente labore necessitatibus voluptatem necessitatibus. Et ut quos ut suscipit.', '1981-11-14 00:49:02');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('76', '162', '162', 'Similique voluptates ullam aut magnam doloremque. Aliquam est impedit molestiae non itaque. Ut vitae quidem molestiae aliquid. Et eveniet rerum in dolor et.', '1971-01-16 03:26:25');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('77', '164', '164', 'Quam consectetur molestiae est optio tenetur est. Vel possimus fugiat ullam accusamus quibusdam doloribus.', '1982-04-06 14:38:11');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('78', '165', '165', 'Deleniti et dolorem delectus quis. Voluptate tempore voluptatem aut corporis. Eum cum necessitatibus rerum excepturi veritatis voluptatibus.', '1982-11-16 07:08:49');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('79', '168', '168', 'Sit rerum adipisci molestias provident explicabo doloremque ut. Asperiores commodi aliquid sit aperiam labore doloribus.', '2019-12-04 23:48:15');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('80', '170', '170', 'Autem aut qui tenetur facere laboriosam qui. Dignissimos hic et dolorum aut veniam amet accusamus vel. Amet aut ratione sunt. Aut et non possimus.', '1991-03-06 03:50:09');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('81', '171', '171', 'Atque expedita delectus quia fuga. Eveniet est illum quis laboriosam voluptatem nostrum rerum. Harum et est et. Est vero atque quo corporis ab temporibus dicta. Sit temporibus voluptatem temporibus inventore eos.', '2017-01-17 21:36:27');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('82', '172', '172', 'Nisi rerum quis nostrum id quisquam suscipit. Magni et quo corrupti quam quos debitis.', '2015-04-06 11:45:53');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('83', '173', '173', 'Minima voluptate accusamus sed unde nihil impedit. Adipisci numquam iusto beatae aut voluptas.', '1989-06-15 03:41:26');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('84', '175', '175', 'Tempore nobis maiores dignissimos architecto. Velit molestiae accusantium dolores soluta ea impedit saepe. Repellat voluptatem odio a eius qui non. Fugiat et dignissimos dignissimos iste repellendus inventore enim.', '1997-09-20 08:34:30');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('85', '176', '176', 'Voluptatem quaerat dolores laborum sed sit corrupti. Ducimus consequatur doloremque aut quo est. Totam sed reprehenderit ut pariatur sit.', '1979-03-15 14:58:22');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('86', '178', '178', 'Ad culpa accusamus debitis. Quas soluta sit iure sapiente eveniet dignissimos. Accusantium atque deserunt quae pariatur eveniet.', '1970-03-21 14:49:18');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('87', '183', '183', 'Omnis aliquid totam molestiae saepe illo quaerat. Earum ea autem facere aut dolores odio. Ut odit impedit cumque. Odio voluptates in repellat reiciendis maiores totam quibusdam.', '1975-04-25 13:43:02');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('88', '186', '186', 'Nisi sint aut delectus ut harum. Facilis consectetur dignissimos sed aut et. Aut et maiores ut et fuga id. Voluptatem ipsa et natus corporis at.', '1997-02-08 08:19:57');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('89', '187', '187', 'Voluptatem quia quasi alias quia quaerat. Consequatur odio nihil labore culpa unde. Consequatur nisi aut rerum eaque autem.', '1999-07-10 01:25:11');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('90', '189', '189', 'Libero autem cum nemo qui consequuntur quo. Autem minima ipsam ducimus a culpa ut similique eum. Corrupti omnis tempore illum velit aspernatur deleniti expedita.', '2012-03-18 16:02:04');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('91', '191', '191', 'Et excepturi ratione qui ex error earum accusamus inventore. Voluptatem ipsa accusamus tempore velit vel doloremque rerum qui. Porro dolorem omnis suscipit voluptas at commodi. Enim distinctio et adipisci blanditiis quos.', '1990-11-01 10:58:26');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('92', '197', '197', 'Est dolorem explicabo dolor sequi nulla quia. Soluta et autem quam molestias omnis sint quaerat alias. Voluptates dolores maxime magnam dolorem. Veniam sapiente harum voluptatibus porro deleniti.', '2014-03-26 20:23:53');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('93', '199', '199', 'Ut sit harum corporis provident et et reiciendis. Omnis dolorum et at. Voluptatem mollitia voluptatum fuga.', '2014-11-08 16:38:21');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('94', '200', '200', 'Vel aspernatur asperiores sint sunt enim accusantium itaque. Distinctio expedita tempora consectetur mollitia ea non. Soluta vero omnis ut aspernatur optio aliquam soluta. Praesentium ipsa earum nemo occaecati rerum est aspernatur.', '1990-12-09 10:35:44');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('95', '101', '101', 'Accusamus illo rerum necessitatibus modi voluptatum illum quas. Voluptatibus in enim quia consequuntur in. Quisquam quam rem nihil et.', '1976-10-14 08:51:59');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('96', '102', '102', 'Laborum quis quae recusandae id culpa. Sed enim unde consequuntur corporis provident. Et neque et ab atque eos non fuga.', '2011-10-20 12:20:19');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('97', '105', '105', 'Sunt cupiditate id non facere commodi non sit. Illum sunt et sit aut vel ipsum.', '1995-12-30 03:14:36');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('98', '107', '107', 'Eum omnis repellendus deleniti. Accusantium voluptatem eos qui sed est soluta unde. Sint corrupti eum ab corporis voluptates.', '1975-07-05 12:40:13');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('99', '113', '113', 'Autem ab nam officia illo numquam quia optio ullam. Ut odit quam itaque. Dignissimos ullam tempora perferendis sint sed.', '1989-03-05 18:55:40');
INSERT INTO `massages` (`id`, `from_user_id`, `to_user_id`, `body`, `created_at`) VALUES ('100', '117', '117', 'Officia est fuga laborum doloremque maxime voluptas quis. Eius ea quos sunt itaque beatae quisquam praesentium vel. Facilis facilis ut deserunt accusamus velit distinctio voluptatem.', '1997-12-23 14:22:24');