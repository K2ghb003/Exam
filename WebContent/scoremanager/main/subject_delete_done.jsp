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
	<c:param name="title">
		得点管理システム
	</c:param>

	<c:param name="scripts"></c:param>

	<c:param name="content">
		<section class="me-4">
			<h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">科目情報削除</h2>

      		<p style="background-color:#80bd9e; text-align:center ">削除が完了しました</p>

			<p><a href="SubjectList.action">科目一覧</a></p>
		</section>
	</c:param>
</c:import>



