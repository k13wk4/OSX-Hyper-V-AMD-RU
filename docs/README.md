<h1 align="center">OSX-Hyper-V</h1>
<p align="center">
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/graphic.png"
 alt="Graphic of Hyper-V Window"
 class="center"
 width=500px
 ><br>
 Проект <b>Hackintosh</b>, реализующий пакет <a href="https://github.com/acidanthera/MacHyperVSupport">MacHyperVSupport</a> для <b>Windows Hyper-V</b>, построенный поверх загрузчика <a href="https://github.com/acidanthera/OpenCorePkg">OpenCore</a> и менеджера сборки <a href="https://github.com/Qonfused/OCE-Build">OCE-Build</a>.
</p>

<div align="center">

 <a href="/LICENSE">![License](https://img.shields.io/badge/⚖_License-BSD_3_Clause-lightblue?labelColor=3f4551)</a>
 <a href="/docs/CHANGELOG.md">![SemVer](https://img.shields.io/github/v/release/k13wk4/OSX-Hyper-V-AMD-RU?label=SemVer&logo=SemVer&labelColor=3f4551)</a>
 <a href="">![macOS Versions](https://img.shields.io/badge/macOS%20Versions-10.4%20to%2026-important?labelColor=3f4551)</a>
 <a href="https://github.com/acidanthera/OpenCorePkg/releases">![OpenCore](https://img.shields.io/badge/OpenCore-1.0.5-0c7dbe?logo=Osano&logoColor=0298e1&labelColor=3f4451)</a>
 <a href="https://github.com/k13wk4/OSX-Hyper-V-AMD-RU/actions/workflows/oce-build.yml">![OCE Build](https://github.com/k13wk4/OSX-Hyper-V-AMD-RU/actions/workflows/oce-build.yml/badge.svg?branch=main)</a>

</div>

## ⚡Быстрые ссылки

- [Текущий прогресс](#текущий-прогресс)
- [Поддержка версий macOS](#поддержка-версий-macos)
- [Как начать](#как-начать)
 - [1. Клонирование репозитория через Git](#1-клонирование-репозитория-через-git)
 - [2. Настроить OpenCore для вашего железа](#2-настроить-opencore-для-вашего-железа)
 - [Intel](#intel)
 - [AMD](#amd)
 - [3. Сборка репозитория с помощью OCE-Build](#3-сборка-репозитория-с-помощью-oce-build)
 - [4. Настройка Hyper-V](#4-настройка-hyper-v)
 - [5. Использование этого EFI с macOS](#5-использование-этого-efi-с-macos)
 - [6. Устранение неполадок](#6-устранение-неполадок)
- [Как внести вклад](#как-внести-вклад)
- [Лицензия](#лицензия)
- [Благодарности](#благодарности)

## ⚙️ Текущий прогресс

Смотрите [CHANGELOG](/docs/CHANGELOG.md) или доску SemVer для изменений, реализованных в каждой версии.

### Поддержка версий macOS:

> [!NOTE]
> Установки OS X Tiger (10.4) до Snow Leopard (10.6) напрямую невозможны. Рекомендуется сначала установить более новую версию macOS и затем восстановиться до желаемой версии с использованием [образа диска, предоставленного Acidanthera](https://dortania.github.io/OpenCore-Install-Guide/installer-guide/mac-install-dmg.html).
>
> Также можно найти архивы InstallAssistant.dmg на [Archive.org](https://archive.org/details/@khronokernel).

Поддерживаемые версии перечислены ниже — от **10.4** до **26.0**.

<table>
 <thead>
 <tr>
 <th>Версия macOS</th>
 <th colspan=2>Статус</th>
 <th>Минимальная версия</th>
 <th>Максимальная версия</th>
 </tr>
 </thead>
 <tbody>
 <!-- macOS26 -->
 <tr>
 <td>
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/macOS-roundrels/_placeholder.png"
 width=25
 hspace=2
 align="top"
 />
 Tahoe
 </td>
 <td style="text-align: center;">🚧</td>
 <td>В работе.</td>
 <td><code>(Нет)</code></td>
 <td><a href="https://www.apple.com/macos/macos-tahoe-preview/"><code>(Последняя)</code></a></td>
 </tr>
 <!-- macOS15 -->
 <tr>
 <td>
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/macOS-roundrels/sequoia.png"
 width=25
 hspace=2
 align="top"
 />
 Sequoia
 </td>
 <td style="text-align: center;">✅</td>
 <td>Поддерживается.</td>
 <td><code>(Нет)</code></td>
 <td><a href="https://www.apple.com/macos/macos-sequoia/"><code>(Последняя)</code></a></td>
 </tr>
 <!-- macOS14 -->
 <tr>
 <td>
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/macOS-roundrels/sonoma.png"
 width=25
 hspace=2
 align="top"
 />
 Sonoma
 </td>
 <td style="text-align: center;">✅</td>
 <td>Поддерживается.</td>
 <td><code>(Нет)</code></td>
 <td><a href="https://apps.apple.com/us/app/macos-sonoma/id6450717509"><code>(Последняя)</code></a></td>
 </tr>
 <!-- macOS13 -->
 <tr>
 <td>
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/macOS-roundrels/ventura.png"
 width=25
 hspace=2
 align="top"
 />
 Ventura
 </td>
 <td style="text-align: center;">✅</td>
 <td>Поддерживается.</td>
 <td><code>(Нет)</code></td>
 <td><a href="https://apps.apple.com/us/app/macos-ventura/id1638787999"><code>(Последняя)</code></a></td>
 </tr>
 <!-- macOS12 -->
 <tr>
 <td>
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/macOS-roundrels/monterey.png"
 width=22
 hspace=2
 align="top"
 />
 Monterey
 </td>
 <td style="text-align: center;">✅</td>
 <td>Поддерживается.</td>
 <td><code>(Нет)</code></td>
 <td><a href="https://apps.apple.com/us/app/macos-monterey/id1576738294"><code>(Последняя)</code></a></td>
 </tr>
 <!-- macOS11 -->
 <tr>
 <td>
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/macOS-roundrels/big-sur.png"
 width=25
 hspace=2
 align="top"
 />
 Big Sur
 </td>
 <td style="text-align: center;">✅</td>
 <td>Поддерживается.</td>
 <td><code>(Нет)</code></td>
 <td><a href="https://apps.apple.com/us/app/macos-big-sur/id1526878132"><code>(Последняя)</code></a></td>
 </tr>
 <!-- macOS10.15 -->
 <tr>
 <td>
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/macOS-roundrels/catalina.png"
 width=25
 hspace=2
 align="top"
 />
 Catalina
 </td>
 <td style="text-align: center;">✅</td>
 <td>Поддерживается.</td>
 <td><code>(Нет)</code></td>
 <td><a href="https://apps.apple.com/us/app/macos-catalina/id1466841314"><code>(Последняя)</code></a></td>
 </tr>
 <!-- macOS10.14 -->
 <tr>
 <td>
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/macOS-roundrels/mojave.png"
 width=25
 hspace=2
 align="top"
 />
 Mojave
 </td>
 <td style="text-align: center;">✅</td>
 <td>Поддерживается.</td>
 <td><code>(Нет)</code></td>
 <td><a href="https://apps.apple.com/us/app/macos-mojave/id1398502828"><code>(Последняя)</code></a></td>
 </tr>
 <!-- macOS10.13 -->
 <tr>
 <td>
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/macOS-roundrels/high-sierra.png"
 width=25
 hspace=2
 align="top"
 />
 High Sierra
 </td>
 <td style="text-align: center;">✅</td>
 <td>Поддерживается.</td>
 <td><code>(Нет)</code></td>
 <td><a href="https://apps.apple.com/us/app/macos-high-sierra/id1246284741"><code>(Последняя)</code></a></td>
 </tr>
 <!-- macOS10.12 -->
 <tr>
 <td>
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/macOS-roundrels/sierra.png"
 width=25
 hspace=2
 align="top"
 />
 Sierra
 </td>
 <td style="text-align: center;">✅</td>
 <td>Поддерживается.</td>
 <td><code>(Нет)</code></td>
 <td><a href="http://updates-http.cdn-apple.com/2019/cert/061-39476-20191023-48f365f4-0015-4c41-9f44-39d3d2aca067/InstallOS.dmg"><code>(Последняя)</code></a></td>
 </tr>
 <!-- macOS10.11 -->
 <tr>
 <td>
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/macOS-roundrels/el-capitan.png"
 width=25
 hspace=2
 align="top"
 />
 El Capitan
 </td>
 <td style="text-align: center;">✅</td>
 <td>Поддерживается.</td>
 <td><code>(Нет)</code></td>
 <td><a href="http://updates-http.cdn-apple.com/2019/cert/061-41424-20191024-218af9ec-cf50-4516-9011-228c78eda3d2/InstallMacOSX.dmg"><code>(Последняя)</code></a></td>
 </tr>
 <!-- macOS10.10 -->
 <tr>
 <td>
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/macOS-roundrels/yosemite.png"
 width=25
 hspace=2
 align="top"
 />
 Yosemite
 </td>
 <td style="text-align: center;">✅</td>
 <td>Поддерживается.</td>
 <td><code>(Нет)</code></td>
 <td><a href="http://updates-http.cdn-apple.com/2019/cert/061-41343-20191023-02465f92-3ab5-4c92-bfe2-b725447a070d/InstallMacOSX.dmg"><code>(Последняя)</code></a></td>
 </tr>
 <!-- macOS10.9 -->
 <tr>
 <td>
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/macOS-roundrels/mavericks.png"
 width=25
 hspace=2
 align="top"
 />
 Mavericks
 </td>
 <td style="text-align: center;">✅</td>
 <td>Поддерживается.</td>
 <td><code>(Нет)</code></td>
 <td><a href="https://archive.org/details/os-x-mavericks-10.9.5"><code>(Последняя)</code></a></td>
 </tr>
 <!-- macOS10.8 -->
 <tr>
 <td>
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/macOS-roundrels/mountain-lion.png"
 width=25
 hspace=2
 align="top"
 />
 Mountain Lion
 </td>
 <td style="text-align: center;">✅</td>
 <td>Поддерживается.</td>
 <td><code>(Нет)</code></td>
 <td><a href="https://updates.cdn-apple.com/2021/macos/031-0627-20210614-90D11F33-1A65-42DD-BBEA-E1D9F43A6B3F/InstallMacOSX.dmg"><code>(Последняя)</code></a></td>
 </tr>
 <!-- macOS10.7 -->
 <tr>
 <td>
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/macOS-roundrels/lion.png"
 width=25
 hspace=2
 align="top"
 />
 Lion
 </td>
 <td style="text-align: center;">✅</td>
 <td>Поддерживается.</td>
 <td><code>(Нет)</code></td>
 <td><a href="https://updates.cdn-apple.com/2021/macos/041-7683-20210614-E610947E-C7CE-46EB-8860-D26D71F0D3EA/InstallMacOSX.dmg"><code>(Последняя)</code></a></td>
 </tr>
 <!-- macOS10.6 -->
 <tr>
 <td>
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/macOS-roundrels/snow-leopard.png"
 width=25
 hspace=2
 align="top"
 />
 Snow Leopard
 </td>
 <td style="text-align: center;">🚧</td>
 <td>Поддерживается.</td>
 <td><code>(Нет)</code></td>
 <td><code>(Retail)</code></td>
 </tr>
 <!-- macOS10.5 -->
 <tr>
 <td>
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/macOS-roundrels/leopard.png"
 width=25
 hspace=2
 align="top"
 />
 Leopard
 </td>
 <td style="text-align: center;">🚧</td>
 <td>Поддерживается.</td>
 <td><code>(Нет)</code></td>
 <td><code>(Retail)</code></td>
 </tr>
 <!-- macOS10.4 -->
 <tr>
 <td>
 <img
 src="https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/macOS-roundrels/tiger.png"
 width=25
 hspace=2
 align="top"
 />
 Tiger
 </td>
 <td style="text-align: center;">🚧</td>
 <td>Поддерживается.</td>
 <td><code>(Нет)</code></td>
 <td><code>(Retail)</code></td>
 </tr>
 </tbody>
</table>

См. [HyperV-versions.md](https://github.com/acidanthera/MacHyperVSupport/blob/master/Docs/HyperV-versions.md) для полного описания совместимости macOS с версиями Windows Client, Server и Hyper-V.

## ✨ Как начать

Если вы используете один из предварительно собранных релизов из этого репозитория, вы можете перейти сразу к разделу [2. Настройка OpenCore для вашего железа](#2-настроить-opencore-для-вашего-железа), чтобы настроить OpenCore под ваш CPU, а затем перейти к [4. Настройка Hyper-V](#4-настройка-hyper-v) для создания новой виртуальной машины.

Те, кто желает собрать проект из исходников, могут следовать шагам ниже для клонирования репозитория, сборки EFI и настройки Hyper-V.

###1. Клонирование репозитория через Git

Чтобы клонировать репозиторий, выполните:
```sh
- git clone https://github.com/Qonfused/OSX-Hyper-V
- cd OSX-Hyper-V
+ git clone https://github.com/k13wk4/OSX-Hyper-V-AMD-RU
+ cd OSX-Hyper-V-AMD-RU
```

> [!TIP]
> В качестве альтернативы можно использовать команду curl для загрузки и распаковки архива с GitHub:
> ```pwsh
> - iwr https://github.com/Qonfused/OSX-Hyper-V/archive/refs/heads/main.zip -OutFile OSX-Hyper-V-main.zip | tar -xf OSX-Hyper-V-main.zip
> - rm OSX-Hyper-V-main.zip
> - cd OSX-Hyper-V-main
> + iwr https://github.com/k13wk4/OSX-Hyper-V-AMD-RU/archive/refs/heads/main.zip -OutFile OSX-Hyper-V-AMD-RU-main.zip | tar -xf OSX-Hyper-V-AMD-RU-main.zip
> + rm OSX-Hyper-V-AMD-RU-main.zip
> + cd OSX-Hyper-V-AMD-RU-main
> ```

###2. Настроить OpenCore для вашего железа

> [!NOTE]
> **MacHyperVSupport** требует Windows Server2012 R2 / Windows8.1 или новее. Windows Server2016 в настоящее время не поддерживается.

Поскольку Hyper-V — гипервизор типа1, он требует совместимый CPU для запуска macOS. Это означает, что любое передаваемое оборудование должно быть поддержано или пропатчено так же, как на обычном Hackintosh.

По умолчанию нет аппаратного ускорения GPU, поэтому все графические задачи будут выполняться CPU и будут медленными. Для получения аппаратного ускорения нужно использовать Discrete Device Assignment (DDA) для проброса поддерживаемой видеокарты.

> [!IMPORTANT]
> В отличие от bare metal, iGPU/APU по умолчанию невидимы для VM и требуют поддержки DDA для проброса GPU. Кроме того, большинство дискретных GPU, даже если они нативно поддерживаются, могут не работать при пробросе через DDA. Смотрите раздел с [ограничениями](https://github.com/k13wk4/OSX-Hyper-V-AMD-RU?tab=readme-ov-file#limitations) для обзора текущей поддержки в Hyper-V.

Для общего обзора поддержки оборудования обратитесь к разделам [Поддержка CPU](https://dortania.github.io/OpenCore-Install-Guide/macos-limits.html#cpu-support) и [Поддержка GPU](https://dortania.github.io/OpenCore-Install-Guide/macos-limits.html#gpu-support) руководства Dortania для разбора поддержки аппаратуры по версиям macOS.

Чтобы настроить OpenCore для вашего CPU, следуйте разделам для Intel или AMD в руководстве Dortania [Dortania Install](https://dortania.github.io/OpenCore-Install-Guide/) для вашей семьи CPU. Игнорируйте любые разделы про USB-маппинг, прошивки или материнские платы, так как они не релевантны для Hyper-V (Hyper-V предоставляет своё виртуальное оборудование).

Ниже — дополнительная информация о поддержке аппаратуры и специфические настройки для Hyper-V.

#### Intel

> [!NOTE]
> Для Intel Tiger Lake и новее (11-го поколения и новее) можно следовать руководству Dortania для [Comet Lake](https://dortania.github.io/OpenCore-Install-Guide/config.plist/comet-lake.html).
>
> Нужно подменить идентификацию CPU на Comet Lake, используя следующий CPUID патч:
> ```yml
> Kernel:
> Emulate:
> Cpuid1Data: Data | <55060A00000000000000000000000000>
> Cpuid1Mask: Data | <FF FF FF FF000000000000000000000000>
> ```
> Добавьте это в файл `config.yml` в секцию `Kernel -> Emulate` или вручную в сгенерированный `config.plist` под `EFI/OC/config.plist`.
>
> См. [Cpuid1Data](https://github.com/Qonfused/OCE-Build/blob/main/docs/schema.md#kernel---emulate---cpuid1data) для других доступных CPUID патчей для лучшей поддержки XCPM.

Ниже список поддерживаемых поколений CPU и их первая/последняя поддерживаемые версии macOS:

##### Desktop CPU:

| Поколение | Первая поддержка | Последняя поддержка |
| ------------------------------- | -------------------------- | --------------------------- |
| [Penryn](ID-1) | OS X10.4.10 (Tiger) | macOS10.13.6 (High Sierra) |
| [Clarkdale (1st Gen)](ID-2) | OS X10.6.3 (Snow Leopard) | macOS12 (Monterey) |
| [Sandy Bridge (2nd Gen)](ID-3) | OS X10.6.7 (Snow Leopard) | macOS12 (Monterey) |
| [Ivy Bridge (3rd Gen)](ID-4) | OS X10.7 (Lion) | macOS12 (Monterey) |
| [Haswell (4th Gen)](ID-5) | OS X10.8 (Mountain Lion) | (Текущая) |
| [Skylake (6th Gen)](ID-6) | OS X10.11 (El Capitan) | (Текущая) |
| [Kaby Lake (7th Gen)](ID-7) | macOS10.12 (Sierra) | (Текущая) |
| [Coffee Lake (8th Gen)](ID-8 ) | macOS10.13 (High Sierra) | (Текущая) |
| [Comet Lake (10th Gen)](ID-9) | macOS10.15 (Catalina) | (Текущая) |

[ID-1]: https://dortania.github.io/OpenCore-Install-Guide/config.plist/penryn.html
[ID-2]: https://dortania.github.io/OpenCore-Install-Guide/config.plist/clarkdale.html
[ID-3]: https://dortania.github.io/OpenCore-Install-Guide/config.plist/sandy-bridge.html
[ID-4]: https://dortania.github.io/OpenCore-Install-Guide/config.plist/ivy-bridge.html
[ID-5]: https://dortania.github.io/OpenCore-Install-Guide/config.plist/haswell.html
[ID-6]: https://dortania.github.io/OpenCore-Install-Guide/config.plist/skylake.html
[ID-7]: https://dortania.github.io/OpenCore-Install-Guide/config.plist/kaby-lake.html
[ID-8]: https://dortania.github.io/OpenCore-Install-Guide/config.plist/coffee-lake.html
[ID-9]: https://dortania.github.io/OpenCore-Install-Guide/config.plist/comet-lake.html

##### Мобильные CPU:

| Поколение | Первая поддержка | Последняя поддержка |
| ------------------------------ | ---------------------- | --------------------------- |
| [Arrandale (1st Gen)](IM-1) | OS X10.6.3 (Snow Leopard) | macOS10.13 (High Sierra) |
| [Sandy Bridge (2nd Gen)](IM-2) | OS X10.6.7 (Snow Leopard) | macOS12 (Monterey) |
| [Ivy Bridge (3rd Gen)](IM-3) | OS X10.7 (Lion) | macOS12 (Monterey) |
| [Haswell (4th Gen)](IM-4) | OS X10.8 (Mountain Lion) | macOS12 (Monterey) |
| [Broadwell (5th Gen)](IM-5) | OS X10.10 (Yosemite) | macOS12 (Monterey) |
| [Skylake (6th Gen)](IM-6) | OS X10.11 (El Capitan) | (Текущая) |
| [Kaby Lake (7th Gen)](IM-7) | macOS10.12 (Sierra) | (Текущая) |
| [Coffee Lake (8th Gen)](IM-8) | macOS10.13 (High Sierra) | (Текущая) |
| [Whiskey Lake (8th Gen)](IM-8) | macOS10.14.1 (Mojave) | (Текущая) |
| [Comet Lake (10th Gen)](IM-9) | macOS10.15.4 (Catalina) | (Текущая) |
| [Ice Lake (10th Gen)](IM-10) | macOS10.15.4 (Catalina) | (Текущая) |

[IM-1]: https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/arrandale.html
[IM-2]: https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/sandy-bridge.html
[IM-3]: https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/ivy-bridge.html
[IM-4]: https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/haswell.html
[IM-5]: https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/broadwell.html
[IM-6]: https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/skylake.html
[IM-7]: https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/kaby-lake.html
[IM-8]: https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/coffee-lake.html
[IM-9]: https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/coffee-lake-plus.html
[IM-10]: https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/icelake.html

#### AMD

> [!IMPORTANT]
> AMD CPU требуют включения опции `Kernel -> Emulate -> DummyPowerManagement` в `config.plist`, так как у AMD нет родного драйвера управления питанием в macOS:
> ```yml
> Kernel:
> Emulate:
> DummyPowerManagement: Boolean | true
> ```

Ниже список поддерживаемых поколений и их первая/последняя поддерживаемые версии macOS:

| Поколение | Первая поддержка | Последняя поддержка |
| -------------------------- | ---------------------- | ------------------- |
| [Bulldozer (15h)](AD-1) | macOS13 (High Sierra) | macOS12 (Monterey) |
| [Jaguar (16h)](AD-1) | macOS13 (High Sierra) | macOS12 (Monterey) |
| [Ryzen (17h)](AD-2) | macOS13 (High Sierra) | (Текущая) |
| [Threadripper (19h)](AD-2) | macOS13 (High Sierra) | (Текущая) |

[AD-1]: https://dortania.github.io/OpenCore-Install-Guide/AMD/fx.html
[AD-2]: https://dortania.github.io/OpenCore-Install-Guide/AMD/zen.html

В дополнение к [патчам ядра для AMD](https://github.com/AMD-OSX/AMD_Vanilla) (для семейств CPU AMD15h,16h,17h и19h), следующий патч ядра требуется для High Sierra и выше:

```yml
Kernel:
 Patch:
 - Arch: String | "x86_64"
 Base: String | "_cpu_syscall_init"
 Comment: String | "flagers - kill invalid wrmsr |10.13+"
 Count: Number |3
 Find: Data | "0F30"
 Identifier: String | "kernel"
 MaxKernel: String | ""
 MinKernel: String | "17.0.0"
 Replace: Data | "9090"
```

Вы также можете вручную добавить ниже приведённую запись plist в ваш `config.plist`:

<details><summary>Запись plist (файл: <a href="https://github.com/user-attachments/files/18508274/patch.plist.zip">patch.plist.zip</a>)</summary>


```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
 <key>Kernel</key>
 <dict>
 <key>Patch</key>
 <array>
 <dict>
 <key>Arch</key>
 <string>x86_64</string>
 <key>Base</key>
 <string>_cpu_syscall_init</string>
 <key>Comment</key>
 <string>flagers - kill invalid wrmsr |10.13+</string>
 <key>Count</key>
 <integer>3</integer>
 <key>Enabled</key>
 <true/>
 <key>Find</key>
 <data>DzA=</data>
 <key>Identifier</key>
 <string>kernel</string>
 <key>Limit</key>
 <integer>0</integer>
 <key>Mask</key>
 <data></data>
 <key>MaxKernel</key>
 <string></string>
 <key>MinKernel</key>
 <string>17.0.0</string>
 <key>Replace</key>
 <data>kJA=</data>
 <key>ReplaceMask</key>
 <data></data>
 <key>Skip</key>
 <integer>0</integer>
 </dict>
 </array>
 </dict>
</dict>
</plist>
```

</details>

> [!NOTE]
> При применении AMD патчей ядра выбирайте количество ядер, соответствующее числу ядер, выделенных виртуальной машине при конфигурации CPU (т.е. патчи `algrey - Force cpuid_cores_per_package`).
>
> Например, для6-ядерного AMD Ryzen9600X рекомендуется выделить6 ядер VM и использовать `06` для патча `cpuid_cores_per_package`. Если возникают проблемы при загрузке с6 ядрами, попробуйте выделить8 ядер и использовать `08` для патча (см. [#37](https://github.com/k13wk4/OSX-Hyper-V-AMD-RU/issues/37)).

> [!TIP]
> Вы можете использовать скрипт `amd.ps1` для автоматической генерации AMD патчей для вашего CPU, выполнив:
> ```powershell
> .\scripts\amd.ps1 --cpu <core_count>
> ```
>
> Обратите внимание, что требуется опция `--cpu`, указанная как количество ядер, выделенных VM.

###3. Сборка репозитория с помощью OCE-Build

Этот проект использует [OCE-Build](https://github.com/Qonfused/OCE-Build) для автоматического версионирования и сборки EFI этого репозитория.

> [!IMPORTANT]
> Для запуска PowerShell скриптов может потребоваться изменить политику выполнения:
> ```powershell
> Set-ExecutionPolicy RemoteSigned
> ```

Чтобы собрать EFI проекта, выполните одну из команд в корне проекта:
```powershell
# Собрать для macOS10.8 и новее
.\scripts\build.ps1

# Собрать для macOS10.7 и старее
.\scripts\build.ps1 --legacy

# Собрать для macOS10.4 -10.5,10.6 в32-битном режиме
.\scripts\build.ps1 --legacy --32-bit
```

Это создаст новую директорию `dist/` с виртуальным диском `EFI.vhdx` и директорией `dist/Scripts/`, содержащей скрипты для создания и настройки виртуальной машины.

###4. Настройка Hyper-V

Сначала убедитесь, что вы [включили Hyper-V](https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v) перед продолжением.
- Вы можете включить роль Hyper-V выполнив команду в PowerShell от имени администратора:
 ```ps
 Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
 ```
- После перезагрузки проверьте успешность включения Hyper-V:
 ```ps
 Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V
 ```

> [!TIP]
> После **сборки** или **загрузки** EFI этого проекта вы можете запустить скрипт `create-virtual-machine.ps1` для быстрого создания новой виртуальной машины.
> 
> Например, из локальной сборки проекта:
>
> ```powershell
> # Использовать последнюю версию macOS (cpu=2 ядра, ram=8 ГБ, size=50 ГБ)
> .\dist\Scripts\create-virtual-machine.ps1 -name "My New Virtual Machine"
> 
> # Использовать более старую версию macOS (cpu=4 ядра, ram=16 ГБ, size=128 ГБ)
> .\dist\Scripts\create-virtual-machine.ps1 -name "Catalina" -version10.15 -cpu4 -ram16 -size128
> ```
> или из загруженного релиза:
> ```powershell
> cd ~/Downloads/EFI-1.0.0-64-bit-DEBUG # Скрипты поставляются с релизами
> 
> # Использовать последнюю версию macOS (cpu=2 ядра, ram=8 ГБ, size=50 ГБ)
> .\Scripts\create-virtual-machine.ps1 -name "My New Virtual Machine"
> 
> # Использовать более старую версию macOS (cpu=4 ядра, ram=16 ГБ, size=128 ГБ)
> .\Scripts\create-virtual-machine.ps1 -name "Catalina" -version10.15 -cpu4 -ram16 -size128
> ```

> [!IMPORTANT]
> Новые версии macOS (Big Sur и новее) требуют6-8 ГБ ОЗУ для загрузки установщика. Для более старых версий можно использовать меньше памяти (минимум4 ГБ для Catalina и старее).

Ниже изложены шаги для ручного создания новой виртуальной машины для macOS:

---

#### i. Создание загрузочного VHDX диска

Отформатируйте небольшой (1 ГБ) диск в FAT32 и инициализируйте как GPT. Смонтируйте диск — он будет служить загрузочным разделом для вашей VM и будет содержать папку OpenCore EFI.
- Выберите один из трёх способов создания VHD/VHDX:
 - (A) Hyper-V Manager - Перейдите в `Action > New > Hard Disk`. <br>![A-VHD](https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/README/A-VHD.png)
 - Файлы виртуальных дисков находятся в `C:\ProgramData\Microsoft\Windows\Virtual Hard Disks\`.
 - Смонтировать VHD/VHDX можно правой кнопкой по файлу -> `Mount`.
 - Отмонтировать — `Eject`.
 - (B) Disk Management - Перейдите в `Action > Create VHD`. <br>![B-VHD](https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/README/B-VHD.png)
 - Инициализируйте диск как GPT и создайте новый раздел FAT32.
 - Смонтировать VHD/VHDX: `Action > Attach VHD`.
 - Отмонтировать: правой кнопкой по тому же тому -> `Detach VHD`.
 - (C) Powershell - Создать VHD/VHDX с помощью `New-VHD`:
 <details><summary>(Команда PowerShell)</summary>

 ```ps
 # Выполните в PowerShell от имени администратора

 $vhdpath = "$env:USERPROFILE\Desktop\EFI.vhdx"
 $vhdsize =1GB
 $vhdpart = "GPT"
 $vhdfs = "FAT32"
 New-VHD -Path $vhdpath -Dynamic -SizeBytes $vhdsize |
 Mount-VHD -Passthru |
 Initialize-Disk -PartitionStyle $vhdpart -Confirm:$false -Passthru |
 New-Partition -AssignDriveLetter -UseMaximumSize |
 Format-Volume -FileSystem $vhdfs -Confirm:$false -Force
 ```

 </details>

Перенесите папку `EFI` (всю папку) в корень VHDX диска.
- В корне вашего EFI VHDX диска должна остаться папка `EFI/`.

[ps/New-VHD]: https://learn.microsoft.com/en-us/powershell/module/hyper-v/new-vhd

---

#### ii. Создание VHDX диска с установщиком/восстановлением macOS
Создайте или добавьте диск установщика одним из способов ниже:
- (A) Скачать `BaseSystem` или `Recovery` образ напрямую с Apple используя `macrecovery.py`:
 - Следуйте руководству Dortania [Dortania-Guide/Installer#Windows] для шагов по загрузке образов установщика macOS.
 - Переместите файлы `.chunklist` и `.dmg`, скачанные `macrecovery`, в папку `com.apple.recovery.boot` на вашем EFI VHDX диске. В итоге в корне должны быть папки `EFI/` и `com.apple.recovery.boot/`.
- (B) Конвертировать DMG установщика в VHDX с помощью `qemu-img`:
 - Если у вас уже есть DMG установщика macOS (например для Sierra и старее), вы можете конвертировать образ в VHDX:
 ```powershell
 qemu-img.exe convert -f raw -O vhdx InstallMacOSX.dmg InstallMacOSX.vhdx
 ```

[qemu-img/docs]: https://cloudbase.it/qemu-img-windows/
[OpenCorePkg]: https://github.com/acidanthera/OpenCorePkg/releases
[Dortania-Guide/Installer#Windows]: https://dortania.github.io/OpenCore-Install-Guide/installer-guide/windows-install.html

---

#### iii. Создание виртуальной машины macOS

В Hyper-V Manager выберите `Action > New > Virtual Machine`.

![3-New-VM](https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/README/3-New-VM.png)

При создании укажите следующие параметры:
- **Specify Generation**: Выберите `Generation2`.
- **Assign Memory**: Выделите минимум `4096 MB` (рекомендуется `8192 MB` для Big Sur и новее).
- **Configure Networking**: Оставьте сетевой переключатель по умолчанию.
- **Connect Virtual Hard Disk**: Назовите и укажите размер диска для установки macOS.

После создания правой кнопкой по VM -> `Settings`.

![3-VM-Settings](https://raw.githubusercontent.com/k13wk4/OSX-Hyper-V-AMD-RU/main/docs/assets/README/3-VM-Settings.png)

Затем настройте следующие опции в разделе Hardware:
- Перейдите в `Security` и отключите `Enable Secure Boot`.
- Перейдите в `SCSI Controller` и добавьте новый жёсткий диск для вашего EFI VHDX (и диска установщика, если он есть).
 - Прикрепите EFI VHDX с `location`0 и измените `location` для основного виртуального диска на другое значение (например `1` или `2`). Это нужно, чтобы EFI диск был первым в порядке загрузки.

---

###5. Использование этого EFI с macOS

Смотрите раздел [Процесс установки][Dortania-Guide/Installation-Process] руководства Dortania. Дополнительные пост-инсталляционные шаги приведены для удобства с Hyper-V (или особенностей проекта).

 <!--
 Другой пользователь предложил следующие шаги (для справки):
1. Запустить PS скрипт для создания VM
2. Запустить VM, открыть Console
3. Загрузиться в EFI (dmg) чтобы запустить меню восстановления
4. Открыть Дисковую утилиту
5. Выбрать "Msft Virtual Disk Media", нажать "Erase"
6. Назвать новый диск "MyInteralDrive", выбрать AFPS
7. Выполнить стирание
8. Выйти из Дисковой утилиты
9. В главном меню Recovery выбрать "Reinstall macOS"
10. Выбрать только что созданный AFPS-диск
11. Дождаться установки (~2 часа).
 -->

Краткое описание процесса установки:

1. Запустите виртуальную машину и выберите `EFI (dmg)` в меню загрузчика OpenCore.
 - Если вы создали отдельный VHDX установщика macOS, он может отображаться как `macOS Base System (External)` или `Install macOS Big Sur (External)` в зависимости от версии.
2. Когда загрузится установщик, откройте Disk Utility через меню Utilities.
 - Выберите `Msft Virtual Disk Media` (ваш основной виртуальный диск) и нажмите `Erase` для форматирования.
 - Дайте диску имя (например, `macOS` или `Macintosh HD`).
 - Для macOS10.13 и новее используйте `APFS`. Для старых версий используйте `Mac OS Extended (Journaled)`.
4. Выйдите из Disk Utility и вернитесь в главное меню установщика.
5. Выберите `Reinstall macOS` и следуйте подсказкам для установки на отформатированный диск.
 - Убедитесь, что выбрали правильный диск для установки (тот, который вы только что отформатировали).
 - Установка может занять значительное время (30 минут —2 часа).
6. После завершения установки виртуальная машина перезагрузится и вы увидите меню OpenCore.
 - Может потребоваться несколько перезагрузок для завершения установки.
7. Выберите установленный диск (или имя, которое вы задали) для загрузки macOS.
 - Если загрузка не проходит, возможно, придётся снова выбрать диск установщика.
 - Можно сделать запись загрузки по умолчанию, удерживая `Ctrl` при выборе диска.

Виртуальный EFI диск, создаваемый этим проектом, включает пост-инсталляционный скрипт, который устанавливает драйвер `MacHyperVFramebuffer` и настраивает демоны для дополнительной поддержки сервисов Hyper-V. Это требуется для поддержки изменения разрешения и аппаратного курсора в macOS.

Чтобы выполнить этот скрипт, запустите `post-install.sh` с EFI диска из каталога `Scripts/`. Например, в терминале macOS во время установки выполните:

```bash
cd /Volumes/EFI # Перейти на EFI диск
bash ./Scripts/post-install.sh
```

Опционально можно запустить скрипт `optimize-vm.sh` для отключения индексирования Spotlight, уменьшения дисковой активности и отключения системных анимаций. Это рекомендуется для виртуальных машин с графикой, рендерящейся CPU, и с ограниченной производительностью диска.

```bash
cd /Volumes/EFI # Перейти на EFI диск
bash ./Scripts/optimize-vm.sh
```

[Dortania-Guide/Installation-Process]: https://dortania.github.io/OpenCore-Install-Guide/installation/installation-process.html

###6. Устранение неполадок

Если вы столкнулись с проблемами во время установки или загрузки, можете [создать issue на GitHub](https://github.com/k13wk4/OSX-Hyper-V-AMD-RU/issues/new) и привести как можно больше деталей о вашей конфигурации, включая:
- Версию macOS, которую вы пытаетесь установить.
- Версию Windows, на которой работает Hyper-V.
- Ваш CPU (например, Intel i7-9700K, AMD Ryzen53600 и т.д.).
- Число выделенных ядер и объём ОЗУ для виртуальной машины.
- Любые сообщения об ошибках, appearing в меню OpenCore или во время установки.

Ниже перечислены распространённые проблемы и возможные решения:
- Ранний перезапуск после выбора установщика (`#[EB.MM.AKM|!] Err(0xE) <- EB.MM.MKP`)
 - Обычно это означает, что установщику macOS не хватает памяти для загрузки. Убедитесь, что выделено как минимум6-8 ГБ ОЗУ для macOS11 Big Sur и новее, или4 ГБ для старых версий.
 - Смотрите [#44](https://github.com/k13wk4/OSX-Hyper-V-AMD-RU/issues/44) для подробностей.
- Зависание на `vm_shared_region_start_address()` или `failed lookup: com.apple.dock.fullscreen`:
 - Задержки в этой области обычно означают, что GUI установщика macOS не смог запуститься. Могут появляться и другие сообщения, связанные с `WindowServer` или `gui/0`, запрашивающие службы (например `logd` или `recoveryosd`).
 - Попробуйте перезапустить и сбросить NVRAM (опция `Reset NVRAM` в меню OpenCore), чтобы проверить, решит ли это проблему.
 - Хороший обходной путь — установить macOS Catalina (10.15), а затем обновиться до нужной версии после установки. См. [#53](https://github.com/k13wk4/OSX-Hyper-V-AMD-RU/issues/53#issuecomment-3089641792).
- Перезагрузка после установки при выборе установщика.
 - Это relativamente нормальное поведение. Может потребоваться несколько перезагрузок (с выбором установщика каждый раз) для завершения установки.

#### Ограничения

Есть известные ограничения в базовой конфигурации для Hyper-V:

- Разрешение дисплея
 - По умолчанию виртуальное разрешение установлено в1024x768, но его можно изменить, модифицировав `SupportedResolutions` в `Info.plist` драйвера `MacHyperVFramebuffer`.
 - Смотрите issue [#6](https://github.com/k13wk4/OSX-Hyper-V-AMD-RU/issues/6) для подробностей.
- Аппаратное ускорение графики
 - По умолчанию macOS работает с синтетическим графическим драйвером `MacHyperVFramebuffer`, который обеспечивает базовую графику (с8 МБ видеопамяти). Такой драйвер подходит для базовых задач, но не даёт аппаратного ускорения.
