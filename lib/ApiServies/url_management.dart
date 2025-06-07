class ApiEndpoint {

  static const baseUrl ='http://13.200.129.19:4500/api/';


  static const loginEndPoint = '${baseUrl}login';
  static const signupEndPoint = '${baseUrl}registration';
  static const userProfileEndPoint = '${baseUrl}userProfile';
  static const myProjectEndPoint = '${baseUrl}getMyProjects';
  static const mySkillsEndPoint = '${baseUrl}getMySkills';
  static const createSkillEndPoint = '${baseUrl}createSkills';
  static const createProjectEndPoint = '${baseUrl}createProject';
  static const forgotPasswordEndPoint = '${baseUrl}sendOTP';
  static const verifyOtpEndPoint = '${baseUrl}sendPassword';
  static const allUserUrlEndPoint = '${baseUrl}getAllUserList';
  static const myAllProjectEndPoint = '${baseUrl}getMyProjects';
  static const allProjectEndPoint = '${baseUrl}getAllProjects';
  static const updateUserProfileEndPoint = '${baseUrl}updateUserProfile';
  static const interestedProjectEndPoint = '${baseUrl}requestInvitation';
  static const createCertificateEndPoint = '${baseUrl}createCertificate';
  static const getMyCertificatesEndPoint = '${baseUrl}getMyCertificates';
  static const deleteCertificateEndPoint = '${baseUrl}deleteCertificate';
  static const deleteSkillsEndPoint = '${baseUrl}deleteSkills';
  static const projectDetailsEndPoint = '${baseUrl}get-project-by-id?project_id=';
  static const userDetailsEndPoint = '${baseUrl}getUserProfileById?crUserId=';
  static const myInviteReEndPoint = '${baseUrl}getUserProjectAssociateList';
  static const myInviteSendEndPoint = '${baseUrl}getUserListProjectWise';
  static const myShowInterestEndPoint = '${baseUrl}getUserListProjectWise';
  static const myShowInterestSendEndPoint = '${baseUrl}showInterest';
  static const createInvitationEndPoint = '${baseUrl}createInvitation';
  static const assignProjectEndPoint = '${baseUrl}getProjectsUserList?prId=';
}