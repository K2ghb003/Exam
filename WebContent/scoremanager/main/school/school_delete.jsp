<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">学校削除確認</c:param>
  <c:param name="scripts"></c:param>

  <c:param name="content">
    <style>
      section.school-delete h2 {
        background-color: #f1f1f1;
        padding: 10px;
        font-size: 22px;
        border-left: 5px solid red;
        margin-bottom: 20px;
      }

      .delete-message {
        font-size: 16px;
        margin-bottom: 20px;
      }

      input[type="submit"],
      .btn-danger {
        background-color: red;
        color: white;
        padding: 10px 24px;
        font-size: 16px;
        border-radius: 6px;
        border: none;
        cursor: pointer;
        margin-right: 12px;
        text-decoration: none;
      }

      input[type="submit"]:hover,
      .btn-danger:hover {
        background-color: #cc0000;
      }

      .btn-cancel {
        font-size: 14px;
        padding: 10px 20px;
        background-color: #6c757d;
        color: white;
        text-decoration: none;
        border-radius: 6px;
      }

      .btn-cancel:hover {
        background-color: #545b62;
        text-decoration: none;
      }

      .alert-danger {
        color: #842029;
        background-color: #f8d7da;
        border: 1px solid #f5c2c7;
        padding: 10px;
        border-radius: 5px;
        margin-bottom: 15px;
      }
    </style>

    <section class="school-delete container mt-4">
      <h2>学校削除確認</h2>

      <c:if test="${not empty error}">
        <div class="alert-danger">${error}</div>
      </c:if>

      <p class="delete-message">以下の学校を削除してもよろしいですか？</p>

      <p><strong>学校コード：</strong>${school.cd}</p>
      <p><strong>学校名　　：</strong>${school.name}</p>

      <form action="SchoolDeleteExecute.action" method="post">
        <input type="hidden" name="cd" value="${school.cd}">
        <input type="submit" value="削除する" class="btn-danger">
        <a href="SchoolList.action" class="btn-cancel">キャンセル</a>
      </form>
    </section>
  </c:param>
</c:import>
