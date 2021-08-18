package kr.ac.hansung.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import kr.ac.hansung.model.Place;

@RestController // @Controller + @ResponseBody
@RequestMapping("/api/results")
public class SearchRestController {
	
	/*
	@RequestMapping(value="/places/{keyword}", method = RequestMethod.GET)
	public ResponseEntity<Void> viewSearchPlaceResult(@PathVariable(value = "keyword") String keyword) {
		
		System.out.println("키워드 : "+keyword);
		
		return new ResponseEntity<Void>(HttpStatus.OK);
		
	}
	*/
	

	@RequestMapping(value="/places/{keyword}", method = RequestMethod.GET)
	public ModelAndView viewSearchPlaceResult(@PathVariable(value = "keyword") String keyword) {
		
		System.out.println(keyword);
		//String selected = "";
		
		ModelAndView mav = new ModelAndView();
        mav.setViewName("search-result");
        mav.addObject("keyword", keyword);
        mav.addObject("selected","place");
        
        return mav;
		
	}
	
	@RequestMapping(value="/folders/{keyword}", method = RequestMethod.GET)
	public ModelAndView viewSearchFolderResult(@PathVariable(value = "keyword") String keyword) {
		
		System.out.println(keyword);
		
		ModelAndView mav = new ModelAndView();
        mav.setViewName("search-result");
        mav.addObject("keyword", keyword);
        mav.addObject("selected","folder");
    
        return mav;
		
	}
	
	@RequestMapping(value="/places/{id}", method = RequestMethod.POST)
	public ModelAndView viewPlaceDetail(@PathVariable(value = "id") String id, Place place) {
		
		System.out.println(id);
		System.out.println(place.getPlace_name());
			
		ModelAndView mav = new ModelAndView();
        mav.setViewName("detail-place");
        mav.addObject("place", place);
        
        return mav;
	}
		

}
