package kr.ac.hansung.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.ac.hansung.model.ImageFile;
import kr.ac.hansung.model.Review;
import kr.ac.hansung.service.FileUploadService;
import kr.ac.hansung.service.ReviewService;

@RestController
@RequestMapping("/api/reviews")
public class ReviewRestController {
	
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private FileUploadService fileService;
	
	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView createReview(@Valid Review review, BindingResult result, MultipartHttpServletRequest mRequest ){
		
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
		
		int rvId = reviewService.addReview(review);
		System.out.println("리뷰아이디를 제대로 가져오냐 : "+rvId);
		Review tmpRv = reviewService.getReviewById(rvId);
		System.out.println("리뷰를 제대로 가져오냐 : "+tmpRv);
		ImageFile file = new ImageFile();
		file.setReview(tmpRv);
		System.out.println("52줄이다 : "+file);
		
		fileService.multipleFileUpload(mRequest, file);
		
		
		if (mRequest.getHeader("Referer") != null) {
			// 데이터를 유지하고 이전 페이지로 리다이렉트함 
		    mav.setViewName("redirect:" + mRequest.getHeader("Referer"));
		} else {
			mav.setViewName("redirect:/api/results/places/" + review.getPlaceId() + "/details");
		}

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
