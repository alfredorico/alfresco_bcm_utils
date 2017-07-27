# AlfrescoBcmUtils

**alfresco_bmc_utils**  is a gem that connect to Alfresco Repository, to query documents that match criteria defined on "Alfresco Custom Models" and run background job to notify via email if a document is about to get due. This gem development was part of an Alfresco Implementation Project to which I belonged to.


## Installation

Add this line to your application's Gemfile:

```ruby
gem install --local alfresco_bcm_utils-0.1.0.gem
```
And then execute at command line:

notificador_alfresco: Command to list and notify by email documents that are past due

    --prueba-correo              Verify that the sending engine works by sending an email
    --docs-vigentes              List the documents in force as of this date
    --docs-sin-vigencia          List documents that do not have the number of valid months in the metadata
    --docs-por-vencerse          List the documents you have left 21 days or less to expire
    --docs-vencidos              List documents that are past due on this date
    --docs-todos                 List all documents with metadatabod today
    --nd                         Notify by e-mail of documents due or due to expire on this date
    --lc CONFIGURACION           List the values of alfresco or mail parameters. Ex: --lc alfresco / --lc email
    --ac CONFIGURACION           Set which configuration parameter is to be set. Ex: --ac alfresco / --ac
-p PARAM                         Indicate the parameter to update
-v VALUE                         Indicate the value of the field to be updated
