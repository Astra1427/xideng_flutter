class AccountApis {
  static const String SendRegisterEmail = "account/SendRegisterEmail";
  static const String Authenticate = "account/authenticate";
  static const String RefreshToken = "account/refresh-token";
  static const String Register = "account/Register";
  static const String SendForgotPasswordEmail =
      "account/SendForgotPasswordEmail";
  static const String ResetPassword = "account/ResetPassword";

  /// <summary>
  /// POST : String email
  /// </summary>
  static const String SendDestroyAccountEmail =
      "account/SendDestroyAccountEmail";

  /// <summary>
  /// POST : String email,String code
  /// </summary>
  static const String DestroyAccount = "account/DestroyAccount";

  /// <summary>
  /// GET : Guid id
  /// </summary>
  static const String GetById = "account/GetById";

  /// <summary>
  /// GET : String email
  /// </summary>
  static const String GetByEmail = "account/GetByEmail";

  /// <summary>
  /// GET : String name
  /// </summary>
  static const String GetByName = "account/GetByName";

  /// <summary>
  /// GET : Guid id
  /// </summary>
  static const String GetVisitAccountInfoById =
      "account/GetVisitAccountInfoById";

  /// <summary>
  /// POST : String newName
  /// </summary>
  static const String EditAccountName = "account/EditAccountName";
}

class ExercisePlanApis {
  static const String GetAllPlans = "ExercisePlan/GetAllPlans";
  static const String AddPlan = "ExercisePlan/AddPlan";

  /// <summary>
  /// POST : ExercisePlanDTO model
  /// </summary>
  static const String UpdatePlan = "ExercisePlan/UpdatePlan";

  /// <summary>
  /// Guid planId
  /// </summary>
  static const String DeletePlan = "ExercisePlan/DeletePlan";

  /// <summary>
  /// POST : AccountRunningPlanDTO model
  /// </summary>
  static const String StartPlan = "ExercisePlan/StartPlan";

  /// <summary>
  /// POST : Guid planId
  /// </summary>
  static const String PausePlan = "ExercisePlan/PausePlan";

  /// <summary>
  /// POST : Guid PlanId
  /// </summary>
  static const String RestartPlan = "ExercisePlan/RestartPlan";

  /// <summary>
  /// POST : Guid PlanId
  /// </summary>
  static const String PublishOrCancelPlan = "ExercisePlan/PublishOrCancelPlan";

  /// <summary>
  /// GET : int pageIndex,int pageSize,int orderPriority
  /// </summary>
  static const String GetAllPublishPlansByPage =
      "ExercisePlan/GetAllPublishPlansByPage";

  /// <summary>
  /// GET : String planName
  /// </summary>
  static const String SearchPublishPlansByName =
      "ExercisePlan/SearchPublishPlansByName";

  /// <summary>
  /// GET : Guid planId
  /// </summary>
  static const String GetPlanByID = "ExercisePlan/GetPlanByID";

  /// <summary>
  /// POST : Guid planId
  /// </summary>
  static const String CollectPlan = "ExercisePlan/CollectPlan";

  /// <summary>
  /// POST : Guid planId
  /// </summary>
  static const String UncollectPlan = "ExercisePlan/UncollectPlan";

  /// <summary>
  /// GET : Guid folderId
  /// </summary>
  static const String GetPlansByCollectionFolder =
      "ExercisePlan/GetPlansByCollectionFolder";
}

class SkillApis {
  static const String GetSkillsWithDefault = "Skill/GetSkillsWithDefault";
  static const String GetSkills = "Skill/GetSkills";
}

class SynchronizationApis {
  /// <summary>
  /// POST : SynchronizationDTO model
  /// </summary>
  static const String LocalToCloud = "Synchronization/LocalToCloud";

  /// <summary>
  /// Get
  /// </summary>
  static const String CouldToLocal = "Synchronization/CouldToLocal";
}

class CollectionApis {
  /// <summary>
  /// POST : Guid folderId,Guid planId
  /// </summary>
  static const String CollectPlan = "Collection/CollectPlan";

  /// <summary>
  /// POST : Guid folderId,Guid planId
  /// </summary>
  static const String UncollectPlan = "Collection/UncollectPlan";

  /// <summary>
  /// GET : Guid reqeustAccountId, Guid purposeAccountId
  /// </summary>
  static const String GetCollectionFolders = "Collection/GetCollectionFolders";

  /// <summary>
  /// POST : CollectionFolderDTO model
  /// </summary>
  static const String CreateCollectFolder = "Collection/CreateCollectFolder";

  /// <summary>
  /// POST : CollectAndUncollectPlanReqeust model
  /// </summary>
  static const String CollectAndUncollectPlan =
      "Collection/CollectAndUncollectPlan";

  /// <summary>
  /// POST : Guid folderId
  /// </summary>
  static const String RemoveCollectFolder = "Collection/RemoveCollectFolder";

  /// <summary>
  /// POST : CollectionFolderDTO model
  /// </summary>
  static const String UpdateCollectFolder = "Collection/UpdateCollectFolder";
}
