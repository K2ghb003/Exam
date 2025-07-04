<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="bean.Subject, java.util.List" %>

<%
    @SuppressWarnings("unchecked")
    List<Subject> list = (List<Subject>) request.getAttribute("subject_list");
%>

<c:import url="/common/base.jsp">
  <c:param name="title">得点管理システム</c:param>
  <c:param name="scripts"></c:param>

  <c:param name="content">
    <style>
      table.simple-table {
        width: 100%;
        border-collapse: collapse;
        font-family: sans-serif;
      }

      table.simple-table th,
      table.simple-table td {
        border-bottom: 1px solid #ccc;
        padding: 10px;
        text-align: left;
      }

      table.simple-table tr:last-child td {
        border-bottom: none;
      }

      .delete-link {
        color: red;
        text-decoration: none;
        font-weight: bold;
        transition: color 0.2s;
      }

      .delete-link:hover {
        color: #cc0000;
        text-decoration: underline;
      }

      .create-link {
        color: #28a745;
        font-weight: bold;
        text-decoration: none;
        margin-right: 12px;
        transition: color 0.2s;
      }

      .create-link:hover {
        color: #1e7e34;
        text-decoration: underline;
      }

      .header-actions {
        text-align: right;
        margin-bottom: 10px;
      }
    </style>

    <section style="width: 800px; margin: auto;">
      <h2 style="background-color: #f1f1f1; padding: 10px; font-size: 22px; border-left: 5px solid #007bff; margin-bottom: 20px;">
        科目管理
      </h2>

      <div class="header-actions">
        <a href="SubjectCreate.action" class="create-link">新規登録</a>
      </div>

      <table class="simple-table">
        <tr>
          <th>科目コード</th>
          <th>科目名</th>
          <th></th>
          <th></th>
        </tr>

        <% for (Subject sub : list) { %>
          <tr>
            <td><%= sub.getCd() %></td>
            <td><%= sub.getName() %></td>
            <td><a href="SubjectUpdate.action?cd=<%= sub.getCd() %>">変更</a></td>
            <td><a href="SubjectDelete.action?cd=<%= sub.getCd() %>" class="delete-link">削除</a></td>
          </tr>
        <% } %>
      </table>
    </section>
  </c:param>
</c:import>
