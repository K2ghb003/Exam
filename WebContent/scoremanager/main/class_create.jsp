<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/common/base.jsp">
  <c:param name="title">クラス追加</c:param>

  <c:param name="content">
    <section class="container mt-4">
      <h2 class="mb-4">クラス新規登録</h2>

      <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
      </c:if>

      <form action="ClassCreate.action" method="post">
        <div class="mb-3">
          <label for="class_num" class="form-label">クラス番号：</label>
          <input type="text" name="class_num" id="class_num" class="form-control" required />
        </div>

        <button type="submit" class="btn btn-primary">登録して一覧へ</button>
        <a href="ClassList.action" class="btn btn-secondary">戻る</a>
      </form>
    </section>
  </c:param>
</c:import>
