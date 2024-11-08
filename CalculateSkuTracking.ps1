function CalculateSkuTracking
{
    param
    (
        [Parameter(Mandatory = $true)]
        $skus
    )

    $global:skuTracking = @()

    out-logfile -string "Entering CalculateSkuTracking"

    foreach ($sku in $skus)
    {
        out-logfile -string ("Evaluating Sku: "+$sku.skuPartNumber)

        foreach ($servicePlan in $sku.ServicePlans)
        {
            out-logfile -string ("Evaluating Service Plan: "+$servicePlan.ServicePlanName)

            if ($servicePlan.AppliesTo -eq "User")
            {
                out-logfile -string "Service plan is per user - creating object."

                $functionObject = New-Object PSObject -Property @{
                    SkuID = $sku.SkuId
                    SkuPartNumber = $sku.SkuPartNumber
                    SkuPartNumber_ServicePlanName = $sku.SkuPartNumber+"_"+$servicePlan.ServicePlanName
                    ServicePlanID = $servicePlan.ServicePlanId
                    ServicePlanName = $servicePlan.ServicePlanName
                    EnabledOnGroup = $false
                    EnabledNew = $false
                }

                $global:skuTracking += $functionObject
            }
        }
    }           

    out-xmlFile -itemToExport $global:skuTracking -itemNameToExport ("SkuTracking-"+(Get-Date -Format FileDateTime))

    out-logfile -string "Exiting CalculateSkuTracking"
}