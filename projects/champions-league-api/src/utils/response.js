export const successResponse = (data, message = null) => ({
  success: true,
  data,
  message,
  timestamp: new Date().toISOString()
});

export const errorResponse = (error, statusCode = 400) => ({
  success: false,
  error,
  statusCode,
  timestamp: new Date().toISOString()
});
