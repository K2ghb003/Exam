<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<%--
    width: 500px;
    margin: auto;

<style>
  .form-box {
    background-color: #f2f2f2;
    padding: 30px;
    border-radius: 10px;
  }

  .form-box h2 {
    margin-top: 0;
  }

  .message {
    background-color: #a0d6b4; /* 緑っぽい背景 */
    color: #000;
    padding: 10px;
    text-align: center;
    margin-top: 20px;
    border-radius: 5px;
    font-weight: bold;
  }

  .form-box .link {
    margin-top: 20px;
    text-align: center;
  }

  .form-box .link a {
    color: #007bff;
    text-decoration: underline;
  }
</style>--%>

<style>
  h2 {
        background-color: #f1f1f1;
        padding: 10px;
        font-size: 22px;
        border-left: 5px solid #28a745;
        margin-bottom: 20px;
      }
  p {
    margin-top: 0;
    margin-bottom: 0;
	}
  </style>

<c:import url="/common/base.jsp">
  <c:param name="title">得点管理システム</c:param>
  <c:param name="content">
    <section class="me-4"><%--  class="form-box" --%>
      <h2>学生情報変更</h2>

	  <div class="alert alert-success px-4" role="alert" style="--bs-alert-padding-y: 0rem;
      	text-align: center; margin: 0 0 0 0; background-color: #d4edda; border-color: #c3e6cb; color: #0e3818;"> <%--  py-3 --%>
        変更が完了しました
      </div>
      <%-- <div class="alert alert-success px-4" role="alert" style="--bs-alert-padding-y: 0rem;
      	text-align: center; margin: 0 0 0 0; background-color: #d4edda; border-color: #c3e6cb; color: #0e3818;">変更が完了しました</div> --%>

      <div class="link" style="margin-left: 1rem; margin-top: 5rem;">
        <a href="StudentList.action" style="margin-right: 1.5rem; color: #007bff; text-decoration: none;">学生一覧</a>
      </div>
    </section>
  </c:param>
</c:import>
