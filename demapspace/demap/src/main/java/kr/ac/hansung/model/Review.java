package kr.ac.hansung.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@Table(name="review")
public class Review implements Serializable{
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="review_id", nullable=false, updatable=false, unique=true)
	private int id;
	
	//@ManyToOne
	//@JoinColumn(name="userId")
	//@JsonIgnore
	//private User user;
	private String userId;
	
	@NotNull
	private int placeId;
	
	@Min(value=1, message="The review score must no be less than one")
	private int rating;
	
	private String rvText;
	
	@Transient
	private List<MultipartFile> rvImgList = new ArrayList<MultipartFile>();
	
	
	//private List<String> imgFilenameList = new ArrayList<String>();

}
