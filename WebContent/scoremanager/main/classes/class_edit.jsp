<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    request.setAttribute("class_num", request.getAttribute("classnum.class_num"));
%>

<c:import url="/common/base.jsp">
  <c:param name="title">クラス編集</c:param>
  <c:param name="scripts"></c:param>

  <c:param name="content">
    <style>
      section.class-form h2 {
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

      input[type="text"] {
        border-radius: 8px;
        padding: 10px;
        width: 100%;
        font-size: 16px;
        border: 2px solid #cce4ff;
        box-sizing: border-box;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.08);
        outline: none;
        transition: all 0.2s ease-in-out;
      }

      input[type="text"]:focus {
        border-color: #66afe9;
        box-shadow: 0 0 6px rgba(102, 175, 233, 0.6);
      }

      input[type="submit"] {
        background-color: #007bff;
        color: white;
        padding: 10px 24px;
        font-size: 16px;
        border-radius: 6px;
        border: none;
        cursor: pointer;
        margin-top: 10px;
      }

      input[type="submit"]:hover {
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

      .error {
        color: orange;
        font-size: 14px;
        margin-bottom: 12px;
        margin-left: 4px;
        display: block;
      }
    </style>

    <section class="class-form">
      <h2>クラス編集</h2>


      <form action="ClassEditExecute.action" method="post">
        <label>現在のクラス番号</label>
        <p>
          <input type="text" name="class_num" value="${classnum.class_num}" readonly style="border: 0; box-shadow: none;">
        </p>

        <label>新しいクラス番号</label>
        <p>
          <input type="text" name="new_class_num" value="" placeholder="新しいクラス番号を入力してください" maxlength="10" required>
        </p>
      <c:if test="${not empty error}">
        <div class="error">${error}</div>
      </c:if>

        <input type="submit" value="変更" <c:if test="${not empty disabled}">disabled</c:if> >
        <a href="ClassList.action">戻る</a>
      </form>
    </section>
  </c:param>
</c:import>
