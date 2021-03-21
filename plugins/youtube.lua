local function GetInputFile(file)  
local file = file or ""   if file:match('/') then  infile = {ID= "InputFileLocal", path_  = file}  elseif file:match('^%d+$') then  infile = {ID= "InputFileId", id_ = file}  else  infile = {ID= "InputFilePersistentId", persistent_id_ = file}  end return infile 
end
local function sendRequest(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra) 
tdcli_function ({  ID = request_id,    chat_id_ = chat_id,    reply_to_message_id_ = reply_to_message_id,    disable_notification_ = disable_notification,    from_background_ = from_background,    reply_markup_ = reply_markup,    input_message_content_ = input_message_content,}, callback or dl_cb, extra) 
end
local function sendAudio(chat_id,reply_id,audio,title,caption)  
tdcli_function({ID="SendMessage",  chat_id_ = chat_id,  reply_to_message_id_ = reply_id,  disable_notification_ = 0,  from_background_ = 1,  reply_markup_ = nil,  input_message_content_ = {  ID="InputMessageAudio",  audio_ = GetInputFile(audio),  duration_ = '',  title_ = title or '',  performer_ = '',  caption_ = caption or ''  }},dl_cb,nil)
end
local function sendVoice(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, voice, duration, waveform, caption, cb, cmd)  
local input_message_content = {   ID = "InputMessageVoice",   voice_ = getInputFile(voice),  duration_ = duration or 0,   waveform_ = waveform,    caption_ = caption  }  sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function yt(msg)
if text == 'تفعيل اليوتيوب' and Manager(msg) then   
if database:get(bot_id..'Lock:yout'..msg.chat_id_)  then
database:del(bot_id..'Lock:yout'..msg.chat_id_) 
Text = '\n ✸∫ تم تفعيل اليوتيوب' 
else
Text = '\n ✸∫  بالتاكيد تم تفعيل اليوتيوب'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل اليوتيوب' and Manager(msg) then  
if not database:get(bot_id..'Lock:yout'..msg.chat_id_)  then
database:set(bot_id..'Lock:yout'..msg.chat_id_,true) 
Text = '\n ✸∫ تم تعطيل اليوتيوب' 
else
Text = '\n ✸∫ بالتاكيد تم تعطيل اليوتيوب'
end
send(msg.chat_id_, msg.id_,Text) 
end
if not database:get(bot_id..'Lock:yout'..msg.chat_id_) then
if text and text:match("(%S+!!)") then 
local tyt = text:match("%S+!!")
local tyt2 = text:match("%S+")
local InfoSearch = https.request('https://teamstorm.tk/search/?query='..URL.escape(tyt2))
local JsonSearch = JSON.decode(InfoSearch)
for k,vv in pairs(JsonSearch) do
if k == 1 then
local url,res = https.request('https://teamstorm.tk/Get_yt/?url='..vv.id..'&status=getmp3')
local infoLink = JSON.decode(url)  
for k,v in pairs(infoLink) do
local download_to = download_to_file(v.url,vv.id..'.mp3')
print('download Mp3 done ...\nName : '..vv.Title..'\nIdLink : '..vv.id)
sendAudio(msg.chat_id_, msg.id_,'./'..download_to,vv.Title,'SourceCh ---> @blackklo')
os.execute('rm -rf ./'..vv.id..'.mp3') 
https.request('https://teamstorm.tk/Get_yt/?url='..vv.id..'&status=del')
end
end
end
end

if text and text:match("(%S+؟؟)") then 
local tyt = text:match("%S+؟؟")
local tyt2 = text:match("%S+")
local InfoSearch = https.request('https://teamstorm.tk/search/?query='..URL.escape(tyt2))
local JsonSearch = JSON.decode(InfoSearch)
for k,vv in pairs(JsonSearch) do
if k == 1 then
local url,res = https.request('https://teamstorm.tk/Get_yt/?url='..vv.id..'&status=getmp3')
local infoLink = JSON.decode(url)
for k,v in pairs(infoLink) do
local download_to = download_to_file(v.url,vv.id..'.ogg')
print('download Mp3 done ...\nName : '..vv.Title..'\nIdLink : '..vv.id)
sendVoice(msg.chat_id_,msg.id_,'./'..download_to,'SourceCh ---> @blackklo')
os.execute('rm -rf ./'..vv.id..'.ogg') 
https.request('https://teamstorm.tk/Get_yt/?url='..vv.id..'&status=del')
end
end
end
end
end
end
return {
    Poyka = {
    '^(تفعيل اليوتيوب)$',
    '^(تعطيل اليوتيوب)$',
    '^(.*) (!!)$',
    '^(.*) (؟؟)$',
    },
    Poyka = yt,
    
    
    }
