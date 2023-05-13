enum ApiConnectionState {
  none,
  backendCheck, // connected to internet, trying to connect to backend
  backendFail,  // connected to internet, backend could not be reached
  authCheck,    // connected to backend, authenticating
  authFail,     // connected to backend, authentication failed
  full,         // connected to backend, authenticated
}
