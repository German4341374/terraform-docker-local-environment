# State safety

State includes resource IDs, dependency data, and configuration attributes. `sensitive = true`
redacts selected CLI output but does not remove or encrypt the underlying value. Protect state like
a credential, back it up before state surgery, and prefer `terraform state` and `import` commands
over manual JSON editing. See the recovery runbook.
