<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
	<c:param name="title">学生情報登録</c:param>
	<c:param name="content">
		<section class="me-4">
			<h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">学生情報登録</h2>
			<form action="StudentCreateExecute.action" method="post">
				<div class="mb-3">
					<label>入学年度</label>
					<select name="entYear" class="form-control">
						<option value="">--------</option>
						<c:forEach var="year" begin="2020" end="2025">
							<option value="${year}">${year}</option>
						</c:forEach>
					</select>
				</div>

				<div class="mb-3">
					<label>学生番号</label>
					<input type="text" name="no" class="form-control" placeholder="学生番号を入力してください" />
				</div>

				<div class="mb-3">
					<label>氏名</label>
					<input type="text" name="name" class="form-control" placeholder="氏名を入力してください" />
				</div>

				<div class="mb-3">
					<label>クラス</label>
					<select name="classNum" class="form-control">
						<c:forEach var="c" items="${class_list}">
							<option value="${c.cd}">${c.cd}</option>
						</c:forEach>
					</select>
				</div>

				<button type="submit" class="btn btn-dark">登録して終了</button>
			</form>
			<div class="mt-2"><a href="StudentList.action">戻る</a></div>
		</section>
	</c:param>
</c:import>
