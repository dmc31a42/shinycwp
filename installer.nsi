Unicode true

; headers
!include "MUI2.nsh"

; define const
!define VERSION "1.3.0704.7"
!define APP_NAME "ShinyCWP transKR"
!define APP_DIR "ShinyCWP_TransKR"

; metadata
# 인스톨러 이름
Name "${APP_NAME}"
# 빌드 후 생성할 파일명
OutFile "Shinycwp_transKR_win_x64_installer.exe"
# 설치 디렉터리 기본값
InstallDir "$APPDATA\ShinyCWP_TransKR"
# Windows 커널 5.1부터 적용된 비주얼 스타일을 적용합니다.
;XPStyle on
# 인스톨러의 압축 방식을 지정합니다.
SetCompressor /SOLID lzma
# 설치 도중 자세한 정보를 기본적으로 보여줍니다.
ShowInstDetails show
RequestExecutionLevel user

; file descriptions
# 파일 버전 정보를 기입합니다. 파일 속성의 자세히 탭에 나타나는 정보입니다.
VIProductVersion "${VERSION}"
VIAddVersionKey "FileVersion" "${VERSION}"
VIAddVersionKey "ProductVersion" "${VERSION}"
VIAddVersionKey "ProductName" "${APP_NAME}"

; MUI config
# 언/인스톨러의 아이콘을 지정합니다. NSIS 설치 디렉터리에 기본으로 제공하고 있는 리소스를 사용할 수 있습니다.
!define MUI_ICON "ShinyCWP_TransKR\shanicon.ico"
!define MUI_UNICON "ShinyCWP_TransKR\shanicon.ico"
 
; inst pages
;!insertmacro MUI_PAGE_WELCOME
; License page
!define MUI_LICENSEPAGE_RADIOBUTTONS
!insertmacro MUI_PAGE_LICENSE "License.txt" ;License.txt 파일을 라이선스페이지에 표시한다.
!insertmacro MUI_PAGE_INSTFILES
!define MUI_FINISHPAGE_RUN "nw.exe"
!insertmacro MUI_PAGE_FINISH

; uninst pages
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH
 
!insertmacro MUI_LANGUAGE "Korean"


Section "main"
# 파일이 설치될 디렉터리를 지정합니다.
SetOutPath "$INSTDIR"
# 설치할 파일들을 지정합니다. /r 옵션을 통해 이 스크립트가 존재하는 디렉터리의 ${APP_DIR} 폴더 전체를 압축한 후 SetOutPath로 지정한 위치에 설치(압축 해제)합니다.
File /r "${APP_DIR}\*"
SectionEnd

# 섹션명에 -를 접두어로 붙여두면 이 섹션은 사용자에게 보여지지 않습니다. 단, 여기선 설치 옵션을 선택할 수 있는 COMPONETS 페이지를 삽입하지 않았기 때문에 효과가 없습니다.
Section "-post"
# 설치 로그에 문자열을 한 줄 출력합니다.
DetailPrint "언인스톨 정보 등록"
# 언인스톨러를 생성합니다.
WriteUninstaller "uninstall.exe"
# 시작메뉴에 바로가기를 생성합니다.
CreateShortCut "$DESKTOP\ShinyCWP transKR.lnk" "$INSTDIR\nw.exe" "" "$INSTDIR\shanicon.ico"
CreateShortCut "$SMPrograms\ShinyCWP transKR.lnk" "$INSTDIR\nw.exe" "" "$INSTDIR\shanicon.ico"
SetOutPath "$INSTDIR"
SectionEnd

# 언인스톨러에서 사용하는 섹션입니다.
Section Uninstall
SectionIn RO
RMDir /r "$INSTDIR\*"
RMDir "$INSTDIR"
SetShellVarContext all
Delete "$DESKTOP\ShinyCWP transKR.lnk"
Delete "$SMPrograms\ShinyCWP transKR.lnk"
SectionEnd