$AppPath = "C:\Users\rapatchi\Desktop\CounterActorApplication"

$WebServiceManifestlocation = $AppPath + "\CounterActorWebServicePkg\"
$WebServiceManifestlocationLinux = $WebServiceManifestlocation + "ServiceManifest-Linux.xml"
$WebServiceManifestlocationWindows = $WebServiceManifestlocation + "ServiceManifest-Windows.xml"
Remove-Item $WebServiceManifestlocationLinux
Rename-Item $WebServiceManifestlocationWindows ServiceManifest.xml 


$ActorServiceManifestlocation = $AppPath + "\CounterActorPkg\"
$ActorServiceManifestlocationLinux = $ActorServiceManifestlocation + "\ServiceManifest-Linux.xml"
$ActorServiceManifestlocationWindows = $ActorServiceManifestlocation + "\ServiceManifest-Windows.xml"
Remove-Item $ActorServiceManifestlocationLinux
Rename-Item $ActorServiceManifestlocationWindows ServiceManifest.xml 

Copy-ServiceFabricApplicationPackage -ApplicationPackagePath $AppPath -ApplicationPackagePathInImageStore CounterActorApplicationType -ImageStoreConnectionString (Get-ImageStoreConnectionStringFromClusterManifest(Get-ServiceFabricClusterManifest)) -TimeoutSec 1800
Register-ServiceFabricApplicationType CounterActorApplicationType
New-ServiceFabricApplication fabric:/CounterActorApplication CounterActorApplicationType 1.0.0