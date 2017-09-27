<div>
    <g:if test="${auditList}">
        <g:each in="${auditList}" var="audit">
            <li>Status changed to ${audit.updatedStatus} from ${audit.prevStatus} by ${audit.updatedBy} at ${audit.dateUpdated}</li>
        </g:each>
    </g:if>
    <g:else>
        No Data To Show
    </g:else>
</div>