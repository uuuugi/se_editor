create database seEditor;

show databases;

use seEditor;

create table user -- 회원정보 테이블 생성
(
user_id varchar(20) not null unique, -- pk/ 회원 id
user_pw varchar(20) not null, -- 회원 pw
user_name varchar(20) not null, -- 회원 이름
user_email varchar(30) not null, -- 회원 email
user_introduce varchar(3000) not null default '자기소개 없음', -- 회원 자기소개 초기값 '자기소개없음'
user_authority varchar(30) not null default 'user', -- 회원 권한 초기값 'user'
primary key(user_id) -- pk는 user_id 사용
);

SHOW GLOBAL VARIABLES LIKE 'local_infile'; -- local_infile 설정 확인
SET GLOBAL local_infile = 'ON'; -- on으로 변경
SHOW GLOBAL VARIABLES LIKE 'local_infile'; -- 설정이 on으로 변경되었는지 확인

create table workspaceUserData -- workspaceUserdata 생성
( -- workspace를 개인별로 나누기 위함
workspaceId varchar(255) not null unique, -- workspaceUser 정보 / pk
primary key(workspaceId),
constraint fk_user2workspaceUserData foreign key (workspaceId) references user (user_id) on update cascade on delete cascade
);

create table workspace -- workspace table 생성 
( -- workspace 유저들의 코드를 모아두는 곳
user_id varchar(20) not null, -- 유니크값이 아니어서 여러개 생성이 가능 / workspaceUserData table에 workspaceId 와 user_id 가 일치해야만 생성 가능 
num int not null auto_increment unique, -- 코드의 번호
codeName varchar(30) not null, -- 사용자가 저장한 코드의 이름
codeType varchar(30) not null, -- code type ex) c++ or java
code text(100000) not null, -- code 내용
constraint fk_workspaceUserData2workspace foreign key (user_id) references workspaceUserData (WorkspaceId) on update cascade on delete cascade
);

create table board( -- 게시판 테이블
id varchar(20) not null,
name varchar(20)  not null,
text varchar(10000),
star int default 0,
postNum int auto_increment unique,
constraint fk_user2board foreign key (id) references user (user_id) on update cascade on delete cascade
);

create table comment( -- 댓글 테이블
id varchar(20) not null,
text varchar(300) not null,
postNum int,
commentNum int not null auto_increment unique,
constraint fk_board2comment foreign key(postNum) references board (postNum) on update cascade on delete cascade,
constraint fk_comment2user foreign key(id) references user(user_id) on update cascade on delete cascade
);

create table comment2(
id varchar(20) not null,
text varchar(300) not null,
commentNum int not null,
comment2Num int not null auto_increment unique,
constraint fi_comment22user foreign key(id) references user(user_id) on update cascade on delete cascade,
constraint fk_comment22comment foreign key(commentNum) references comment (commentNum) on update cascade on delete cascade
);

create table star(
id varchar(20) not null,
postNum int not null,
constraint fk_starId2userId foreign key(id) references user(user_id) on update cascade on delete cascade,
constraint fk_star2postNum foreign key(postNum) references board(postNum) on update cascade on delete cascade
);

create table inquiry(
id varchar(20) not null,
inquiryNum int not null auto_increment unique,
title varchar(20) not null,
text varchar(10000) not null,
constraint fk_inquiry2User foreign key(id) references user(user_id) on update cascade on delete cascade
);

create table inquiryComment(
id varchar(20) not null,
inquiryNum int not null,
title varchar(20) not null,
text varchar(10000) not null,
constraint fk_inquiryComment2inquiry foreign key(inquiryNum) references inquiry(inquiryNum) on update cascade on delete cascade,
constraint fk_inquiryComment2User foreign key(id) references user(user_id) on update cascade on delete cascade
);

-- insert
insert into user -- user에 insert
values ('id2', 'password', 'name1', 'email1', 'introduce1', 'user');

insert into workspaceUserData  -- workspaceUserData 값 add
value('id2');

insert into workspace (user_id, codeName, codeType, code)-- workspace 값 add / num값은 auto
values ('id1','codename3', 'codetype1', 'text3');

insert into board(id, name, text) -- 게시판에 insert
values('id1','test16', 'text2');

insert into comment(id, text, num) -- comment 에 insert
values('id2', 'comment', 1);


-- delete
set sql_safe_updates=0; -- workbench에서 delete를 막아둠 workspace del이 오류가 뜰 경우 실행

delete from user -- 회원탈퇴시 삭제 / workspaceUserdata, workscpae 테이블도 같이 삭제됨
where user_id = 'aa';

delete from workspace -- workspace에 있는 내용만 선택 삭제 / code삭제
where codeName='testc';

delete from workspace where user_id='id1' and codeName='test c';

-- drop
drop table user; 
drop table workspaceUserData;
drop table workspace;
drop table board;
drop table comment;
drop table star;
drop table comment2;

-- user및 IDE관련 select 
select * from user;
select * from workspaceUserData;
select * from workspace; 
select user_name, user_Email, user_introduce from user where user_id='id1';
select user_id from user where user_name='name1' and user_email='email1';

select codeName, codeType from user -- id값을 통해 작성한 코드 목록 select 
left join workspaceUserData on user.user_id=workspaceUserData.workspaceId
left join workspace on workspaceUserData.workspaceId = workspace.user_id
where user.user_id='id1'; 

select codeName, codeType, code from user -- id값과 codeName을 이용하여 codeName, codeType, code selct
left join workspaceUserData on user.user_id=workspaceUserData.workspaceId
left join workspace on workspaceUserData.workspaceId = workspace.user_id
where user.user_id='id1' and workspace.codeName= 'codename2'; 

-- 게시판 관련 select 
select * from board;
select * from comment;
select * from comment2;
select * from star;
select name from board where id='id'; -- id값으로 작성글 검색
select name from board where name='name'; -- 글 이름으로 글 검색
