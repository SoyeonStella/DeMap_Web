package kr.ac.hansung.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Place {
	
	private int id;
	private String address_name;
	private String category_group_code;
	private String category_group_name;
	private String category_name;
	private String phone;
	private String place_name;
	private String road_address_name;
	private double x;
	private double y;

}
