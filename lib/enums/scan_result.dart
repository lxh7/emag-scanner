enum ScanResult {
  none, // no status
  pass, // person is registered and thus may enter
  check, // person is registered but has been scanned before. additional checking needed
  deny, // person is not registered
  error, // error during processing
}
