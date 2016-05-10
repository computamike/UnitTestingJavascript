try{
cls
cd ..
echo "TESTING"
echo "======="
#Get-ChildItem Env:
    $a = @("bamboo_working_directory","bamboo_repository_revision_number","bamboo_buildNumber")

    for ($i=0; $i -lt $a.length; $i++) 
    {
        $env= ($a[$i]) 
        if (!(get-item env:$env)  )
        {
            throw [System.ArgumentNullException] "$env not found."
        }
    }
    # Calculate paths.
    $ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
    $scriptPath = (get-item $ScriptDir ).parent.FullName
    $testResultsPath = ${scriptPath} +  "\TestResults"
    $testAdapterPath = ${env:bamboo_working_directory} + "\packages"
    $javascriptTest = ${env:bamboo_working_directory} + "\UnitTestLibrary\Javascript.test.js"
    $nunitTest = ${env:bamboo_working_directory} + "\UnitTestLibrary\bin\Debug\UnitTestsLibrary.test.dll"
    $vsTest = (Split-Path -Path ${env:VS120COMNTOOLS} -Parent) + "\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe"
    $msbuild = "C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe"

    cd $env:bamboo_working_directory

    echo "Configuration  : "
    echo ("Current Directory         " + $ScriptDir)
    echo ("Current Directory         " + $scriptPath)
    echo ("Test Results Directory    " + $testResultsPath)
    echo ("testAdapterPath           " + $testAdapterPath)
    echo ("javascriptTest            " + $javascriptTest)
    echo ("nunitTest                 " + $nunitTest)
    echo ("vsTest                    " + $vsTest)

    echo " "
    echo "-- Clear out old TRX files"
    Get-ChildItem -Path $testResultsPath -Include *.* -File -Recurse | foreach { $_.Delete()}


    & $vsTest /logger:trx /TestAdapterpath:"$testAdapterPath" /ListExecutors /UseVsixExtensions:true 
    & $vsTest /logger:trx /TestAdapterpath:"$testAdapterPath" "$javascriptTest" "$nunitTest"

    echo "-- Find Newest Results"
    $latest = ${testResultsPath} + "\"+(Get-ChildItem -Path $testResultsPath | Sort-Object LastAccessTime -Descending | Select-Object -First 1)
    $newName = ${testResultsPath} + "\TestResults-Rev_${env:bamboo_repository_revision_number}-Build_${env:bamboo_buildNumber}.trx"

    echo $latest
    echo $newName

    Rename-Item $latest $newName


    echo "-- END OF TESTS --"
  
} 
catch {
  echo "===="
  echo $_.Exception|format-list -force
  echo "===="
}
