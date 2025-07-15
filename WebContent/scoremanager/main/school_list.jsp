<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">学校一覧</c:param>
  <c:param name="content">
    <section class="container mt-4">
      <h2 class="mb-3">学校一覧</h2>

      <table class="table table-bordered table-striped">
        <thead>
          <tr>
            <th>学校コード</th>
            <th>学校名</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="school" items="${schools}">
            <tr>
              <td>${school.cd}</td>
              <td>${school.name}</td>
              <td>
                <a href="SchoolEdit.action?cd=${school.cd}" class="btn btn-sm btn-primary">編集</a>
                <a href="SchoolDelete.action?cd=${school.cd}" class="btn btn-sm btn-danger">削除</a>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>

      <a href="SchoolCreate.action" class="btn btn-success mt-3">新規登録</a>
    </section>
  </c:param>
</c:import>
