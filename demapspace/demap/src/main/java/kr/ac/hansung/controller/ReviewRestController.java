package kr.ac.hansung.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import kr.ac.hansung.model.Review;
import kr.ac.hansung.service.ReviewService;

@RestController
@RequestMapping("/api/reviews")
public class ReviewRestController {
	
	@Autowired
	private ReviewService reviewService;
	
	@RequestMapping(value="/{placeId}", method=RequestMethod.GET)
	public ResponseEntity<List<Review>> getReviewsByPlace(@PathVariable(value="placeId") String placeId) {
		
		List<Review> reviewsByPlaceList = reviewService.getReviewsByPlace(placeId);
		
		for(Review review : reviewsByPlaceList) {
			System.out.println(placeId);
			System.out.println(review.getRvText());
		}
		
		return new ResponseEntity<List<Review>>(reviewsByPlaceList, HttpStatus.OK);
		
	}

}
