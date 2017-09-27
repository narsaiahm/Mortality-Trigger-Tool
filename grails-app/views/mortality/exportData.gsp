<%@ page import="org.mountsinai.mortalitytriggersystem.MortalityConstants; org.mountsinai.mortalitytriggersystem.AdminConstants" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
<asset:javascript src="dashboard.js"/>
</head>
<g:form action="exportData">
    <g:each in="${params}">
        <g:hiddenField name="${it.key}" value="${it.value}"></g:hiddenField>
    </g:each>
    <div class="col-md-12">
        <div class="form-group margin">
            Form Status: <span class="fontWeight-bold">${params.formStatus}</span>&nbsp;&nbsp;
            MSHS Hospital: <span class="fontWeight-bold">${params.facility}</span>&nbsp;&nbsp;
            MSHS Discharging Division: <span class="fontWeight-bold">${params.speciality}</span>&nbsp;&nbsp;
            Forms assigned to: <span class="fontWeight-bold">${params.assignedTo}</span>
        </div>

        <div class="row">

            <div class="col-md-12 margin_top_-10">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <th>Patient Name</th>
                            <th>Discharge Date</th>
                            <th>Facility</th>
                            <th>Discharging Unit</th>
                            <th>Discharging Division/Assigned To</th>
                            <th>Days Since Death</th>
                            <th>Status Date/Time</th>
                            <th>Status</th>
                            <th>Status History</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr><td colspan="9" class="leftAlign"
                                style="background-color: lightgrey;font-weight: bold">Unassigned</td></tr>
                        <g:each in="${mortalityReviewList}" var="review">
                            <g:if test="${review.status.equals(MortalityConstants.UNASSIGNED)}">
                                <tr>
                                    <td>${review.patientName}</td>
                                    <td>${review.dischargeDateTime}</td>
                                    <td>${review.facilityCode}</td>
                                    <td>${review.dischargeUnit}</td>
                                    <td>${review.dischargingDivision}
                                        <g:if test="${review.assignedTo_role.equals(AdminConstants.QUALITY_LEAD)}">
                                            [Quality Lead Assigned : ${review.assignedTo}]
                                        </g:if>
                                        <g:else>
                                            [Other Reviewer Assigned : ${review.assignedTo}]
                                        </g:else>
                                    </td>
                                    <td>${review.daysSinceDeath}</td>
                                    <td>${review.statusDateTime}</td>
                                    <td>${review.status}</td>
                                    <td>%{--${review.statusHistory}--}%</td>
                                </tr>
                            </g:if>
                        </g:each>
                        <g:if test="${mortalityReviewList.grep { it -> it.status?.equals(MortalityConstants.UNASSIGNED) }.size() == 0}">
                            <tr><td colspan="9">No records found</td></tr>
                        </g:if>
                        <tr><td colspan="9" class="leftAlign"
                                style="background-color: lightgrey;font-weight: bold">Incomplete</td></tr>
                        <g:each in="${mortalityReviewList}" var="review">
                            <g:if test="${review.status.equals(MortalityConstants.ASSIGNED) || review.status.equals(MortalityConstants.REASSIGNED) || review.status.equals(MortalityConstants.ACCEPTED) || review.status.equals(MortalityConstants.UPDATED)}">
                                <tr>
                                    <td>${review.patientName}</td>
                                    <td>${review.dischargeDateTime}</td>
                                    <td>${review.facilityCode}</td>
                                    <td>${review.dischargeUnit}</td>
                                    <td>${review.dischargingDivision}
                                        <g:if test="${review.assignedTo_role.equals(AdminConstants.QUALITY_LEAD)}">
                                            [Quality Lead Assigned : ${review.assignedTo}]
                                        </g:if>
                                        <g:else>
                                            [Other Reviewer Assigned : ${review.assignedTo}]
                                        </g:else>
                                    </td>
                                    <td>${review.daysSinceDeath}</td>
                                    <td>${review.statusDateTime}</td>
                                    <td>${review.status}</td>
                                    <td>%{--${review.statusHistory}--}%</td>
                                </tr>
                            </g:if>
                        </g:each>
                        <g:if test="${mortalityReviewList.grep { it -> it.status?.equals(MortalityConstants.ASSIGNED) || it.status?.equals(MortalityConstants.REASSIGNED) || it.status?.equals(MortalityConstants.ACCEPTED) || it.status?.equals(MortalityConstants.UPDATED) }.size() == 0}">
                            <tr><td colspan="9">No records found</td></tr>
                        </g:if>
                        <tr><td colspan="9" class="leftAlign"
                                style="background-color: lightgrey;font-weight: bold">Complete</td></tr>
                        <g:each in="${mortalityReviewList}" var="review">
                            <g:if test="${review.status.equals(MortalityConstants.SUBMITTED)}">
                                <tr>
                                    <td>${review.patientName}</td>
                                    <td>${review.dischargeDateTime}</td>
                                    <td>${review.facilityCode}</td>
                                    <td>${review.dischargeUnit}</td>
                                    <td>${review.dischargingDivision}
                                        <g:if test="${review.assignedTo_role.equals(AdminConstants.QUALITY_LEAD)}">
                                            [Quality Lead Assigned : ${review.assignedTo}]
                                        </g:if>
                                        <g:else>
                                            [Other Reviewer Assigned : ${review.assignedTo}]
                                        </g:else>
                                    </td>
                                    <td>${review.daysSinceDeath}</td>
                                    <td>${review.statusDateTime}</td>
                                    <td>${review.status}</td>
                                    <td>%{--${review.statusHistory}--}%</td>
                                </tr>
                            </g:if>
                        </g:each>
                        </tbody>
                        <g:if test="${mortalityReviewList.grep { it -> it.status?.equals(MortalityConstants.SUBMITTED) }.size() == 0}">
                            <tr><td colspan="9">No records found</td></tr>
                        </g:if>
                    </table>
                </div>
            </div>
        </div>
        <g:link controller="mortality" action="adminDashboard">
            <button type="button" class="btn btn-primary cancelButton">Cancel</button>
        </g:link>
        <g:actionSubmit value="Export Data to Excel" action="exportSearchData" onclick="this.form.action='${createLink(action:'exportData')}';" class="btn btn-primary"></g:actionSubmit>
    </div>

</g:form>