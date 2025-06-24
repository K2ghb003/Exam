<%-- メニューJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="bean.Subject, java.util.List" %>
<%
@SuppressWarnings("unchecked")
Subject subject=(Subject)request.getAttribute("subject");
%>
<c:import url="/common/base.jsp">
	<c:param name="title">
		得点管理システム
	</c:param>

	<c:param name="scripts"></c:param>

	<c:param name="content">
		<section class="me-4">
			<h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">科目管理</h2>

			<form action ="SubjectDeleteExecute.action">
				<p>「<%=subject.getName() %>(<%=subject.getCd() %>)を削除してもよろしいですか」</p>
				<input type="text" name="cd" value="<%=subject.getCd() %>" hidden>
				<input type="submit" value="削除">
				<p><a href="SubjectList.action">戻る</a></p>
			</form>
		</section>
	</c:param>
</c:import>



