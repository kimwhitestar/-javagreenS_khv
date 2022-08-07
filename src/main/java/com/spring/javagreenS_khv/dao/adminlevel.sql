-- drop table adminlevel;
create table adminlevel (
	seq			int(3) not null auto_increment primary key,
	level		char(1) not null default 0,		/* 0:관리자 */
	levelName	varchar(10) not null, 			/* 0:관리자 */
	createDate	timestamp null default now(), /*생성날짜*/
	createUser	varchar(20) null, 				/*생성자*/
	updateDate	timestamp null default now(), 	/*수정날짜*/
	updateUser	varchar(20) null, 				/*수정자*/
	deleteDate	timestamp null default now(), 	/*삭제날짜*/
	deleteUser	varchar(20) null 					/*삭제자*/
);

-- delete from adminlevel;
insert into adminlevel values (default, default, '관리자', default, 'admin', null, null, null, null);
select * from adminlevel;
delete from adminlevel