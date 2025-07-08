<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/common/base.jsp">
  <c:param name="title">学生情報登録</c:param>
  <c:param name="content">
    <style>
      .form-container {
        width: 500px;
        margin: 0 auto;
      }

      h2 {
        background-color: #f1f1f1;
        padding: 10px;
        font-size: 22px;
        border-left: 5px solid #007bff;
        margin-bottom: 20px;
      }

      label {
        font-weight: bold;
        display: block;
        margin-bottom: 6px;
        font-size: 15px;
      }

      input[type="text"],
      select {
        border-radius: 8px;
        padding: 10px;
        width: 100%;
        font-size: 16px;
        border: 2px solid #cce4ff;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.08);
        outline: none;
        margin-bottom: 6px;
        transition: all 0.2s ease-in-out;
      }

      input[type="text"]:focus,
      select:focus {
        border-color: #66afe9;
        box-shadow: 0 0 6px rgba(102, 175, 233, 0.6);
      }

      .error {
        color: orange;
        font-size: 14px;
        margin-top: -4px;
        margin-bottom: 10px;
        margin-left: 4px;
        display: block;
      }

      .btn-submit {
        background-color: #007bff;
        color: white;
        padding: 10px 24px;
        font-size: 16px;
        border-radius: 6px;
        border: none;
        cursor: pointer;
        margin: 15px 0px 15px 0px;
      }

      .btn-submit:hover {
        background-color: #0056b3;
      }

      a {
        <%--margin-left: 12px;
        font-size: 14px;
        display: inline-block;
        margin-top: 16px;
        color: #007bff;
        text-decoration: none;--%>
      }

      a:hover {
        text-decoration: underline;
      }
    </style>

    <div><%--  class="form-container" --%>
      <h2>学生情報登録</h2>
      <form action="StudentCreateExecute.action" method="post">

        <!-- 入学年度 -->
        <label for="entYear">入学年度</label>
        <select id="entYear" name="entYear">
          <option value="">選択してください</option>
          <c:forEach var="y" items="${entYearList}">
            <option value="${y}" <c:if test="${student.entYear == y}">selected</c:if>>${y}</option>
          </c:forEach>
        </select>
        <c:if test="${not empty errors.entYear}">
          <div class="error">${errors.entYear}</div>
        </c:if>

        <!-- 学生番号 -->
        <label for="no">学生番号</label>
        <input type="text" id="no" name="no" value="${student.no}" placeholder="学生番号を入力してください" required />
        <c:if test="${not empty errors.no}">
          <div class="error">${errors.no}</div>
        </c:if>

        <!-- 氏名 -->
        <label for="name">氏名</label>
        <input type="text" id="name" name="name" value="${student.name}" placeholder="氏名を入力してください" required />
        <c:if test="${not empty errors.name}">
          <span class="error">${errors.name}</span>
        </c:if>

        <!-- クラス -->
        <label for="classNum">クラス</label>
        <select id="classNum" name="classNum">
          <option value="">選択してください</option>
          <c:forEach var="c" items="${classNumList}">
            <option value="${c}" <c:if test="${student.classNum == c}">selected</c:if>>${c}</option>
          </c:forEach>
        </select>
        <c:if test="${not empty errors.classNum}">
          <span class="error">${errors.classNum}</span>
        </c:if>

        <!-- 登録ボタン -->
        <div>
          <button class="btn-submit" name="end">登録して終了</button>
        </div>
        <div>
          <a href="StudentList.action">戻る</a>
        </div>
      </form>
    </div>
  </c:param>
</c:import>
