function EvaluateGroupLicenses
{
    out-logfile -string "Entering EvaluateGroupLicenses"

    out-logfile -string "Evaluating the skus in the tenant against the group provided."

    if ($global:graphGroupLicenses.assignedLicenses.count -gt 0)
    {
        out-logfile -string "The group specified has licenses - being the evaluation."

        foreach ($skuObject in $global:skuTracking)
        {
            out-logfile -string "Checking to see if the group has the SKU id..."

            if ($global:graphGroupLicenses.AssignedLicenses.SkuID.contains($skuObject.skuID))
            {
                out-logfile -string "The group licenses the sku id - check disabled plans..."

                $workingLicense = $global:graphGroupLicenses.assignedLicenses | where {$_.skuID -eq $skuObject.skuID}

                out-logfile -string ("Evaluating the following sku ID on the group: "+$workingLicense.skuID)

                if ($workingLicense.disabledPlans.contains($skuObject.ServicePlanID))
                {
                    out-logfile -string "The plan is disabled - no work."
                }
                else
                {
                    out-logfile -string "The sku is not disabled - set the SKU to enabled."
                    $skuObject.EnabledOnGroup = $TRUE
                }
            }
        }
    }

    out-xmlFile -itemToExport $global:skuTracking -itemNameToExport ("SkuTrackingGroupEvaluation-"+(Get-Date -Format FileDateTime))

    out-logfile -string "Existing Evaluate Group Licenses"
}