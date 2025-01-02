document.addEventListener("DOMContentLoaded", function() {

	const modal = document.getElementById("deliveryModal");
	const radioButtons = modal.querySelectorAll('input[type="radio"]');
	const closeButton = document.querySelector(".close");
	const totalInputField = document.querySelector('input[name="totalInput"]');
	const deliveryNumInput = document.querySelector('input[name="selectedDNum"]');
	const orderInfoDiv = document.getElementById("orderInfo");

	// 처음에 기본으로 배송지 설정 (기본 배송지 기준은 where m_id='gold12' 하고 d_num 오름차순 정렬해서 젤 작은걸로)
	deliveryNumInput.value = radioButtons[0].value;
	const deliveryItem = radioButtons[0].closest(".delivery-item");
	const name = deliveryItem.querySelector(".deliveryName").textContent;
	const mobile = deliveryItem.querySelector(".deliveryMobile").textContent;
	const postcode = deliveryItem.querySelector(".deliveryPostcode").textContent;
	const address = deliveryItem.querySelector(".deliveryAddress").textContent;

	orderInfoDiv.innerHTML = `
	                <div class="space">
	                    <span class="infoSpan">이름</span>
	                    <span>${name}</span><br>
	                </div>
	                <div class="space">
	                    <span class="infoSpan">전화번호</span>
	                    <span>${mobile}</span><br>
	                </div>
	                <div class="space">
	                    <span class="infoSpan">주소</span>
	                    <span>${postcode} ${address}</span><br>
	                </div>
	            `;

	$("button#selectDelivery").click(function() {

		modal.style.display = "block";

		// 첫번째 라디오 버튼 (기본배송지) 로 자동 선택되어져있게
		if (radioButtons.length > 0) {
			radioButtons[0].checked = true;
		}

	});


	closeButton.addEventListener("click", function() {
		modal.style.display = "none";
	});


	// 배송지 선택된 거 d_num 가져오기 (주문 테이블에 insert 해야 함)
	deliveryButton.addEventListener("click", function() {
		const selectedRadioButton = modal.querySelector('input[type="radio"]:checked');


		if (selectedRadioButton) {
			const dNum = selectedRadioButton.value;
			deliveryNumInput.value = dNum;
			modal.style.display = "none";

			// 선택된 배송지 정보 가져오기
			const deliveryItem = selectedRadioButton.closest(".delivery-item");
			const name = deliveryItem.querySelector(".deliveryName").textContent;
			const mobile = deliveryItem.querySelector(".deliveryMobile").textContent;
			const postcode = deliveryItem.querySelector(".deliveryPostcode").textContent;
			const address = deliveryItem.querySelector(".deliveryAddress").textContent;

			orderInfoDiv.innerHTML = `
				                <div class="space">
				                    <span class="infoSpan">이름</span>
				                    <span>${name}</span><br>
				                </div>
				                <div class="space">
				                    <span class="infoSpan">전화번호</span>
				                    <span>${mobile}</span><br>
				                </div>
				                <div class="space">
				                    <span class="infoSpan">주소</span>
				                    <span>${postcode} ${address}</span><br>
				                </div>
				            `;
		}
	});


	const pointInput = document.querySelector(".point_price");
	const totalPriceElement = document.querySelector(".total_price");
	const myPointElement = document.querySelector(".myPoint");
	const originalTotalPrice = parseInt(totalPriceElement.textContent.replace(/,/g, ""), 10);
	const maxPointValue = parseInt(myPointElement.textContent.replace(/,/g, ""), 10);

	pointInput.addEventListener("input", function() {
		let pointValue = parseInt(pointInput.value.replace(/[^0-9]/g, ""), 10);
		if (isNaN(pointValue)) {
			pointValue = 0;
		}

		// 입력값이 최대치를 초과했는지 확인
		if (pointValue > maxPointValue) {
			alert(`적립금은 최대 ${maxPointValue.toLocaleString()}원까지만 사용할 수 있습니다.`);
			pointInput.value = 0; // 최대값으로 제한
			pointValue = 0; // 값도 최대값으로 설정
		}

		const updatedTotalPrice = originalTotalPrice - pointValue;

		// total_price 업데이트
		totalPriceElement.textContent = updatedTotalPrice.toLocaleString();
		totalInputField.value = updatedTotalPrice;

	});

	const btnOrder = document.getElementById("btn-order");
	btnOrder.addEventListener("click", function() {

		const IMP = window.IMP;
		IMP.init("imp28303334");	// 채은꺼 가맹점 식별코드

		const productName = "claret";
		const totalAmount = parseInt(document.querySelector('input[name="totalInput"]').value, 10);
		const buyerName = document.querySelector('span#buyName').textContent.trim();
		const buyerTel = document.querySelector('span#buyMobile').textContent.trim().replace(/[\s-]/g, '');
		const buyerEmail = document.querySelector('input[name="buyEmail"]').value;
		const fk_m_id = document.querySelector('input[name="fk_m_id"]').value;
		const fk_d_num = document.querySelector('input[name="selectedDNum"]').value;
		const o_cnt = document.querySelector('input[name="o_cnt"]').value;
		const selectedCNumInputs = document.querySelectorAll('input[name="selectedCNum"]');
		const selectedCNumValues = Array.from(selectedCNumInputs).map(input => input.value); // 장바구니 번호 배열
		const m_point = document.querySelector('input[name="point_price"]').value;
		const pointValue = m_point === "" ? 0 : parseInt(m_point, 10);
				
		const fk_p_numInputs = document.querySelectorAll('input[name="fk_p_num"]');
		const fk_p_numValues = Array.from(fk_p_numInputs).map(input => input.value);	// 상품 번호 fk_p_num 
		
		const od_countInputs = document.querySelectorAll('input[name="od_count"]');
		const od_countValues = Array.from(od_countInputs).map(input => input.value);	// 각 제품 구매개수 od_count
		
		const fk_op_numInputs = document.querySelectorAll('input[name="fk_op_num"]');
		const fk_op_numValues = Array.from(fk_op_numInputs).map(input => input.value);	// 옵션번호 fk_op_num
		
		const od_priceInputs = document.querySelectorAll('input[name="od_price"]');
		const od_priceValues = Array.from(od_priceInputs).map(input => input.value);	// 제품 1개의 가격 od_price
				
		IMP.request_pay(
			{
				pg: "html5_inicis", // PG사 선택
				pay_method: "card", // 결제 방식 (카드, 계좌이체 등)
				merchant_uid: 'merchant_' + new Date().getTime(), // 주문번호
				name: productName, // 주문명
				amount: 100, // 결제 금액
				buyer_email: buyerEmail, // 구매자 이메일
				buyer_name: buyerName, // 구매자 이름
				buyer_tel: buyerTel, // 구매자 전화번호
				buyer_addr: "", // 구매자 주소 (옵션)
				buyer_postcode: "", // 구매자 우편번호 (옵션)
			},
			function(rsp) {
				if (rsp.success) {	// 결제 성공하면
					$.ajax({
						url: "orderComplete.cl",
						contentType: "application/json; charset=UTF-8",
						data: JSON.stringify({
							fk_m_id: fk_m_id, // 사용자 ID
							fk_d_num: fk_d_num, // 배송지 번호
							o_price: totalAmount, // 구매가격
							o_cnt: o_cnt, // 한 주문에 해당하는 주문건수
							selectedCNumValues: selectedCNumValues, // 장바구니 번호 배열
							m_point: pointValue ,	// 사용된 포인트
							fk_p_numValues: fk_p_numValues,
							od_countValues: od_countValues,
							fk_op_numValues: fk_op_numValues,
							od_priceValues: od_priceValues
						}),
						type: "POST",
						async: false,
						dataType: "json",

						success: function(json) {
							if (json.n == 1) {
								alert("결제가 완료되었습니다.");
								window.location.href = "/CLARETe/cart/Complete.cl";
							}

						},
						error: function(request, status, error) {
							alert("결제는 완료되었으나 주문 처리에 실패했습니다. 고객센터로 문의해주세요.");
						}
					});

				} else {
					// 결제 실패 시
					location.href = "/CLARETe";
					alert(`결제에 실패하였습니다: ${rsp.error_msg}`);
				}
			}
		);
	});

});
