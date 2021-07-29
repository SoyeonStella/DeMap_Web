<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>


<head>

<script src="<c:url value="/resources/js/controller.js" /> "></script>

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

	function detail(p) {
		console.log("버튼 작동 : " + p);

	}
</script>

</head>

<main class="main">

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

<!--  
	<section class="py-5 text-center" ng-app="searchApp">
		<div class="container">

				<div ng-controller="searchCtrl">
					
					<form ng-submit="searchPlace(keyword)">
						<select id="select_pf">
							<option value="place" selected>장소</option>
							<option value="folder">폴더</option>
						</select> 
						<input type="text" value="${keyword_h}" ng-value="'${keyword_h}'" id="keyword" size="30"
							placeholder="&nbsp;&nbsp;장소 또는 폴더명을 입력 해 주세요" ng-model="keyword" onchange="search(this.form)" class="round_rect">
						<input type="submit" value="Submit" class="round_rect"/>
						
					</form>
				</div>
			
		</div>
	</section>
-->

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
				<ul id="placesList"></ul>
				<div id="pagination"></div>
			</div>
		</div>



		<!-- 카카오 지도 api 호출 -->
		<!-- 장소검색, 주소-좌표 변환 / 지도 마커 클러스터링 / 지도위 마커 그래픽 객체 그리기 모드 라이브러리 -->
		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=50b803eed41adcd48a6d6416bfb3fc22&libraries=services,clusterer,drawing"></script>

		<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			mapOption = {
				center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
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
			function displayMarker(locPosition, message) {

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
				map.setCenter(locPosition);
			}
			/*
			 // HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
			 if (navigator.geolocation) {
			 // GeoLocation을 이용해서 접속 위치를 얻어옵니다
			 navigator.geolocation
			 .getCurrentPosition(function(position) {

			 var lat = position.coords.latitude; // 위도
			 var lon = position.coords.longitude; // 경도

			 var locPosition = new kakao.maps.LatLng(lat,
			 lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다

			 // 마커를 생성합니다
			 var marker = new kakao.maps.Marker({
			 position : locPosition
			 });

			 // 마커가 지도 위에 표시되도록 설정합니다
			 marker.setMap(map);

			 // 아래 코드는 지도 위의 마커를 제거하는 코드입니다 START
			 // marker.setMap(null);    
			 // END

			 var message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다

			 // 마커와 인포윈도우를 표시합니다
			 displayMarker(locPosition, message);

			 });

			 } else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
			 console.log("if문 실행됨");
			 var locPosition = new kakao.maps.LatLng(33.450701,
			 126.570667);

			 var message = '<div style="padding:5px;">geolocation을 사용할수 없어요..</div>';

			 displayMarker(locPosition, message);

			 }
			 */

			// 장소 검색 START
			// 장소 검색 객체를 생성합니다
			var ps = new kakao.maps.services.Places();

			// 검색 옵션 객체를 생성합니다
			var searchOption = {
				location : currentPos,
				radius : 1000,
				size : 5
			};

			// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
			var infowindowforsearch = new kakao.maps.InfoWindow({
				zIndex : 1
			});

			// 키워드로 장소를 검색합니다
			searchPlaces();

			// 키워드 검색을 요청하는 함수입니다
			function searchPlaces() {

				var keyword = document.getElementById('keyword').value;

				if (!keyword.replace(/^\s+|\s+$/g, '')) {
					alert('키워드를 입력해주세요!');
					return false;
				}

				// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
				ps.keywordSearch(keyword, placesSearchCB);
			}

			// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
			function placesSearchCB(data, status, pagination) {
				if (status === kakao.maps.services.Status.OK) {

					// 정상적으로 검색이 완료됐으면
					// 검색 목록과 마커를 표출합니다
					displayPlaces(data);

					// 페이지 번호를 표출합니다
					displayPagination(pagination);

				} else if (status === kakao.maps.services.Status.ZERO_RESULT) {

					alert('검색 결과가 존재하지 않습니다.');
					return;

				} else if (status === kakao.maps.services.Status.ERROR) {

					alert('검색 결과 중 오류가 발생했습니다.');
					return;

				}
			}

			// 검색 결과 목록과 마커를 표출하는 함수입니다
			function displayPlaces(places) {

				var listEl = document.getElementById('placesList'), menuEl = document
						.getElementById('menu_wrap'), fragment = document
						.createDocumentFragment(), bounds = new kakao.maps.LatLngBounds(), listStr = '';

				// 검색 결과 목록에 추가된 항목들을 제거합니다
				removeAllChildNods(listEl);

				// 지도에 표시되고 있는 마커를 제거합니다
				removeMarker();

				for (var i = 0; i < places.length; i++) {

					// 마커를 생성하고 지도에 표시합니다
					var placePosition = new kakao.maps.LatLng(places[i].y,
							places[i].x), marker = addMarker(placePosition, i), itemEl = getListItem(
							i, places[i]); // 검색 결과 항목 Element를 생성합니다

					// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
					// LatLngBounds 객체에 좌표를 추가합니다
					bounds.extend(placePosition);

					// 마커와 검색결과 항목에 mouseover 했을때
					// 해당 장소에 인포윈도우에 장소명을 표시합니다
					// mouseout 했을 때는 인포윈도우를 닫습니다
					(function(marker, title, places) {
						kakao.maps.event.addListener(marker, 'mouseover',
								function() {
									displayInfowindow(marker, title);
								});

						kakao.maps.event.addListener(marker, 'mouseout',
								function() {
									infowindowforsearch.close();
								});

						itemEl.onmouseover = function() {
							displayInfowindow(marker, title);
						};

						itemEl.onmouseout = function() {
							infowindowforsearch.close();
						};

						//itemEl.onclick = detail(event, places);

						itemEl.addEventListener('click', function() {
							detail(places)
						});

					})(marker, places[i].place_name, places[i]);

					fragment.appendChild(itemEl);
				}

				// 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
				listEl.appendChild(fragment);
				menuEl.scrollTop = 0;

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
				map.setBounds(bounds);
			}

			// 검색결과 항목을 Element로 반환하는 함수입니다
			function getListItem(index, places) {

				var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
						+ (index + 1)
						+ '"></span>'
						+ '<div class="info">'
						+ '   <h5>' + places.place_name + '</h5>';

				if (places.road_address_name) {
					itemStr += '    <span>' + places.road_address_name
							+ '</span>' + '   <span class="jibun gray">'
							+ places.address_name + '</span>';
				} else {
					itemStr += '    <span>' + places.address_name + '</span>';
				}

				itemStr += '  <span class="tel">' + places.phone + '</span>'
						+ '</div>';

				el.innerHTML = itemStr;
				el.className = 'item';

				return el;
			}

			// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
			function addMarker(position, idx, title) {
				var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
				imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
				imgOptions = {
					spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
					spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
					offset : new kakao.maps.Point(13, 37)
				// 마커 좌표에 일치시킬 이미지 내에서의 좌표
				}, markerImage = new kakao.maps.MarkerImage(imageSrc,
						imageSize, imgOptions), marker = new kakao.maps.Marker(
						{
							position : position, // 마커의 위치
							image : markerImage
						});

				marker.setMap(map); // 지도 위에 마커를 표출합니다
				markers.push(marker); // 배열에 생성된 마커를 추가합니다

				return marker;
			}

			// 지도 위에 표시되고 있는 마커를 모두 제거합니다
			function removeMarker() {
				for (var i = 0; i < markers.length; i++) {
					markers[i].setMap(null);
				}
				markers = [];
			}

			// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
			function displayPagination(pagination) {
				var paginationEl = document.getElementById('pagination'), fragment = document
						.createDocumentFragment(), i;

				// 기존에 추가된 페이지번호를 삭제합니다
				while (paginationEl.hasChildNodes()) {
					paginationEl.removeChild(paginationEl.lastChild);
				}

				for (i = 1; i <= pagination.last; i++) {
					var el = document.createElement('a');
					el.href = "#";
					el.innerHTML = i;

					if (i === pagination.current) {
						el.className = 'on';
					} else {
						el.onclick = (function(i) {
							return function() {
								pagination.gotoPage(i);
							}
						})(i);
					}

					fragment.appendChild(el);
				}
				paginationEl.appendChild(fragment);
			}

			// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
			// 인포윈도우에 장소명을 표시합니다
			function displayInfowindow(marker, title) {
				var content = '<div style="padding:5px;z-index:1;">' + title
						+ '</div>';

				infowindowforsearch.setContent(content);
				infowindowforsearch.open(map, marker);
			}

			// 검색결과 목록의 자식 Element를 제거하는 함수입니다
			function removeAllChildNods(el) {
				while (el.hasChildNodes()) {
					el.removeChild(el.lastChild);
				}
			}

			// 장소 검색 END

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

