---
applyTo: "**/*.{ts,tsx,js,jsx,py,java,cs,go,rb,php}"
description: "Secure-coding rules applied to all application source files"
---

# Secure Coding Instructions

Apply these rules when authoring or modifying application code. They are scoped to source files only (see `applyTo`) to keep token usage low.

## Input & Output
- Validate all external input at the boundary (type, length, range, allowlist).
- Encode output per sink (HTML, SQL, shell, LDAP, JSON). Never concatenate untrusted data into queries.
- Use parameterized queries / prepared statements. No string-built SQL.

## AuthN / AuthZ
- Check authorization at every entry point, not only at the gateway.
- Prefer platform identity (managed identity, OIDC) over static secrets.
- Session tokens must be `HttpOnly`, `Secure`, `SameSite=Lax` or stricter.

## Secrets & Cryptography
- No secrets in source, logs, or error messages. Use a vault.
- Use vetted libraries (libsodium, WebCrypto, `cryptography`). Do not roll your own crypto.
- Hash passwords with Argon2id or bcrypt (cost ≥ 12). Never MD5/SHA1 for passwords.

## Dependencies
- Pin direct dependencies. Review transitive CVEs before upgrades.
- Prefer maintained libraries with signed releases.

## Errors & Logging
- Never log secrets, tokens, PII, or full request bodies.
- Fail closed: on error, deny access rather than granting it.

## OWASP Top 10 Reminders
- A01 Broken Access Control · A02 Cryptographic Failures · A03 Injection · A04 Insecure Design · A05 Security Misconfiguration · A06 Vulnerable Components · A07 Identification & AuthN Failures · A08 Software & Data Integrity · A09 Logging & Monitoring Failures · A10 SSRF
