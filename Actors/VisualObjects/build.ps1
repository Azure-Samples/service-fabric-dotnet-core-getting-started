$invocation = (Get-Variable MyInvocation).Value
$rootpath = Split-Path $invocation.MyCommand.Path

rm -Recurse VisualObjectsApplicationCSharp
mkdir VisualObjectsApplicationCSharp

pushd $rootpath\src\VisualObjects.Common\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build
popd

pushd $rootpath\src\VisualObjects.ActorService\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -c Release --self-contained --runtime win-x64 -o ..\..\VisualObjectsApplicationCSharp\VisualObjects.ActorServicePkg\Code
popd

pushd $rootpath\src\VisualObjects.WebService\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build
dotnet publish -c Release --self-contained --runtime win-x64 -o ..\..\VisualObjectsApplicationCSharp\VisualObjects.WebServicePkg\Code
popd

cp $rootpath\ApplicationManifest.xml $rootpath\VisualObjectsApplicationCSharp\.
cp $rootpath\src\VisualObjects.ActorService\PackageRoot\ServiceManifest-Linux.xml $rootpath\VisualObjectsApplicationCSharp\VisualObjects.ActorServicePkg\. 
cp $rootpath\src\VisualObjects.ActorService\PackageRoot\ServiceManifest-Windows.xml $rootpath\VisualObjectsApplicationCSharp\VisualObjects.ActorServicePkg\. 
cp $rootpath\src\VisualObjects.WebService\PackageRoot\ServiceManifest-Linux.xml $rootpath\VisualObjectsApplicationCSharp\VisualObjects.WebServicePkg\.
cp $rootpath\src\VisualObjects.WebService\PackageRoot\ServiceManifest-Windows.xml $rootpath\VisualObjectsApplicationCSharp\VisualObjects.WebServicePkg\.
cp -r -Force $rootpath\src\VisualObjects.WebService\wwwroot $rootpath\VisualObjectsApplicationCSharp\VisualObjects.WebServicePkg\Code\.
cp $rootpath\src\VisualObjects.WebService\entryPoint.sh $rootpath\VisualObjectsApplicationCSharp\VisualObjects.WebServicePkg\Code\.
cp $rootpath\src\VisualObjects.ActorService\entryPoint.sh $rootpath\VisualObjectsApplicationCSharp\VisualObjects.ActorServicePkg\Code\.
cp $rootpath\src\VisualObjects.WebService\entryPoint.cmd $rootpath\VisualObjectsApplicationCSharp\VisualObjects.WebServicePkg\Code\.
cp $rootpath\src\VisualObjects.ActorService\entryPoint.cmd $rootpath\VisualObjectsApplicationCSharp\VisualObjects.ActorServicePkg\Code\.
cp -r -Force $rootpath\src\VisualObjects.WebService\PackageRoot\Config $rootpath\VisualObjectsApplicationCSharp\VisualObjects.WebServicePkg\.
cp -r -Force $rootpath\src\VisualObjects.ActorService\PackageRoot\Config $rootpath\VisualObjectsApplicationCSharp\VisualObjects.ActorServicePkg\.
