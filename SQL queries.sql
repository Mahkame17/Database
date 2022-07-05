select max(p.ticket_price) from Playedin as p,Cinema as c where p.cinema_id = c.cinema_id and c.name = "Esteghlal";

select distinct c.name from Playedin as p , Cinema as c where p.cinema_id = c.cinema_id and p.ticket_price > 30 order by c.name asc;

select m.title from Playedin as p , Cinema as c , Actedin as a , Movie as m , Actor where c.cinema_id = p.cinema_id and p.movie_id = m.movie_id and m.movie_id = a.movie_id and a.actor_id = actor.actor_id and actor.first_name = "Leila" and actor.last_name = "Hatami" and c.name = "Ghods" order by m.title asc;

select v.first_name,v.last_name from attended as a , viewer as v where a.viewer_id = v.viewer_id and v.gender = "m" and v.age = ( select max(v.age) from attended as a , viewer as v where a.viewer_id = v.viewer_id and v.gender = "male" );

select avg(v.age) from viewer as v , attended as a  , playedin as p , movie as m where v.viewer_id = a.viewer_id and a.Playedin_id = p.id and p.movie_id = m.movie_id and m.title = "Tenet";

select v.first_name,v.last_name from viewer as v where exists (select * from attended as a  , playedin as p where v.viewer_id = a.viewer_id and a.Playedin_id = p.id and p.ticket_price = 20 and p.date like "%2000%") order by v.last_name,v.first_name asc;

select actor.first_name,actor.last_name from actor where exists (select * from actedin as a , movie as m where actor.actor_id = a.actor_id and m.movie_id = a.movie_id and m.genre = "comedi" ) order by actor.last_name,actor.first_name asc;

select count(a.viewer_id) from attended as a , playedin as p , cinema as c where a.Playedin_id = p.id and p.cinema_id = c.cinema_id and c.name = "Ghods";

select v.last_name,v.first_name from viewer as v where exists ( select * from attended as a,playedin as p where a.viewer_id = v.viewer_id and a.Playedin_id = p.id and p.date like "%2010%" ) order by v.last_name,v.first_name asc;

select v.gender, count(v.viewer_id) from viewer as v, attended as a, playedin as p , movie as m where v.viewer_id = a.viewer_id and a.Playedin_id = p.id and p.movie_id = m.movie_id and m.title = "Drive" group by v.gender;

select m.title from movie as m where exists ( select * from viewer as v, attended as a, playedin as p where v.viewer_id = a.viewer_id and a.Playedin_id = p.id and p.movie_id = m.movie_id and p.date = ( select min(p2.date) from viewer as v2, attended as a2, playedin as p2 where v2.viewer_id = a2.viewer_id and a2.Playedin_id = p2.id ) ) order by m.title asc;

with viewer_t as ( select * from viewer as v,attended as a where v.viewer_id = a.viewer_id) select x.first_name,y.first_name,count(*) from viewer_t as x ,viewer_t as y where x.gender <> y.gender and x.playedin_id = y.playedin_id group by x.first_name,y.first_name

with ticket(count,title) as (
select count(v.viewer_id) as count, m.title from viewer as v, attended as a, playedin as p , movie as m where v.viewer_id = a.viewer_id and a.Playedin_id = p.id and p.movie_id = m.movie_id group by m.title )
select title from ticket 
where ticket.count = (select min(count) from ticket)
or ticket.count = (select max(count) from ticket)
order by title asc;

with view_count as (select sum(a.viewer_id) as tot , m.title as m_name , c.name as c_name from movie as m , playedin as p , attended as a, cinema as c where m.movie_id = p.movie_id and p.id = a.playedin_id and p.cinema_id = c.cinema_id group by p.id) select * from view_count where view_count.tot = ( select max(tot) from view_count) order by m_name asc

select count(*) from actor as aa where (select count(a.movie_id) from actedin as a where a.actor_id = aa.actor_id) >= 2