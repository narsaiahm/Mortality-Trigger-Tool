package org.mountsinai.mortalitytriggersystem

import grails.converters.JSON
import grails.transaction.Transactional
import groovy.json.JsonOutput
import groovy.sql.Sql
import groovyx.gpars.GParsPool
import oracle.jdbc.OracleTypes
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.concurrent.Future

/**
 * @author bansaa03
 * @since 09/01/2017
 */
@Transactional
class AuditService {
    def dataSource
    static Logger log = LoggerFactory.getLogger(AuditService.class)

    def auditRequest(def params, def userName, def actionName) {
        def auditing = {
            try {
                def mortalityReviewId = params.reviewId
                def prevStatus = params.status
                def updatedStatus
                def assignedUser
                if (actionName == 'acceptReviewForm') {
                    updatedStatus = MortalityConstants.ACCEPTED
                } else if (actionName == 'assignLeadReviewer') {
                    updatedStatus = MortalityConstants.REASSIGNED
                    if (params.leadName) {
                        assignedUser = params.leadName
                    } else if (params.reviewerName) {
                        assignedUser = params.reviewerName
                    }
                } else if (actionName == 'saveMortalityReviewForm') {
                    updatedStatus = MortalityConstants.UPDATED
                }
                def updatedBy = userName
                Sql sql = new Sql(dataSource)
                sql.call '{ call MTT_FRONTEND.auditTrack(?,?,?,?,?,?)}', [mortalityReviewId, prevStatus, updatedStatus, updatedBy, assignedUser, Sql.out(OracleTypes.NUMBER)], { status ->

                }
            } catch (Exception e) {
                e.printStackTrace()
                log.error(e.message)
            }
        }

        //for asynchronous call
        GParsPool.withPool {
            Future result = auditing.callAsync()
        }
    }
}
