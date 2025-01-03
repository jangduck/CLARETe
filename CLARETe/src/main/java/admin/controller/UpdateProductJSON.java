package admin.controller;

import org.json.JSONObject;

import common.controller.AbstractController;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import product.domain.ProductVO;
import yihun.myshop.model.ProductDAO;
import yihun.myshop.model.ProductDAO_imple;

public class UpdateProductJSON extends AbstractController {

    private ProductDAO pdao = new ProductDAO_imple();

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
        String method = request.getMethod();

        if ("post".equalsIgnoreCase(method)) {
            // POST 요청 처리
        	// System.out.println("여기까진 오십니까");
            int p_num = Integer.parseInt(request.getParameter("p_num"));

            // System.out.println("찍어보자" + request.getParameter("p_num"));
            
          
            // 해당 상품 정보 가져오기
            ProductVO pvo = pdao.selectProductOne(p_num);

            // JSON 객체 생성
            JSONObject jsonObj = new JSONObject();
            
            // System.out.println("불러옴? " +pvo.getP_num());
            
            jsonObj.put("p_num", pvo.getP_num());                  // 상품번호
            jsonObj.put("p_name", pvo.getP_name());                // 상품명
            jsonObj.put("p_season", pvo.getP_season());            // 계절
            jsonObj.put("p_sale", pvo.getP_sale());                // 할인율
            jsonObj.put("p_price", pvo.getP_price());              // 가격
            jsonObj.put("p_register", pvo.getP_register());        // 등록일
            jsonObj.put("p_release", pvo.getP_release());          // 발매일
            jsonObj.put("p_ex", pvo.getP_ex());                    // 설명
            jsonObj.put("p_inven", pvo.getP_inven());              // 재고
            jsonObj.put("p_gender", pvo.getP_gender());            // 성별
            jsonObj.put("p_image", pvo.getP_image());              // 이미지
            jsonObj.put("p_detail_image", pvo.getP_detail_image()); // 상세 이미지

            // JSON 데이터 출력
            response.setContentType("application/json; charset=UTF-8");
            response.getWriter().print(jsonObj.toString());
            response.getWriter().flush();
            
        } else {
            // GET 요청 처리 (필요하면 추가)
            
        }
    }
}
