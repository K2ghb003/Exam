<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
  .form-box {
    background-color: #f2f2f2;
    padding: 30px;
    border-radius: 10px;
    width: 500px;
    margin: auto;
  }

  .form-box h2 {
    margin-top: 0;
  }

  .message {
    background-color: #a0d6b4; /* 緑っぽい背景 */
    color: #000;
    padding: 10px;
    text-align: center;
    margin-top: 20px;
    border-radius: 5px;
    font-weight: bold;
  }

  .form-box .link {
    margin-top: 20px;
    text-align: center;
  }

  .form-box .link a {
    color: #007bff;
    text-decoration: underline;
  }
</style>

<c:import url="/common/base.jsp">
  <c:param name="title">得点管理システム</c:param>
  <c:param name="content">
    <div class="form-box">
      <h2>学生情報変更</h2>

      <div class="message">変更が完了しました</div>

      <div class="link">
        <a href="StudentList.action">学生一覧</a>
      </div>
    </div>
  </c:param>
</c:import>
