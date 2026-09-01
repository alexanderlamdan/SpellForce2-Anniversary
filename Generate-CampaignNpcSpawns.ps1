Write-Host "=== Генератор NPC-обёрток для кампании ===" -ForegroundColor Cyan
Write-Host ""

$OutputDir = ".\generated"

if (-not (Test-Path $OutputDir)) {
	New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

$TemplateFile = Read-Host "Имя шаблон-файла (dofile), например HomeCrew.lua"
if ([string]::IsNullOrWhiteSpace($TemplateFile)) {
	Write-Host "Имя шаблона обязательно, выход." -ForegroundColor Yellow
	exit
}

$FilePrefix = Read-Host "Префикс имени файлов (например testnpc_, testnpc-, testnpc)"
if ([string]::IsNullOrWhiteSpace($FilePrefix)) {
	$FilePrefix = [System.IO.Path]::GetFileNameWithoutExtension($TemplateFile).ToLower()
}

$countInput = Read-Host "Сколько NPC нужно сгенерировать"
[int]$count = 0
if (-not [int]::TryParse($countInput, [ref]$count) -or $count -le 0) {
	Write-Host "Нужно указать целое число больше нуля, выход." -ForegroundColor Yellow
	exit
}

Write-Host ""
Write-Host "Шаблон (dofile): $TemplateFile"
Write-Host "Папка вывода:    $OutputDir"
Write-Host "Префикс файлов:  $FilePrefix"
Write-Host "Количество:      $count"
Write-Host ""
$templatePath = Join-Path $OutputDir $TemplateFile

if (-not (Test-Path $templatePath)) {

	$templateContent = @'
State
{
	StateName = "INIT",
	OnFigureRespawnEvent
	{
		WaitTime = ,
		X = ,
		Y = ,
		Conditions =
		{

		},
		Actions =
		{

		},

	}
}
'@

	Set-Content -Path $templatePath -Value $templateContent -Encoding ASCII

	Write-Host "Файл-шаблон создан: $TemplateFile (заполни X/Y/Conditions/Actions вручную)" -ForegroundColor Green
} else {
	Write-Host "Файл-шаблон $TemplateFile уже существует в $OutputDir - не трогаю." -ForegroundColor DarkGray
}

Write-Host ""
$summary = @()

for ($i = 1; $i -le $count; $i++) {

	$fileName = "${FilePrefix}$i.lua"
	$filePath = Join-Path $OutputDir $fileName

	$content = @"
dofile(GetScriptPath().."$TemplateFile")
"@

	Set-Content -Path $filePath -Value $content -Encoding ASCII

	$summary += [PSCustomObject]@{ File = $fileName }
}

Write-Host "=== Готово. Сгенерировано файлов: $($summary.Count) ===" -ForegroundColor Cyan
$summary | Format-Table -AutoSize

Write-Host ""
Write-Host "Не забудь подключить каждый файл через dofile в мастер-скрипте карты," -ForegroundColor Yellow
Write-Host "и расставить сами фигуры в редакторе карт по этим точкам." -ForegroundColor Yellow
