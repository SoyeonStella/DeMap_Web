package kr.ac.hansung.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import kr.ac.hansung.model.ImageFile;

@Repository
@Transactional
public class FileDao {
	@Autowired
	private SessionFactory sessionFactory;

	// DB에서 파일 리스트를 가져와주는 메서드
	public List<ImageFile> getFiles() {

		Session session = sessionFactory.getCurrentSession();
		// session이 가지고 있는 메서드들로 가져올 수 없어서 hql 쿼리문을 만들어 가져온다
		String hql = "from File";

		Query<ImageFile> query = session.createQuery(hql, ImageFile.class);
		List<ImageFile> fileList = query.getResultList();

		return fileList;

	}

	// DB에서 특정 id에 해당하는 파일을 가져다주는 메서드
	public ImageFile getFileById(int id) {
		// SessionFactory 객체를 받아옴
		Session session = sessionFactory.getCurrentSession();
		// 인자로 받아온 id 값을 바탕으로 해서 Review.class와 매핑되는 테이블에서 id에 해당하는 레코드를 가져옴
		ImageFile file = (ImageFile) session.get(ImageFile.class, id);

		return file;

	}

	// DB에서 특정 장소리뷰에 해당하는 파일을 가져다주는 메서드
	public List<ImageFile> getFilesByReview(int rvId) {

		Session session;

		try {
			session = sessionFactory.getCurrentSession();
		} catch (HibernateException e) {
			session = sessionFactory.openSession();
		}

		String hql = "from File where review_id=:review_Id";

		Query<ImageFile> query = session.createQuery(hql, ImageFile.class);
		query.setParameter("review_id", rvId);
		List<ImageFile> fileByReviewList = query.getResultList();

		return fileByReviewList;

	}

	// DB에 파일을 추가해주는 메서드
	public void addFile(ImageFile file) {
		Session session;

		try {
			session = sessionFactory.getCurrentSession();
		} catch (HibernateException e) {
			session = sessionFactory.openSession();
		}

		session.saveOrUpdate(file);
		// session.flush();

	}

	// 특정 id에 해당하는 파일을 DB에서 삭제하는 메서드
	public void deleteFile(ImageFile file) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(file);
		session.flush();

	}

	// DB에 파일 내용 수정 사항을 반영해주는 메서드
	public void updateFile(ImageFile file) {

		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(file);
		session.flush();

	}
}
