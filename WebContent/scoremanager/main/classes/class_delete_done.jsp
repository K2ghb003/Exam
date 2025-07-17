<%-- メニューJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="bean.Subject, java.util.List" %>
<%
@SuppressWarnings("unchecked")
List<Subject> list=(List<Subject>)request.getAttribute("subject_list");
%>
<c:import url="/common/base.jsp">
	<c:param name="title">得点管理システム</c:param>
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

	    <section>
	      <h2>クラス情報削除</h2>
	      <div class="alert alert-success px-4" role="alert" style="--bs-alert-padding-y: 0rem;
      	text-align: center; margin: 0 0 0 0; background-color: #d4edda; border-color: #c3e6cb; color: #0e3818;"> <%--  py-3 --%>
        <p>削除が完了しました</p>
      </div>

		  <div class="link" style="margin-left: 1rem; margin-top: 5rem;">
		  	<p><a href="ClassList.action">クラス一覧</a></p>
		  </div>
		</section>
	</c:param>
</c:import>



