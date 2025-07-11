<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">成績管理</c:param>
  <c:param name="scripts"></c:param>
  <c:param name="content">

  <style>
	  h2 {
	        background-color: #f1f1f1;
	        padding: 10px;
	        font-size: 22px;
	        border-left: 5px solid #007bff;
	        margin-bottom: 20px;
	      }
	  p {
	    margin-top: 0;
	    margin-bottom: 0;
		}
  </style>

    <section class="me-4"> <%--  style="padding: 20px;" --%>
      <!-- ① タイトル -->
      <h2>成績管理</h2> <%--  style="margin-bottom: 20px;" --%>

      <!-- ② 登録完了メッセージ -->
      <%-- <div style="background-color: #a6d8a8; color: #000; padding: 12px 16px; border-radius: 6px; width: fit-content; min-width: 200px;">
        登録が完了しました
      </div> --%>
      <div class="alert alert-success px-4" role="alert" style="--bs-alert-padding-y: 0rem;
      	text-align: center; margin: 0 0 0 0; background-color: #d4edda; border-color: #c3e6cb; color: #0e3818;"> <%--  py-3 --%>
        <p>登録が完了しました</p>
      </div>

      <!-- 間隔 -->
      <div style="margin-left: 1rem; margin-top: 5rem;">
        <a href="TestRegist.action" style="margin-right: 1.5rem; color: #007bff; text-decoration: none;">戻る</a>
        <a href="TestList.action" style="color: #007bff; text-decoration: none;">成績参照</a>
      </div>
      <%-- <div style="height: 30px;"></div>

      <!-- ③ 戻るボタン -->
      <a href="TestRegist.action" style="margin-right: 30px; text-decoration: underline; color: #0000cc;">戻る</a>

      <!-- ④ 成績参照リンク -->
      <a href="TestList.action" style="text-decoration: underline; color: #0000cc;">成績参照</a> --%>
    </section>
  </c:param>
</c:import>
