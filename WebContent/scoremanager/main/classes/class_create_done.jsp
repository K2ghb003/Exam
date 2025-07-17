<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">登録完了</c:param>
  <c:param name="scripts"></c:param>
  <c:param name="content">

    <style>
      h2 {
        background-color: #f1f1f1;
        padding: 10px;
        font-size: 22px;
        border-left: 5px solid #28a745;
        margin-bottom: 20px;
      }
    p {
	    margin-top: 0;
	    margin-bottom: 0;
		}

	</style>

    <section class="me-4">
      <h2>クラス情報登録</h2>

      <div class="alert alert-success px-4" role="alert" style="--bs-alert-padding-y: 0rem;
      	text-align: center; margin: 0 0 0 0; background-color: #d4edda; border-color: #c3e6cb; color: #0e3818;"> <%--  py-3 --%>
        <p>登録が完了しました</p>
      </div>

	  <div style="margin-left: 1rem; margin-top: 5rem;">
        <a href="ClassCreate.action" style="margin-right: 1.5rem; color: #007bff; text-decoration: none;">戻る</a>
        <a href="ClassList.action" style="color: #007bff; text-decoration: none;">クラス一覧</a>
      </div>
    </section>
  </c:param>
</c:import>
