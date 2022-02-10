<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/bs4.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자주묻는 질문</title>
</head>

<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
	<div class="container">
		<h3>취소/환불/교환 관련</h3>
		<hr>
	  <div id="accordion">
	    <div class="card">
	      <div class="card-header">
	        <a class="card-link" data-toggle="collapse" href="#collapseOne">
	          주문취소/환불 시 사용한 포인트와 쿠폰은 복원 되나요?
	        </a>
	      </div>
	      <div id="collapseOne" class="collapse" data-parent="#accordion">
	        <div class="card-body">
	          [포인트] <br>

- 취소/환불 완료 즉시 환급됩니다. (하이버APP ▶ MY페이지 ▶ 포인트)<br>

- 단, 부분취소/환불의 경우 실 결제하신 상품가 전액 환급되며, 포인트는 환급되지 않습니다.<br>

<br>

[쿠폰]<br>

- 취소/환불 완료 즉시 복원됩니다. <br>

- 유효 기간이 지났을 경우 자동소멸됩니다.<br>
	        </div>
	      </div>
	    </div>
	    <div class="card">
	      <div class="card-header">
	        <a class="collapsed card-link" data-toggle="collapse" href="#collapseTwo">
	         환불을 포인트로 받을 수 있나요?
	      </a>
	      </div>
	      <div id="collapseTwo" class="collapse" data-parent="#accordion">
	        <div class="card-body">
	          주문취소 또는 환불 시 결제하셨던 수단으로만 환급이 가능합니다.<br>

따라서 포인트 환불은 어렵습니다.<br>
	        </div>
	      </div>
	    </div>
	    <div class="card">
	      <div class="card-header">
	        <a class="collapsed card-link" data-toggle="collapse" href="#collapseThree">
	          현재 판매가보다 비싸게 샀어요. 차액 환불 가능한가요?
	        </a>
	      </div>
	      <div id="collapseThree" class="collapse" data-parent="#accordion">
	        <div class="card-body">
	          안타깝지만, 상품 할인율은 변동될 수 있기 때문에 <br>

판매 가격 변동에 따른 차액을 보상해드리지 않습니다. 이 점 너그러이 양해 부탁 드립니다. <br>
	        </div>
	      </div>
	    </div>
	    <div class="card">
	      <div class="card-header">
	        <a class="collapsed card-link" data-toggle="collapse" href="#c4">
	          환불된 금액이 처음 결제했던 금액과 달라요!
	        </a>
	      </div>
	      <div id="c4" class="collapse" data-parent="#accordion">
	        <div class="card-body">
	          환불금액의 경우 실제 결제된 금액과 동일하게 진행 됩니다.<br>

쿠폰 또는 포인트가 사용 되었을 경우 해당 할인 혜택은 제외 후 환불 됩니다. <br>

[주문/배송조회 ▶ 주문상세보기] 통해 사용한 쿠폰 및 포인트를 제외한 결제금액 확인 부탁드립니다.<br>
	        </div>
	      </div>
	    </div>
	    <div class="card">
	      <div class="card-header">
	        <a class="collapsed card-link" data-toggle="collapse" href="#c5">
	          환불은 언제 되나요?
	        </a>
	      </div>
	      <div id="c5" class="collapse" data-parent="#accordion">
	        <div class="card-body">
	          [주문취소]<br>

주문 취소 완료일로부터 아래와 같이 소요됩니다.<br>



[환불완료]<br>

스토어측에서 반품 상품 입고/검수 후 하이버 측으로 [환불승인]이 접수되는 날로부터 아래와 같이 소요됩니다.<br>



※결제수단 별 환불 소요기간 <br>

- 계좌를 통한 환급 : 환불 승인 또는 주문 취소 처리 완료일로부터 영업일 기준 1~2일<br>

- 카드 취소를 통한 환급 : 환불 승인 또는 주문 취소 처리 완료일로부터 영업일 기준 1~4일 (카드사별 상이)<br>

- 핸드폰 결제 취소를 통한 환급 : 핸드폰 결제 즉시 취소(전월 결제 시 계좌 환급 진행되며 환급 기간은 계좌를 통한 환급과 동일)<br>

- 카카오페이/네이버페이/토스 : 환불승인 또는 주문취소 처리 완료일로부터 영업일 기준 1~3일 소요<br>
	        </div>
	      </div>
	    </div>
	    <div class="card">
	      <div class="card-header">
	        <a class="collapsed card-link" data-toggle="collapse" href="#c6">
	          교환/반품시 택배비가 발생되나요?
	        </a>
	      </div>
	      <div id="c6" class="collapse" data-parent="#accordion">
	        <div class="card-body">
	          무료배송은 구매한 상품이 최종적으로 [구매확정]되어야 제공되는 혜택입니다.<br>

반품 사유에 따라 배송비 지불 여부가 결정되며,  반품 시 스토어가 부담한 [초기 배송비+반품/교환] 왕복 배송비가 발생됩니다.<br>

<br>

1. 교환/반품 비용이 무료인 경우<br>

- 수령한 상품이 파손/불량이거나 상품이 잘못 배송된 경우에 해당 됩니다.<br>

<br>

2. 교환/반품 비용이 고객 부담인 경우<br>

- 고객 변심으로 인한 경우 비용이 발생됩니다.<br>


<br>
※ 스토어마다 교환/반품 방법 및 금액이 상이하며  배송비 차감 시스템이 제공되지 않습니다.<br>

따라서 환불요청 접수 시 [배송비 0원] 으로 표기되며, 구매하신 스토어측으로 반품비 관련 별도 문의 바랍니다.<br>
	        </div>
	      </div>
	    </div>
	    <div class="card">
	      <div class="card-header">
	        <a class="collapsed card-link" data-toggle="collapse" href="#c7">
	          주문을 취소하고 싶어요!
	        </a>
	      </div>
	      <div id="c7" class="collapse" data-parent="#accordion">
	        <div class="card-body">
	          주문은 [MY 페이지] 메뉴에서 직접 취소 가능합니다.<br>

<br>

- 결제대기/결제완료/상품준비중 : 고객님께서 직접 주문취소 가능한 상태<br>

- 배송준비중 : 스토어 배송 준비 기간으로 결제일로부터 3영업일(주말/공휴일 제외)간 즉시 주문취소 불가 상태<br>



만약, 3영업일 이내 주문 취소를 원하실 경우 하이버를 통해 구매한 스토어 Q&A/카카오톡/전화로 직접 주문취소 요청 또는 [하이버 고객센터]로 가능 여부를 확인해 주셔야 합니다.<br>



스토어측 연락이 어려울 경우, 주문/배송조회 ▶ 상품사진클릭 ▶ 상세페이지 ▶ Q&A 게시글 작성 바랍니다.<br>
	        </div>
	      </div>
	    </div>
	    
	    <hr>
	    <h3>주문/결제/배송 관련</h3>
			<hr>
	    
	    <div id="accordion">
		    <div class="card">
		      <div class="card-header">
		        <a class="card-link" data-toggle="collapse" href="#d1">
		          구입한 상품에 대한 겨래 명세서 발급 가능한가요?
		        </a>
		      </div>
		      <div id="d1" class="collapse" data-parent="#accordion">
		        <div class="card-body">
		          거래 명세서의 경우 직접 발급이 불가합니다.<br>

주문 후 하이버 고객센터 또는 카카오채널 [@하이버]로 문의 바랍니다.<br>

단, 결제수단이 네이버페이/카카오페이/토스일 경우 해당 결제사로 문의 바랍니다.<br>
		        </div>
		      </div>
		    </div>
		    <div class="card">
		      <div class="card-header">
		        <a class="card-link" data-toggle="collapse" href="#d2">
		          현금영수증 발급은 어떻게 하나요?
		        </a>
		      </div>
		      <div id="d2" class="collapse" data-parent="#accordion">
		        <div class="card-body">
		          현금 영수증은 결제하기 단계에서 신청 가능합니다. <br>


<br>
[현금 영수증 신청 방법]<br>

1) 결제하기 단계에서 현금 영수증 발행 가능한 결제수단 선택 ( 무통장입금 )<br>

2) [현금 영수증 발행 여부]에서 소득공제용, 지출증빙용 선택<br>

3) 번호 입력 후 주문<br>



※ 주문 후 신청을 원할 경우 [구매자 성함/연락처/상품명/상품 금액/이메일]과 함께 하이버 고객센터 또는 카카오채널 [@하이버]로 문의 바랍니다.
		        </div>
		      </div>
		    </div>
		    <div class="card">
		      <div class="card-header">
		        <a class="card-link" data-toggle="collapse" href="#d3">
		          주문 취소한 가상계좌에 입금을 했어요!
		        </a>
		      </div>
		      <div id="d3" class="collapse" data-parent="#accordion">
		        <div class="card-body">
		          주문 취소된 주문건에 대하여 입금 하였을 경우 자동 환불이 되지 않습니다.<br>

번거로우시겠지만 환급 받을 은행명/예금주명/계좌번호와 함께 하이버 고객센터 또는 카카오채널 [@하이버]로 문의 바랍니다.<br>
		        </div>
		      </div>
		    </div>
		    <div class="card">
		      <div class="card-header">
		        <a class="card-link" data-toggle="collapse" href="#d4">
		          구매확정은 언제 되나요?
		        </a>
		      </div>
		      <div id="d4" class="collapse" data-parent="#accordion">
		        <div class="card-body">
		          구매확정까지는 배송완료 후 7일 뒤 자동으로 변경됩니다.<br>

[배송중 +7일 ▶ 배송완료 +7일 ▶ 구매확정]<br>

<br>

구매확정 상태는 교환/반품 의사가 없는 단계이므로, 구매확정 후 교환/반품은 불가한 점 참고 바랍니다.
		        </div>
		      </div>
		    </div>
		    <div class="card">
		      <div class="card-header">
		        <a class="card-link" data-toggle="collapse" href="#d5">
		          아직 상품을 수령하지 못했는데 [배송완료]처리 되었어요!
		        </a>
		      </div>
		      <div id="d5" class="collapse" data-parent="#accordion">
		        <div class="card-body">
		          먼저, 배송 지연으로 불편 드려 죄송합니다.<br>

구입한 상품의 실제 배송과 택배 시스템의 차이가 있을 수 있는 점 양해바랍니다.<br>

<br>

- 배송 조회 시 이동중일 경우 1-3일내로 수령 가능합니다. ※ 해당 기간은 택배사 내부 사정에 의해 변동될 수 있습니다.<br>

- 배송 완료 장소를 확인하였으나 수령하지 못 했을 경우 배송조회를 통해 담당 배송기사님께 문의 바랍니다.<br>

- 장기적으로 상품배송을 받지 못하였을 경우 하이버 고객센터 또는 카카오채널 [@하이버]로 문의 바랍니다.<br>
		        </div>
		      </div>
		    </div>
  	 </div>
	    
     	<hr>
	    <h3>리뷰 관련</h3>
			<hr>
			<div id="accordion">
		    <div class="card">
		      <div class="card-header">
		        <a class="card-link" data-toggle="collapse" href="#e1">
		          리뷰 작성 기준이 궁금해요!
		        </a>
		      </div>
		      <div id="e1" class="collapse" data-parent="#accordion">
		        <div class="card-body">
		          리뷰는 텍스트/포토 리뷰 중 1회만 작성 가능하며 리뷰 작성 시, 포인트가 즉시 지급됩니다.<br>

<br>

- 포토리뷰 : 직접 촬영한 상품 사진으로 등록해야 합니다.<br>

- 텍스트리뷰 : 상품에 대한 내용을 바탕으로 작성해야 합니다.<br>

<br>

상품과 무관한 사진 또는 부적절한 내용 작성 시 사전 안내 없이 삭제 되는 점 참고 바랍니다.<br>

※ 동일 상품(동일한 옵션)으로 여러 개 구매하셨을 경우 동일 상품 리뷰는 1회만 작성 가능합니다.<br>
		        </div>
		      </div>
		    </div>
		    <div class="card">
		      <div class="card-header">
		        <a class="card-link" data-toggle="collapse" href="#e2">
		          리뷰는 구입 후 언제까지 작성 가능한가요?
		        </a>
		      </div>
		      <div id="e2" class="collapse" data-parent="#accordion">
		        <div class="card-body">
		          리뷰 작성은 구매확정일로부터 15일 이내 작성 가능합니다.<br>

기간 이후에는 작성이 불가하기 때문에  정해진 기간 내 작성 바랍니다.<br>
		        </div>
		      </div>
		    </div>
		    <div class="card">
		      <div class="card-header">
		        <a class="card-link" data-toggle="collapse" href="#e3">
		          리뷰를 삭제하거나 수정할 수 있나요?
		        </a>
		      </div>
		      <div id="e3" class="collapse" data-parent="#accordion">
		        <div class="card-body">
		          리뷰 작성 완료 후 텍스트는 수정이 가능하나, 포토리뷰는 수정이 불가합니다.<br>

삭제 후 리뷰 재작성은 불가한 점 참고 부탁드립니다.<br>
		        </div>
		      </div>
		    </div>
		    <div class="card">
		      <div class="card-header">
		        <a class="card-link" data-toggle="collapse" href="#e4">
		          리뷰를 작성하고 싶어요!
		        </a>
		      </div>
		      <div id="e4" class="collapse" data-parent="#accordion">
		        <div class="card-body">
		          상품 수령 후 교환/환불 의사 없을 경우 구매확정 클릭 ▶ 리뷰 작성 가능합니다.<br>

<br>

1) APP ▶ 하단 오른쪽 사람 모양 아이콘 클릭 <br>

2) MY 페이지 ▶ 주문/배송조회 또는 MY 리뷰 ▶ [리뷰 쓰고 포인트 받기] 클릭<br>
		        </div>
		      </div>
		    </div>
		    
		  </div>
	    
	  </div>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>