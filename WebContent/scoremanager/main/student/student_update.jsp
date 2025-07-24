<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">得点管理システム</c:param>
  <c:param name="scripts"></c:param>
  <c:param name="content">
<%-- section.student-form
 display: flex;
 margin-left: 120px; --%>
    <style>
      section.student-form {
        width: 500px;
        margin: auto;
      }
      .h2{
        background-color: #f1f1f1;
        padding: 10px;
        font-size: 22px !important;
        border-left: 5px solid #007bff;
        margin-bottom: 20px;
      }

      .form-row {
        align-items: center;
        margin-bottom: 16px;
      }
      .form-row input{
        align-items: center;
        margin-left: 16px;
      }
      .form-row select{
        align-items: center;
        margin-left: 16px;
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

        margin-right: 6px;
        transform: scale(1.2);
      }

      .error {
        color: orange;
        font-size: 14px;
        margin-left: 20px;
        margin-top: -12px;
        margin-bottom: 8px;
        display: block;
      }

      .button-row {
        margin-bottom: 20px;
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

    <section> <%--  class="student-form" --%>
      <h2 class="h2">学生情報変更</h2>
      <form action="StudentUpdateExecute.action" method="post">

        <div class="form-row">
          <label>入学年度</label><br>
          <input type="text" class="value" style="font-size: 18px; border: 0; box-shadow: 0 0 0 0;" value="${student.entYear}" readonly />
        </div>

        <div class="form-row">
          <div>
          <label>学生番号</label><br>
             <%--${student.no} --%>
            <input type="text" class="value" name="no" style="font-size: 18px; border: 0; box-shadow: 0 0 0 0;" value="${student.no}" readonly/>
          </div>
        </div>

        <div class="form-row">
          <label for="name">氏名</label><br>
          <input type="text" name="name" id="name" value="${student.name}" placeholder="氏名を入力してください" required />
        </div>
        <c:if test="${not empty errors.name}">
          <div class="error">${errors.name}</div>
        </c:if>

        <div class="form-row">
          <label for="classNum">クラス</label><br>
          <select name="classNum" id="classNum">
            <option value="">選択してください</option>
            <c:forEach var="c" items="${classNumList}">
              <option value="${c}" <c:if test="${student.classNum == c}">selected</c:if>>${c}</option>
            </c:forEach>
          </select>
        </div>
        <c:if test="${not empty errors.classNum}">
          <div class="error">${errors.classNum}</div>
        </c:if>

        <div class="form-row">
          <label for="year">学年</label><br>
          <select name="year" id="year">
            <option value="">選択してください</option>
            <option value="1" <c:if test="${student.year == 1}">selected</c:if>>1</option>
            <option value="2" <c:if test="${student.year == 2}">selected</c:if>>2</option>
          </select>
        </div>
        <c:if test="${not empty errors.year}">
          <div class="error">${errors.year}</div>
        </c:if>

        <div class="checkbox-row">
          <input class="form-check-input" type="checkbox" name="isAttend" id="isAttend" value="true" <c:if test="${student.attend}">checked</c:if> />
          <label for="isAttend" style="margin: 0 0 0 0;">在学中</label>
        </div>

        <div class="button-row">
          <input type="submit" style="" value="変更" /><br>
          <a href="StudentList.action">戻る</a>
        </div>
      </form>
    </section>
  </c:param>
</c:import>
