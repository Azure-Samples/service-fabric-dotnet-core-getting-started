$AppPath = "C:\Users\rapatchi\Desktop\VisualObjectsApplication"

$WebServiceManifestlocation = $AppPath + "\VisualObjects.WebServicePkg\"
$WebServiceManifestlocationLinux = $WebServiceManifestlocation + "ServiceManifest-Linux.xml"
$WebServiceManifestlocationWindows = $WebServiceManifestlocation + "ServiceManifest-Windows.xml"
$WebServiceManifestlocationFinal= $WebServiceManifestlocation + "ServiceManifest.xml"
Copy-Item -Path $WebServiceManifestlocationWindows -Destination $WebServiceManifestlocationFinal -Force


$ActorServiceManifestlocation = $AppPath + "\VisualObjects.ActorServicePkg\"
$ActorServiceManifestlocationLinux = $ActorServiceManifestlocation + "ServiceManifest-Linux.xml"
$ActorServiceManifestlocationWindows = $ActorServiceManifestlocation + "ServiceManifest-Windows.xml"
$ActorServiceManifestlocationFinal= $ActorServiceManifestlocation + "ServiceManifest.xml"
Copy-Item -Path $ActorServiceManifestlocationWindows -Destination $ActorServiceManifestlocationFinal -Force



Copy-ServiceFabricApplicationPackage -ApplicationPackagePath $AppPath -ApplicationPackagePathInImageStore VisualObjectsApplicationType -ImageStoreConnectionString (Get-ImageStoreConnectionStringFromClusterManifest(Get-ServiceFabricClusterManifest)) -TimeoutSec 1800
Register-ServiceFabricApplicationType VisualObjectsApplicationType
New-ServiceFabricApplication fabric:/VisualObjectsApplication VisualObjectsApplicationType 1.0.0