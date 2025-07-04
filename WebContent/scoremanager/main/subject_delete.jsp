<%-- メニューJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="bean.Subject" %>

<%
  Subject subject = (Subject) request.getAttribute("subject");
%>

<c:import url="/common/base.jsp">
  <c:param name="title">得点管理システム</c:param>
  <c:param name="scripts"></c:param>

  <c:param name="content">
    <style>
      section.subject-delete {
        width: 500px;
        margin: auto;
      }

      section.subject-delete h2 {
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

      input[type="submit"] {
        background-color: red;
        color: white;
        padding: 10px 24px;
        font-size: 16px;
        border-radius: 6px;
        border: none;
        cursor: pointer;
        margin-right: 12px;
      }

      input[type="submit"]:hover {
        background-color: #cc0000;
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

    <section class="subject-delete">
      <h2>科目情報削除</h2>

      <form action="SubjectDeleteExecute.action" method="post">
        <p class="delete-message">
          「<%= subject.getName() %>（<%= subject.getCd() %>）」を削除してもよろしいですか？
        </p>
        <input type="hidden" name="cd" value="<%= subject.getCd() %>">
        <input type="submit" value="削除">
        <a href="SubjectList.action">戻る</a>
      </form>
    </section>
  </c:param>
</c:import>
