@echo off 
if "%1" == "h" goto begin 
mshta vbscript:createobject("wscript.shell").run("%~nx0 h",0)(window.close)&&exit 
:begin
docker run -it --rm --name mogeaver -v d:\MogeaverData:/root/.local/share/MogeaverData -v d:\dump_data:/root mogeaver-docker:latest