class UserTable:
    TABLE="user"
    ID="id"
    NAME="name"
    SEX_ID="sex_id"
    EMAIL="email"
    BIRTH_DAY="birth_day"


class SexTable:
    TABLE="sex"
    ID="id"
    VALUE="value"


class AnalysisTable:
    TABLE="analysis"
    ID="id"
    NAME="name"
    TYPE="type"
    SUB_TYPE="sub_type"
    SEX_ID="sex_id"
    UNIT="unit"


class AnalysisNormTable:
    TABLE="analysis_norm"
    ID="id"
    ANALYSIS_ID="analysis_id"
    VALUE_MIN="value_min"
    VALUE_MAX="value_max"
    SEX_ID="sex_id"
    AGE_MIN="age_min"
    AGE_MAX="age_max"


class BloodBankTable:
    TABLE="blood_bank"
    ID="id"
    NAME="name"
    ADDRESS="address"
    COMPANY="company"
    LATITUDE="latitude"
    LONGITUDE="longitude"
    STATUS_ID="status_id"


class BloodNeedTable:
    TABLE="blood_need"
    ID="id"
    BANK_ID="bank_id"
    TIMESTAMP="timestamp"


class FacilityStatusTable:
    TABLE="facility_status"
    ID="id"
    VALUE="value"


class FileTable:
    TABLE="file"
    ID="id"
    PATH="path"
    NAME="name"
    UPLOADED_AT="uploaded_at"
    UPLOADED_BY_ID="uploaded_by_id"


class LaboratoryTable:
    TABLE="laboratory"
    ID="id"
    NAME="name"
    ADDRESS="address"
    LATITUDE="latitude"
    LONGITUDE="longitude"
    STATUS_ID="status_id"


class ParsedFileTable:
    TABLE="parsed_file"
    ID="id"
    FILE_ID="file_id"
    USER_ANALYSIS_ID="user_analysis_id"


class UserAnalysisTable:
    TABLE="user_analysis"
    ID="id"
    USER_ID="user_id"
    ANALYSIS_ID="analysis_id"
    ACTUAL_VALUE="actual_value"
    TIMESTAMP="timestamp"


class UserVisitTable:
    TABLE="user_visit"
    ID="id"
    FACILITY_ID="facility_id"
    USER_ID="user_id"
    TIMESTAMP="timestamp"
    STATUS_ID="status_id"


class VisitStatusTable:
    TABLE="visit_status"
    ID="id"
    VALUE="value"
    




