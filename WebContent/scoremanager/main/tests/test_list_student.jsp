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
		  <c:when test="${mode == 'st'}"> <%-- fw-normal  --%>
	      	<h2 class="h3 mb-3 bg-secondary bg-opacity-10 py-2 px-4">成績一覧（学生）</h2>
	      </c:when>
		  <c:when test="${mode == 'sj'}">
			<h2 class="h3 mb-3 bg-secondary bg-opacity-10 py-2 px-4">成績一覧（科目別）</h2>
		  </c:when>
		  <c:otherwise>
		    <h2 class="h3 mb-3 bg-secondary bg-opacity-10 py-2 px-4">成績一覧</h2>
		  </c:otherwise>
		</c:choose>

      <!-- フィルター -->
      <div class="bg-white border rounded p-3 p-md-4 mb-4 mx-2">
        <!-- 科目情報検索 -->
        <form action="TestListSubjectExecute.action" method="get" class="mb-3">
          <div class="row g-3">
            <div class="col-12">
              <p class="mb-0 fw-bold">科目情報</p>
            </div>

            <div class="col-6 col-md-3">
              <label for="entYear" class="form-label">入学年度：</label>
              <select name="entYear" class="form-select w-100">
                <option value="">----</option>
                <c:forEach var="year" items="${entYearList}">
                  <option value="${year}" <c:if test="${param.entYear == year}">selected</c:if>>${year}</option>
                </c:forEach>
              </select>
            </div>

            <div class="col-6 col-md-3">
              <label for="classNum" class="form-label">クラス：</label>
              <select name="classNum" class="form-select w-100">
                <option value="">----</option>
                <c:forEach var="c" items="${classList}">
                  <option value="${c}" <c:if test="${param.classNum == c}">selected</c:if>>${c}</option>
                </c:forEach>
              </select>
            </div>

            <div class="col-12 col-md-4">
              <label for="subject" class="form-label">科目：</label>
              <select name="subject" class="form-select w-100">
                <option value="">----</option>
                <c:forEach var="sub" items="${subjectList}">
                  <option value="${sub.cd}" <c:if test="${param.subject == sub.cd}">selected</c:if>>${sub.name}</option>
                </c:forEach>
              </select>
            </div>

            <div class="col-12 col-md-2 d-grid align-items-end">
              <button type="submit" class="filter-btn">検索</button>
            </div>
          </div>
        </form>

        <!-- エラー表示 -->
        <c:if test="${errors.size() > 0}">
          <div class="error mt-2">
            <c:set var="first" value="true" />
            <c:if test="${not empty errors.entYear}">
              <c:if test="${not first}">、</c:if>${errors['entYear']}
              <c:set var="first" value="false" />
            </c:if>
            <c:if test="${not empty errors.classNum}">
              <c:if test="${not first}">、</c:if>${errors['classNum']}
              <c:set var="first" value="false" />
            </c:if>
            <c:if test="${not empty errors.subject}">
              <c:if test="${not first}">、</c:if>${errors['subject']}
            </c:if>
            を入力してください
          </div>
        </c:if>

        <hr>

        <!-- 学生番号検索 -->
        <form action="TestListStudentExecute.action" method="get" class="mb-3">
          <div class="row g-3 align-items-end">
            <div class="col-12">
              <p class="mb-0 fw-bold">学生情報</p>
            </div>

            <div class="col-6 col-md-4">
              <label for="no" class="form-label">学生番号：</label>
              <input type="text" id="no" name="no" class="form-control" required />
            </div>

            <div class="col-6 col-md-2 d-grid">
              <button type="submit" class="filter-btn">検索</button>
            </div>
          </div>
        </form>
      </div>

      <c:choose>
		  <c:when test="${mode == 'st'}">
	      	  <!-- 結果 -->
	      	  <c:if test="${not empty student}">
		      <div class="px-4 mb-2">氏名：${student.name}(${student.no})</div>
		      </c:if>

		  	  <!-- 成績が見つからない場合のメッセージ表示 -->
			  <c:if test="${notFound}">
			    <div class="px-4 mb-2">成績情報が存在しませんでした。</div>
			  </c:if>

			  <c:if test="${notExistant}">
			    <div class="px-4 mb-2">学生の情報が存在しませんでした。</div>
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
		                <td><c:if test="${not empty testliststudent.point}">${testliststudent.point}</c:if>
		                	<c:if test="${empty testliststudent.point}"> - </c:if></td>
		              </tr>
		            </c:forEach>
		          </tbody>
		        </table>
		      </c:if>
	      </c:when>

		  <c:when test="${mode == 'sj'}">
		    <!-- 結果件数 -->

			<%-- <c:choose>
				<c:when test="${empty subjectTestList}"> --%>
			<c:if test="${not empty subjectTestList}">
		      <div class="px-4 mb-2">科目：${subject.name}</div>
		    </c:if>

		  	  <!-- 成績が見つからない場合のメッセージ表示 -->
			  <c:if test="${notFound}">
			    <div class="px-4 mb-2">成績情報が存在しませんでした。</div>
			  </c:if>

			  <c:if test="${notExistant}">
			    <div class="px-4 mb-2">学生の情報が存在しませんでした。</div>
			  </c:if>
		  		<%-- <c:when test="${empty subjectTestList}">
					<div>学生情報が存在しませんでした</div> --%>
				<%-- </c:when> --%>
			<%-- <c:otherwise> --%>

			<c:if test="${not empty subjectTestList}">
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
		              <td><c:if test="${not empty subjectTest.getPoint(1)}"><c:out value="${subjectTest.getPoint(1)}" /></c:if>
		              		<c:if test="${empty subjectTest.getPoint(1)}"> - </c:if></td>
		              <td><c:if test="${not empty subjectTest.getPoint(2)}"><c:out value="${subjectTest.getPoint(1)}" /></c:if>
		              		<c:if test="${empty subjectTest.getPoint(2)}"> - </c:if></td>
		            </tr>
		          </c:forEach>
		        </tbody>

		      </table>
		    </c:if>
		    <%-- </c:otherwise>
			</c:choose> --%>
		  </c:when>
		  <c:otherwise>
		  </c:otherwise>
		</c:choose>


    </section>
  </c:param>
</c:import>
