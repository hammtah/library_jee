<%--
  Created by IntelliJ IDEA.
  User: taha
  Date: 12/25/25
  Time: 10:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Cart</title>
    <style>
        body {
            font-family: "Merriweather", Georgia, "Times New Roman", serif;
            max-width: 1100px;
            margin: 0 auto;
            padding: 24px;
            background-color: #F4F1EA;
        }

        h1 {
            color: #382110;
            text-align: center;
            margin-bottom: 24px;
        }

        .cart-container {
            background: transparent;
        }

        .cart-list {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .cart-item {
            display: grid;
            grid-template-columns: 88px 1fr 120px;
            gap: 16px;
            background: #FFFFFF;
            border-radius: 8px;
            padding: 16px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.08);
            align-items: center;
        }

        .cover {
            width: 88px;
            height: 128px;
            border-radius: 6px;
            object-fit: cover;
            background-color: #EEEAE2;
        }

        .cart-info {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .cart-title {
            font-size: 18px;
            font-weight: 700;
            color: #382110;
        }

        .cart-author {
            color: #636363;
            font-style: italic;
        }

        .cart-meta {
            color: #666666;
            font-size: 13px;
        }

        .cart-qty {
            justify-self: end;
            color: #382110;
            font-weight: 600;
            padding: 6px 10px;
            background: #F0E6D6;
            border-radius: 16px;
        }

        .actions {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
            position: sticky;
            bottom: 0;
            background: #F4F1EA;
            padding: 1em;
        }

        .btn {
            display: inline-block;
            padding: 10px 16px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 600;
            border: 1px solid transparent;
        }

        .btn-danger {
            background-color: #8D3B1A;
            color: #FFFFFF;
            border-color: #7A3215;
        }

        .btn-danger:hover {
            background-color: #6F2F14;
        }
    </style>
</head>
<body>
<div class="cart-container">
    <h1>Your Shopping Cart</h1>
    <c:if test="${empty cartItems}">
        <h2 style="text-align: center; margin-top: 3rem;">Your Cart is empty, try adding some books.</h2>
    </c:if>
    <div class="cart-list">
        <c:forEach items="${cartItems}" var="book">
            <c:set var="imgUrl" value="" />
            <c:choose>
                <c:when test="${not empty book.img}">
                    <c:set var="imgUrl" value="${book.img}" />
                </c:when>
<%--                <c:when test="${not empty book.coverUrl}">--%>
<%--                    <c:set var="imgUrl" value="${book.coverUrl}" />--%>
<%--                </c:when>--%>
<%--                <c:when test="${not empty book.coverImageUrl}">--%>
<%--                    <c:set var="imgUrl" value="${book.coverImageUrl}" />--%>
<%--                </c:when>--%>
<%--                <c:when test="${not empty book.image}">--%>
<%--                    <c:set var="imgUrl" value="${book.image}" />--%>
<%--                </c:when>--%>
<%--                <c:when test="${not empty book.cover}">--%>
<%--                    <c:set var="imgUrl" value="${book.cover}" />--%>
<%--                </c:when>--%>
            </c:choose>

            <div class="cart-item">
                <c:choose>
                    <c:when test="${not empty imgUrl}">
                        <img class="cover" src="${imgUrl}" alt="${book.title} cover" loading="lazy" onerror="this.onerror=null;this.src='https://placehold.co/88x128?text=No+Cover';" />
                    </c:when>
                    <c:otherwise>
                        <img class="cover" src="https://placehold.co/88x128?text=No+Cover" alt="No cover available" loading="lazy" />
                    </c:otherwise>
                </c:choose>

                <div class="cart-info">
                    <div class="cart-title">${book.title}</div>
                    <c:if test="${not empty book.author}">
                        <div class="cart-author">by ${book.author}</div>
                    </c:if>
                    <div class="cart-meta">
                        <c:if test="${not empty book.isbn}">ISBN: ${book.isbn}</c:if>
                        <c:if test="${not empty book.price}">
                            <c:if test="${not empty book.isbn}"> | </c:if>
                            Price: $${book.price}
                        </c:if>
                    </div>
                </div>

                <div class="cart-qty">Qty: ${book.nb}</div>
            </div>
        </c:forEach>
    </div>

    <div class="actions">
        <a href="<%=request.getContextPath()%>/book" class="btn btn-primary">Continue Shopping</a>
        <a href="<%=request.getContextPath()%>/clear" class="btn btn-danger">Clear Cart</a>
    </div>
</div>
</body>
</html>