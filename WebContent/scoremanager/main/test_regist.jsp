<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">成績登録</c:param>
  <c:param name="scripts">
    <script>
      window.addEventListener('DOMContentLoaded', function () {
        const errorElem = document.querySelector('.point-error');
        if (errorElem) {
          errorElem.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
      });
    </script>
  </c:param>

  <c:param name="content">
    <section> <%--  style="padding: 20px;" --%>

      <!-- タイトル -->
      <h2
      <c:if test="${param.searchFlg == 'true'}"> style="border-left: 6px solid #007bff; background-color: #f5f5f5;
                 padding: 12px 16px; margin-bottom: 20px; font-size: 20px; border-radius: 4px;" </c:if>
      <c:if test="${not param.searchFlg == 'true'}">  class="h3 mb-3 bg-secondary bg-opacity-10 py-2 px-4"  </c:if>
      >
        成績管理
      </h2>

      <!-- 検索フォーム -->
      <div style="border: 1px solid #ccc; padding: 16px; border-radius: 6px; margin-bottom: 20px;">
        <form action="TestRegist.action" method="get">
          <input type="hidden" name="searchFlg" value="true">
          <div style="display: flex; justify-content: center; align-items: flex-end; gap: 16px; flex-wrap: wrap;">

            <!-- 入学年度 -->
            <div style="display: flex; flex-direction: column; min-width: 120px;">
              <label>入学年度：</label>
              <select name="f1">
                <option value="">--------</option>
                <c:forEach var="year" items="${entYearList}">
                  <option value="${year}" <c:if test="${param.f1 == year}">selected</c:if>>${year}</option>
                </c:forEach>
              </select>
            </div>

            <!-- クラス -->
            <div style="display: flex; flex-direction: column; min-width: 120px;">
              <label>クラス：</label>
              <select name="f2">
                <option value="">--------</option>
                <c:forEach var="cnum" items="${classNumList}">
                  <option value="${cnum}" <c:if test="${param.f2 == cnum}">selected</c:if>>${cnum}</option>
                </c:forEach>
              </select>
            </div>

            <!-- 科目 -->
            <div style="display: flex; flex-direction: column; min-width: 120px;">
              <label>科目：</label>
              <select name="f3">
                <option value="">--------</option>
                <c:forEach var="subject" items="${subjectList}">
                  <option value="${subject.cd}" <c:if test="${param.f3 == subject.cd}">selected</c:if>>${subject.name}</option>
                </c:forEach>
              </select>
            </div>

            <!-- 回数 -->
            <div style="display: flex; flex-direction: column; min-width: 120px;">
              <label>回数：</label>
              <select name="f4">
                <option value="">--------</option>
                <c:forEach begin="1" end="2" var="i">
                  <option value="${i}" <c:if test="${param.f4 == i}">selected</c:if>>${i}</option>
                </c:forEach>
              </select>
            </div>

            <!-- 検索ボタン -->
            <div style="align-self: flex-end;">
              <input type="submit" value="検索" style="padding: 6px 14px;">
            </div>
          </div>

          <!-- 共通エラー表示 -->
          <%--
          System.out.println(request.getParameter("f1"));
          System.out.println(request.getParameter("f2"));
          System.out.println(request.getParameter("f3"));
          System.out.println(request.getParameter("f4"));

          --%>
          <c:if test="${param.searchFlg == 'true'
              && (empty param.f1 or empty param.f2 or empty param.f3 or empty param.f4)}">
              <div class="error"  style="color: #f8a73d; font-size: 0.9rem; margin-top: 12px; padding-left: 4.5em">
			    <c:set var="first" value="true" />

			    <c:if test="${empty param.f1}">
			      <c:if test="${not first}">、</c:if>
			      入学年度
			      <c:set var="first" value="false" />
			    </c:if>

			    <c:if test="${empty param.f2}">
			      <c:if test="${not first}">、</c:if>
			      クラス
			      <c:set var="first" value="false" />
			    </c:if>

			    <c:if test="${empty param.f3}">
			      <c:if test="${not first}">、</c:if>
			      科目
			      <c:set var="first" value="false" />
			    </c:if>

			    <c:if test="${empty param.f4}">
			      <c:if test="${not first}">、</c:if>
			      回数
			      <c:set var="first" value="false" />
			    </c:if>
	            を入力してください
			  </div>
            <%-- <div style="color: #f8a73d; font-size: 0.9rem; margin-top: 12px; text-align: center;">
              すべて選択してください。
            </div> --%>
          </c:if>
        </form>
      </div>

      <!-- 成績入力フォーム -->
      <c:if test="${empty studentList && param.searchFlg == 'true'}">
			    <div class="px-4 mb-2">成績情報が存在しませんでした。</div>
			  </c:if>
      <c:if test="${not empty studentList}">
        <form action="TestRegistExecute.action" method="post">
          <input type="hidden" name="entYear" value="${param.f1}">
          <input type="hidden" name="classNum" value="${param.f2}">
          <input type="hidden" name="subject" value="${param.f3}">
          <input type="hidden" name="count" value="${param.f4}">

          <!-- 科目名と回数表示 -->
          <div style="margin-bottom: 10px; font-size: 16px;">
            科目：
            <c:forEach var="subject" items="${subjectList}">
              <c:if test="${subject.cd == param.f3}">
                ${subject.name}
              </c:if>
            </c:forEach>
            （<c:out value="${param.f4}" />回）
          </div>

          <!-- テーブル -->
          <table style="width: 100%; border-collapse: collapse;">
            <thead style="background-color: #f0f8ff;">
              <tr style="border-bottom: 1px solid #ccc;">
                <th style="text-align: left; padding: 8px;">入学年度</th>
                <th style="text-align: left; padding: 8px;">クラス</th>
                <th style="text-align: left; padding: 8px;">学生番号</th>
                <th style="text-align: left; padding: 8px;">氏名</th>
                <th style="text-align: left; padding: 8px;">点数</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="student" items="${studentList}">
                <tr style="border-bottom: 1px solid #eee;">
                  <td style="padding: 8px;">${param.f1}</td>
                  <td style="padding: 8px;">${param.f2}</td>
                  <td style="padding: 8px;">${student.no}</td>
                  <td style="padding: 8px;">${student.name}</td>
                  <td style="padding: 8px;">
                    <input type="hidden" name="regist" value="${student.no}">
                    <input type="number" name="point"
                           value="${pointMap[student.no] != null ? pointMap[student.no] : ''}"
                           style="width: 60px;">
                    <c:if test="${not empty pointErrors[student.no]}">
                      <div class="point-error" style="color: #f8a73d; font-size: 0.9rem; margin-top: 4px;">
                        ${pointErrors[student.no]}
                      </div>
                    </c:if>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>

          <br>
          <input type="submit" value="登録して終了"
                 style="background-color: #007bff; color: white; padding: 8px 20px; border: none; border-radius: 4px;">
        </form>
      </c:if>
    </section>
  </c:param>
</c:import>
