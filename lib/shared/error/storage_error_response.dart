import 'abs_error_response.dart';

enum StorageErrorCode {
  // 버킷 관련
  noSuchBucket(code: 'NoSuchBucket', message: '지정한 버킷이 존재하지 않습니다'),
  bucketAlreadyExists(code: 'BucketAlreadyExists', message: '버킷이 이미 존재합니다'),
  invalidBucketName(code: 'InvalidBucketName', message: '버킷 이름 형식이 잘못되었습니다'),

  // 객체/키 관련
  noSuchKey(code: 'NoSuchKey', message: '지정한 객체가 존재하지 않습니다'),
  invalidKey(code: 'InvalidKey', message: '객체 키 형식이 잘못되었습니다'),
  keyAlreadyExists(code: 'KeyAlreadyExists', message: '객체 키가 이미 존재합니다'),
  invalidRange(code: 'InvalidRange', message: '요청한 Range가 유효하지 않습니다'),

  // 업로드 관련
  noSuchUpload(code: 'NoSuchUpload', message: '지정한 업로드 ID가 존재하지 않습니다'),
  invalidUploadId(code: 'InvalidUploadId', message: '업로드 ID가 잘못되었습니다'),
  invalidUploadSignature(
    code: 'InvalidUploadSignature',
    message: '업로드 서명이 유효하지 않습니다',
  ),
  entityTooLarge(code: 'EntityTooLarge', message: '업로드할 파일 크기가 허용 한도를 초과했습니다'),
  missingPart(code: 'MissingPart', message: '멀티파트 업로드 시 파트가 누락되었습니다'),

  // 인증·접근
  invalidJWT(code: 'InvalidJWT', message: '유효하지 않은 JWT 토큰입니다'),
  accessDenied(code: 'AccessDenied', message: '해당 리소스에 대한 접근 권한이 없습니다'),

  // 서명 오류
  invalidSignature(code: 'InvalidSignature', message: '제공된 서명이 유효하지 않습니다'),
  signatureDoesNotMatch(
    code: 'SignatureDoesNotMatch',
    message: '요청 서명이 일치하지 않습니다',
  ),

  // S3 호환 오류
  s3Error(code: 'S3Error', message: 'S3 호환 오류가 발생했습니다'),
  s3InvalidAccessKeyId(
    code: 'S3InvalidAccessKeyId',
    message: 'AWS 액세스 키 ID가 잘못되었습니다',
  ),
  s3MaximumCredentialsLimit(
    code: 'S3MaximumCredentialsLimit',
    message: '생성 가능한 자격 증명 한도에 도달했습니다',
  ),

  // 시스템·데이터베이스
  internalError(code: 'InternalError', message: '서버 내부 오류가 발생했습니다'),
  databaseError(code: 'DatabaseError', message: 'Storage 데이터베이스 오류가 발생했습니다'),
  databaseTimeout(code: 'DatabaseTimeout', message: '데이터베이스 응답 시간 초과가 발생했습니다'),
  resourceLocked(code: 'ResourceLocked', message: '리소스가 잠겨 있어 변경할 수 없습니다'),
  lockTimeout(code: 'LockTimeout', message: '잠금 대기 시간 초과가 발생했습니다'),
  slowDown(code: 'SlowDown', message: '요청 속도가 너무 높아 일시적으로 차단되었습니다'),
  missingContentLength(
    code: 'MissingContentLength',
    message: 'Content-Length 헤더가 누락되었습니다',
  ),
  missingParameter(code: 'MissingParameter', message: '필수 파라미터가 누락되었습니다'),
  resourceAlreadyExists(
    code: 'ResourceAlreadyExists',
    message: '리소스가 이미 존재합니다',
  ),

  // 알 수 없는 오류
  unknown(code: 'Unknown', message: '알 수 없는 Storage 오류가 발생했습니다');

  final String code;
  final String message;

  const StorageErrorCode({required this.code, required this.message});
}

class StorageError extends AbsError {
  final StorageErrorCode code;

  StorageError({required this.code, String? message})
    : super(message: message ?? code.message, type: ErrorType.supabase);

  @override
  String toString() => '[StorageError-${code.name}] $message';
}
