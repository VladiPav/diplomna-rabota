export enum InternalErrorMessage {
  // GENERIC
  Default = "SOMETHING_WENT_WRONG",
  NotFound = "NOT_FOUND",
  InternalError = "INTERNAL_ERROR",
  Unauthorized = "REQUEST_DENIED",
  BadRequest = "BAD_REQUEST",

  //  User
  UserNotExist = "USER_DOESNT_EXIST",
  UserExist = "USER_ALREADY_EXISTS",
  UserMissingName = "MISSING_NAME",
  UserHasCard = "USER_HAS_CARD",

}

export enum HTTPStatusCode {
  Ok = 200,
  Created = 201,
  NoContentSuccess = 204,
  EmailSent = 250,
  BadRequest = 400,
  Unauthorized = 401,
  Forbidden = 403,
  NotFound = 404,
  InternalServerError = 500,
}

interface CustomErrorConstructor {
  statusCode: HTTPStatusCode;
  message: string;
  internalMessage: InternalErrorMessage;
}

export class CustomError extends Error {
  readonly message: string;
  readonly statusCode: HTTPStatusCode;
  readonly internalMessage: InternalErrorMessage;

  constructor(args: CustomErrorConstructor) {
    super(args.message);
    this.message = args.message;
    this.statusCode = args.statusCode;
    this.internalMessage = args.internalMessage;

    Object.setPrototypeOf(this, CustomError.prototype);
  }
}