package org.mountsinai.mortalitytriggersystem

import grails.transaction.Transactional
import com.xlson.groovycsv.CsvParser
import groovy.io.FileType
import groovy.sql.Sql
import groovyx.gpars.GParsPool
import oracle.jdbc.OracleTypes
import org.apache.juli.logging.Log
import org.springframework.mail.MailException
import org.mountsinai.mortalitytriggersystem.EmailHandler
import java.util.concurrent.Future

@Transactional
class MortalityTriggerService {

    def dataSource
    def groovyPageRenderer
    def exportService
    def grailsApplication

    def insertMortalityData() {
        def fileList = []

        def dir = new File(MortalityConstants.FTP_FILE_PATH)
        dir.eachFileRecurse (FileType.FILES) { file ->
            fileList << file
        }
        try{
            fileList.each{
                mortalityReviewUpdate(it)
            }
        }catch(Exception e){
            e.printStackTrace()
        }

    }

    def mortalityReviewUpdate(file){
        def fileName = file?.getName()?.toString()?.toUpperCase()
        def fileString = new String(file.getBytes())
        def mortalityReviewForm
        def mortalityReviewFormMap = [:]
        def unassignedStatus = ReviewStatus.findByStatus(MortalityConstants.UNASSIGNED)
        def assignedStatus = ReviewStatus.findByStatus(MortalityConstants.ASSIGNED)
        def data = new CsvParser().parseCsv(fileString)
        def hospitalSite = ""
        def facilityCode = ""

        if(fileName.indexOf(MortalityConstants.MSH) > -1){
            hospitalSite = MortalityConstants.MSH
            facilityCode = MortalityConstants.MSH
        }
        else if(fileName.indexOf(MortalityConstants.MSQ) > -1){
            hospitalSite = MortalityConstants.MSQ
            facilityCode = MortalityConstants.MSQ
        }
        else if(fileName.indexOf(MortalityConstants.BIPETRIE) > -1){
            facilityCode = MortalityConstants.MSBI
        }
        else if(fileName.indexOf(MortalityConstants.MSB) > -1){
            facilityCode = MortalityConstants.MSB
        }
        else if(fileName.indexOf(MortalityConstants.MSWEST) > -1){
            facilityCode = MortalityConstants.MSW
        }
        else if(fileName.indexOf(MortalityConstants.STLUKES) > -1){
            facilityCode = MortalityConstants.MSSL
        }

        def facility = Facility.findByFacilityCode(facilityCode)
        def depts = Department.findAllByFacility(facility)
        def specialities = Speciality.findAllByFacility(facility)

        def deptMap = [:]
        def specialityMap = [:]

        depts.each{
            deptMap[it?.departmentName?.toUpperCase()] = it
        }

        specialities.each{
            specialityMap[it?.specialityName?.toUpperCase()] = it
        }

        for(fields in data) {
            mortalityReviewForm = new MortalityReviewForm()
            mortalityReviewForm.admitUnit = fields."Admit Unit".trim()
            mortalityReviewForm.patientName = fields."Patient Name".trim()
            mortalityReviewForm.mrn = fields."MRN".trim()
            mortalityReviewForm.gender = fields."Gender".trim()
            mortalityReviewForm.admittingDiagnosis = fields."Admitting Diagnosis".trim()
            mortalityReviewForm.dischargeDiagnosis = fields."Discharge Diagnosis".trim()
            mortalityReviewForm.dischargeUnit = fields."Discharge Unit".trim()
            if(hospitalSite == ''){
                mortalityReviewForm.admitDateTime = new Date().parse("mm/dd/yyyyHH:mm", (fields."Admit Date".trim() + fields."Admit Time".trim()).toString())
                mortalityReviewForm.expiredDateTime = new Date().parse("mm/dd/yyyyHH:mm", (fields."Date Expired".trim() + fields."Time Expired".trim()).toString())
            }else{
                mortalityReviewForm.admitDateTime = new Date().parse("MM/dd/yyHH:mm", (fields."Admit Date".trim() +fields."Admit Time".trim()).toString())
                mortalityReviewForm.expiredDateTime = new Date().parse("yyyy-mm-ddHH:mm", (fields."Date Expired".trim() +fields."Time Expired".trim()).toString())
            }

            mortalityReviewForm.hospService = fields."Hosp service".trim()
            mortalityReviewForm.lastAttending = fields."Last Attending".trim()
            mortalityReviewForm.dictationCode = fields."Dictation Code".trim()
            mortalityReviewForm.serviceTeam = fields."Service Team".trim()
            mortalityReviewForm.visitId = fields."Visit ID".trim()

            if(fields.columns.toString().indexOf("Hospital Site")>-1){
                mortalityReviewForm.hospitalSite = fields."Hospital Site".trim()
            }else{
                mortalityReviewForm.hospitalSite = hospitalSite
            }

            mortalityReviewForm.createdBy = MortalityConstants.MTT_SYSTEM

            mortalityReviewForm.facility = facility
            mortalityReviewForm.dept = deptMap[mortalityReviewForm.hospService.toUpperCase()]
            mortalityReviewForm.speciality = specialityMap[mortalityReviewForm.hospService.toUpperCase()]
            mortalityReviewForm.lead = mortalityReviewForm.speciality?.lead

            if(mortalityReviewForm.speciality){
                mortalityReviewForm.status = assignedStatus
            }else{
                mortalityReviewForm.status = unassignedStatus
            }

            mortalityReviewFormMap[fields."MRN"] = mortalityReviewForm

        }

        if (mortalityReviewFormMap.size() > 0) {
            //batch insert
            mortalityReviewFormMap.each {
                def mortalityReviewFormObj = it.value
                MortalityReviewForm.withTransaction {
                    mortalityReviewFormObj.save(failOnError: true)
                }
            }

            MortalityReviewForm.withSession { session ->
                session.flush()
            }
            println "MortalityReviewForm Information inserted from file " + fileName + " at "  + new Date()
        }
    }

    def sendMortalityNotification(){
        def yesterday = new Date()-2
        println yesterday
        def reviewList = MortalityReviewForm.executeQuery("select mrf.id, mrf.mrn, mrf.patientName, mrf.lead from MortalityReviewForm mrf where mrf.lead is not null and trunc(mrf.dateCreated) = trunc(:dateCreated)",[dateCreated:yesterday])

        reviewList.each{
            /*println it[0]
            println it[1]
            println it[2]
            println it[3]?.id
            println it[3]?.email*/
            def reviewFormLink = AdminUtils.getBaseURL() + '/mortality/review?reviewId=' + it[0] + '&userId=' + it[3]?.id
            println reviewFormLink
            sendEmail(it[2], it[1], true, reviewFormLink, "anshul.bansal@mountsinai.org")
        }

    }


    def getReviewList(facilities, leadEmail, specialityId) {

        Sql sql = new Sql(dataSource)
        def reviewList = []
        sql.call '{ call MTT_FRONTEND.getReviewList(?,?,?,?)}', [facilities, leadEmail, specialityId, Sql.out(OracleTypes.CURSOR)], { row ->
            row.eachRow() {

                def review = [:]
                review.id = row.ID
                review.patientName = row.PATIENT_NAME
                review.dischargeDateTime = row.DISCHARGE_DATE_TIME
                review.facilityName = row.FACILITY_NAME
                review.facilityCode = row.FACILITY_CODE
                review.dischargingDepartment = row.DISCHARGING_DEPARTMENT
                review.dischargeUnit = row.DISCHARGE_UNIT
                review.statusDateTime = row.DATE_UPDATED
                review.status = row.status
                review.mrn = row.mrn
                reviewList.add(review)
            }
        }
        return reviewList
    }

    def sendEmail(patientName, mrn, isQualityLead, reviewFormLink, toAddr){
        def fromAddr = 'do-not-reply@mountsinai.org'
        def ccAddr = ''
        def subject = "Mortality Trigger Tool - Review form of $patientName :$mrn"
        def text = groovyPageRenderer.render template: '../email/templates/notificationEmail', model: [patientName: patientName, mrn: mrn, isQualityLead:isQualityLead, reviewFormLink:reviewFormLink]
        try {
            EmailHandler.sendEmail(fromAddr, toAddr, ccAddr, subject, text)
        } catch (MailException ex) {
            return false
        }
    }
    /**
     * Method to get Admin Review List from MTT_FRONTEND.getReviewList based on facilities
     * @param facilities
     * @return adminReviewList
     */
    def getAdminReviewList(facilities) {
        Sql sql = new Sql(dataSource)
        def adminReviewList = []
        sql.call '{call MTT_FRONTEND.getReviewList(?,?,?,?)}', [facilities, "", "", Sql.out(OracleTypes.CURSOR)], { rows ->
            rows.eachRow() { row ->
                def review = [:]
                review.id = row.ID
                review.patientName = row.PATIENT_NAME
                review.dischargeDateTime = row.DISCHARGE_DATE_TIME
                review.facilityCode = row.FACILITY_CODE
                review.dischargeUnit = row.DISCHARGE_UNIT
                review.dischargingDivision = row.DISCHARGING_DIVISION
                review.assignedTo = row.ASSIGNED_TO
                review.assignedTo_role = row.ROLE
                review.daysSinceDeath = row.DAYS_SINCE_DEATH
                review.statusDateTime = row.FORM_DATE_UPDATED
                review.status = row.status
                adminReviewList.add(review)
            }
        }

        return adminReviewList
    }

    /**
     * Method to get facilityList, specialityList, leadList and adhocList from MTT_FRONTEND.getAdminSearchFields based on facilityId Passed
     * @param facilityId
     * @return facilityList, specialityList, leadList, adhocList
     */
    def getAdminSearchFields(facilityId) {
        def facilityList = []
        def specialityList = []
        def leadList = []
        def adhocList = []
        Sql sql = new Sql(dataSource)
        sql.call '{call MTT_FRONTEND.getAdminSearchFields(?,?,?,?,?)}', [facilityId, Sql.out(OracleTypes.CURSOR), Sql.out(OracleTypes.CURSOR), Sql.out(OracleTypes.CURSOR), Sql.out(OracleTypes.CURSOR)], { facilityListCursor, specialityListCursor, leadListCursor, adhocListCursor ->
            facilityListCursor.eachRow() { facilityRs ->
                def facility = [:]
                facility.id = facilityRs.id
                facility.facilityName = facilityRs.facility_name
                facility.facilityCode = facilityRs.facility_code
                facilityList.add(facility)
            }

            specialityListCursor.eachRow() { specialityRs ->
                def speciality = [:]
                speciality.id = specialityRs.id
                speciality.specialityName = specialityRs.speciality_name
                specialityList.add(speciality)
            }

            leadListCursor.eachRow() { leadRs ->
                def lead = [:]
                lead.id = leadRs.id
                lead.name = leadRs.name
                leadList.add(lead)
            }
            adhocListCursor.eachRow() { adhocRs ->
                def adhoc = [:]
                adhoc.id = adhocRs.id
                adhoc.name = adhocRs.name
                adhocList.add(adhoc)
            }
        }
        return ['facilityList': facilityList, 'specialityList': specialityList, 'leadList': leadList, 'adhocList': adhocList]
    }

    /**
     * Method to get Search Result list for admin board by passing params from admin dashboard
     * @param params
     * @return resultList
     */
    def searchReview(params) {
        def sb = StringBuilder.newInstance();
        def basicSql = """
                        SELECT mr.id,
                          mr.patient_Name,
                          mr.discharge_Date_Time,
                          to_char(mr.expired_date_time,'mm/dd/yyyy hh24:mi'),                          
                          fac.facility_code,
                          fac.facility_name,
                          mr.DISCHARGE_UNIT,
                          spec.speciality_name as discharging_division,
                          mu.name as assigned_to,
                          role.role_name role,
                          extract (DAY FROM(sysdate - mr.expired_date_time)) AS days_since_death,
                          to_char(mr.date_updated,'mm/dd/yyyy hh24:mi') as form_date_updated,
                          status.status,
                          aut.prev_status,
                          aut.updated_status,
                          aut.assigned_user,
                          aut.updated_by,
                          to_char(aut.date_updated,'mm/dd/yyyy hh24:mi') as status_date_updated
                          
                        FROM mortality_review_form mr,
                          review_status status,
                          facility fac, 
                          speciality spec,
                          mortality_user mu,
                          audit_track aut,
                          role role
                        WHERE fac.id    = mr.facility_id
                        AND mr.facility_id = '$params.facility'
                        AND status.id   = mr.status_id
                        AND mr.speciality_id = spec.id
                        AND mr.lead_id = mu.id
                        AND mr.id = aut.mortality_review_form_id
                        AND mu.role_id = role.id
                        order by mr.expired_date_time, aut.date_updated
                        """
        sb << basicSql
        if(params.formStatus){
            if(params.formStatus.equals(MortalityConstants.UNASSIGNED)){
                sb << " and status.status != '$MortalityConstants.SUBMITTED'"
            }else if(params.formStatus.equals(MortalityConstants.SUBMITTED)){
                sb << " and status.status = '$params.formStatus'"
            }
        }
        if (params.speciality && params.speciality != '') {
            sb << " and speciality_id = $params.speciality "
        }
        if (params.qualityLead && params.qualityLead != '') {
            sb << " and lead_id = $params.qualityLead "
        }
        /*if (params.adhoc && params.adhoc != '') {
            sb << " and reviewer_id = $params.adhoc "
        }*/
        if (params.mrn && params.mrn != '') {
            sb << " and mrn = $params.mrn "
        }
        if (params.patientName && params.patientName != '') {
            sb << " and patient_name like '%$params.patientName%'"
        }
       // println params
        if (params?.dateOfDeathRadio?.toString()?.indexOf(MortalityConstants.DATE_OF_DEATH)>-1) {
            sb << " and trunc(expired_date_time) = to_date('$params.dateOfDeath', 'mm/dd/yyyy')"
        }

        if (params.dateOfDeathRadio?.toString()?.indexOf(MortalityConstants.DATE_RANGE)>-1){
            sb << " and trunc(expired_date_time) between to_date('$params.fromDeathDate','mm/dd/yyyy') and  to_date('$params.toDeathDate','mm/dd/yyyy') "
        }

        if (params.dateCompletedRadio?.toString()?.indexOf(MortalityConstants.DATE_COMPLETED)>-1) {
            sb << " and trunc(mr.date_updated) = to_date('$params.dateCompleted','mm/dd/yyyy') "
        }

        if (params.dateCompletedRadio?.toString()?.indexOf(MortalityConstants.COMPLETED_RANGE)>-1) {
            sb << " and status.status = 'COMPLETED' "
            sb << " and trunc(mr.date_updated) between to_date('$params.fromDateCompleted','mm/dd/yyyy') and to_date('$params.toDateCompleted','mm/dd/yyyy') "
        }
        if(params.requiredFurtherReview){
            sb << " and does_death_require_further_rev = 1"
        }
        if(params.expectedPatToDieAdmission){
            sb << " and expected_pat_to_die_admission = 1"
        }

        println sb.toString()
        Sql sql = new Sql(dataSource)
        def resultList = []
        sql.call '{call MTT_FRONTEND.searchReview(?,?)}', [sb.toString(), Sql.out(OracleTypes.CURSOR)], { results ->
            results.eachRow() { result ->
                def searchResult = [:]
                searchResult.id = result.ID
                searchResult.patientName = result.PATIENT_NAME
                searchResult.dischargeDateTime = result.DISCHARGE_DATE_TIME
                searchResult.facilityCode = result.FACILITY_CODE
                searchResult.dischargeUnit = result.DISCHARGE_UNIT
                searchResult.dischargingDivision = result.DISCHARGING_DIVISION
                searchResult.assignedTo = result.ASSIGNED_TO
                searchResult.assignedTo_role = result.ROLE
                searchResult.daysSinceDeath = result.DAYS_SINCE_DEATH
                searchResult.statusDateTime = result.FORM_DATE_UPDATED
                searchResult.status = result.STATUS
                searchResult.history_prev_status = result.PREV_STATUS
                searchResult.history_updated_status = result.UPDATED_STATUS
                searchResult.history_assigned_user = result.ASSIGNED_USER
                searchResult.history_updated_by = result.UPDATED_BY
                searchResult.history_date_updated = result.STATUS_DATE_UPDATED
                resultList.add(searchResult)
            }
        }

        def statusHistoryResultMap = [:]

        resultList.each{
            def statusMap = [:]
            statusMap.history_prev_status = it.history_prev_status
            statusMap.history_updated_status = it.history_updated_status
            statusMap.history_assigned_user = it.history_assigned_user
            statusMap.history_updated_by = it.history_updated_by
            statusMap.history_date_updated = it.history_date_updated
            if(!statusHistoryResultMap[it.id]){
                statusHistoryResultMap[it.id] = [statusMap]
            }else{
                statusHistoryResultMap[it.id] << statusMap
            }
        }
        resultList = resultList.unique{it.id}
        return [resultList,statusHistoryResultMap]
    }

    def formatReviewResultsWithHistory(reviewList, statusHistoryMap){

        reviewList.each{
            def statusHistory = statusHistoryMap[it.id]
            /*def sb = new StringBuilder()
            sb.append()*/
            it.statusHistory = statusHistory
        }
        return reviewList
    }

    /**
     * Method to export search data to Excel format
     * @return
     */
    def exportData(params, response, reviewResults) {
        params.format = "excel" //pdf
        params.extension = "xls" //pdf

        if (params?.format) {
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename=mttExport.${params.extension}")

            List fields = ["patientName", "dischargeDateTime", "facilityCode", "dischargeUnit","dischargingDivision","assignedTo","role","daysSinceDeath","statusDateTime","status","statusHistory"]
            Map labels = ["patientName": "Patient Name", "dischargeDateTime": "Discharge Date", "facilityCode": "Facility" ,"dischargeUnit":"Discharging Unit","dischargingDivision":"Discharging Division",
                          "assignedTo":"Assigned To","role":"Role","daysSinceDeath":"Days Since Death","statusDateTime":"Status Date/Time","status":"Status","statusHistory":"Status History"]

            Map formatters = [:]
            Map parameters = [:]

            exportService.export(params.format, response.outputStream, reviewResults, fields, labels, formatters, parameters)
            return response.outputStream

        }
    }

    def checkIsReviewFormEditable(user,mReviewForm){
        def isFormEditable = false
        MortalityUser mUser = user
        MortalityReviewForm reviewForm = mReviewForm
        def formStatus = reviewForm?.status?.status

        if(reviewForm?.lead){
            if (formStatus.equals(MortalityConstants.ACCEPTED) || formStatus.equals(MortalityConstants.UPDATED)){
                if(mUser.email.equals(reviewForm?.lead?.email)) {
                    isFormEditable = true
                }
            }
        }
        println isFormEditable
        return isFormEditable
    }

    def sendNotification(params) {
        def returnMap = [:]
        def notification = {
            try{
                def isQualityLead = true
                def reviewFormLink
                def toAddr
                if (params.leadId) {
                    reviewFormLink = AdminUtils.getBaseURL() + '/mortality/review?reviewId=' + params.reviewId + '&userId=' + params.leadId
                } else if (params.reviewerId) {
                    // MortalityUser reviewerObj = MortalityUser.findById(params.reviewerId)
                    // toAddr = reviewerObj.email
                    reviewFormLink = AdminUtils.getBaseURL() + '/mortality/review?reviewId=' + params.reviewId + '&userId=' + params.reviewerId
                }
                def patientName = params.patientName
                def mrn = params.mrn
                toAddr = 'sanjayhm@nousinfo.com'
                sendEmail(patientName, mrn, isQualityLead, reviewFormLink, toAddr)
                returnMap[MortalityConstants.STATUS] = MortalityConstants.SUCCESS
            }catch (Exception e) {

                e.printStackTrace()
                log.error(e.message)
                returnMap[MortalityConstants.STATUS] = MortalityConstants.FAILED

            }

        }

        //for asynchronous call
        GParsPool.withPool {
            Future result = notification.callAsync()
        }
        return returnMap
    }

    def updateAssignLeadReviewer(params, userName) {
        def returnMap = [:]
        try {
            MortalityReviewForm patientForm = MortalityReviewForm.findById(params.reviewId)
            if (params.leadId) {
                MortalityUser leadObj = MortalityUser.findById(params.leadId)
                patientForm.lead = leadObj
            } else if (params.reviewerId) {
                MortalityUser reviewerObj = MortalityUser.findById(params.reviewerId)
                patientForm.reviewer = reviewerObj
            }
            if (params.status == MortalityConstants.ASSIGNED) {
                ReviewStatus statusObj = ReviewStatus.findByStatus(MortalityConstants.REASSIGNED)
                patientForm.status = statusObj
            } else if (params.status == MortalityConstants.UNASSIGNED) {
                ReviewStatus statusObj = ReviewStatus.findByStatus(MortalityConstants.ASSIGNED)
                patientForm.status = statusObj
            }
            patientForm.dateUpdated = new Date()
            patientForm.updatedBy = userName
            patientForm.save(failOnError: true, flush: true)
            returnMap[MortalityConstants.STATUS] = MortalityConstants.SUCCESS

        } catch (Exception e) {
            e.printStackTrace()
            log.error(e.message)
            returnMap[MortalityConstants.STATUS] = MortalityConstants.FAILED

        }

        return returnMap
    }

    def acceptReviewForm(params, userName) {
        def returnMap = [:]
        try {
            MortalityReviewForm patientForm = MortalityReviewForm.findById(params.reviewId)
            ReviewStatus statusObj = ReviewStatus.findByStatus(MortalityConstants.ACCEPTED)
            patientForm.status = statusObj
            patientForm.dateUpdated = new Date()
            patientForm.updatedBy = userName
            patientForm.save(failOnError: true, flush: true)
            returnMap[MortalityConstants.STATUS] = MortalityConstants.SUCCESS
        } catch (Exception e) {
            e.printStackTrace()
            log.error(e.message)
            returnMap[MortalityConstants.STATUS] = MortalityConstants.ERROR
            returnMap[MortalityConstants.MESSAGE] = e.message
        }
        return returnMap
    }

    def updateReviewFormChanges(params, userName) {
        def returnMap = [:]
        try {
            MortalityReviewForm patientForm = MortalityReviewForm.findById(params.reviewId)
            ReviewStatus statusObj = ReviewStatus.findByStatus(MortalityConstants.UPDATED)
            patientForm.status = statusObj
            params.remove('status')
            patientForm.properties = params
            patientForm.updatedBy = userName
            patientForm.save(failOnError: true, flush: true)
            returnMap[MortalityConstants.STATUS] = MortalityConstants.SUCCESS
        } catch (Exception e) {
            e.printStackTrace()
            log.error(e.message)
            returnMap[MortalityConstants.STATUS] = MortalityConstants.ERROR
            //returnMap[MortalityConstants.MESSAGE] = e.message
        }
        return returnMap
    }
}
