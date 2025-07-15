<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="/common/base.jsp">
  <c:param name="title">得点管理システム</c:param>

  <c:param name="scripts"></c:param>

  <c:param name="content">
    <style>
      h3 {
      font-weight: bold;
      }

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

      .create-link {
        color: #28a745;
        font-weight: bold;
        text-decoration: none;
        margin-right: 12px;
        transition: color 0.2s;
        text-decoration: underline;
      }

      .create-link:hover {
        color: #1e7e34;
        text-decoration: underline;
      }
    </style>

    <section class="me-4">
      <h2 class="h3 mb-3 bg-secondary bg-opacity-10 py-2 px-4">学生管理</h2>
      <div style="text-align: right; margin: 0 16px 16px 0;">
        <a href="StudentCreate.action" class="create-link">新規登録</a>
      </div>

      <!-- フィルター -->
      <div style="background: #fff; border: 1px solid #ccc; padding: 16px; border-radius: 8px; margin: 5px 16px 16px 16px;">
      <form action="StudentList.action" method="get" class="mb-3">
	  <table>
		  <tr>
		  	<td style="width: 30%;">
		          <label class="me-2">入学年度：</label><br>
		          <select name="entYear" class="me-4" style="width: 85%">
		            <option value="">----</option>
		            <c:forEach var="year" items="${entYearList}">
		              <option value="${year}" <c:if test="${param.entYear == year}">selected</c:if>>${year}</option>
		            </c:forEach>
		          </select>
		    </td>
			<td style="width: 30%;">
		          <label class="me-2">クラス：</label><br>
		          <select name="classNum" class="me-4" style="width: 85%">
		            <option value="">----</option>
		            <c:forEach var="c" items="${classNumList}">
		              <option value="${c}" <c:if test="${param.classNum == c}">selected</c:if>>${c}</option>
		            </c:forEach>
		          </select>
		    </td>
			<td style="width: 18%;">
		          <label class="me-3">
		            <input class="form-check-input" type="checkbox" name="isAttend" value="true" <c:if test="${param.isAttend == 'true'}">checked</c:if>> 在学中
		          </label>
			</td>
			<td style="width: 10%;">
		          <button type="submit" class="filter-btn">絞込み</button>
		    </td>
		  </tr>
	  </table>
      </form>
      </div>
	<c:choose>
    <c:when test="${fn:length(students) >0 }">
      <!-- 結果件数 -->
      <div class="px-4 mb-2">検索結果：${fn:length(students)}件</div>

      <!-- 一覧 -->
      <table class="table mb-5" style="border-collapse: collapse;">
        <thead>
          <tr>
            <th class="ps-4">入学年度</th>
            <th>学生番号</th>
            <th>氏名</th>
            <th>クラス</th>
            <th>在学中</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="student" items="${students}">
            <tr>
              <td class="ps-4">${student.entYear}</td>
              <td>${student.no}</td>
              <td>${student.name}</td>
              <td>${student.classNum}</td>
              <td>
                <c:choose>
                  <c:when test="${student.attend}">○</c:when>
                  <c:otherwise>×</c:otherwise>
                </c:choose>
              </td>
              <td><a href="StudentUpdate.action?no=${student.no}">変更</a></td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      </c:when>
    <c:otherwise>
        <p>学生情報が存在しませんでした</p>
    </c:otherwise>
</c:choose>


    </section>
  </c:param>
</c:import>
