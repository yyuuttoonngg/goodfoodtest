CREATE DATABASE goodfoodhunting;

CREATE TABLE dishes (
    id SERIAL4 PRIMARY KEY,
    name VARCHAR(100),
    image_url VARCHAR(400)
);

INSERT INTO dishes (name,image_url) VALUES ('birthdaycake','https://cdn.photofunia.com/effects/birthday-cake/icons/medium.jpg');

INSERT INTO dishes (name,image_url) VALUES ('pudding','https://www.bbcgoodfood.com/sites/default/files/styles/recipe/public/recipe_images/recipe-image-legacy-id--1270451_8.jpg?itok=6raGNNjr');

INSERT INTO dishes (name,image_url) VALUES ('icecream','http://img-aws.ehowcdn.com/340x221p/photos.demandstudios.com/getty/article/170/170/87689891.jpg');


create TABLE comments(
    id SERIAL4 PRIMARY KEY,
    content TEXT not null,
    dish_id integer not null,
    foreign key (dish_id) references dishes (id) on delete restrict
);

insert into  comments (content, dish_id) values ('yum',9);

create table users(
    id SERIAL4 PRIMARY KEY,
    email VARCHAR(300),
    password_digest VARCHAR(400)
);

alter table dishes add column user_id integer;

create table likes(
    id SERIAL4 PRIMARY KEY,
    user_id integer,
    dish_id integer
);