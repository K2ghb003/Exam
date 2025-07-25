<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/common/base.jsp">
  <c:param name="title">クラス追加</c:param>

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
        border: none;
        cursor: pointer;
      }

      .btn-primary {
        background-color: #007bff;
        color: white;
      }

      .btn-primary:hover {
        background-color: #0056b3;
      }

      a.back-link {
        font-size: 15px;
        color: #007bff;
        margin-top: 12px;
        display: inline-block;
        text-decoration: none;
      }

      a.back-link:hover {
        text-decoration: underline;
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

    <section class="container mt-4">
      <h2>クラス新規登録</h2>


      <form action="ClassCreate.action" method="post">
        <div class="mb-3">
          <label for="class_num">クラス番号</label>
          <input type="text" name="class_num" id="class_num" value="${class_num}" maxlength="6" required/>
        </div>
      <c:if test="${not empty error}">
        <div class="error">${error}</div>
      </c:if>

        <button type="submit" class="btn btn-primary">登録</button>
        <a href="ClassList.action" class="back-link">戻る</a>
      </form>
    </section>
  </c:param>
</c:import>
