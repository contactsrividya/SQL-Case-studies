with recursive input1 as
(
  select '2021-07-01' dt ,'1,2,3,14,6' Attendance
  union all 
  select '2021-07-02','1,3,24,25'
  union all 
  select '2021-07-03','1,2,3,4,5,6'
  union all 
  select '2021-07-04','1,2,5'
),
input1res as 
(
  select dt,length(attendance),length(replace(attendance,",","")),
  length(attendance) - length(replace(attendance,",",""))+1  attendance
  from
    input1
),
 input2 as
(
  select 1 ID,'Vishal' Name 
  union all 
  select 2 ID,'Vishal' Name 
  union all 
  select 3 ID,'Vishal' Name 
  union all 
  select 4 ID,'Kaushal' Name 
  union all 
  select 5 ID,'Kaushal' Name 
  union all 
  select 6 ID,'Kaushal' Name 
),
input2res as 
(
  select Name from 
  (select ID,Name,row_number() over(partition by Name order by ID) rownum from input2)a
  order by rownum,Name desc
),
input3 as 
(
  select 1 ID,'2019-07-01' dt,100 amount 
  union all 
  select 2 ID,'2019-07-01' dt,120 amount 
  union all 
  select 3 ID,'2019-07-01' dt,110 amount 
  union all 
  select 4 ID,'2019-07-02' dt,160 amount 
  union all 
  select 5 ID,'2019-07-02' dt,700 amount 
  union all 
  select 6 ID,'2019-07-03' dt,200 amount 
  union all 
  select 7 ID,'2019-07-03' dt,50 amount 
),
input3_sum as
(
    select 
      dt,sum(amount) amount 
    from
      input3
    group by 1
),
input_lag as
(
  select
    dt,amount,
    case  when (lag(amount) over (order by dt)) is not null
                then (lag(amount) over (order by dt)) - amount
        else amount
    end lagamount
    from input3_sum
),
input_lag_res as
(
    select 
        dt,
        case when lag(lagamount) over(order by dt) is null then amount 
            when lag(lagamount) over(order by dt) > 0 then amount - lag(lagamount) over(order by dt) 
            else  amount + lag(lagamount) over(order by dt) 
        end as amount 
    from 
    input_lag
),
Teams as 
(
  select 'India' country union all 
  select 'Australia' union all 
  select 'England' union all 
  select 'NewZealand' 
)
,teamsresult as 
(
  select 
    A.country,B.country
  from 
    Teams A , Teams B 
    where A.country < B.country
  order by 1
),
empsal as 
(
  select 1 ID,'vishal' Fname,'kaushal' Lname,8000 salary
  union all 
  select 2,'Akshay','kumar',9000
  union all 
  select 3,'zishan','khan',3000
  union all 
  select 4,'khan','zishan', 5000
  union all 
  select 5,'katrina','kaif',10000
  union all 
  select 6,'kaushal','vishal',4000
)
, empdata as 
(
  select 
      a1.id a1id,a2.id a2id,
      case when a2.salary is null then a1.id 
           when  a1.id< a2.id then a1.id else a2.id  end as minid,
      a1.Fname,a1.salary alsalary,a2.salary a2salary,a1.Lname,a1.Salary+ coalesce(a2.salary,0) newsal
  from
    empsal a1 left join empsal a2
    on a2.Lname = a1.Fname and a2.Fname = a1.Lname 
)
,resemp  as (select a1id id,Fname,Lname,newsal Salary from empdata where a1id = minid)
 ,genid1 as 
(
    select 1 id 
    union all 
    select id+1 id  from genid1 where id+1 < 11
),
genid as 
(
  select id,row_number() over(order by id) rownum 
  from genid1
),
c1 as 
(
  select a.id column1,row_number() over(order by a.id) rownum
  from 
    genid a where rownum<=(select count(*) div 2 from genid)
),
c2 as
(
  select a.id column2,row_number() over(order by a.id desc) rownum
  from 
    genid a where rownum>(select count(*) div 2 from genid)
),
res as 
(
  select c1.column1,c2.column2 
  from 
    c2 left join c1
    on c1.rownum=c2.rownum
)
, Airport as 
(
  select 'DELHI'  source,'MUMBAI' destination
  union all 
  select 'MUMBAI' ,'DELHI' 
  union all 
  select 'DELHI' ,'PATNA' 
  union all 
  select 'BANGALORE' ,'PUNE' 
  union all 
  select 'PUNE' ,'BANGALORE' 
  union all 
  select 'CHENNAI' ,'CHANDIGARH'
  union all 
  select 'PUNE' ,'MUMBAI' 
  union all 
  select 'HYDERABAD' ,'GOA' 
  union all 
  select 'GOA','HYDERABAD'
)
,mthd1 as
(
  select distinct 
     case when source <destination then source else destination end as source ,
    case when source >destination then source else destination end as destination 
  from Airport
)
,mthd2 as 
(
  select distinct 
    case when b.source is null then a.source  
         when a.source <a.destination then a.source else a.destination
    end as source, 
    case when b.destination is null then a.destination 
         when a.source > a.destination then a.destination else a.source 
    end as destination 
  from 
     Airport a left join Airport b 
    on b.destination = a.source and b.source=a.destination 
)
select * from mthd1