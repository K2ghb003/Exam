<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/common/base.jsp">
  <c:param name="title">学校登録</c:param>

  <c:param name="content">
    <style>
      h2 {
        background-color: #f1f1f1;
        padding: 10px;
        font-size: 22px;
        border-left: 5px solid #28a745;
        margin-bottom: 20px;
      }

      label {
        font-weight: bold;
        display: block;
        margin-bottom: 6px;
        font-size: 15px;
      }

      input[type="text"] {
        border-radius: 8px;
        padding: 10px;
        width: 100%;
        font-size: 16px;
        border: 2px solid #cce4ff;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.08);
        outline: none;
        margin-bottom: 4px;
        transition: all 0.2s ease-in-out;
        box-sizing: border-box;
      }

      input[type="text"]:focus {
        border-color: #66afe9;
        box-shadow: 0 0 6px rgba(102, 175, 233, 0.6);
      }

      .btn {
        padding: 10px 24px;
        font-size: 16px;
        border-radius: 6px;
        font-weight: bold;
        margin-right: 10px;
        text-decoration: none;
      }

      .btn-primary {
        background-color: #007bff;
        color: white;
        border: none;
      }

      .btn-primary:hover {
        background-color: #0056b3;
      }

      .btn-secondary {
        background-color: #6c757d;
        color: white;
        border: none;
      }

      .btn-secondary:hover {
        background-color: #545b62;
      }

      .alert-danger {
        color: #842029;
        background-color: #f8d7da;
        border-color: #f5c2c7;
        padding: 10px;
        border-radius: 5px;
        margin-bottom: 15px;
      }

      .error {
        color: orange;
        font-size: 14px;
        margin-bottom: 12px;
        margin-left: 4px;
        display: block;
      }
    </style>

    <div class="container mt-4">
      <h2>学校登録</h2>


      <form action="SchoolCreateExecute.action" method="post">
        <div class="mb-3">
          <label class="form-label">学校コード</label>
          <input type="text" name="cd" class="form-control" value="${school.cd}" maxlength="6" required />
        </div>
      <c:if test="${not empty error}">
        <div class="error">${error}</div>
      </c:if>

        <div class="mb-3">
          <label class="form-label">学校名</label>
          <input type="text" name="name" class="form-control" value="${school.name}" required />
        </div>

        <button type="submit" class="btn btn-primary">登録</button>
        <a href="SchoolList.action" class="btn btn-secondary">キャンセル</a>
      </form>
    </div>
  </c:param>
</c:import>
