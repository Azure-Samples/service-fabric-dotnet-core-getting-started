$AppPath = "$PSScriptRoot\CounterActorApplication"
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

Copy-ServiceFabricApplicationPackage -ApplicationPackagePath $AppPath -ApplicationPackagePathInImageStore CounterActorApplicationType -ImageStoreConnectionString (Get-ImageStoreConnectionStringFromClusterManifest(Get-ServiceFabricClusterManifest)) -TimeoutSec 1800
Register-ServiceFabricApplicationType CounterActorApplicationType
New-ServiceFabricApplication fabric:/CounterActorApplication CounterActorApplicationType 1.0.0