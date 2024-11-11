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
        if ($global:skuHash[$sku.skuPartNumber])
        {
            $skuCommonName = $global:skuHash[$sku.skuPartNumber].'???Product_Display_Name'
        }
        else 
        {
            $skuCommonName = $sku.SkuPartNumber    
        }

        out-logfile -string ("Evaluating Sku: "+$sku.skuPartNumber)

        foreach ($servicePlan in $sku.ServicePlans)
        {
            out-logfile -string ("Evaluating Service Plan: "+$servicePlan.ServicePlanName)

            if ($global:servicePlanHash[$servicePlan.servicePlanName])
            {
                $servicePlanCommonName = $global:servicePlanHash[$servicePlan.servicePlanName].Service_Plans_Included_Friendly_Names
            }
            else 
            {
                $servicePlanCommonName = $servicePlan.servicePlanName
            }

            if ($servicePlan.AppliesTo -eq "User")
            {
                out-logfile -string "Service plan is per user - creating object."

                $functionObject = New-Object PSObject -Property @{
                    SkuID = $sku.SkuId
                    SkuPartNumber = $sku.SkuPartNumber
                    SkuCommonName = $skuCommonName
                    SkuPartNumber_ServicePlanName = $sku.SkuPartNumber+"_"+$servicePlan.ServicePlanName
                    ServicePlanID = $servicePlan.ServicePlanId
                    ServicePlanName = $servicePlan.ServicePlanName
                    ServicePlanCommonName = $servicePlanCommonName
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