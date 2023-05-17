create database pro;
use pro;
create table Note(
note_id char(4) primary key,
note_title varchar(20) not null,
note_content text(1000) not null,
note_status char(4) not null,
note_creation_date datetime not null
);
 create table Category(
 category_id char(4) primary key,
 category_name varchar(20) not null,
 category_descr varchar(200) not null, 
 category_creation_date datetime not null, 
 category_creator varchar(20) not null 
 );
 
 create table Reminder(
 reminder_id char(4) primary key, 
 reminder_name varchar(20) not null, 
 reminder_descr varchar(100) not null,
 reminder_type varchar(20),
 reminder_creation_date datetime not null,
 reminder_creator varchar(20) not null
 );
  create table User(
  user_id char(4) primary key, 
  user_name varchar(20) not null, 
  user_added_date datetime not null, 
  user_password varchar(15) not null check(char_length(user_password)>=4), 
  user_mobile varchar(10) not null check ( char_length(user_mobile)=10)
  );
   --  alter table user modify column user_password varchar(20) not null check(char_length(user_password)>=5 ); 
  create table UserNote(
   usernote_id char(4) not null, 
   user_id char(4) not null,
   note_id char(4) not null,
   primary key (usernote_id),
   Foreign Key (user_id) references User (user_id) , 
   Foreign Key (note_id) references Note (note_id)
   );
   
   create table NoteReminder(
   notereminder_id char(4) primary key, 
   note_id char(4) not null, 
   reminder_id char(4) not null,
   foreign key(note_id) references Note (note_id),
   foreign key(reminder_id) references Reminder (reminder_id)
   );
   
   create table NoteCategory(
   notecategory_id char(4) primary key, 
   note_id char(4) not null, 
   category_id char(4) not null,
   foreign key(note_id) references Note(note_id),
   foreign key(category_id) references Category(category_id)
   );
   
   
   
   
   
   
   use project;
   
   select * from note;
   
      insert into Note values('1','pubg','i play pubg 6 hours a day','pass',curdate());
   insert into Note values('2','cod','i play cod once a week','pass',now());
   insert into Note values('3','freefire','i dont play this game much','fail',curdate());
   
   insert into Category values('4', 'horror','Amazing',curdate(),'balaji');
   insert into Category values('5','thrilling','thrill',curdate(),'vinay');
   insert into Category values('6','romance','cool',curdate(),'aditya');
   
   insert into Reminder values('7','arjun','active',null,now(),'sara');
   insert into Reminder values('8','priya','comedy','good',now(),'carlo');
   insert into Reminder values('9','allu',' null',null,now(),'obama');
   select * from Reminder;
   
   insert into User values('10','binod',curdate(),'11111','9999999999');
   insert into User values('11','agent',now(),'222222','8888888888');
   insert into User values('12','mortal',now(),'222222','0000000000');
   select * from user;
   insert into UserNote values('13','10','1');
   insert into UserNote values('14','12','3');
   insert into UserNote values('15','11','2');
   
   insert into NoteReminder values('16','1','7');
   insert into NoteReminder values('17','2','8');
   insert into NoteReminder values('18','3','9');
   
   insert into NoteCategory values('19','2','4');
   insert into NoteCategory values('20','2','5');
   insert into NoteCategory values('21','3','6');
   
   
   
    -- Fetch the row from User table based on Id and Password.
   select * from User where user_id='11' and user_password='222222';
   
   
   -- Fetch all the rows from Note table based on the field note_creation_date.
   select * from Note where note_creation_date=curdate();
   
   
   
    -- Fetch all the Categories created after the particular Date.
       select * from Category where category_creation_date>="2019-03-08";
       
       
       
         -- Fetch all the Note ID from UserNote table for a given User.
       select note_id from UserNote where user_id='10';
       
       
        -- Write Update query to modify particular Note for the given note Id.
        update Note set note_status='pass' where note_id='3';
        
        select * from note;
         -- Fetch all the Notes from the Note table by a particular User.
         select * from Note where note_id = (select note_id from UserNote where user_id = '11');


   -- Fetch all the Notes from the Note table for a particular Category.
         select * from Note where note_id = (select note_id from NoteCategory where category_id = '4');
         
         
         -- Fetch all the reminder details for a given note id.
       select * from Reminder where reminder_id = (select reminder_id from NoteReminder where note_id = '3');
       
       
       	-- Fetch the reminder details for a given reminder id.
        select * from Reminder where reminder_id='9';
        
        
        
        
         -- Write a query to create a new Note from particular User (Use Note and UserNote tables - insert statement).
  delimiter //
   create trigger notetgr1
   after insert on note for each row
   begin
   insert into UserNote values('333','10',new.note_id);
   end
   //  delimiter ;
        -- Write a query to create a new Note from particular User to particular Category(Use Note and NoteCategory tables - insert statement)

   delimiter //
   create trigger notetgr
   after insert on note for each row
   begin
   insert into UserNote values('999','10',new.note_id);
   insert into NoteCategory values('324',new.note_id,'6');
   end
   //  delimiter ;
   
   
   
   
   
      
   insert into Note values('325','quiet','be calm','fail',curdate());
   select * from Note;
   select * from UserNote;
   
   -- insert into Note values('326','action','thriller','fail',curdate());
   select * from Note;
   select * from UserNote;
   select * from NoteCategory;
   
   
   
   
   
   
    -- Write a query to set a reminder for a particular note (Use Reminder and NoteReminder tables - insert statement)
  
  delimiter //
   create trigger remindertgr
   after insert  on reminder for each row
   begin
   insert into NoteReminder values('327','3',new.reminder_id);
   end;
   //
   
   insert into Reminder values('328','cool','good','single',curdate(),'sesi');
   select * from Reminder;
   select * from Notereminder;
   
   
   
   
   
     -- Write a query to delete particular Note from particular Category(Note and NoteCategory tables - delete statement)
  
  delimiter //
  create trigger deleteNote
  before delete on Note for each row
  begin
  delete from NoteCategory
  where note_id=old.note_id;
  end;
  //
  select * from note;
  delete from Note where note_id='325';
  
  
    -- Write a query to delete particular Note from particular Category(Note and NoteCategory tables - delete statement)
  
  delimiter //
  create trigger deleteNote
  before delete on Note for each row
  begin
  delete from NoteCategory
  where note_id=old.note_id;
  end;
  //
  delete from Note where note_id='2'
  
  
  
   -- Create a trigger to delete all matching records from UserNote, NoteReminder and NoteCategory table when :
-- 1. A particular note is deleted from Note table (all the matching records from UserNote, NoteReminder and NoteCategory should be removed automatically)

  delimiter //
 CREATE trigger deletecattrg
 before delete on Note for each row
 begin
 delete from NoteCategory
 where note_id = old.note_id;
 delete from NoteReminder
 where note_id = old.note_id;
 delete from UserNote
 where note_id = old.note_id;
 end;
 //
delete from Note where note_id = '3';
   
   
   
   
   -- 2. A particular user is deleted from User table (all the matching notes should be removed automatically)
  
delimiter //
CREATE trigger deleteUser
before delete on User for each row
begin
delete from UserNote
where user_id = old.user_id;
end;
//
delete from User
where user_id = '11'
   
   
   
   
 
   
        