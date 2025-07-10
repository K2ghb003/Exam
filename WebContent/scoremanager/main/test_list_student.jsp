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
      <c:choose>
		  <c:when test="${mode == 'st'}">
	      	<h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">成績一覧（学生）</h2>
	      </c:when>
		  <c:when test="${mode == 'sj'}">
			<h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">成績一覧（科目別）</h2>
		  </c:when>
		  <c:otherwise>
		    <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">成績一覧</h2>
		  </c:otherwise>
		</c:choose>

      <!-- フィルター -->
      <div style="background: #fff; border: 1px solid #ccc; padding: 16px; border-radius: 8px; margin: 0 16px 16px 16px;">
        <form action="TestListSubjectExecute.action" method="get" class="px-4 mb-3">

		  <label>科目情報</label>

          <label class="me-2">入学年度：</label>
          <select name="entYear" class="me-4">
            <option value="">----</option>
            <c:forEach var="year" items="${entYearList}">
              <option value="${year}" <c:if test="${param.entYear == year}">selected</c:if>>${year}</option>
            </c:forEach>
            <c:if test="${not empty errors.entYear}">
	          <div class="error">${errors.entYear}</div>
	        </c:if>
          </select>

          <label class="me-2">クラス：</label>
          <select name="classNum" class="me-4">
            <option value="">----</option>
            <c:forEach var="c" items="${classList}">
              <option value="${c}" <c:if test="${param.classNum == c}">selected</c:if>>${c}</option>
            </c:forEach>
            <c:if test="${not empty errors.classNum}">
	          <div class="error">${errors.classNum}</div>
	        </c:if>
          </select>

          <label class="me-2">科目：</label>
          <select name="subject" class="me-4">
            <option value="">----</option>
            <c:forEach var="sub" items="${subjectList}">
              <option value="${sub.cd}" <c:if test="${param.subject == sub.cd}">selected</c:if>>${sub.name}</option>
            </c:forEach>
          </select>

          <button type="submit" class="filter-btn me-3">検索</button>

        </form>
      </div>

      <div style="background: #fff; border: 1px solid #ccc; padding: 16px; border-radius: 8px; margin: 0 16px 16px 16px;">
        <form action="TestListStudentExecute.action" method="get" class="px-4 mb-3">

          <label>学生情報</label>

          <label class="me-2">学生番号：</label>
              <input type="text" required id="no" name="no" <c:if test="${not empty student.no}">value="${student.no}"</c:if> />
          <button type="submit" class="filter-btn me-3">検索</button>

        </form>
      </div>

      <c:choose>
		  <c:when test="${mode == 'st'}">
	      	  <!-- 結果 -->
		      <div class="px-4 mb-2">氏名：${student.name}(${student.no})</div>

		  	  <!-- 成績が見つからない場合のメッセージ表示 -->
			  <c:if test="${notFound}">
			    <div class="px-4 mb-2">成績情報が存在しませんでした。</div>
			  </c:if>

			  <!-- 成績情報が存在する場合の表示 -->
		      <!-- 一覧  -->
			  <c:if test="${not empty testliststudent}">
		        <table class="table mb-5" style="border-collapse: collapse;">
		           <thead>
		            <tr>
		              <th class="ps-4">科目名</th>
		              <th>科目コード</th>
		              <th>回数</th>
		              <th>点数</th>
		            </tr>
		          </thead>

		          <tbody>
		            <c:forEach var="testliststudent" items="${testliststudent}">
		              <tr>
		                <td class="ps-4">${testliststudent.subjectName}</td>
		                <td>${testliststudent.subjectCd}</td>
		                <td>${testliststudent.num}</td>
		                <td>${testliststudent.point}</td>
		              </tr>
		            </c:forEach>
		          </tbody>
		        </table>
		      </c:if>
	      </c:when>

		  <c:when test="${mode == 'sj'}">
		    <!-- 結果件数 -->
		      <div class="px-4 mb-2">科目：${subject.name}</div>

			<c:choose>
		  		<c:when test="${empty subjectTestList}">
					<div>学生情報が存在しませんでした</div>
				</c:when>
				<c:otherwise>

		      <!-- 一覧 -->
		      <table class="table mb-5" style="border-collapse: collapse;">
		        <thead>
		          <tr>
		            <th class="ps-4">入学年度</th>
		            <th>クラス</th>
		            <th>学生番号</th>
		            <th>氏名</th>
		            <th>1回</th>
		            <th>2回</th>
		          </tr>
		        </thead>

		        <tbody>
		          <c:forEach var="subjectTest" items="${subjectTestList}">
		            <tr>
		              <td>${subjectTest.entYear}</td>
		              <td>${subjectTest.classNum}</td>
		              <td>${subjectTest.studentNo}</td>
		              <td>${subjectTest.studentName}</td>
		              <td><c:out value="${subjectTest.getPoint(1)}" /></td>
		              <td><c:out value="${subjectTest.getPoint(2)}" /></td>
		            </tr>
		          </c:forEach>
		        </tbody>

		      </table>
		    </c:otherwise>
			</c:choose>
		  </c:when>
		  <c:otherwise>
		  </c:otherwise>
		</c:choose>


    </section>
  </c:param>
</c:import>
