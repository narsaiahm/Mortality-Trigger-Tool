<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <asset:javascript src="dashboard.js"/>
    </head>
    <body>
        <div>
            <div id ="adminDashboardSearch">
                <g:render template="/mortality/templates/adminDashBoardSearchLayout"></g:render>
            </div>
            <div id="adminDashboard">
                <g:render template="/mortality/templates/adminDashBoardLayout"></g:render>
            </div>
        </div>
    </body>
</html>