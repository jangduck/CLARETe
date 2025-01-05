$(document).ready(function() {

    // 페이지 로드 시 초기화 (quantity 값을 1로 설정하고 priceSpan, productprice 동기화)
    $(".counter-container").each(function() {
        const container = $(this);
        const counterValue = container.find(".counter-value");
        const priceSpan = container.closest(".product").find(".priceSpan");
        const basePrice = parseFloat(priceSpan.data("price"));
        const productDiv = container.closest(".product");
        const productPriceInput = productDiv.find("input[name='productprice']"); 
        const quantityInput = productDiv.find("input[name='quantity']");

        // 초기 수량을 1로 설정하고 가격 업데이트
        const initialCount = 1;
        const initialPrice = basePrice * initialCount;

        priceSpan.text(new Intl.NumberFormat().format(initialPrice));
        priceSpan.attr("data-price", initialPrice);
        productPriceInput.val(initialPrice);
        counterValue.attr("data-count", initialCount).text(initialCount);
        quantityInput.val(initialCount);  // quantity input도 1로 초기화

        updateTotalPrice(); // 총 가격 업데이트
    });

    // 상품 개수 조절 이벤트 처리
    $(".counter-container").each(function() {
        const container = $(this);
        const counterValue = container.find(".counter-value");
        const decreaseBtn = container.find(".decrease");
        const increaseBtn = container.find(".increase");
        const priceSpan = container.closest(".product").find(".priceSpan");
        const basePrice = parseFloat(priceSpan.data("price"));

        const productDiv = container.closest(".product");
        const quantityInput = productDiv.find("input[name='quantity']");
        const priceQuantityInput = productDiv.find("input[name='priceQuantity']");
        const productPriceInput = productDiv.find("input[name='productprice']");

        // 감소 버튼 클릭 이벤트
        decreaseBtn.click(function() {
            let count = parseInt(counterValue.attr("data-count"), 10);
            if (count > 1) {
                count--;
                updateProductPrice(count);
            } else {
                alert("상품 수량은 최소 1개 이상이어야 합니다.");
            }
        });

        // 증가 버튼 클릭 이벤트
        increaseBtn.click(function() {
            let count = parseInt(counterValue.attr("data-count"), 10);
            count++;
            updateProductPrice(count);
        });

        // 가격 업데이트 및 동기화 함수
        function updateProductPrice(count) {
            counterValue.attr("data-count", count).text(count); 
            quantityInput.val(count);               
            const newPrice = basePrice * count; 	

            priceSpan.attr("data-price", newPrice); 
            priceSpan.text(new Intl.NumberFormat().format(newPrice));
            priceQuantityInput.val(newPrice);
            productPriceInput.val(newPrice);  // productprice 값 동기화
            
            updateTotalPrice();  // 총 가격 업데이트
        }

    });

    // 총 금액 업데이트 함수
    function updateTotalPrice() {
        let total = 0;
        let shipping = 0;

        $(".priceSpan").each(function() {
            const price = parseFloat($(this).attr("data-price")) || 0;
            total += price;
        });

        $(".product_price").text(new Intl.NumberFormat().format(total));
        $("#total_product").text(new Intl.NumberFormat().format(total));
        $("#input_total_product").val(total);

        if (total > 100000) {
            shipping = 0;
        } else {
            shipping = 3000;
        }

        $(".shipping_price").text(new Intl.NumberFormat().format(shipping));
        $("#total_shipping").text(new Intl.NumberFormat().format(shipping));
        $("#input_total_shipping").val(shipping);

        $(".total_price").text(new Intl.NumberFormat().format(total + shipping));
        $("#total_total").text(new Intl.NumberFormat().format(total + shipping));
        $("#input_total_total").val(total + shipping);
    }

});
