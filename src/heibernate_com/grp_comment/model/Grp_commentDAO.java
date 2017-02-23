package heibernate_com.grp_comment.model;
/*
 Hibernate is providing a factory.getCurrentSession() method for retrieving the current session. A
 new session is opened for the first time of calling this method, and closed when the transaction is
 finished, no matter commit or rollback. But what does it mean by the “current session”? We need to
 tell Hibernate that it should be the session bound with the current thread.
 <hibernate-configuration>
 <session-factory>
 ...
 <property name="current_session_context_class">thread</property>
 ...
 </session-factory>
 </hibernate-configuration>
 */
import org.hibernate.*;
import hibernate.util.HibernateUtil;
import java.util.*;
public class Grp_commentDAO implements Grp_comment_interface {
	private static final String GET_ALL_STMT = "from Grp_commentVO order by grpComment_Id";
	@Override
	public void insert(Grp_commentVO grp_commentVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(grp_commentVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}
	@Override
	public void update(Grp_commentVO grp_commentVO) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(grp_commentVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}
	@Override
	public void delete(String grpComment_Id) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
//        【此時多方(宜)可採用HQL刪除】
//			Query query = session.createQuery("delete Grp_commentVO where grpComment_Id=?");
//			query.setParameter(0, grpComment_Id);
//			//System.out.println("刪除的筆數=" + query.executeUpdate());
//        【或此時多方(也)可採用去除關聯關係後，再刪除的方式】
			Grp_commentVO grp_commentVO = new Grp_commentVO();
			grp_commentVO.setGrpComment_Id(grpComment_Id);
			session.delete(grp_commentVO);
//        【此時多方不可(不宜)採用cascade聯級刪除】
//        【多方grp_comment2.hbm.xml如果設為 cascade="all"或 cascade="delete"將會刪除所有相關資料-包括所屬部門與同部門的其它員工將會一併被刪除】
//			Grp_commentVO grp_commentVO = (Grp_commentVO) session.get(Grp_commentVO.class, grpComment_Id);
//			session.delete(grp_commentVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
	}
	@Override
	public Grp_commentVO findByPrimaryKey(String grpComment_Id) {
		Grp_commentVO grp_commentVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			grp_commentVO = (Grp_commentVO) session.get(Grp_commentVO.class, grpComment_Id);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return grp_commentVO;
	}
	@Override
	public List<Grp_commentVO> getAll() {
		List<Grp_commentVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(GET_ALL_STMT);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}
}