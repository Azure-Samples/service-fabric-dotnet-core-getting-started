$AppPath = "C:\Users\rapatchi\Desktop\CalculatorActorApplication"

$ActorServiceManifestlocation = $AppPath + "\CalculatorActorPkg\"
$ActorServiceManifestlocationLinux = $ActorServiceManifestlocation + "ServiceManifest-Linux.xml"
$ActorServiceManifestlocationWindows = $ActorServiceManifestlocation + "ServiceManifest-Windows.xml"
$ActorServiceManifestlocationFinal= $ActorServiceManifestlocation + "ServiceManifest.xml"
Copy-Item -Path $ActorServiceManifestlocationWindows -Destination $ActorServiceManifestlocationFinal -Force

Copy-ServiceFabricApplicationPackage -ApplicationPackagePath $AppPath -ApplicationPackagePathInImageStore CalculatorActorApplication -ImageStoreConnectionString (Get-ImageStoreConnectionStringFromClusterManifest(Get-ServiceFabricClusterManifest)) -TimeoutSec 1800
Register-ServiceFabricApplicationType CalculatorActorApplicatione
New-ServiceFabricApplication fabric:/CalculatorActorApplication CalculatorActorApplicationType 1.0.0