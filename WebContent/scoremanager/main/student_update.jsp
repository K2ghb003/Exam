<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">得点管理システム</c:param>
  <c:param name="scripts"></c:param>
  <c:param name="content">
    <style>
      section.student-form {
        width: 500px;
        margin: auto;
      }

      section.student-form h2 {
        background-color: #f1f1f1;
        padding: 10px;
        font-size: 22px;
        border-left: 5px solid #007bff;
        margin-bottom: 20px;
      }

      .form-row {
        display: flex;
        align-items: center;
        margin-bottom: 16px;
      }

      .form-row label {
        width: 120px;
        font-weight: bold;
        font-size: 15px;
      }

      .form-row .value {
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
        transition: all 0.2s ease-in-out;
      }

      input[type="text"]:focus,
      select:focus {
        border-color: #66afe9;
        box-shadow: 0 0 6px rgba(102, 175, 233, 0.6);
      }

      .checkbox-row {
        display: flex;
        align-items: center;
        margin-bottom: 16px;
      }

      .checkbox-row input[type="checkbox"] {
        margin-left: 120px;
        margin-right: 6px;
        transform: scale(1.2);
      }

      .error {
        color: orange;
        font-size: 14px;
        margin-left: 120px;
        margin-top: -12px;
        margin-bottom: 8px;
        display: block;
      }

      .button-row {
        margin-left: 120px;
        margin-top: 20px;
      }

      input[type="submit"] {
        background-color: #007bff;
        color: white;
        padding: 10px 24px;
        font-size: 16px;
        border-radius: 6px;
        border: none;
        cursor: pointer;
        margin-right: 16px;
      }

      input[type="submit"]:hover {
        background-color: #0056b3;
      }

      a {
        font-size: 14px;
        color: #007bff;
        text-decoration: none;
      }

      a:hover {
        text-decoration: underline;
      }
    </style>

    <section class="student-form">
      <h2>学生情報変更</h2>
      <form action="StudentUpdateExecute.action" method="post">

        <div class="form-row">
          <label>入学年度</label>
          <div class="value">${student.entYear}</div>
        </div>

        <div class="form-row">
          <label>学生番号</label>
          <div class="value">
            ${student.no}
            <input type="hidden" name="no" value="${student.no}" />
          </div>
        </div>

        <div class="form-row">
          <label for="name">氏名</label>
          <input type="text" name="name" id="name" value="${student.name}" placeholder="氏名を入力してください" required />
        </div>
        <c:if test="${not empty errors.name}">
          <span class="error">${errors.name}</span>
        </c:if>

        <div class="form-row">
          <label for="classNum">クラス</label>
          <select name="classNum" id="classNum">
            <option value="">選択してください</option>
            <c:forEach var="c" items="${classNumList}">
              <option value="${c}" <c:if test="${student.classNum == c}">selected</c:if>>${c}</option>
            </c:forEach>
          </select>
        </div>

        <div class="checkbox-row">
          <input type="checkbox" name="isAttend" id="isAttend" value="true" <c:if test="${student.attend}">checked</c:if> />
          <label for="isAttend" style="margin: 0;">在学中</label>
        </div>

        <div class="button-row">
          <input type="submit" value="変更" />
          <a href="StudentList.action">戻る</a>
        </div>
      </form>
    </section>
  </c:param>
</c:import>
