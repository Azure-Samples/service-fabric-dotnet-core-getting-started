rm -Recurse VisualObjectsApplicationCSharp
mkdir VisualObjectsApplicationCSharp

pushd src\VisualObjects.Common\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build
popd

pushd src\VisualObjects.ActorService\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build 
dotnet publish -c Release --self-contained --runtime win-x64 -o ..\..\VisualObjectsApplicationCSharp\VisualObjects.ActorServicePkg\Code
popd

pushd src\VisualObjects.WebService\
dotnet restore -s https://api.nuget.org/v3/index.json 
dotnet build
dotnet publish -c Release --self-contained --runtime win-x64 -o ..\..\VisualObjectsApplicationCSharp\VisualObjects.WebServicePkg\Code
popd

cp ApplicationManifest.xml VisualObjectsApplicationCSharp\.
cp src\VisualObjects.ActorService\PackageRoot\ServiceManifest-Linux.xml VisualObjectsApplicationCSharp\VisualObjects.ActorServicePkg\. 
cp src\VisualObjects.ActorService\PackageRoot\ServiceManifest-Windows.xml VisualObjectsApplicationCSharp\VisualObjects.ActorServicePkg\. 
cp src\VisualObjects.WebService\PackageRoot\ServiceManifest-Linux.xml VisualObjectsApplicationCSharp\VisualObjects.WebServicePkg\.
cp src\VisualObjects.WebService\PackageRoot\ServiceManifest-Windows.xml VisualObjectsApplicationCSharp\VisualObjects.WebServicePkg\.
cp -r -Force src\VisualObjects.WebService\wwwroot VisualObjectsApplicationCSharp\VisualObjects.WebServicePkg\Code\.
cp src\VisualObjects.WebService\entryPoint.sh VisualObjectsApplicationCSharp\VisualObjects.WebServicePkg\Code\.
cp src\VisualObjects.ActorService\entryPoint.sh VisualObjectsApplicationCSharp\VisualObjects.ActorServicePkg\Code\.
cp src\VisualObjects.WebService\entryPoint.cmd VisualObjectsApplicationCSharp\VisualObjects.WebServicePkg\Code\.
cp src\VisualObjects.ActorService\entryPoint.cmd VisualObjectsApplicationCSharp\VisualObjects.ActorServicePkg\Code\.
cp -r src\VisualObjects.WebService\PackageRoot\Config VisualObjectsApplicationCSharp\VisualObjects.WebServicePkg\.
cp -r src\VisualObjects.ActorService\PackageRoot\Config VisualObjectsApplicationCSharp\VisualObjects.ActorServicePkg\.
