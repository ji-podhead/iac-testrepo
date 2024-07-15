# Pod-Shop
 ***App-Configuration***

## 15.7.24

at the moment i use vault for key/val secrets. the thing with secrets is that you cant read/get gh actions secrets and i need at least one secret to access vault, to read all the other secrets. 
<br>
     ***the vault approle token secret either needs to be stored in `credentials.auto.tfvar`, or as gh-actions secret***

i want to keep my project as flexibel as possible so i decided to keep my terraform project structure and run it in gh actions, but dont put all the code in the workflow file

- this is somehow problematic because the project needs to be aware of how its deployed(manually, or via gh actions).
- therefore we need to check if the credentiuals.auto.tfvars file is existing, or if we need to get the vault secret via gitub 
- but terraform allows us to pass values via constructor like this:
```bash
$ terraform apply -var='vault_key=mein_sicherer_vault_key' -var='db_password=sicheres_passwort'
```
so we dont need to check if the credentifals file is existing.

***Do i need a vault gh actions workflow?***

no!<br>
we deploy via tailscale, so we dont. this is kinda tricky, but as i mentioned before: 
*I want to keep my project as flexible as possible*


 ---
