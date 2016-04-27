<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%@ taglib prefix="user" uri="http://www.jahia.org/tags/user" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<jcr:nodeProperty node="${currentNode}" name="text" var="text"/>
<jcr:nodeProperty node="${currentNode}" name="jcr:createdBy" var="createdBy"/>
	
<c:set var="currentUser" value="${user:lookupUser(createdBy.string)}"/>

<jcr:nodeProperty node="${currentNode}" name="jcr:created" var="created"/>
<c:if test="${jcr:isNodeType(currentNode, 'jnt:blogPost')}">
    <c:set var="blogHome" value="${url.base}${currentResource.node.parent.path}.html"/>
</c:if>
<c:if test="${!jcr:isNodeType(currentNode, 'jnt:blogPost')}">
    <c:set var="blogHome" value="${url.current}"/>
</c:if>
<div class="panel panel-default">
    <div class="panel-body">
        <div class="page-header">
            <h3>
                <a href="<c:url value='${url.base}${currentNode.path}.html'/>"><c:out value="${title.string}"/></a>
                <small>${' '}<fmt:message key="mydxmblognt.label.by"/>${' '}${user:userFullName(currentUser)}</small>
                <small class="momentToFormat pull-right" data-moment-display-type="format"
                       data-moment-format="LL" data-moment-locale="${currentResource.locale}"
                       data-moment="<fmt:formatDate value="${created.time}" pattern="yyyy-MM-dd'T'HH:mm:ssZ"/>"></small>
            </h3>
            <ul class="list-inline">
                <jcr:nodeProperty node="${currentNode}" name="j:tagList" var="assignedTags"/>
                <c:forEach items="${assignedTags}" var="tag" varStatus="status">
                    <li><span class="label label-default">${fn:escapeXml(tag.string)}</span></li>
                </c:forEach>
            </ul>
        </div>

        <p class="lead">
            ${fn:substring(text.string, 0, 600)}${' ...'}
        </p>
        <p class="pull-right"><a title="#" href="<c:url value='${url.base}${currentNode.path}.html'/>"><fmt:message key="jnt_blog.readPost"/></a></p>
    </div>
</div>
<template:addCacheDependency path="${currentNode.path}/comments"/>