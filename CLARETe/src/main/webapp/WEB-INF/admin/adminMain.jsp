<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
    String ctxPath = request.getContextPath();
%>

    <jsp:include page="adminheader.jsp"></jsp:include>
    
    <section>
        <div style="display: flex; flex-wrap: wrap;">
            <div class="first-div">
                <div style="margin: 30px 0px 0px 30px;">
                    <form>
                        <div style="display: flex; gap: 8px; flex-wrap: wrap;">
                            <div class="input-box">
                                <div><label for="userid">유저 아이디</label></div>
                                <div>
                                    <input type="text" id="userid" name="userid" placeholder="유저 아이디를 입력하세요">
                                </div>
                            </div>
                            <div class="input-box">
                                <div><label for="userid">유저명</label></div>
                                <div>
                                    <input type="text" id="userid" name="userid" placeholder="유저명을 입력하세요">
                                </div>
                            </div>
                        </div>
                        <div style="display: flex; gap: 8px; flex-wrap: wrap;">
                            <div class="input-box">
                                <div><label for="userid">삭제여부</label></div>
                                <div>
                                    <input type="text" id="userid" name="userid" placeholder="전체">
                                </div>
                            </div>
                            <div class="input-box">
                                <div><label for="userid">휴면여부</label></div>
                                <div>
                                    <input type="text" id="userid" name="userid" placeholder="전체">
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="form-btn-box">
                        <input type="submit" class="btn search" value="검색"/>
                        <input type="reset" class="btn reset" value="초기화"/>
                    </div>
                </div>
            </div>

        </div>
        <div class="second-div">
            <h1>관리자 메인으로 쓸 페이지입니다.!!!!!!!!!!!!</h1>
        </div>
    </section>

<jsp:include page="adminfooter.jsp"></jsp:include>