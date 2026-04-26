// Enums are fixed lists of named options
// Much safer than using plain strings like "male" / "female"
// because the compiler catches typos automatically

enum Gender {
  male,
  female,
  preferNotToSay,
}

enum FormStatus {
  initial,    // form just loaded, nothing happened yet
  loading,    // processing (e.g. waiting for response)
  success,    // everything went well
  failure,    // something went wrong
}