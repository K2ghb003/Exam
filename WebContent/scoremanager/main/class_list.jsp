<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">クラス一覧</c:param>

  <c:param name="content">
    <section class="container mt-4">
      <h2>クラス一覧</h2>

      <table class="table table-bordered mt-3">
        <thead>
          <tr>
            <th>クラス名</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="classNum" items="${classList}">
            <tr>
              <td>${classNum}</td>
              <td>
                <a href="ClassEdit.action?class_num=${classNum}" class="btn btn-primary btn-sm">編集</a>
                <a href="ClassDelete.action?class_num=${classNum}" class="btn btn-danger btn-sm">削除</a>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>

      <a href="ClassCreate.action" class="btn btn-success mt-3">＋ 新規クラス登録</a>
    </section>
  </c:param>
</c:import>
