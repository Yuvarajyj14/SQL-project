-- Project details  --
	-- data set
	-- output result
	-- DQL (5)
    -- Stored Procedure
    -- Trigger
    
    create database yuvi;
    
   use yuvi;

  
  -- DQL

select * from sales_transaction;

select * from sales_transaction where row_id = 6567;
select * from sales_transaction where customer_name like'g%';
select * from sales_transaction where  customer_name like 'c________e';
select * from sales_transaction where ship_mode like 'first_class';
select * from sales_transaction where row_id not like 7485;
select * from sales_transaction where customer_name not in ('darrin van huff');


select distinct country from sales_transaction;

select city, region, sum(quantity) as total_quantity from sales_transaction group by city, region ;

select city , count(*) as total , avg(profit) as average_profit from sales_transaction
group by city having average_profit >= 69 order by average_profit ;


select city, state , count(*) as total ,sum(profit) as profit from sales_transaction group by
city , state  order by profit desc; 

select city, count(*) as total , sum(profit) as profit   from sales_transaction group by city 
having profit >= 20000 order by profit desc;
    
    
    
    select * from employee;
    select * from employee_details;
    create table employee (emp_id int primary key , emp_name text , qualification varchar(60),
                          phn_number bigint unique , working_hrs int );
      insert into employee values ( 110, 'naga', 'B.Tech', 2010 , 7);     
      
      update employee set working_hrs = 8 where emp_id = 106;
        
        
      create table employee_details (emp_id int primary key , emp_name text ,
                          salary decimal(10,2), experience_yrs int);
		insert into employee_details values (112 , 'jp',25000.00,1), ( 113, 'udhaya', 24000.00 , 1),                     
          ( 102, 'mani', 35000.15 , 2),
          ( 103, 'sheru', 32000.00 , 2),
          ( 104, 'mathi', 25000.90 , 1),
          ( 105, 'vicky', 21000.80 , 1),
          ( 106, 'deepak', 20000.00 , 1);
          
    -- windows function
    
    select emp_id, emp_name,salary, 
        row_number() over(order by salary desc) as high_pay from employee_details;
    
    select emp_id, emp_name , salary , row_number() over( partition by experience_yrs order by emp_id) as row_id 
               from employee_details;
    
    select emp_id, emp_name, salary,
          row_number() over(order by salary desc) as high_pay,
          rank() over(order by salary desc) as high_pays,
          dense_rank()over(order by salary desc) as high_payer
          from employee_details;
          
   -- joins       
    
select * from employee inner join employee_details on employee.emp_id = employee_details.emp_id;
      
select * from employee left join employee_details on employee.emp_id = employee_details.emp_id;                         
                          
select * from employee right join employee_details on employee.emp_id = employee_details.emp_id;  

select employee.emp_name , employee.phn_number ,employee_details.salary from employee left join employee_details on 
employee.emp_id = employee_details.emp_id;   

-- window function

  


-- store procedures                   
                          
       call profit;
       call average_profit;
       
  -- triggers
  select * from employee;
  select * from employee_details;
  
  insert into employee values (321, 'tharun', 'B.tech', 3002,7);
  delete from employee where emp_id = 321;
  
  delimiter //
  create trigger before_insert
  before insert on employee for each row
  begin
  if new.qualification = 'B.tech' then set
  new.qualification = 'engineering';
  end if;
  end//
  
  show triggers;
  drop trigger before_insert;
  
  create table employee_index (emp_id int primary key , emp_name text , qualification varchar(60),
                          phn_number bigint unique , working_hrs int );
   
   insert into employee values ( 241, 'kc', 'B.Tech', 2018 , 7); 
   
   select * from employee_index;
   
  
	delimiter //
    create trigger after_insert
    after insert on employee for each row
    begin
    insert into employee_index values (new.emp_id,new.emp_name,new.qualification,new.phn_number,new.working_hrs);
    end //
    
    
    create table backup_records (user text , statuses text);
    
    insert into employee_details values ( 241, 'kc', 18000, 1 );
    
    select * from backup_records;
    
    delimiter //
    create trigger after_insert_edit
    after insert on employee_details for each row
    begin 
    insert into backup_records values (current_user(),concat('inserted for', new.emp_id,'  ',
    new.emp_name,'  ', now()));
    end //

    
    update employee_details set salary = '40000' where emp_id = 103;
    
    delimiter //
   create trigger Before_update
   before update on employee_details for each row
   begin
    if new.salary <> old.salary then 
	signal sqlstate '45000'
	set message_text= "You dont have an access";
end if;  
end //

-- before delete

delimiter //
create trigger before_delete
before delete on employee for each row
begin
    signal sqlstate '45000'
    set message_text = 'you dont have permission to delete';
    end //

drop trigger before_delete;
show triggers;

delete from employee where emp_id = 241;

delimiter //
create trigger after_delete
after delete on employee for each row
begin
insert into backup_records values (current_user() , concat( 'Deleted row','    ',old.emp_id,'   ',
                   old.emp_name,'   ',now()));
   end //                

select * from backup_records;








  
  
  
  
  
  
  
  
  
  
  
  
  
  
       
       
                          
                          
                          
    