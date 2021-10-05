package kr.ac.hansung.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity
@Table(name = "file")
public class ImageFile {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "file_id", nullable = false, updatable = false, unique = true)
	private int id;

	@ManyToOne
	@JoinColumn(name="review_id")
	@JsonIgnore
	private Review review;
	
	@NotNull
	private String savename;
	
	@NotNull
	private String originname;
	
	@NotNull
	private long size;
	
	@NotNull
	private String savepath;


}
