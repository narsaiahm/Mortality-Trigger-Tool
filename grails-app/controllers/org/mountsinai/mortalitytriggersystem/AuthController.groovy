package org.mountsinai.mortalitytriggersystem

import static grails.util.Environment.PRODUCTION
import static grails.util.Environment.getCurrentEnvironment

class AuthController {
//added comment
    static defaultAction = "login"

    def login() {
        println params
        def userId = request.getHeader('sm_user')
        def userName = request.getHeader('MSNYU_FULLNAME')
        def email = ''
        if(currentEnvironment != PRODUCTION) {
            if(!userId) {
                userId = 'jullieswain'
                email = 'Lori.Finkelstein-Blond@mountsinai.org'
                //email = 'julie.swain@mountsinai.org'//'Michael.Bronson@mountsinai.org'
            }
        }
        session['userId'] = userId
        session['email'] = email
        log.info("login --> $userId")
		log.debug("session cleared: $session")
        def users = []
        //to check if review form is accessed through email link
        if(params.isEmailLink.equals("1") && params.userId){
            users = MortalityUser.findAllById(params?.userId)
        }else{
            users = MortalityUser.findAllByEmailIlike(email)
        }
        println users
        if(users) {
            //check database for roles
            def totalRoles = users.size()
            session.user = users[0]
            if(totalRoles > 1){
                session.userFacilities = users.facility.id
            }
            println session
            //to open review form directly, if accessed through email link
            if(params.isEmailLink.equals("1") && params.userId){
                redirect(controller:'mortality',action:'review',params:params)
            }else if (users[0].role.roleName == 'ADMIN') {
                redirect(controller:'mortality',action:'adminDashboard')
            }else if(users[0].role.roleName == 'QUALITY_LEAD' || users[0].role.roleName == 'ADHOC') {
                redirect(controller:'mortality',action:'qlDashboard')
            }
        } else {
            //redirect uri: '/logout.openam
            if(params.isEmailLink.equals("1") && params.userId){
                redirect(controller: "auth", action: "login")
            }else{
                render "You are not authorised to use this application, please contact your system administrator"
            }
        }
    }

    def logout() {
        session.invalidate()
        redirect uri: '/logout.openam'
    }
}
