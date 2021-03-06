
<%
/**
 * OpenCPS is the open source Core Public Services software
 * Copyright (C) 2016-present OpenCPS community
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>
 */
%>
<%@page import="org.opencps.util.WebKeys"%>
<%@page import="org.opencps.util.MessageKeys"%>
<%@page import="com.liferay.portal.kernel.language.LanguageUtil"%>
<%@page import="org.opencps.accountmgt.search.BusinessDisplayTerms"%>
<%@page import="org.opencps.accountmgt.model.Business"%>
<%@ include file="../init.jsp" %>

<%
	Business business = (Business) request.getAttribute(WebKeys.BUSINESS_ENTRY);

	long businessId = business!=null ? business.getBusinessId() : 0L;
%>

<portlet:renderURL var="switcherCitizenRegisterURL">
	<portlet:param name="mvcPath" value='<%= templatePath + "citizenregistration.jsp" %>'/>
</portlet:renderURL>

<div class="opencps accountmgt fm-registration header">
	<div class="register-label">
		<liferay-ui:message key="register-business"/>
	</div>
	<div class="switcher-btn">
		<aui:button name="citizen" value="citizen" type="button" href="<%=switcherCitizenRegisterURL.toString() %>"/>
	</div>
</div>

<div class="bottom-horizontal-line"></div>


<portlet:actionURL var="updateBusinessURL" name="updateBusiness">
	<portlet:param 
		name="<%=BusinessDisplayTerms.BUSINESS_BUSINESSID %>" 
		value="<%=String.valueOf(businessId) %>"
	/>	
</portlet:actionURL>

<aui:form 
	action="<%=updateBusinessURL.toString() %>"
	name="fm"	
	method="post"
	enctype="multipart/form-data"
	onSubmit='<%= "event.preventDefault(); " + renderResponse.getNamespace() + "registerAccount();" %>'
>
	<liferay-util:include 
		page="/html/portlets/accountmgt/registration/business/general_info.jsp" 
		servletContext="<%=application %>" 
	/> 
	
	<liferay-util:include 
		page="/html/portlets/accountmgt/registration/business/contact.jsp" 
		servletContext="<%=application %>" 
	/> 
	<aui:row>
		<aui:input 
			name="termsOfUse"
			type="checkbox" 
			label="terms-of-use"
		/>
	</aui:row>
	
	<aui:row>
		<aui:button name="register" type="submit" value="register" disabled="true"/>
		<aui:button name="back" type="button" value="back" onClick="window.history.back();"/>
	</aui:row>
</aui:form>

<aui:script>
	AUI().ready(function(A) {
		var termsOfUseCheckbox = A.one('#<portlet:namespace />termsOfUseCheckbox');
		if(termsOfUseCheckbox) {
			termsOfUseCheckbox.on('click',function() {
				
				var termsOfUse = A.one('#<portlet:namespace />termsOfUse');
				
				var register = A.one('#<portlet:namespace />register');
				
				if(termsOfUse.val() == 'true'){
					register.removeClass('disabled');
					register.removeAttribute('disabled');
				}else{
					register.addClass('disabled');
					register.setAttribute('disabled' , 'true');
				}
			});
		}
	});

	Liferay.provide(window, '<portlet:namespace />registerAccount', function() {
		A = AUI();
		var register = A.one('#<portlet:namespace />register');
		var termsOfUse = A.one('#<portlet:namespace />termsOfUse');
		if(termsOfUse.val() == 'true'){
			submitForm(document.<portlet:namespace />fm);
		}else{
			return;
		}
	});
	
</aui:script>
