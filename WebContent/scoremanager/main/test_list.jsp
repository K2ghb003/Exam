<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="/common/base.jsp">
  <c:param name="title">得点管理システム</c:param>

  <c:param name="scripts"></c:param>

  <c:param name="content">
    <style>
      select, input[type="checkbox"] {
        border: 1px solid #ccc;
        padding: 4px 8px;
        border-radius: 4px;
      }

      .filter-btn {
        background-color: #e0e0e0;
        border: 1px solid #aaa;
        padding: 4px 16px;
        border-radius: 4px;
        font-weight: bold;
        color: #333;
      }

      .filter-btn:hover {
        background-color: #d0d0d0;
      }

      .table th,
      .table td {
        border-top: 1px solid #ccc !important;
        border-bottom: none !important;
      }

      .table thead th {
        font-weight: bold;
      }

      .table td, .table th {
        vertical-align: middle;
      }
    </style>

    <section class="me-4">
      <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">成績一覧</h2>

      <!-- フィルター -->
      <div style="background: #fff; border: 1px solid #ccc; padding: 16px; border-radius: 8px; margin: 0 16px 16px 16px;">
        <form action="TestListSubjectExecute.action" method="get" class="px-4 mb-3">
        <div style="display: flex; justify-content: center; align-items: flex-end; gap: 16px;">
         <div style="display: flex; flex-direction: column; min-width: 120px;">
		    <p>科目情報</p>
		  </div>
          <div style="display: flex; flex-direction: column; min-width: 120px;">
	          <label class="me-2">入学年度：</label>
	          <select name="entYear" class="me-4">
	            <option value="">----</option>
	            <c:forEach var="year" items="${entYearList}">
	              <option value="${year}" <c:if test="${param.entYear == year}">selected</c:if>>${year}</option>
	            </c:forEach>
	            <c:if test="${not empty requestScope.errors}">
		          <div class="error">${requestScope.errors.get(entYear)}</div>
		        </c:if>
	          </select>
		  </div>
		  <div style="display: flex; flex-direction: column; min-width: 120px;">
          <label class="me-2">クラス：</label>
          <select name="classNum" class="me-4">
            <option value="">----</option>
            <c:forEach var="c" items="${classList}">
              <option value="${c}" <c:if test="${param.classNum == c}">selected</c:if>>${c}</option>
            </c:forEach>
            <c:if test="${not empty requestScope.errors}">
	          <div class="error">${requestScope.errors.classNum}</div>
	        </c:if>
          </select>
          </div>
          <div style="display: flex; flex-direction: column; min-width: 120px;">
  		  <label class="me-2">科目：</label>
          <select name="subject" class="me-4">
            <option value="">----</option>
            <c:forEach var="sub" items="${subjectList}">
              <option value="${sub.cd}" <c:if test="${param.subject == sub.cd}">selected</c:if>>${sub.name}</option>
            </c:forEach>
            <c:if test="${not empty requestScope.errors}">
	          <div class="error">$requestScope.{errors['subject']}</div>
	        </c:if>
          </select>
          </div>
        <button type="submit" class="filter-btn me-3">検索</button>
		</div>
        </form>
        <%--<p>DEBUG: entYear param = ${param.entYear}</p>
		<p>DEBUG: errors = ${errors}</p> --%>

	        <c:if test="${errors.size() > 0}">
	          <div class="error">
		          <%--<c:if test="${not empty errors.entYear}">${errors.entYear}</c:if>
		          <c:if test="${not empty errors.classNum}">${errors.classNum}</c:if>
		          <c:if test="${not empty errors.subject}">${errors.subject}</c:if> --%>

		            <c:if test="${errors.size() > 0}">
					  <div class="error"  style="color: #f8a73d">
					    <c:set var="first" value="true" />

					    <c:if test="${not empty errors.entYear}">
					      <c:if test="${not first}">、</c:if>
					      ${errors['entYear']}
					      <c:set var="first" value="false" />
					    </c:if>

					    <c:if test="${not empty errors.classNum}">
					      <c:if test="${not first}">、</c:if>
					      ${errors['classNum']}
					      <c:set var="first" value="false" />
					    </c:if>

					    <c:if test="${not empty errors.subject}">
					      <c:if test="${not first}">、</c:if>
					      ${errors['subject']}
					      <c:set var="first" value="false" />
					    </c:if>
		          を入力してください
					  </div>
					</c:if>


	          </div>
	        </c:if>

		<hr>

        <form action="TestListStudentExecute.action" method="get" class="px-4 mb-3">
		<div style="display: flex; align-items: flex-end; gap: 8px; flex-wrap: wrap;">
		  <div style="display: flex; flex-direction: column; min-width: 120px;">
            <p>学生情報</p>
          </div>

		  <div style="display: flex; flex-direction: column; min-width: 120px;">
          <label class="me-2">学生番号：</label>
              <input type="text" id="no" name="no" required />
		  </div>
		  <div style="display: flex; flex-direction: column; min-width: 120px;">
          <button type="submit" class="filter-btn me-3">検索</button>
          </div>

		</div>
        </form>
      </div>

      <!-- 結果件数 -->
      <p style="color: #00c5ff">科目情報を選択または学生情報を入力してして検索ボックスをクリックしてください</p>

    </section>
  </c:param>
</c:import>
