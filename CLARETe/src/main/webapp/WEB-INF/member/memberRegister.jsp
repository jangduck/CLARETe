<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    //    /SEMI
%> 
   
<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/memberRegister.css" />


<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/js/member/memberRegister.js"></script>
    
<div id="container">
      
      <h2>로고</h2>
      <form name="registerFrm">
         <h4>회원가입</h4>
            <div id="divId">
               <span>아이디</span>
               <input type="text" name="id" id="id" placeholder="아이디를 입력해주세요" />
               <input type="button" id="idCheck" value="중복확인" onclick="duplicateId()" />
            </div>
            
            <div id="divPwd">
               <span>비밀번호</span>
               <input type="text" name="pwd" id="pwd" placeholder="비밀번호를 입력해주세요" />
            </div>
            
            
            <div id="divPwdCheck">
               <span>비밀번호확인</span>
               <input type="text" id="pwdCheck" placeholder="비밀번호를 한번 더 입력해주세요" />
            </div>
         
            <div id="divName">
               <span>이름</span>
               <input type="text" name="name" id="name" placeholder="이름을 입력해주세요" />
            </div>
            
            
            <div id="divEmail">
               <span>이메일</span>
               <input type="text" name="email" id="email" placeholder="예: hongkd@naver.com" />
               <input type="button" id="emailCheck" value="중복확인" onclick="duplicateEmail()" />
            </div>
            
            <div id="divMobile">
               <span>휴대폰</span>
               <input type="text" name="mobile" id="mobile" placeholder="숫자만 입력해주세요" />
            </div>
            
            <div id="divPostcode">
               <span>우편번호</span>
               <input type="text" name="postcode" id="postcode" placeholder="우편번호" />
               <%-- 우편번호 찾기 --%>
               <input type="button" id="zipcodeSearch" value="우편번호 찾기" onclick="searchPostcode()"/>
            </div>
            
            <div id="divAddress">
               <span>주소</span>
               <input type="text" name="address" id="address" size="40" maxlength="200" placeholder="주소" /><br>
               <span>상세주소</span>
                    <input type="text" name="detailaddress" id="detailAddress" size="40" maxlength="200" placeholder="상세주소" />&nbsp;
                    <input type="text" name="extraaddress" id="extraAddress" size="40" maxlength="200" placeholder="참고항목" />  
            </div>
            
            <div id="divGender">
               <span>성별</span>
               <input type="radio" name="gender" value="1" id="male" /><label for="male" style="margin-left: 1.5%;">남자</label>
                    <input type="radio" name="gender" value="2" id="female" style="margin-left: 10%;" /><label for="female" style="margin-left: 1.5%;">여자</label>
            </div>
            
            <div id="divBirthday">
               <span>생년월일</span>
               <input type="text" name="birthday" id="birthday" placeholder="YYYY/MM/DD" />
            </div>
         
              <div id="submit">
                 <input type="button" value="가입하기" onclick="goRegister()" />
              </div>
         
         
      </form>
      
   </div>