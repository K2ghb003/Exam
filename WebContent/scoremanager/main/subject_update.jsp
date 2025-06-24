<%-- メニューJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

			<form action ="SubjectUpdateExecute.action">
				<div>
		          <label for="cd">科目コード</label><br>
		          <input type="text" id="cd" name="cd" value="${subject.cd}" readonly /><br>
		          <c:if test="${not empty errors.cd}">
		            <span class="error">${errors.cd}</span>
		          </c:if>
		        </div>

		        <!-- 科目名 -->
		        <div>
		          <label for="name">科目名</label><br>
		          <input type="text" id="name" name="name" value="${subject.name}" required placeholder="科目名を入力してください" /><br>
		          <c:if test="${not empty errors.name}">
		            <span class="error">${errors.name}</span>
		          </c:if>
		        </div>

		        <div>
		          <input type="submit" value="変更" />
		        </div>
		        <div>
		          <a href="SubjectList.action">戻る</a>
		        </div>
			</form>
		</section>
	</c:param>
</c:import>



