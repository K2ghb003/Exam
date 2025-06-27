<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
  .form-box {
    background-color: #f2f2f2;   /* 薄いグレー背景 */
    padding: 30px;
    border-radius: 10px;
    width: 400px;
    margin: auto;
  }

  .form-box h2 {
    margin-top: 0;
  }

  .form-box label {
    display: block;
    margin-top: 15px;
    font-weight: bold;
  }

  .form-box input[type="text"],
  .form-box select {
    width: 100%;
    padding: 8px;
    margin-top: 5px;
    box-sizing: border-box;
  }

  .form-box .checkbox-label {
    display: flex;
    align-items: center;
    margin-top: 15px;
  }

  .form-box .checkbox-label input {
    margin-right: 5px;
  }

  .form-box .buttons {
    margin-top: 20px;
  }

  .form-box .buttons button {
    background-color: #007bff; /* ブルー */
    color: white;
    padding: 8px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  .form-box .buttons a {
    display: inline-block;
    margin-top: 10px;
    color: #007bff;
    text-decoration: underline;
  }

  .error {
    color: red;
    font-size: 0.9em;
    margin-top: 4px;
  }
</style>

<c:import url="/common/base.jsp">
  <c:param name="title">得点管理システム</c:param>
  <c:param name="content">
    <div class="form-box">
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
