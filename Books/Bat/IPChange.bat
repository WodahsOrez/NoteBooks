@echo off
rem //���ñ��� 
set NAME="WLAN"
rem //��������ֵ���Ը�����Ҫ����
set ADDR=172.16.103.13
set MASK=255.255.255.0
set GATEWAY=172.16.103.254
set DNS1=114.114.114.114
set DNS2=
rem //������������ΪIP��ַ���������롢���ء���ѡDNS������DNS

rem //��ȡ��ǰwifi����
netsh wlan show interface > temp.txt
FOR /F "tokens=2 delims=: " %%i in ('findstr /R "\<SSID" temp.txt') do set wifiName=%%i
del temp.txt

set mode=dynamic
rem //��wifi��ΪiBizSys_5Gʱ�����þ�̬ip
set value=iBizSys_5G
IF %value%==%wifiName% set mode=static
rem //��wifi��ΪiBizSysʱ�����þ�̬ip
set value=iBizSys
IF %value%==%wifiName% set mode=static

IF  %mode%==static (
  goto 1
) ELSE (
  goto 2
)



:1
echo �������þ�̬IP�����Ե�...
rem //���Ը��������Ҫ���� 
echo IP��ַ = %ADDR%
echo ���� = %MASK%
echo ���� = %GATEWAY%
netsh interface ipv4 set address %NAME% static %ADDR% %MASK% %GATEWAY% 
rem //echo ��ѡDNS = %DNS1% 
rem //netsh interface ipv4 set dns %NAME% static %DNS1%
rem //echo ����DNS = %DNS2% 
rem //if "%DNS2%"=="" (echo DNS2Ϊ��) else (netsh interface ipv4 add dns %NAME% %DNS2%) 
echo ��̬IP�����ã�
rem //pause
goto 3


:2
echo �������ö�̬IP�����Ե�...
echo ���ڴ�DHCP�Զ���ȡIP��ַ...
netsh interface ip set address %NAME% dhcp
echo ���ڴ�DHCP�Զ���ȡDNS��ַ...
netsh interface ip set dns %NAME% dhcp 
echo ��̬IP�����ã�
rem //pause
goto 3


:3
exit

:4
rem //�ֶ��л�����
echo ��ǰ���ò����У�
echo 1 ����Ϊ��̬IP
echo 2 ����Ϊ��̬IP
echo 3 �˳�
echo ��ѡ���س���
set /p operate=
if %operate%==1 goto 1
if %operate%==2 goto 2
if %operate%==3 goto 3