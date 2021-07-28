package kr.ac.hansung.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController // @Controller + @ResponseBody
@RequestMapping("/api/results")
public class SearchRestController {
	
	@RequestMapping(value="/places/{keyword}", method = RequestMethod.GET)
	public ResponseEntity<Void> viewSearchPlaceResult(@PathVariable(value = "keyword") String keyword) {
		
		System.out.println("키워드 : "+keyword);
		
		return new ResponseEntity<Void>(HttpStatus.OK);
		
	}
	
	/*
	@RequestMapping(value="/places/{keyword}", method = RequestMethod.GET)
	public ModelAndView viewSearchPlaceResult(@PathVariable(value = "keyword") String keyword) {
		
		System.out.println(keyword);
		
		ModelAndView mav = new ModelAndView();
        mav.setViewName("search-result");
        mav.addObject("keyword", keyword);
        return mav;
		
	}
	*/
	
	@RequestMapping(value="/folders/{keyword}", method = RequestMethod.GET)
	public ModelAndView viewSearchFolderResult(@PathVariable(value = "keyword") String keyword) {
		
		System.out.println(keyword);
		
		ModelAndView mav = new ModelAndView();
        mav.setViewName("search-result");
        mav.addObject("keyword", keyword);
        return mav;
		
	}

}
