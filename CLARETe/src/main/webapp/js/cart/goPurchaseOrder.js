document.addEventListener("DOMContentLoaded", function() {

	$('#menu1 > span').click(function(){
        $('#memberInfo').slideToggle();
    });
		
    $('#menu2 > span').click(function(){
        $('#orderInfo').slideToggle();
        $('#selectDelivery').slideToggle();
    });

	$('#menu3 > span').click(function(){
        $('#productList').slideToggle();
    });
	
    const modal = document.getElementById("deliveryModal");
    const radioButtons = modal.querySelectorAll('input[type="radio"]');
    const closeButton = document.querySelector(".close");
    const totalInputField = document.querySelector('input[name="totalInput"]');
    const deliveryNumInput = document.querySelector('input[name="selectedDNum"]');
    const orderInfoDiv = document.getElementById("orderInfo");
    const productPrice = parseFloat(document.querySelector(".product_price").textContent.replace(/,/g, "")) || 0;
    const shippingPrice = parseFloat(document.querySelector(".shipping_price").textContent.replace(/,/g, "")) || 0;

    // 페이지 로드 시 totalInput 값을 초기화
    const initialTotalPrice = productPrice + shippingPrice;
    totalInputField.value = initialTotalPrice;
    $(".total_price").text(new Intl.NumberFormat().format(initialTotalPrice));

    // 처음에 기본으로 배송지 설정 (기본 배송지 기준은 where m_id='gold12' 하고 d_num 오름차순 정렬해서 젤 작은걸로)
    if (radioButtons.length > 0) {
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
    }

    // 배송지 선택 버튼 클릭
    $("button#selectDelivery").click(function() {
        modal.style.display = "block";
        if (radioButtons.length > 0) {
            radioButtons[0].checked = true;
        }
    });

    closeButton.addEventListener("click", function() {
        modal.style.display = "none";
    });

    // 배송지 선택된 정보 반영
    deliveryButton.addEventListener("click", function() {
        const selectedRadioButton = modal.querySelector('input[type="radio"]:checked');
        if (selectedRadioButton) {
            const dNum = selectedRadioButton.value;
            deliveryNumInput.value = dNum;
            modal.style.display = "none";
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

    // 적립금 사용에 따른 총 금액 업데이트
    const pointInput = document.querySelector(".point_price");
    const totalPriceElement = document.querySelector(".total_price");
    const myPointElement = document.querySelector(".myPoint");
    const maxPointValue = parseInt(myPointElement.textContent.replace(/,/g, ""), 10);

    pointInput.addEventListener("input", function() {
        let pointValue = parseInt(pointInput.value.replace(/[^0-9]/g, ""), 10);
        if (isNaN(pointValue)) pointValue = 0;
        if (pointValue > maxPointValue) {
            alert(`적립금은 최대 ${maxPointValue.toLocaleString()}원까지만 사용할 수 있습니다.`);
            pointInput.value = 0;
            pointValue = 0;
        }

        const updatedTotalPrice = initialTotalPrice - pointValue;
        totalPriceElement.textContent = updatedTotalPrice.toLocaleString();
        totalInputField.value = updatedTotalPrice;
    });

	
	
	const btnOrder = document.getElementById("btn-order");
		btnOrder.addEventListener("click", function() {

			const IMP = window.IMP;
			IMP.init("imp28303334");	// 채은꺼 가맹점 식별코드

			const productName = "claret";
			const buyerName = document.querySelector('span#buyName').textContent.trim();
			const buyerTel = document.querySelector('span#buyMobile').textContent.trim().replace(/[\s-]/g, '');
			const fk_m_id = document.querySelector('input[name="fk_m_id"]').value;
			
			// json 데이터
			const totalAmount = parseInt(document.querySelector('input[name="totalInput"]').value, 10);
			const pointInput = document.querySelector(".point_price").value;
			const pointValue = pointInput === "" ? 0 : parseInt(pointInput, 10);
			
			const d_num = document.querySelector("input[name='selectedDNum']").value;
			const p_num = document.querySelector("input[name='fk_p_num']").value;
			const op_num = document.querySelector("input[name='fk_op_num']").value;
			const od_count = document.querySelector("input[name='od_count']").value;
			const od_price = document.querySelector("input[name='od_price']").value;

			
			IMP.request_pay(
				{
					pg: "html5_inicis", // PG사 선택
					pay_method: "card", // 결제 방식 (카드, 계좌이체 등)
					merchant_uid: 'merchant_' + new Date().getTime(), // 주문번호
					name: productName, // 주문명
					amount: 100, // 결제 금액
					buyer_name: buyerName, // 구매자 이름
					buyer_tel: buyerTel, // 구매자 전화번호
					buyer_addr: "", // 구매자 주소 (옵션)
					buyer_postcode: "", // 구매자 우편번호 (옵션)
				},
				function(rsp) {
					if (rsp.success) {	// 결제 성공하면
						$.ajax({
							url: "oneOrder.cl",
							contentType: "application/json; charset=UTF-8",
							data: JSON.stringify({
								fk_m_id: fk_m_id, // 사용자 ID
								fk_d_num: d_num, // 배송지 번호
								o_price: totalAmount, // 구매가격
								m_point: pointValue ,	// 사용된 포인트
								p_num: p_num,	// 상품 번호
								op_num: op_num,	// 옵션 번호
								od_count: od_count,	// 구매 개수
								od_price: od_price	// 구매가
							}),
							type: "POST",
							async: false,
							dataType: "json",

							success: function(json) {
								if (json.n == 1) {
									alert("결제가 완료되었습니다.");
									window.location.href = "/CLARETe/cart/oneOrderComplete.cl";
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
