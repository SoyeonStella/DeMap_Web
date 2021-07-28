package kr.ac.hansung.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/search")
public class SearchController {
	
	@RequestMapping("/results/places/{keyword}")
	public String viewSearchPlaceResult(@PathVariable String keyword, Model model) {
		System.out.println(keyword);
		model.addAttribute("keyword_h", keyword);
		
		return "search-result";
	}
	
	@RequestMapping("/results/folders/{keyword}")
	public String viewSearchFolderResult(@PathVariable String keyword, Model model) {
		model.addAttribute("keyword", keyword);
		
		return "search-result";
	}

}
