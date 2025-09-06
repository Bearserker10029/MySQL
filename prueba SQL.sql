-- show databases;

drop database if exists twitter_db;

create database twitter_db;

show databases;

use twitter_db;
create table users (
	user_id int auto_increment,
    user_handle VARCHAR(50) not null unique,
    created_at timestamp not null default (now()),
    primary key(user_id)
);

insert into users (user_handle)
values
('midu'),
('hola'),
('mid'),
('data');

create table followers (
follower_id int not null ,
following_id int not null,
foreign key (follower_id) references users(user_id),
foreign key (following_id) references users(user_id),
primary key(follower_id, following_id)
);

alter table followers
add constraint check_follower_id
check(follower_id <> following_id);

insert into followers (follower_id, following_id)
values
(1, 2),
(2, 1),
(3, 1);

