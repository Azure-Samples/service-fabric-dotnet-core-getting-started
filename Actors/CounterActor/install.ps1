$invocation = (Get-Variable MyInvocation).Value
$rootpath = Split-Path $invocation.MyCommand.Path

$AppPath = "$rootpath\CounterActorApplicationCSharp"
$sdkInstallPath = (Get-ItemProperty 'HKLM:\Software\Microsoft\Service Fabric SDK').FabricSDKInstallPath
$sfSdkPsModulePath = $sdkInstallPath + "Tools\PSModule\ServiceFabricSDK"
Import-Module $sfSdkPsModulePath\ServiceFabricSDK.psm1

$WebServiceManifestlocation = $AppPath + "\CounterActorWebServicePkg\"
$WebServiceManifestlocationLinux = $WebServiceManifestlocation + "ServiceManifest-Linux.xml"
$WebServiceManifestlocationWindows = $WebServiceManifestlocation + "ServiceManifest-Windows.xml"
$WebServiceManifestlocationFinal= $WebServiceManifestlocation + "ServiceManifest.xml"
Copy-Item -Path $WebServiceManifestlocationWindows -Destination $WebServiceManifestlocationFinal -Force

$ActorServiceManifestlocation = $AppPath + "\CounterActorPkg\"
$ActorServiceManifestlocationLinux = $ActorServiceManifestlocation + "\ServiceManifest-Linux.xml"
$ActorServiceManifestlocationWindows = $ActorServiceManifestlocation + "\ServiceManifest-Windows.xml"
$ActorServiceManifestlocationFinal= $ActorServiceManifestlocation + "ServiceManifest.xml"
Copy-Item -Path $ActorServiceManifestlocationWindows -Destination $ActorServiceManifestlocationFinal -Force

Copy-ServiceFabricApplicationPackage -ApplicationPackagePath $AppPath -ApplicationPackagePathInImageStore CounterActorApplicationTypeCSharp -ImageStoreConnectionString (Get-ImageStoreConnectionStringFromClusterManifest(Get-ServiceFabricClusterManifest)) -TimeoutSec 1800
Register-ServiceFabricApplicationType CounterActorApplicationTypeCSharp
New-ServiceFabricApplication fabric:/CounterActorApplicationCSharp CounterActorApplicationTypeCSharp 1.0.0