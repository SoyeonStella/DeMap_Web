package kr.ac.hansung.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.ac.hansung.model.Review;

@Repository
@Transactional(readOnly = true, propagation=Propagation.NOT_SUPPORTED)
public class ReviewDao {

	// SessionFactory Bean을 의존성 주입으로 받아온다.
	@Autowired
	private SessionFactory sessionFactory;

	// DB에서 리뷰 리스트를 가져와주는 메서드
	public List<Review> getReviews() {

		Session session = sessionFactory.getCurrentSession();
		// session이 가지고 있는 메서드들로 가져올 수 없어서 hql 쿼리문을 만들어 가져온다
		String hql = "from Review";

		Query<Review> query = session.createQuery(hql, Review.class);
		List<Review> reviewList = query.getResultList();

		return reviewList;

	}

	// DB에서 특정 id에 해당하는 리뷰를 가져다주는 메서드
	public Review getReviewById(int id) {
		// SessionFactory 객체를 받아옴
		Session session = sessionFactory.getCurrentSession();
		// 인자로 받아온 id 값을 바탕으로 해서 Review.class와 매핑되는 테이블에서 id에 해당하는 레코드를 가져옴
		Review review = (Review) session.get(Review.class, id);

		return review;

	}

	// DB에서 특정 장소에 해당하는 리뷰를 가져다주는 메서드
	public List<Review> getReviewsByPlace(String placeId) {
		// SessionFactory 객체를 받아옴
		//Session session = sessionFactory.getCurrentSession();
		
		Session session;

		try {
		    session = sessionFactory.getCurrentSession();
		} catch (HibernateException e) {
		    session = sessionFactory.openSession();
		}

		String hql = "from Review where placeId=:placeId";

		Query<Review> query = session.createQuery(hql, Review.class);
		query.setParameter("placeId", placeId);
		List<Review> reviewByPlaceList = query.getResultList();

		return reviewByPlaceList;

	}

	// DB에 리뷰를 추가해주는 메서드
	public void addReview(Review review) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(review);
		session.flush();

	}

	// 특정 id에 해당하는 리뷰를 DB에서 삭제하는 메서드
	public void deleteReview(Review review) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(review);
		session.flush();

	}

	// DB에 리뷰 내용 수정 사항을 반영해주는 메서드
	public void updateReview(Review review) {

		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(review);
		session.flush();

	}

}
