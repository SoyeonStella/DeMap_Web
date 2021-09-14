package kr.ac.hansung.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import kr.ac.hansung.model.Review;
import kr.ac.hansung.service.ReviewService;

@RestController
@RequestMapping("/api/reviews")
public class ReviewRestController {
	
	@Autowired
	private ReviewService reviewService;
	
	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView createReview(@Valid Review review, BindingResult result ){
		
		ModelAndView mav = new ModelAndView();
		
		if(result.hasErrors()) {
			System.out.println("======== Web Form data has some Errors =========");
			List<ObjectError> errors = result.getAllErrors();
			for(ObjectError error : errors) {
				System.out.println(error.getDefaultMessage());
			}
			mav.setViewName("redirect:/api/results/places/" + review.getPlaceId() + "/details");
			
			return mav;
		}
		
		reviewService.addReview(review);
		
		mav.setViewName("redirect:/api/results/places/" + review.getPlaceId() + "/details");
		return mav;
	}
	
	/*
	@RequestMapping(value="/{placeId}", method=RequestMethod.GET)
	public ResponseEntity<List<Review>> getReviewsByPlace(@PathVariable(value="placeId") String placeId) {
		
		List<Review> reviewsByPlaceList = reviewService.getReviewsByPlace(placeId);
		
		for(Review review : reviewsByPlaceList) {
			System.out.println(placeId);
			System.out.println(review.getRvText());
		}
		
		return new ResponseEntity<List<Review>>(reviewsByPlaceList, HttpStatus.OK);
		
	}
	*/

}
