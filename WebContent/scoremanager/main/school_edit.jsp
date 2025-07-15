<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">学校編集</c:param>

  <c:param name="content">
    <div class="container mt-4">
      <h2>学校編集</h2>
      <form action="SchoolEditExecute.action" method="post">
        <div class="mb-3">
          <label class="form-label">学校コード</label>
          <input type="text" name="cd" class="form-control" value="${school.cd}" readonly />
        </div>
        <div class="mb-3">
          <label class="form-label">学校名</label>
          <input type="text" name="name" class="form-control" value="${school.name}" required />
        </div>
        <button type="submit" class="btn btn-primary">更新</button>
        <a href="SchoolList.action" class="btn btn-secondary">戻る</a>
      </form>
    </div>
  </c:param>
</c:import>
