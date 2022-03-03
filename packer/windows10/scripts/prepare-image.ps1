# Install software

# Install Sysmon
choco install -y sysmon

# Install Notepad++
choco install -y notepadplusplus.install

# Install Root Certificate 
certutil.exe -addstore root c:\terraform\certs\ca\ca.crt

exit 0
