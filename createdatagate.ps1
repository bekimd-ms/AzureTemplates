$resourceGroup = "datagate"
$vnetname = $resourceGroup + "-vnet"
$dataFactory = "onedwtest"
$gateway = "AzSDataGate" 
$gatewayKey = "DMG@7ea7c5ab-4b36-4594-a909-7d66cb136525@c5cb45be-e644-40d5-9618-9a0fb7c7f4b0@eu@Fic820pJ8KL0EuSLYZjiOyQY0gJsMqyOGZAjbsNuYkw="

New-AzureRMResourceGroup -Name $resourceGroup -Location local

$vnet = New-AzureRmVirtualNetwork -Name $vnetname -ResourceGroupName $resourceGroup -Location local -AddressPrefix "10.0.0.0/24" -Verbose
Add-AzureRmVirtualNetworkSubnetConfig -Name default -VirtualNetwork $vnet -AddressPrefix 10.0.0.0/24
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet

New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroup -Name dg01 `
                                   -TemplateFile .\adfgatewayvm.json `
                                   -TemplateParameterFile .\adfgatewayvm.params.json `
                                   -ExistingDataFactoryName $dataFactory `
                                   -GatewayName $gateway `
                                   -GatewayKey  $gatewayKey `
                                   -ExistingVirtualNetworkName $vnetname `
                                   -ExistingVnetResourceGroupName $resourceGroup `
                                   -Verbose



