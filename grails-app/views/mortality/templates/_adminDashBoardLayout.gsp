<%@page import="org.mountsinai.mortalitytriggersystem.MortalityConstants; org.mountsinai.mortalitytriggersystem.AdminConstants"%>
<div class="col-md-9">
    <span class="fright">Loaded <g:formatDate format="EEE MM-dd-yyyy HH:mm:ss" date="${new Date()}"/></span>
</div>

<div class="col-md-9">
    <div class="row">
        <span class="textTitle">Unassigned</span>
        <div class="col-md-12 margin_top_-10">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>Action</th>
                        <th>Patient Name</th>
                        <th>Discharge Date</th>
                        <th>Facility</th>
                        <th>Discharging Unit</th>
                        <th>Discharging Division</th>
                        <th>Days Since Death</th>
                        <th>Status Date/Time</th>
                        <th>Status</th>
                        <th>Status History</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${mortalityReviewList}" var = "review">
                        <g:if test="${review.status.equals(MortalityConstants.UNASSIGNED)}">
                            <tr>
                                <td>
                                    <g:link action="assignReviewForm"
                                            params="[reviewId: review.id, status: review.status, patientName: review.patientName, mrn: review.mrn]">
                                        <button type="button" class="btn btn-primary btn-xs btn-xs">Assign</button>
                                    </g:link>
                                </td>
                                <td><g:link action="review" params="[reviewId: review.id]">${review.patientName}</g:link></td>
                                <td>${review.dischargeDateTime}</td>
                                <td>${review.facilityCode}</td>
                                <td>${review.dischargeUnit}</td>
                                <td>${review.dischargingDivision}</td>
                                <td>${review.daysSinceDeath}</td>
                                <td>${review.statusDateTime}</td>
                                <td>${review.status}</td>
                                <td>
                                    <button type="button"
                                            class="btn btn-primary btnQualityLead btn-xs"
                                            id="showHistory_${review.id}"
                                            onclick="showHistory(${review.id}, this)">Show History</button>
                                </td>
                            </tr>
                        </g:if>
                    </g:each>
                    <g:if test="${mortalityReviewList.grep{it -> it.status?.equals(MortalityConstants.UNASSIGNED)}.size()==0}">
                        <tr><td colspan="10">No records found</td></tr>
                    </g:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="row">
        <span class="textTitle">Incomplete</span>
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
                    <g:each in="${mortalityReviewList}" var = "review">
                        <g:if test="${review.status.equals(MortalityConstants.ASSIGNED) || review.status.equals(MortalityConstants.REASSIGNED) || review.status.equals(MortalityConstants.ACCEPTED) || review.status.equals(MortalityConstants.UPDATED)}">
                            <tr>
                                <td><g:link action="review" params="[reviewId: review.id]">${review.patientName}</g:link></td>
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
                                <td>
                                    <button type="button"
                                            class="btn btn-primary btnQualityLead btn-xs"
                                            id="showHistory_${review.id}"
                                            onclick="showHistory(${review.id}, this)">Show History</button>
                                </td>
                            </tr>
                        </g:if>
                    </g:each>
                    <g:if test="${mortalityReviewList.grep{it -> it.status?.equals(MortalityConstants.ASSIGNED) || it.status?.equals(MortalityConstants.REASSIGNED) || it.status?.equals(MortalityConstants.ACCEPTED) || it.status?.equals(MortalityConstants.UPDATED)}.size()==0}">
                        <tr><td colspan="9">No records found</td></tr>
                    </g:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="row">
        <span class="textTitle">Complete</span>
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
                    <g:each in="${mortalityReviewList}" var = "review">
                        <g:if test="${review.status.equals(MortalityConstants.SUBMITTED)}">
                            <tr>
                                <td><g:link action="review" params="[reviewId: review.id]">${review.patientName}</g:link></td>
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
                                <td>
                                    <button type="button" class="btn btn-primary btn-xs reveal">Show History</button>
                                </td>
                            </tr>
                        </g:if>
                    </g:each>
                    </tbody>
                    <g:if test="${mortalityReviewList.grep{it -> it.status?.equals(MortalityConstants.SUBMITTED)}.size()==0}">
                        <tr><td colspan="9">No records found</td></tr>
                    </g:if>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="dialog" title="Show History">

</div>
