## Style
 
Never use em dashes (—, U+2014) or en dashes (–, U+2013) in any text you write for me: code comments, commit messages, PR descriptions, chat responses, documentation, or any other output.
 
Use commas, periods, parentheses, or colons instead, depending on what reads most naturally.
 
### Exceptions
 
Do not strip or alter dash characters in the following cases, since doing so could break behavior:
 
- Regex patterns that intentionally match `—` or `–`
- Unicode escape sequences (`\u2014`, `\u2013`) in source code
- Test fixtures or test data that use dash characters as literal input
- Existing string literals in databases, config files, or data files (e.g. locale files, migration scripts, historical records) where modifying them would cause a correctness or round-trip mismatch
When in doubt: if removing or changing the dash would alter code behavior or break a test, leave it as-is and add a `// em-dash-ok` comment on that line.
 
