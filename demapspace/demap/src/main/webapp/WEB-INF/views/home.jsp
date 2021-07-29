<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>

<head>

<script type="text/javascript">
	function search(f) {

		if (!f.keyword.value.replace(/^\s+|\s+$/g, '')) {
			alert('검색어를 입력해주세요!');
		} else {

			if (f.select_pf.value == "place") {
				f.action = '/api/results/places/' + f.keyword.value;
			} else if (f.select_pf.value == "folder") {
				f.action = '/api/results/folders/' + f.keyword.value;
			}
		}

	}
</script>

</head>


	<section class="py-5 text-center container">
		<div class="row">
			<div class="col-lg-6 col-md-8 mx-auto">
				<p class="lead text-muted" style="font-size: 18pt">
					<TT>나만의 장소들로 디자인하는 Our Map,</TT>
				</p>
				<h1 class="fw-light" style="font-size: 34pt">DeMap[디:맵]</h1>
				<br> <br>
				<hr align="right"
					style="width: 130px; height: 3px; margin: 0px auto;">
				<!--
        <br><br>  
        <p class="lead text-muted" style="font-size:16pt"><U>Easily Get! 상황과 목적에 맞는 장소 리스트 검색</U></p>
        <p class="lead text-muted" style="line-height:10px; font-size:12pt">간단한 키워드와 태그 검색만으로 폴더로 분류된 장소 리스트를 누려보세요</p>
        <p class="lead text-muted" style="font-size:16pt"><U>Simply Share! 구독 버튼 하나로 공유하는 장소 리스트</U></p>
        <p class="lead text-muted" style="line-height:10px; font-size:12pt">구독과 친구 초대 기능으로 장소 리스트를 간편하게 공유하고 함께 만들어 보세요</p>
        <p class="lead text-muted" style="font-size:16pt"><U>Uniquely Promote! 디맵 폴더로 소개하는 우리 동네</U></p>
        <p class="lead text-muted" style="line-height:10px; font-size:12pt">디맵 폴더를 장소 Wiki처럼 만들어 자신의 지역 및 사업장을 홍보해 보세요</p>
        <br><br>
        <p>
          <a href="#" class="btn btn-primary my-2">Main call to action</a>
          <a href="#" class="btn btn-secondary my-2">Secondary action</a>
        </p>
        -->
			</div>
		</div>
	</section>

	<section class="text-center">
		<div class="py-5 container">

			<div>
				<div >
					<form action="<c:url value="#"/>" method="get">
						<select id="select_pf"> 
							<option value="place" selected>장소</option>
							<option value="folder">폴더</option>
						</select> 
						<input type="text" value="" id="keyword" size="30"
							placeholder="&nbsp;&nbsp;장소 또는 폴더명을 입력 해 주세요" class="round_rect">
					    <input id="btn_submit" class="round_rect" type="submit" value="Search" onclick="search(this.form)" /> 
						<!--  <button id="btnsearchplace" onclick="searchPlaces(keyword.value)); return false;">Search</button> -->
					</form>
				</div>
			</div>
		</div>
	</section>





	<div class="album py-5 bg-light">
		<div class="container">

			<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
				<c:forEach begin="1" end="9">
					<div class="col">
						<div class="card shadow-sm">
							<svg class="bd-placeholder-img card-img-top" width="100%"
								height="225" xmlns="http://www.w3.org/2000/svg" role="img"
								aria-label="Placeholder: Thumbnail"
								preserveAspectRatio="xMidYMid slice" focusable="false">
							<title>Placeholder</title><rect width="100%" height="100%"
									fill="#55595c" />
							<text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>

							<div class="card-body">
								<p class="card-text">This is a wider card with supporting
									text below as a natural lead-in to additional content. This
									content is a little bit longer.</p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
										<button type="button" class="btn btn-sm btn-outline-secondary">Follow</button>
									</div>
									<!--  <small class="text-muted">9 mins</small> -->
								</div>
							</div>
						</div>
					</div>
				</c:forEach>


			</div>
		</div>
	</div>

	