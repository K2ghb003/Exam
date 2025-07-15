<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/common/base.jsp">
  <c:param name="title">クラス削除</c:param>

  <c:param name="content">
    <section class="container mt-5">
      <h2 class="mb-4 text-danger">クラス削除確認</h2>

      <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
      </c:if>

      <form action="ClassDeleteExecute.action" method="post">
        <input type="hidden" name="class_num" value="${classNum.class_num}" />

        <div class="mb-3">
          <label class="form-label fw-bold">削除対象のクラス番号：</label>
          <p class="fs-5">${classNum.class_num}</p>
        </div>

        <div class="alert alert-warning">
          このクラスを削除してもよろしいですか？（元に戻すことはできません）
        </div>

        <div class="d-flex gap-3">
          <button type="submit" class="btn btn-danger">削除</button>
          <a href="ClassList.action" class="btn btn-secondary">キャンセル</a>
        </div>
      </form>
    </section>
  </c:param>
</c:import>
