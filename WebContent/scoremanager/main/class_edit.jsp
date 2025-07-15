<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/common/base.jsp">
  <c:param name="title">クラス編集</c:param>

  <c:param name="content">
    <section class="container mt-4">
      <h2 class="mb-4">クラス編集</h2>

      <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
      </c:if>

      <form action="ClassEdit.action" method="post">
        <div class="mb-3">
          <label for="old_class_num" class="form-label">現在のクラス番号：</label>
          <input type="text" name="old_class_num" id="old_class_num" class="form-control" value="${param.old_class_num}" readonly />
        </div>

        <div class="mb-3">
          <label for="new_class_num" class="form-label">新しいクラス番号：</label>
          <input type="text" name="new_class_num" id="new_class_num" class="form-control" required />
        </div>

        <button type="submit" class="btn btn-primary">更新</button>
        <a href="ClassList.action" class="btn btn-secondary">戻る</a>
      </form>
    </section>
  </c:param>
</c:import>
