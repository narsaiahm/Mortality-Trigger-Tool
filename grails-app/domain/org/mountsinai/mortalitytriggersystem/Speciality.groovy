package org.mountsinai.mortalitytriggersystem

class Speciality {

    long id
    String specialityName
    MortalityUser lead

    Date dateCreated
    String createdBy
    Date dateUpdated
    String updatedBy


    static belongsTo = [dept:Department,facility:Facility]

    static constraints = {
        dept nullable:true
        facility nullable:true
        lead nullable: true
        dateCreated (nullable:true)
        createdBy (nullable:true)
        dateUpdated (nullable:true)
        updatedBy (nullable:true)
    }

    static mapping = {
        version false
    }

    @Override
    String toString() {
        return facility?.facilityCode?.toString() + " : " +dept?.departmentName?.toString() +" : " +specialityName
    }
}
