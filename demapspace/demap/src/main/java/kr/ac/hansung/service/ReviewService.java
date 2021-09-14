package kr.ac.hansung.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.hansung.dao.ReviewDao;
import kr.ac.hansung.model.Review;

@Service
public class ReviewService {
	
	@Autowired
	private ReviewDao reviewDao; // ReviewService는 Autowired로 Dao 의존성 주입하여 받는다.

	public List<Review> getReviews() {
		// dao를 활용해서 getProducts()를 호출한다.
		return reviewDao.getReviews();
	}

	public Review getReviewById(int id) {
		return reviewDao.getReviewById(id);
	}
	
	public List<Review> getReviewsByPlace(int placeId) {
		return reviewDao.getReviewsByPlace(placeId);
	}

	public void addReview(Review review) {

		reviewDao.addReview(review);
	}

	public void deleteReview(Review review) {

		reviewDao.deleteReview(review);
	}

	public void updateReview(Review review) {
		reviewDao.updateReview(review);
	}

}
