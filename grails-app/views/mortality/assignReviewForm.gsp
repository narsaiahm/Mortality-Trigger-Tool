<%@ page import="org.mountsinai.mortalitytriggersystem.AdminConstants" %>
<!DOCTYPE html>
<html>

<head>
    <meta name="layout" content="main"/>
    <asset:javascript src="assignForm.js"/>
</head>

<body>
<div class="container">
    <div class="col-md-6">
        <h4>Assign Form to a Quality Lead</h4>
        <table class="table table-bordered leftAlign">
            <thead>
            <tr>
                <th>
                    <g:if test="${session?.user?.role?.roleName.equals(AdminConstants.ADMIN)}">
                        Quality Lead
                    </g:if>
                    <g:elseif test="${session?.user?.role?.roleName.equals(AdminConstants.QUALITY_LEAD)}">
                        Physician Quality Improvement Lead
                    </g:elseif>
                </th>
                <th>Discharging Division</th>

            </tr>
            </thead>
            <tbody>
            <g:each in="${allLeadsList}" var="lead">
                <tr>
                    <td>
                        <label class="radio-inline control-label">
                            <input type="radio" name="lead" value="${lead.id}" data-leadname="${lead.name}"
                                   data-leademail="${lead.email}"/>${lead.name}
                        </label>
                    </td>
                    <td>
                        ${lead?.speciality?.dept?.departmentName}
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="col-md-6">
        <h4>Assign Form to Other Reviewer</h4>

        <div class="form-group col-md-6">
            <label class="control-label">Search for Other Reviewer:</label>
            <input class="form-control " type="text" value="" id="reviewer">
            <g:select class="control-label hide" id="reviewerSelect" name="reviewerSelect" from="${reviewerMap}"
                      optionKey="key"
                      optionValue="value"/>
        </div>
    </div>
</div>

<div>
    <g:link controller="admin" action="assignEmplToQL"
            class="assignEmplToQL">Assign MSHS Employees to Quality Lead</g:link>
    <g:link controller=" Mortality" action="dashboard" params=" ">
        <button type="button" class="btn btn-primary cancelButton">Cancel</button>
    </g:link>
    <button type="submit" id="saveAssignButtonId" class="btn btn-primary"
            onclick="assignFormReviewer(${reviewinfo.reviewId}, '${reviewinfo.status}', '${reviewinfo.patientName}', ${reviewinfo.mrn});">Submit</button>
</div>

</body>
</html>