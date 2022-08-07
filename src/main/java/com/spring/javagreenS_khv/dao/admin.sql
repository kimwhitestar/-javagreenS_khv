show tables;
--drop table admin;
create table admin (
	seq 		int(5) auto_increment primary key, 
	level		char(1) not null, 				/*0:관리자*/
	memberId	int(8) not null, 			/*회사사원아이디(fk 사원테이블.사원번호)*/
	memberName	varchar(20) not null,		/*회사사원성명*/
	gender		char(1) not null,				/*성별*/
	juminNo 	varchar(14) not null,			/*주민등록번호*/
	birthday 	date not null,					/*생일*/
	tel			varchar(13)	not null,			/*사무실 전화번호(02-1234-1234)*/
	hp			varchar(14)	not null,			/*핸드폰번호(010-1234-1234)*/
	email		varchar(50) not null,			/*이메일*/
	postcode	varchar(5) not null,		/*우편번호*/
	roadAddr	varchar(200) not null,		/*도로명주소*/
	extraAddr	varchar(200) null,			/*지번주소*/
	detailAddr	varchar(200) not null,		/*상세주소*/
	content		varchar(500) not null,			/*자기소개*/
	photo		varchar(100) not null, 			/*관리자사진*/
	hireDate	date not null,				/*입사날짜*/
	resignDate	date null,					/*퇴사날짜*/
	createDate	timestamp null default now(), 	/*생성날짜*/
	createUser	varchar(20) null, 				/*생성자*/
	updateDate	timestamp null default now(), 	/*수정날짜*/
	updateUser	varchar(20) null, 				/*수정자*/
	deleteDate	timestamp null default now(), 	/*삭제날짜*/
	deleteUser	varchar(20) null 				/*삭제자*/
);

desc admin;

insert into admin values (default, 0, 88888888, '박김이', 'M', '881225-1000000', '1988-12-25', '02-1234-1234', '010-1234-1234', 'admin@moolyu-info.com', 
'03182', '서울특별시 종로구 새문안로 79', '', '아름다운빌딩 1F', '관리자입니다', 'noimage.jpg', '2000-08-01', null, '2000-08-01 10:00:00.0', 'manager', null, null, null, null);

select * from admin;
select *, timestampdiff(day, lastDate, now()) as overDaysUserDel from admin order by idx desc;

/*
--datediff 함수 : 날짜 차이
--datediff(날짜1, 날짜2) : 날짜1 - 날짜2

select datediff('2022-04-25', '2022-03-01');
--단위 : second, minute, hour, day, month, year
--timestampdiff 함수 : 날짜,시간 차이
--timestampdiff(단위, 날짜1, 날짜2) : 날짜2(2022-04-25 12:31:50) - 날짜1(2022-03-01 00:00:00)
select timestampdiff(day, '2022-03-01 10:10:10', '2022-04-25 12:31:50');
select 
	(select timestampdiff(year, '2022-03-01 10:10:10', '2022-04-25 12:31:50')) year,
	(select timestampdiff(month, '2022-03-01 10:10:10', '2022-04-25 12:31:50')) month,
	(select timestampdiff(day, '2022-03-01 10:10:10', '2022-04-25 12:31:50')) day,
	(select timestampdiff(minute, '2022-03-01 10:10:10', '2022-04-25 12:31:50')) minute,
	(select timestampdiff(second, '2022-03-01 10:10:10', '2022-04-25 12:31:50')) second
*/

select * from member where date_sub(now(), interval 1 week) <= startDate and startDate <= now() 
select * from member where userInfo = '공개';
select *, timestampdiff(day, lastDate, now()) as overDaysUserDel from member;
select mid from member where email = 'pkl1@naver.com' and pwd = '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4' 

select *, (select levelName from memberlevel where level = member.level) as levelName from member 
where mid = 'pkl1' and pwd = '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4' and userDel = 'No'
