<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>

<head>
<script type="text/javascript">
	function search(f) {
		if (f.select_pf.value == "place") {
			//searchPlaces();
			//return false;
			f.action = '/api/results/places/' + f.keyword.value;
		} else if (f.select_pf.value == "folder") {
			f.action = '/api/results/folders/' + f.keyword.value;
		}
	}
</script>

</head>

<main class="main">
<section class="text-center">
	<div class="py-5 container">

		<div>
			<div>
				<form action="<c:url value="#"/>" method="get">
					<select id="select_pf">
						<option value="place"
							${selected == 'place' ? 'selected="selected"' : '' }>장소</option>
						<option value="folder"
							${selected == 'folder' ? 'selected="selected"' : '' }>폴더</option>
					</select> <input type="text" value="${keyword}" id="keyword" size="30"
						placeholder="&nbsp;&nbsp;장소 또는 폴더명을 입력 해 주세요" class="round_rect">
					<input id="btn_submit" class="round_rect" type="submit"
						value="Search" onclick="search(this.form)" />

				</form>
			</div>
		</div>
	</div>
</section>


<section class="py-5 text-center container">
	<div class="container">

		<!-- 지도를 표시할 div 입니다 -->
		<div class="map_wrap">
			<div id="map"></div>

			<div id="menu_wrap" class="bg-light">
				<span>${place.place_name}</span>&nbsp<span>${place.category_group_name }</span>
				<hr>
				<button>저장하기</button>
				<button>길찾기</button>
				<button>공유하기</button>
				<hr>
				<span>전화번호</span>&nbsp<span>${place.phone}</span><br> <span>주소</span>&nbsp<span>${place.road_address_name }</span><br>
				<span>태그</span>&nbsp<span>태그 나열 예정</span><br>

			</div>
		</div>

		<div id="review_wrap" class="bg-light">
			<h3>리뷰</h3>
			<p>별점평점</p>
			<hr>
			리뷰 리스트
			<div>
				<table>
					<c:forEach items="${reviewList}" var="review">
						<tr>
							<td>${review.userId}</td>
							<td>
								<c:forEach begin="1" end="${review.star}">
									<label><i class="fas fa-star"></i></label>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<td>${review.rvText}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<hr>
			<h5>리뷰 작성</h5>
			<form name="review_f" id="review_f" method="post" action="">
				<fieldset>
					<input type="radio" name="rating" value="5" id="rate1"> <label
						for="rate1"><i class="fas fa-star"></i></label> <input
						type="radio" name="rating" value="4" id="rate2"><label
						for="rate2"><i class="fas fa-star"></i></label> <input
						type="radio" name="rating" value="3" id="rate3"><label
						for="rate3"><i class="fas fa-star"></i></label> <input
						type="radio" name="rating" value="2" id="rate4"><label
						for="rate4"><i class="fas fa-star"></i></label> <input
						type="radio" name="rating" value="1" id="rate5"><label
						for="rate5"><i class="fas fa-star"></i></label>
				</fieldset>
				<br> <br>
				<textarea name="review" id="review" placeholder="내용을 입력해주세요"
					style="width: 90%;" rows=10></textarea>
				<br> <br> <input type="file" name="review_img" multiple />
				<br> <br> <br> <input id="btn_submit"
					class="round_rect" type="submit" value="Upload" onclick="" />
			</form>
		</div>

		<!-- 카카오 지도 api 호출 -->
		<!-- 장소검색, 주소-좌표 변환 / 지도 마커 클러스터링 / 지도위 마커 그래픽 객체 그리기 모드 라이브러리 -->
		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=50b803eed41adcd48a6d6416bfb3fc22&libraries=services,clusterer,drawing"></script>

		<script>
			var x = "${place.x}";
			var y = "${place.y}";

			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			mapOption = {
				//center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				center : new kakao.maps.LatLng(y, x),
				level : 3
			// 지도의 확대 레벨 
			};

			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

			var marker, oldLatLng, infowindow;

			// 마커를 담을 배열입니다 -- 장소 검색 시 사용 
			var markers = [];
			// 장소 검색 키워드 -- 장소 검색 시 사용 
			// var keyword = document.getElementById('keyword').value;

			// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
			var mapTypeControl = new kakao.maps.MapTypeControl();

			// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
			// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
			map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

			// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
			var zoomControl = new kakao.maps.ZoomControl();
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

			// 지도에 마커와 인포윈도우를 표시하는 함수입니다
			function displayMarker(locPosition) {

				var imageSrc = '/resources/img/map_marker.png', // 마커이미지의 주소입니다    
				imageSize = new kakao.maps.Size(44, 49), // 마커이미지의 크기입니다
				imageOption = {
					offset : new kakao.maps.Point(21, 47)
				}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

				// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
				var markerImage = new kakao.maps.MarkerImage(imageSrc,
						imageSize, imageOption);

				// 마커를 생성합니다
				marker = new kakao.maps.Marker({
					map : map,
					position : locPosition,
					image : markerImage
				// 마커이미지 설정 
				});

				var iwContent = message, // 인포윈도우에 표시할 내용
				iwRemoveable = true;

				// 인포윈도우를 생성합니다
				var infowindow = new kakao.maps.InfoWindow({
					content : iwContent,
					removable : iwRemoveable
				});

				// 인포윈도우를 마커위에 표시합니다 
				infowindow.open(map, marker);

				// 지도 중심좌표를 접속위치로 변경합니다
				//map.setCenter(locPosition);
			}

			displayMarker(map.getCenter());

			// 지도 클릭 이벤트 START
			// 지도에 클릭 이벤트를 등록합니다
			// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
			kakao.maps.event.addListener(map, 'click', function(mouseEvent) {

				// 클릭한 위도, 경도 정보를 가져옵니다 
				var latlng = mouseEvent.latLng;

				if (oldLatLng && !oldLatLng.equals(latlng)) {
					infowindow.close();
				}
				oldLatLng = latlng;

				// 마커 위치를 클릭한 위치로 옮깁니다
				marker.setPosition(latlng);

				var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
				message += '경도는 ' + latlng.getLng() + ' 입니다';

				var iwContent = message, // 인포윈도우에 표시할 내용
				iwRemoveable = true;

				// 인포윈도우를 생성합니다
				infowindow = new kakao.maps.InfoWindow({
					content : iwContent,
					removable : iwRemoveable
				});

				// 인포윈도우를 마커위에 표시합니다 
				infowindow.open(map, marker);

				//var resultDiv = document.getElementById('clickLatlng'); 
				//resultDiv.innerHTML = message;

			});
			// 지도 클릭 이벤트 END
		</script>

	</div>

</section>


</main>


