package org.mountsinai.mortalitytriggersystem

import grails.converters.JSON
import groovy.sql.Sql
import oracle.jdbc.OracleTypes

class MortalityController {

    def dataSource
    static defaultAction = "dashboard"
    def mortalityTriggerService
    // Export service provided by Export plugin
    def exportService

    def dashboard() {
        def user = session?.user
        if (user.role.roleName.equals(AdminConstants.ADMIN)) {
            redirect action: 'adminDashboard'
        } else if (user.role.roleName.equals(AdminConstants.QUALITY_LEAD) || user.role.roleName.equals(AdminConstants.ADHOC)) {
            redirect action: 'qlDashboard'
        }
    }

/**
 * Action to display Admin dashboard
 * @return
 */
    def adminDashboard() {
        def facilities = ''
        if(session?.userFacilities){
            session?.userFacilities?.each{
                facilities += it + ','
            }
            facilities = facilities[0..-2]
        }else{
            facilities = session?.user?.facility.id
        }
        def mortalityReviewList = mortalityTriggerService.getAdminReviewList(facilities)
        //this is to just fetch facility list for initial display of Admin Search layout
        def adminSearchFieldsMap = mortalityTriggerService.getAdminSearchFields(0);
        def userFacility = session?.user?.facility?.id
        def facilityMap = [:]
        adminSearchFieldsMap['facilityList'].each{
            facilityMap[it.id] = it.facilityName + " (" +it.facilityCode + ")"
        }
        [mortalityReviewList: mortalityReviewList,facilityMap:facilityMap,specialities:adminSearchFieldsMap['specialityList'],leads:adminSearchFieldsMap['leadList'],adhocs:adminSearchFieldsMap['adhocList']]
    }

    /**
     * Action to fetchDeptQlForFacility
     * @return
     */
    def fetchDeptQlForFacility(){
        def adminSearchFieldsMap = mortalityTriggerService.getAdminSearchFields(params.facilityId);
        def allLeadReviewer = adminSearchFieldsMap['leadList'] + adminSearchFieldsMap['adhocList']
        allLeadReviewer = allLeadReviewer.sort{it.name}
        render (template: "/mortality/templates/adminSearchDeptQL",model:[specialities:adminSearchFieldsMap['specialityList'],leads:adminSearchFieldsMap['leadList'],adhocs:adminSearchFieldsMap['adhocList'],allLeadReviewer:allLeadReviewer])
    }

    def fetchQlForFacility(){
        def adminSearchFieldsMap = mortalityTriggerService.getAdminSearchFields(params.facilityId);
        def allLeadReviewer = []
        if(params.role == 'ALL'){
            allLeadReviewer = adminSearchFieldsMap['leadList'] + adminSearchFieldsMap['adhocList']
        }else if(params.role == AdminConstants.QUALITY_LEAD){
            allLeadReviewer = adminSearchFieldsMap['leadList']
        }else if(params.role == AdminConstants.ADHOC){
            allLeadReviewer = adminSearchFieldsMap['adhocList']
        }
        allLeadReviewer = allLeadReviewer.sort{it.name}
        render (template: "/mortality/templates/adminSearchQL",model:[allLeadReviewer:allLeadReviewer])
    }

    /**
     * Action to display search result and show admin search dashboard
     * @return
     */
    def displaySearchResults(){
        def reviewResults = mortalityTriggerService.searchReview(params);
        render (template: '/mortality/templates/adminDashBoardLayout',model:[mortalityReviewList: reviewResults[0]])
    }

    def cancelSearchForm(){
        println "cancelSearchForm"
    }

    def runReport() {
        println "runReport  params:"+params
        def adminSearchFieldsMap = mortalityTriggerService.getAdminSearchFields(params.facilityId);
        render (view: "/mortality/runReport",model:[specialities:adminSearchFieldsMap['specialityList'],leads:adminSearchFieldsMap['leadList'],adhocs:adminSearchFieldsMap['adhocList']])
       /* def facilityId = session?.user?.facility.id
       // def mortalityReviewList = mortalityTriggerService.getAdminReviewList(facilityId)
        def adminRunReportMap = mortalityTriggerService.getAdminSearchFields(facilityId);
        def userFacility = session?.user?.facility?.id
        def facilityMap = [:]
        adminRunReportMap['facilityList'].each {
            facilityMap[it.id] = it.facilityName + " (" + it.facilityCode + ")"
        }
        [facilityMap: facilityMap, userFacility: userFacility, specialities: adminSearchFieldsMap['specialityList'], leads: adminSearchFieldsMap['leadList'], adhocs: adminSearchFieldsMap['adhocList']]*/
    }

    def exportData(){
        def reviewResults = mortalityTriggerService.searchReview(params);
        def formattedReviewResults = mortalityTriggerService.formatReviewResultsWithHistory(reviewResults[0],reviewResults[1])
        params.remove('action')
        params.remove('controller')
        params.remove('format')
        params.remove('_action_exportData')
        render (view : "/mortality/exportData",model:[mortalityReviewList: formattedReviewResults,params: params])
    }
    /**
     * Action to Export Search data in Excel format
     * @return
     */
    def exportSearchData(){
        println params
        def reviewResults = mortalityTriggerService.searchReview(params);
        def formattedReviewResults = mortalityTriggerService.formatReviewResultsWithHistory(reviewResults[0],reviewResults[1])
        def dataExport = mortalityTriggerService.exportData(params, response, formattedReviewResults);
    }

    def qlDashboard() {
        def facilities = ''
        if(session?.userFacilities){
            session?.userFacilities?.each{
                facilities += it + ','
            }
            facilities = facilities[0..-2]
        }else{
            facilities = session?.user?.facility.id
        }
        def leadEmail = session?.user?.email
        def specialityId = session?.user?.speciality?.id
        def reviewList = mortalityTriggerService.getReviewList(facilities, leadEmail, specialityId)
        [reviewList: reviewList]
    }

    def review() {
        def user =  session?.user
        MortalityReviewForm reviewForm = MortalityReviewForm.findById(params.reviewId)
        def isFormEditable = mortalityTriggerService.checkIsReviewFormEditable(user, reviewForm);
        [mReviewForm: reviewForm,isFormEditable:isFormEditable]
    }

    def reviewFormOnSave() {
        MortalityReviewForm patientForm = MortalityReviewForm.findById(params.reviewId)
        [mReviewForm: patientForm]
    }

    def submitMortalityForm() {
        MortalityReviewForm patientForm = MortalityReviewForm.findById(params.reviewId)
        ReviewStatus statusObj = ReviewStatus.findByStatus(MortalityConstants.SUBMITTED)
        patientForm.status = statusObj
        patientForm.dateUpdated = new Date()
        patientForm.updatedBy = session?.user?.name
        patientForm.properties = params
        if(patientForm.save(failOnError: true, flush: true)){
            redirect action:  "qlDashboard"
        }
    }

    def acceptReviewForm() {
        def userNmae=session?.user?.name
        render  mortalityTriggerService.acceptReviewForm(params,userNmae) as JSON
    }

    def assignReviewForm() {
        def qlRole = Role.findByRoleName(AdminConstants.QUALITY_LEAD)
        def facility = Facility.findByFacilityCode(session?.user?.facility?.facilityCode);
        def leads = MortalityUser.findAllByRoleAndFacility(qlRole, facility)
        leads = leads.grep({ it -> it.id != session?.user?.id })
        def adhocRole = Role.findByRoleName(AdminConstants.ADHOC)
        def reviewerList = MortalityUser.findAllByRoleAndFacility(adhocRole, facility)
        def reviewerMap = [:]
        reviewerList.each {
            def str = it.name
            if (it?.dept) {
                str += " (" + it?.dept?.departmentName + ")"
            }
            reviewerMap[it.id] = str
        }

        [allLeadsList: leads, reviewerMap: reviewerMap, reviewinfo: params]
    }

    def saveMortalityReviewForm() {
        def userName = session?.user?.name
        render mortalityTriggerService.updateReviewFormChanges(params, userName) as JSON

    }


    def assignLeadReviewer() {
        def userName=session?.user?.name
        def updateLead = mortalityTriggerService.updateAssignLeadReviewer(params,userName)
        if(updateLead['STATUS']==MortalityConstants.SUCCESS){
             mortalityTriggerService.sendNotification(params)
        }
        render updateLead as JSON
    }

    def showHistory() {
        def auditList = AuditTrack.findAllByMortalityReviewFormId(params.reviewId)
        render template:'/mortality/templates/showHistory',model:[auditList:auditList]
    }

}
