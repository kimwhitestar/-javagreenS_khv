show tables;
-- drop table adminLogin;
-- delete from adminLogin;
create table adminLogin (
	idx 		int not null auto_increment primary key,			
	loginId		varchar(20) not null, 			/*관리자 아이디*/
	loginPwd 	varchar(100) null,				/*비밀번호(암호화)*/
	level		char(1) null, 					/*0:관리자*/
	loginDate	timestamp null default now(), 	/*로그인 날짜*/
	loginUser	varchar(20) null, 				/*로그인 아이디*/
	logoutDate	timestamp null default now(), 	/*로그아웃 날짜*/
	logoutUser	varchar(20) null, 				/*로그아웃 아이디*/
	createDate	timestamp null default now(), 	/*생성날짜*/
	createUser	varchar(20) null, 				/*생성자*/
	updateDate	timestamp null default now(), 	/*수정날짜*/
	updateUser	varchar(20) null, 				/*수정자*/
	deleteDate	timestamp null default now(), 	/*삭제날짜*/
	deleteUser	varchar(20) null 				/*삭제자*/
);

desc adminLogin;

insert into adminLogin values (default, 'admin', 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855', 0, 
default, 'admin', null, null, default, 'admin', null, null, null, null);

select *, (select ifnull(levelName, '') from adminlevel where level = this.level) as levelName from adminLogin as this where deleteDate is null order by idx desc;
select * from adminLogin;
update adminLogin set loginPwd = 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855' where loginId = 'admin'
















