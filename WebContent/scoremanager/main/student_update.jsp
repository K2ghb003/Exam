<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
        margin-top: 10px;
      }

      .btn-submit:hover {
        background-color: #0056b3;
      }

      a {
        margin-left: 12px;
        font-size: 14px;
        display: inline-block;
        margin-top: 16px;
        color: #007bff;
        text-decoration: none;
      }

      a:hover {
        text-decoration: underline;
      }
    </style>

<c:import url="/common/base.jsp">
  <c:param name="title">得点管理システム</c:param>
  <c:param name="content">
    <div class="form-container">
      <h2>学生情報変更</h2>
      <form action="StudentUpdateExecute.action" method="post">
        <label>入学年度</label>
        <div>${student.entYear}</div>

        <label>学生番号</label>
        <div>${student.no}<input type="hidden" name="no" value="${student.no}" /></div>

        <label for="name">氏名</label>
        <input type="text" name="name" id="name" value="${student.name}" placeholder="氏名を入力してください" required />
        <c:if test="${not empty errors.name}">
          <div class="error">${errors.name}</div>
        </c:if>

        <label for="classNum">クラス</label>
        <select name="classNum" id="classNum">
          <option value="">----</option>
          <c:forEach var="c" items="${classNumList}">
            <option value="${c}" <c:if test="${student.classNum == c}">selected</c:if>>${c}</option>
          </c:forEach>
        </select>

        <div class="checkbox-label">
          <input type="checkbox" name="isAttend" id="isAttend" value="true" <c:if test="${student.attend}">checked</c:if> />
          <label for="isAttend">在学中</label>
        </div>

        <div class="buttons">
          <button type="submit">変更</button><br>
          <a href="StudentList.action">戻る</a>
        </div>
      </form>
    </div>
  </c:param>
</c:import>
