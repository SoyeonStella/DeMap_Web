package kr.ac.hansung.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.ac.hansung.dao.FileDao;
import kr.ac.hansung.model.ImageFile;

@Service
public class FileUploadService {

	@Autowired
	private FileDao fileDao;

	public void fileUpload(MultipartHttpServletRequest mRequest) {
		// 파일 이미지 정보를 받아오기 위한 부분
		String src = mRequest.getParameter("src");
		MultipartFile mf = mRequest.getFile("review_img");

		String rootDirectory = mRequest.getSession().getServletContext().getRealPath("/");
		Path savePath = Paths.get(rootDirectory + "/imagefile/review/");

		String originFileName = mf.getOriginalFilename(); // 원본 파일 명
		long fileSize = mf.getSize(); // 파일 사이즈

		System.out.println("originFileName : " + originFileName);
		System.out.println("fileSize : " + fileSize);

		String saveFile = savePath + originFileName;

		try {
			mf.transferTo(new File(saveFile));
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void multipleFileUpload(MultipartHttpServletRequest mRequest, ImageFile file) {

		System.out.println("여기는 파일업로드서비스 함수 진입");
		// 파일 이미지 정보를 받아오기 위한 부분
		List<MultipartFile> fileList = mRequest.getFiles("review_img");
		String src = mRequest.getParameter("src");

		System.out.println("파일리스트가 제대로 넘어왔나 : " + fileList);

		String rootDirectory = mRequest.getSession().getServletContext().getRealPath("/");
		// Path savePath = Paths.get(rootDirectory + "/imagefile/review/");
		// Path savePath = Paths.get("/demap/src/main/webapp/WEB-INF/imagefile/review");
		String savePath = "/Users/deurorina/Documents/webserver/demap_web/demapspace/demap/src/main/webapp/imagefile/review/";

		// String path = "/imagefile/review";

		for (MultipartFile mf : fileList) {
			String originFileName = mf.getOriginalFilename(); // 원본 파일 명
			long fileSize = mf.getSize(); // 파일 사이즈

			if (mf.isEmpty() == false) {
				System.out.println("------------- file start ---------------");
				System.out.println("name : " + mf.getName());
				System.out.println("filename : " + mf.getOriginalFilename());
				System.out.println("size : " + mf.getSize());
				System.out.println("savePath : " + savePath);
				System.out.println("-------------- file end -----------------");

				file.setSavepath(savePath.toString());
				file.setOriginname(originFileName);
				file.setSavename(savePath + originFileName);
				file.setSize(fileSize);

				fileDao.addFile(file);

				System.out.println("originFileName : " + originFileName);
				System.out.println("fileSize : " + fileSize);

				// 이미지 파일을 실제 저장하는 부분
				String saveFile = savePath + originFileName;

				try {
					mf.transferTo(new File(saveFile));
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

	}

}
