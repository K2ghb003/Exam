<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="bean.Subject" %>

<%
    Subject subject = (Subject) request.getAttribute("subject");
    request.setAttribute("cd", subject.getCd());  // EL式で使うために設定
    request.setAttribute("name", subject.getName());
%>

<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>

    <c:param name="content">
    <%-- section.subject-form {
                width: 500px;
                margin: auto;
            } --%>
        <style>
            section.subject-form h2 {
                background-color: #f1f1f1;
                padding: 10px;
                font-size: 22px;
                border-left: 5px solid #007bff;
                margin-bottom: 20px;
            }

            label {
                font-weight: bold;
                display: block;
                margin-bottom: 6px;
                font-size: 15px;
            }

            div {
                font-weight: bold;
                display: block;
                margin-bottom: 6px;
                font-size: 15px;
            }

            input[type="text"] {
                border-radius: 8px;
                padding: 10px;
                width: 100%;
                font-size: 16px;
                border: 2px solid #cce4ff;
                box-sizing: border-box;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.08);
                outline: none;
                transition: all 0.2s ease-in-out;
            }

            input[type="text"]:focus {
                border-color: #66afe9;
                box-shadow: 0 0 6px rgba(102, 175, 233, 0.6);
            }

            input[type="submit"] {
                background-color: #007bff;
                color: white;
                padding: 10px 24px;
                font-size: 16px;
                border-radius: 6px;
                border: none;
                cursor: pointer;
                margin-top: 10px;
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
            }

            a {
                margin-left: 12px;
                font-size: 14px;
                display: inline-block;
                margin-top: 16px;
                color: #007bff;
                text-decoration: none;
            }

            a:hover {
                text-decoration: underline;
            }
        </style>

        <section class="subject-form">
            <h2>科目情報変更</h2>

            <form action="SubjectUpdateExecute.action" method="post" >
                <label>科目コード</label>
                <p>
                    <input type="text" name="cd" value="${cd}" style="border: 0; box-shadow: 0 0 0 0;" readonly>
                <c:if test="${not empty errors.cd}">
		          <div class="error" style="color:#ffbb00">${errors.cd}</div>
		        </c:if>
                </p>

                <p>
                <label>科目名</label>
                    <input type="text" name="name" value="${name}"
                           required placeholder="科目名を入力してください" maxlength="20">
                </p>

                <input type="submit" value="変更"><br>
                <a href="SubjectList.action">戻る</a>
            </form>
        </section>
    </c:param>
</c:import>
