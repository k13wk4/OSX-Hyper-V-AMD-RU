# ������ ���������
��� �������� ��������� � ���� ������� ����� ��������������� � ���� �����.

������ ������� �� [Keep a Changelog](http://keepachangelog.com/)
� ������ ������� [Semantic Versioning](http://semver.org/).

��������� �������� ����� ����������� �� ����� ������� ����� �����������.

## [0.3.3] -2025-07-17

���������� �������� �� ��������� ������ � ������� `create-macos-recovery.ps1` ���, ����� ������ �� ��������� �������������� Python. ���������� ������� �������� ���������� ����������� � ��������� ������, ��� �������� ����������� ������� ��� �������� VM.

## �����������
- ���������� ��������� ������ � ������� ������ ([`e50fb6d`](https://github.com/Qonfused/OSX-Hyper-V/commit/e50fb6d9869438556ddc8224a425f924b2a67938))

## ��������
- ��������� �������: ��������� �����������, ������� ���������� python3 ([`7ccd8b80`](https://github.com/Qonfused/OSX-Hyper-V/commit/7ccd8b80b85b511d4c1aee3cfc533de9bcbab370))

## ���������
- �������� ������ `amd.ps1` ([`dadaa79`](https://github.com/Qonfused/OSX-Hyper-V/commit/dadaa796e74029b0e8189db34ec95b4481949e39))

## [0.3.2] -2025-07-11

## �����������
- �������������� �������� ������ ���� ��� ���������� plist ([`e689108`](https://github.com/Qonfused/OSX-Hyper-V/commit/e689108d397935c26b4e5ad392fa222d83a44e98))

## [0.3.1] -2025-07-03

���������� �������� � ������� `convert-efi-disk.ps1`, ����� �� ����������� ��������� ����� �� ���������� ������.

## �����������
- ���������� ���� ��� post-install ����� ([`d701770`](https://github.com/Qonfused/OSX-Hyper-V/commit/d701770b53499c8d3f16347813985e5c29ec26b3))

## [0.3.0] -2025-07-02

������� ����������, ���������� ������������ ���������, ����� ������� � ����������� ��� ��������� ������������� � �������� �������������.

��� ����� ������������� ���� ���������� Hyper-V � ����������� kext'���, ��������������� ��������� � ����������� ������������, ����������� ��������� macOS � ����-����������� �� Hyper-V VM.

## ��������
- ���������� �������� � ������������ � upstream ([`3498a02`](https://github.com/Qonfused/OSX-Hyper-V/pull/40/commits/3498a023644184ec8086442365b64cf12998212e))
- ��������� ACPI �����; ����� WS2022 SSDT ([`1d3e69b`](https://github.com/Qonfused/OSX-Hyper-V/pull/40/commits/1d3e69bf29af5e50e7350259bacfd2908c815d06))
- ��������� ������ OpenCore � MacHyperVSupport ([`ac04dd0`](https://github.com/Qonfused/OSX-Hyper-V/pull/40/commits/ac04dd034665250b9c3320b3b12aa2988b370a77))
- ���������� ���� IOGraphicsFamily � ������� ����������� MaxKernel ([`feed097`](https://github.com/Qonfused/OSX-Hyper-V/pull/40/commits/feed09783784373528a4ba9e934339eda1c0fe1e))
- ������� ������� ACPI0007 �� `SSDT-HV-DEV` [`238b571`](https://github.com/Qonfused/OSX-Hyper-V/pull/40/commits/238b571e16ef857ffa5eaf7a390f16162774f7fa)
- ����� kext VMHide, ������ ������ ������ ���� `hv_vmm_present` ([`a377f97`](https://github.com/Qonfused/OSX-Hyper-V/pull/40/commits/a377f977d1c4b48d4630c5c48fa4006474b9196f); ��. [#46](https://github.com/Qonfused/OSX-Hyper-V/issues/46#issuecomment-2813907377))
- ��������� �������� MacHyperVFramebuffer (�������� ��� post-install �������������) ([`a19f660`](https://github.com/Qonfused/OSX-Hyper-V/pull/40/commits/a19f660b95e1e4f397c9b0ccb581496e3cf0b725))
- ������� OpenCore �� v1.0.5 ([`93cd2ab`](https://github.com/Qonfused/OSX-Hyper-V/commit/93cd2ab3647450be544f0883eb0f70ea0a8a574f))

## ���������
- �������� kext MacHyperVFramebuffer � ��������� ������������ ([`f2eb5a1`](https://github.com/Qonfused/OSX-Hyper-V/pull/40/commits/f2eb5a1b88d3fe802df57e40135049dab2d98351))
- �������� post-install ������ ��� �������������� ��������� Hyper-V ������� � MacHyperVFramebuffer ([`d888782`](https://github.com/Qonfused/OSX-Hyper-V/pull/40/commits/d888782fbb726e762a80d35609d03ed497bc93b3))
- �������� ������ amd.py ��� ��������� AMD ������ ([`26efe52`](https://github.com/Qonfused/OSX-Hyper-V/commit/26efe5282b5788f4755bad346103c6577a97ad4c))

## ����������
- ���������� ������������� ���� ��������� macOS ��� ����������� ����������� diskutil ([`fbaecc6`](https://github.com/Qonfused/OSX-Hyper-V/commit/fbaecc635db26ce3ee63bff3ca543abd29ff6bcb))
- ��������� README � ���������� post-install ������� ([`aabc21a`](https://github.com/Qonfused/OSX-Hyper-V/pull/40/commits/aabc21a61cc1d098eea4b5becf277f6f35ed06f4))

## [0.2.4] -2025-01-22

## ��������
- ������� MacHyperVSupport �� e987ee2 - ��������� ��������� ��� ��������� macOS15 ��� ���������� `-lilubetaall` ([`744f385`](https://github.com/Qonfused/OSX-Hyper-V/commit/744f3850f0e41e2c7ca24f5f183af230e3215dac))

## [0.2.3] -2024-12-26

## ��������
- �������������� ����� X64 ISA ��� Gen2 VM ([`e471c83`](https://github.com/Qonfused/OSX-Hyper-V/commit/e471c834bde52f10362898b5ce9319fd6b50e4e3))

## ����������
- README: ���������� ���� `count` � AMD ����� ([`3f18bb6`](https://github.com/Qonfused/OSX-Hyper-V/commit/3f18bb62974b48426ec27d6e05f8a53c996f0580))

## [0.2.2] -2024-12-08

## ���������
- �������� `csr-active-config` � ������ ��������� NVRAM ([`08fc280`](https://github.com/Qonfused/OSX-Hyper-V/commit/08fc28037db79ad947983d108787aa765c545298))
- �������� ������������� OpenCore ISA ���32-������ �� ([`d84213c`](https://github.com/Qonfused/OSX-Hyper-V/commit/d84213c58480bd2f75150f1a094203f2e7513c0a))

## ��������
- ������� OpenCore �� v1.0.3 ([`0f66426`](https://github.com/Qonfused/OSX-Hyper-V/commit/0f664268253389eb70388cd5ed229c8e42e3db97))

## [0.2.1] -2024-11-21

## ���������
- �������� kext VMHide ��� macOS Sequoia ([`d594e28`](https://github.com/Qonfused/OSX-Hyper-V/commit/d594e28e791a432a84ad665f674fa1b576fb132b))

## [0.2.0] -2024-11-04

## ��������
- ������� OpenCore �� v1.0.2 ([`58ccd4b`](https://github.com/Qonfused/OSX-Hyper-V/commit/58ccd4b6e1c6492fab0d704d4b2bf24b834e56f7))
- ������� `-legacy` boot arg ���� ([`36b00a7`](https://github.com/Qonfused/OSX-Hyper-V/commit/36b00a73eaf1bee4ab42b07c70f1900e7500db10))
- ����������� ������� ������ ��� ������������� � PowerShell Core ([`31680e2`](https://github.com/Qonfused/OSX-Hyper-V/commit/31680e2a762059555ae85407db450f625cf5d939))

### ���������
- �������� board-id Sonoma ��� �������� macOS Recovery ([`3bc60c6`](https://github.com/Qonfused/OSX-Hyper-V/commit/3bc60c6a2d7b5b17603123b0565d795870dfa089))

### ����������
- ������ ������ ����� �� ��������� ��� ��������� ������� ������� �������������� macOS ([`25e9275`](https://github.com/Qonfused/OSX-Hyper-V/commit/25e92751264f71671e4c1287744a211d87b49482))
- �������� ������� ������� ������ �� post-install �������� ([`ee0c7e3`](https://github.com/Qonfused/OSX-Hyper-V/commit/ee0c7e3760e9b0c191fbae5fff124ef78afba0cf))
- ���������� ���������� ������ � ���������� � �������� ���������� ([`24ad5a2`](https://github.com/Qonfused/OSX-Hyper-V/commit/24ad5a2decd27c34ea906e23ec465e685eee756f))

## [0.1.0] -2024-02-26

### ��������
- ������� ������ �� ����� ����������� OCE-Build ([`83f31a5`](https://github.com/Qonfused/OSX-Hyper-V/pull/4/commits/83f31a53f26d0d3451ffc9215564bc8e156cb8cb))
- ������� pipeline ������ ��� ������������� ������ PowerShell workflow ([`42a77be`](https://github.com/Qonfused/OSX-Hyper-V/pull/4/commits/42a77be235c4bccccf6664708b5547bd68008147))

### ���������
- ��������� ������������� ��� legacy �32-������ ������ ([`2ab0c7b`](https://github.com/Qonfused/OSX-Hyper-V/pull/4/commits/2ab0c7b2b214886be6c2cc6da0595e4ff1e08b2a))

### �������
- ������� ������ devcontainers ([`ee9a3cd`](https://github.com/Qonfused/OSX-Hyper-V/pull/4/commits/ee9a3cdcae8bf1322502705bc39f43429db2da13))

## [0.0.0] -2023-06-15

������ ����� �������, ���������� �����������, ����� ������� � ��������� ������������ ��� ������������� ������� [MacHyperVSupport](https://github.com/acidanthera/MacHyperVSupport):

### ��������
- ������� scanpolicy ��� �������������� ����������� ����������� ([`8f838a2`](https://github.com/Qonfused/OSX-Hyper-V/commit/8f838a2342af58ccc568ac590f850df6771c6eb9))
- �������� ������� ������� ��� ������������� Default Switch ([`1ce9be2`](https://github.com/Qonfused/OSX-Hyper-V/commit/1ce9be20a0e7f2a1a7980b5c9f80003bf228c9b9))
- ��������� �������������� ����������� ����� ([`de3c6ab`](https://github.com/Qonfused/OSX-Hyper-V/commit/de3c6ab29b2b9903c1e2281f6b1d8a6fe98373a8))

### ���������
- �������� ��������� `--legacy` ���� ���10.7 � ���� ([`468bef2`](https://github.com/Qonfused/OSX-Hyper-V/commit/468bef2c552e661982de3c7cb8091a1ddd9fd495))
- ��������� ��������� ����������� � ���� �� ������������ ([`2764ade`](https://github.com/Qonfused/OSX-Hyper-V/commit/2764ade116b944e8b8ace6dbf183609356d8c02e))
- ��������� PowerShell ������� ��� ������������� �������� VM ([`6badacf`](https://github.com/Qonfused/OSX-Hyper-V/commit/6badacfccf32c3a818fe5ea61eddbad04c8d9738))
- ��������� post-install ������ � ����������� � EFI VHD ([`c426d92`](https://github.com/Qonfused/OSX-Hyper-V/commit/c426d928ba7d2afe4bee16b8c56244668d9fec2b))
- ��������� ��������� post-install VHD ([`f2415d4`](https://github.com/Qonfused/OSX-Hyper-V/commit/f2415d41160f79d66591fe4dda1532aa92b6c9c0))

### ����������
- ��������� ������ �������� recovery ������ ([`46bfb01`](https://github.com/Qonfused/OSX-Hyper-V/commit/46bfb01c4c38abc0a75f3d5ae410184538754c6a))
- ��������� patch-serial ������ ��� linux/WSL2 ([`7557d71`](https://github.com/Qonfused/OSX-Hyper-V/commit/7557d713a5a0551ccd5ac0c40fc0356a1cac1dc5))
