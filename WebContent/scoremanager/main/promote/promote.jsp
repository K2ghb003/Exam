<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">進級処理</c:param>

  <c:param name="scripts">
    <script>
      // 一括クラス選択適用スクリプト
      function applyClassToAll() {
        const selectedClass = document.getElementById("bulkClassSelect").value;
        const selects = document.querySelectorAll("select.student-class-select");
        selects.forEach(select => {
          select.value = selectedClass;
        });
      }
    </script>

    <style>
    label { display: inline-block; width: 100%; }
    </style>
  </c:param>

  <c:param name="content">
    <section class="container mt-5">
      <h2 class="mb-4 text-center">進級処理</h2>

      <!-- 学校・年度選択フォーム -->
      <form id="promoteForm" method="post" action="Promote.action" class="mx-auto" style="max-width: 800px;">
        <div class="form-group mb-3">
          <label for="schoolCd">学校</label>
          <select name="schoolCd" id="schoolCd" class="form-control" required onchange="this.form.submit();">
            <c:forEach var="school" items="${schoolList}">
              <option value="${school.cd}" <c:if test="${school.cd == selectedSchoolCd}">selected</c:if>>
                ${school.name}
              </option>
            </c:forEach>
          </select>
        </div>

        <div class="form-group mb-3">
          <label for="year">対象年度</label>
          <select name="year" id="year" class="form-control" required onchange="this.form.submit();">
            <c:forEach var="y" items="${yearList}">
              <option value="${y}" <c:if test="${y == selectedYear}">selected</c:if>>${y}</option>
            </c:forEach>
          </select>
        </div>
      </form>

      <c:if test="${not empty studentList}">
        <form method="get" action="/exam/scoremanager/main/promote/PromoteExecute.action">		<%-- ARREGLAR! --%>
          <input type="hidden" name="schoolCd" value="${selectedSchoolCd}" />
          <input type="hidden" name="year" value="${selectedYear}" />

          <%-- <!-- 一括クラス選択 -->
          <div class="form-group mt-4">
            <label for="bulkClassSelect">すべての学生に進級先クラスを適用：</label>
            <div class="d-flex">
              <select id="bulkClassSelect" class="form-control mr-2" style="max-width: 300px;">
                <c:forEach var="cls" items="${classList}">
                  <option value="${cls.class_num}">${cls.class_num}</option>
                </c:forEach>
              </select>
              <button type="button" class="btn btn-secondary" onclick="applyClassToAll()">適用</button>
            </div>
          </div>
          --%>

          <h5 class="mt-4">進級対象学生の選択</h5>
          <table class="table table-bordered mt-2">
            <thead>
              <tr>
                <th>進級</th>
                <th>学生番号</th>
                <th>氏名</th>
                <th>学年</th>
                <th>現在のクラス</th>
                <%--<th>進級先クラス</th> --%>
                <th>備考</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="student" items="${studentList}">
                <%--<c:set var="grade" value="${currentYear - student.entYear + 1}" />
                <c:if test="${grade <= 2}"> --%>
                  <tr>
                    <td class="text-center">
                      <%--<c:choose>
                        <c:when test="${!student.attend || student.entYear + 2 <= currentYear}">
                          <input type="checkbox" disabled>
                        </c:when>
                        <c:otherwise>--%>
                          <label><input type="checkbox" id="promoteIds" name="promoteIds" value="${student.no}" checked></label>
                        <%--</c:otherwise>
                      </c:choose>--%>
                    </td>
                    <td>${student.no}</td>
                    <td>${student.name}</td>
                    <td>${student.year} 年生</td>
                    <td>${student.classNum}</td>
                    <%--<td>
                      <c:choose>
                        <c:when test="${!student.attend || student.entYear + 2 <= currentYear}">
                          -
                        </c:when>
                        <c:otherwise>
                          <select name="class_${student.no}" class="form-control student-class-select">
                            <c:forEach var="cls" items="${classList}">
                              <option value="${cls.class_num}">${cls.class_num}</option>
                            </c:forEach>
                          </select>
                        </c:otherwise>
                      </c:choose>
                    </td> --%>
                    <td>
                      <c:choose>
                        <c:when test="${!student.attend}">
                          <span class="text-danger">退学済み</span>
                        </c:when>
                        <c:when test="${student.year == 2}">
                          <span class="text-warning">卒業予定</span>
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                <%--</c:if>--%>
              </c:forEach>
            </tbody>
          </table>

          <div class="text-center mt-4">
            <button type="submit" class="btn btn-primary">進級処理を実行</button>
          </div>

          <c:if test="${not empty message}">
            <div class="alert alert-info mt-4 text-center">${message}</div>
          </c:if>
        </form>
      </c:if>
    </section>
  </c:param>
</c:import>
