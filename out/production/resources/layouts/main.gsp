<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<%@page import="org.mountsinai.mortalitytriggersystem.AdminConstants" %>
<head>
    <title>Mortality Trigger Tool</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <asset:stylesheet src="jquery-ui-1.8.10.css"/>
    <asset:stylesheet src="bootstrap.css"/>
    <asset:stylesheet src="bootstrap-theme.min.css"/>
    <asset:javascript src="jquery-2.2.0.min.js"/>
    <asset:javascript src="jquery-ui-1.8.24.min.js" />
    <asset:javascript src="bootstrap.js"/>
    <asset:javascript src="toastr.js"/>
    <asset:javascript src="application.js"/>
    <asset:stylesheet src="toastr.min.css"/>
    <asset:stylesheet src="web-icons.min.css"/>
    <asset:stylesheet src="material-design.min.css"/>
    <asset:stylesheet src="style.css"/>
    <g:layoutHead />
</head>

<body>

<div class="main-container">
    <div class="main-header">
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
            <div class="container-fluid">
                <div class="col-md-4 fleft">
                    <div>
                        <asset:image src="ms_logo.png" style="width: 170px;height: 80px;" />
                    </div>
                    <div class="heading_2 " style="padding-top: 5px">
                        <div>
                            <p><span class="titleName">Mortality Trigger Tool</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 center">
                    <div class="heading_1">
                        <g:if test="${session?.user?.role?.roleName.equals(AdminConstants.ADMIN)}">
                            <p class="heading_1"><span>Hospital Quality Department(Admin) </span>
                            </p>
                        </g:if>
                        <g:elseif test="${session?.user?.role?.roleName.equals(AdminConstants.QUALITY_LEAD)}">
                            <p class="heading_1"><span>Quality Lead (Contributor) </span>
                            </p>
                        </g:elseif>
                        <g:elseif test="${session?.user?.role?.roleName.equals(AdminConstants.ADHOC)}">
                            <p class="heading_1"><span>Reviewer</span>
                            </p>
                        </g:elseif>
                    </div>
                    %{--<div class="heading_3">
                        <div>
                            <p><span>${session?.user?.facility?.facilityName} (${session?.user?.facility?.facilityCode})</span>
                            </p>
                        </div>
                    </div>--}%
                </div>
                <div class="nameRegion col-md-4 fright">
                    <div style="width:100%;text-align: right">
                        <g:if test="${session?.user}">
                            <span class=><h5>Welcome ${session?.user?.name}</h5></span>
                        </g:if>
                    </div>
                    <div class="fright">
                        <g:if test="${session?.user?.role?.roleName.equals(AdminConstants.ADMIN)}">
                            <g:link role="button" controller="mortality" action="runReport" class="btn btn-info">
                                <span class="glyphicon glyphicon-search"></span>
                                <span class="main-menu-item">Run Report</span>
                            </g:link>
                        </g:if>
                        <a href="#" class="btn btn-info">
                            <span class="glyphicon glyphicon-info-sign"></span> Help
                        </a>
                        <g:if test="${session.multiRolesFlag == AdminConstants.Y}">
                            <g:link role="button" controller="auth" action="login" class="btn btn-info">
                                <span class="glyphicon glyphicon-random"></span>
                                <span class="main-menu-item">Switch</span>
                            </g:link>
                        </g:if>
                        <g:link role="button" controller="auth" action="logout" class="btn btn-danger">
                            <span class="glyphicon glyphicon-log-out"></span> Log out
                        </g:link>
                    </div>
                </div>
            </div>
        </nav>
    </div>
    <div class="main-body">
        <g:layoutBody />
    </div>
</div>
<!-- Footer content -->
<div class="footer">
    <div class="col-md-4">
        &copy;${new Date().format('yyyy')} Mount Sinai Health System  <br/>
        <g:if env="development" >DEV:</g:if><g:if env="test" >TEST:</g:if> Mortality Trigger Tool v<g:meta name="info.app.version"/> (<g:meta name="info.app.buildDate"/>)
    </div>
    <div class="col-md-7"></div>
    <div class="col-md-1" style="float:right">
        <a href=":" target="">Contact Us</a>
    </div>
    <div class="overlay" style="display:none"></div>
    <div id="processing" class="processing" style="display: none">
        <p>Processing...</p>
    </div>
</div>
</body>

</html>
