package kr.ac.hansung.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Place {
	
	int id;
	String address_name;
	String category_group_code;
	String category_group_name;
	String category_name;
	String phone;
	String place_name;
	String road_address_name;
	double x;
	double y;

}
