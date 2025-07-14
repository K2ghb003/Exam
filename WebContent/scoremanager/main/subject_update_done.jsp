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
	        border-left: 5px solid #007bff;
	        margin-bottom: 20px;
	      }

		</style>

	    <section>
	      <h2>科目情報変更</h2>
	      <p style="background-color:#80bd9e; text-align:center ">変更が完了しました</p>

		  <div class="link" style="margin-left: 1rem; margin-top: 5rem;">
		  	<a href="SubjectList.action">科目一覧</a>
		  </div>
		</section>
	</c:param>
</c:import>



