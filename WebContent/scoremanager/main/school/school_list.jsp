<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">学校管理</c:param>
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
        text-decoration: underline;
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
        text-decoration: underline;
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

    <section class="me-4">
      <h2 class="h3 mb-3 bg-secondary bg-opacity-10 py-2 px-4">
        学校管理
      </h2>

      <div class="header-actions">
        <a href="SchoolCreate.action" class="create-link">新規登録</a>
      </div>

      <table class="simple-table">
        <tr>
          <th>学校コード</th>
          <th>学校名</th>
          <th></th>
          <th></th>
        </tr>

        <c:forEach var="school" items="${schools}">
          <tr>
            <td>${school.cd}</td>
            <td>${school.name}</td>
            <td><a href="SchoolEdit.action?cd=${school.cd}">変更</a></td>
            <td><a href="SchoolDelete.action?cd=${school.cd}" class="delete-link">削除</a></td>
          </tr>
        </c:forEach>
      </table>
    </section>
  </c:param>
</c:import>
