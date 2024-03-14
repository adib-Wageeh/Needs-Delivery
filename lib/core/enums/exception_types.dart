enum ExceptionType{

  // dio exceptions
  badCertificate,
  sendTimeout,
  receiveTimeout,
  cancel,
  connectionTimeout,

  // response code exceptions
  unauthorizedRequest,
  notFound,
  conflict,
  unProcessAbleEntity,
  internalServerError,
  serviceUnavailable,
  unknownCode,


  noInternetConnection,
  socketException,
  unExpected,
  formatException,
  unableToProcess,

  // location exception
  location,

  // cart exceptions
  itemMaxAmount,

  // categories
  noSubAvailable,
  noCatAvailable,
  noProductsAvailable,

  // login
  userNotFound,
  waitForApprove,
  userRejected,

  // suppliers
  noSuppliersAvailable,
  noCompaniesAvailable,

  // orders
  noOrdersAvailable,
  noInvoicesAvailable,
  noSlidesAvailable,
  noReturnProducts,
  noDeleteProducts,

  // tickets
  noTypeSelected,
  noMessageAdded,
  noReasonsAdded,
  noTicketsAvailable,

}
