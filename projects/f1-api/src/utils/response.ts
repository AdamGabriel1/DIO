export const successResponse = <T>(data: T, message?: string) => ({
  success: true,
  data,
  message,
  timestamp: new Date().toISOString()
});

export const errorResponse = (error: string, code: number = 400) => ({
  success: false,
  error,
  code,
  timestamp: new Date().toISOString()
});
