[![checkov](https://github.com/ji-podhead/Pod-Shop-App-Configs/actions/workflows/checkov.yml/badge.svg)](https://github.com/ji-podhead/Pod-Shop-App-Configs/actions/workflows/checkov.yml)

# Pod-Shop
 ***App-Configuration***

### CI-CD Pipeline
```mermaid
graph TD;
    p1[pull Request and review]
    pub1[publish test results]
    pub2[publish test results]
    cronjob

    subgraph local_infra
    Proxmox
    Vault

  subgraph Jenkins
      c1[CodeQuality And Linting]
        t1[testing plans]
	d1[Deployment]
    end
end     

    subgraph GitHub 
        Main 
        Development 
    end

Development --> c1
c1-->pub1
pub1-->p1
p1-->Development

Main -->cronjob
cronjob-->t1
t1-->pub2
pub2-->Main
Development -."merge".->Main
d1-->Proxmox
Main-->d1
```

## 16.7.
created automatic iac checks, pull request rules for status check approve and test result publishing integration

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

***Do I need jenkins?***
im not really sure, but we can actually do our iac deployment without jenkins, but testing plans can profit from jenkins.
- *it actually doesnt matter because you can migrate from jenkins to git.*

 ---
