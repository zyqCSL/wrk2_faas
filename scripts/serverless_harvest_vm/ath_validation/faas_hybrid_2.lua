socket = require "socket"
json = require "cjson"
mime=require("mime")
math.randomseed(socket.gettime()*1000)
math.random(); math.random(); math.random()

-------- metadata ---------
wrk2_path = "/home/yz2297/Projects/msr_intern_2019/wrk2_faas"

------ autocomplete ---------
Alphabets = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K",
  "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", 
  "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
  "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}

Domains = {"uspresidents", "uktowns", "soccerplayers", "names",
        "gameofthrones", "dickensnovels", "countries", "characters"}

------ img-ocr ---------
ocr_img_dir = wrk2_path .. "/scripts/serverless_harvest_vm/faas_data/img_ocr_dataset/"
ocr_img_jpg = {}
ocr_img_jpg_num = 6
ocr_img_png  = {}
ocr_img_png_num = 24

for i = 1, ocr_img_jpg_num do
  f = io.open(ocr_img_dir .. tostring(i) .. ".jpg", "rb")
  if f then 
    -- local temp = f:read("*all")
    -- ocr_img_jpg[i] = mime.b64(temp)
    ocr_img_jpg[i] = f:read("*all")
    f:close()
    -- print(ocr_img_dir .. tostring(i) .. ".jpg cached")
  else
    print(ocr_img_dir .. tostring(i) .. ".jpg doesn't exist")
  end
end 

for i = 1, ocr_img_png_num do 
  f = io.open(ocr_img_dir .. tostring(i) .. ".png", "rb")
  if f then 
    -- local temp = f:read("*all")
    -- ocr_img_png[i] = mime.b64(temp)
    ocr_img_png[i] = f:read("*all")
    f:close()
    -- print(ocr_img_dir .. tostring(i) .. ".png cached")
  else
    print(ocr_img_dir .. tostring(i) .. ".png doesn't exist")
  end
end

------ img-resize ---------
img_resize_dir = wrk2_path .. "/scripts/serverless_harvest_vm/faas_data/img_zip_dataset/"
img_resize_jpg = {}
img_resize_jpg_num = 17
img_resize_png  = {}
img_resize_png_num = 15

for i = 1, img_resize_jpg_num do
  f = io.open(img_resize_dir .. tostring(i) .. ".jpg", "rb")
  if f then
    -- local temp = f:read("*all")
    -- img_resize_jpg[i] = mime.b64(temp)
    img_resize_jpg[i] = f:read("*all")
    f:close()
    -- print(img_resize_dir .. tostring(i) .. ".jpg cached")
  else
    print(img_resize_dir .. tostring(i) .. ".jpg doesn't exist")
  end
end 

for i = 1, img_resize_png_num do 
  f = io.open(img_resize_dir .. tostring(i) .. ".png", "rb")
  if f then
    -- local temp = f:read("*all")
    -- img_resize_png[i] = mime.b64(temp)
    img_resize_png[i] = f:read("*all")
    f:close()
    -- print(img_resize_dir .. tostring(i) .. ".png cached")
  else
    print(img_resize_dir .. tostring(i) .. ".png doesn't exist")
  end
end

------ sentiment ---------
sentiment_dir = wrk2_path .. "/scripts/serverless_harvest_vm/faas_data/sentiment_data/"
sentiment_num = 25
sentiments = {}

for i = 1, sentiment_num do 
  f = io.open(sentiment_dir .. tostring(i) .. ".txt", "r")
  if f then
    sentiments[i] = f:read("*all")
    f:close()
    -- print(sentiment_dir .. tostring(i) .. ".txt cached")
  else
    print(sentiment_dir .. tostring(i)  .. ".txt doesn't exist")
  end
end

------ html-markdown ---------
markdown_dir = wrk2_path .. "/scripts/serverless_harvest_vm/faas_data/html_markdown/"
markdown_num = 9
markdowns = {}

for i = 1, markdown_num do 
  f = io.open(markdown_dir .. tostring(i) .. ".txt", "r")
  if f then
    markdowns[i] = f:read("*all")
    f:close()
    -- print(markdown_dir .. tostring(i) .. ".txt cached")
  else
    print(markdown_dir .. tostring(i) .. ".txt doesn't exist")
  end
end

------ function invocation ---------
-- autocomplete  
-- /guest/autocomplete/uspresidents 
-- /guest/autocomplete/uknowns      
-- /guest/autocomplete/soccerplayers
-- /guest/autocomplete/names        
-- /guest/autocomplete/gameofthrones
-- /guest/autocomplete/dickensnovels
-- /guest/autocomplete/countries    
-- /guest/autocomplete/characters   

function autocomplete()
  local chosen_domain = Domains[math.random(#Domains)]
  local alphabet = Alphabets[math.random(#Alphabets)]
  -- https://172.17.0.1/api/v1/web/guest/autocomplete/uspresidents
  local args = "blocking=true"
  local method = "POST"
  local headers = {}
  headers["Content-Type"] = "application/json"
  headers["Authorization"] = "Basic MjNiYzQ2YjEtNzFmNi00ZWQ1LThjNTQtODE2YWE0ZjhjNTAyOjEyM3pPM3haQ0xyTU42djJCS0sxZFhZRnBYbFBrY2NPRnFtMTJDZEFzTWdSVTRWck5aOWx5R1ZDR3VNREdJd1A="

  local path = "https://172.17.0.1/api/v1/web/guest/autocomplete/" .. chosen_domain  .. "?" .. args
  -- below only works with json inputs
  -- local path = "https://172.17.0.1/api/v1/namespaces/_/actions/autocomplete/" .. chosen_domain  .. "?" .. args
  local body = {}
  body["term"] = alphabet
  body_str = json.encode(body)
  return wrk.format(method, path, headers, body_str)

end

local function img_resize()
  -- curl -X POST -H "Content-Type: image/jpeg" --data-binary @./libertybell.jpg \ 
  -- https://172.17.0.1/api/v1/web/guest/default/img-resize -k -v --output output.zip
  local args = "blocking=true"
  local method = "POST"
  local headers = {}  
  headers["Authorization"] = "Basic MjNiYzQ2YjEtNzFmNi00ZWQ1LThjNTQtODE2YWE0ZjhjNTAyOjEyM3pPM3haQ0xyTU42djJCS0sxZFhZRnBYbFBrY2NPRnFtMTJDZEFzTWdSVTRWck5aOWx5R1ZDR3VNREdJd1A="
  body = ""
  local coin = math.random()
  if coin <= 0.53 then
    -- jpg
    headers["Content-Type"] = "image/jpeg"
    body = img_resize_jpg[math.random(img_resize_jpg_num)]
  else
    -- png
    headers["Content-Type"] = "image/png"
    body = img_resize_png[math.random(img_resize_png_num)]
  end

  local path = "https://172.17.0.1/api/v1/web/guest/default/img-resize"
  -- below only works with json inputs
  -- local path = "https://172.17.0.1/api/v1/namespaces/_/actions/img-resize?" .. args

  -- print("before return in ocr_img")
  
  return wrk.format(method, path, headers, body)
end


-- local function markdown_to_html()
-- end

function ocr_img()
  -- print("in ocr_img")

  -- curl -X POST -H "Content-Type: image/jpeg" --data-binary @./pitontable.jpg 
  -- https://172.17.0.1/api/v1/web/guest/default/ocr-img -k -v >output.txt
  local args = "blocking=true"
  local method = "POST"
  local headers = {}  
  headers["Authorization"] = "Basic MjNiYzQ2YjEtNzFmNi00ZWQ1LThjNTQtODE2YWE0ZjhjNTAyOjEyM3pPM3haQ0xyTU42djJCS0sxZFhZRnBYbFBrY2NPRnFtMTJDZEFzTWdSVTRWck5aOWx5R1ZDR3VNREdJd1A="
  body = ""
  local coin = math.random()
  if coin <= 0.2 then
    -- jpg
    headers["Content-Type"] = "image/jpeg"
    body = ocr_img_jpg[math.random(ocr_img_jpg_num)]
  else
    -- png
    headers["Content-Type"] = "image/png"
    body = ocr_img_png[math.random(ocr_img_png_num)]
  end

  local path = "https://172.17.0.1/api/v1/web/guest/default/ocr-img"
  -- below only works with json inputs
  -- local path = "https://172.17.0.1/api/v1/namespaces/_/actions/ocr-img?" .. args

  -- print("before return in ocr_img")
  
  return wrk.format(method, path, headers, body)

end

local function sentiment_analysis()
  -- https://172.17.0.1/api/v1/namespaces/_/actions/sentiment?blocking=true&result=true
  local args = "blocking=true"
  local method = "POST"
  local headers = {}  
  headers["Authorization"] = "Basic MjNiYzQ2YjEtNzFmNi00ZWQ1LThjNTQtODE2YWE0ZjhjNTAyOjEyM3pPM3haQ0xyTU42djJCS0sxZFhZRnBYbFBrY2NPRnFtMTJDZEFzTWdSVTRWck5aOWx5R1ZDR3VNREdJd1A="
  headers["Content-Type"] = "application/json"

  local body = {}
  body["analyse"] = sentiments[math.random(sentiment_num)]
  local body_str = json.encode(body)
  -- print(body_str)
  -- local path = "https://172.17.0.1/api/v1/web/guest/default/sentiment?" .. args
  local path = "https://172.17.0.1/api/v1/namespaces/_/actions/sentiment?" .. args
  -- print(path)
  return wrk.format(method, path, headers, body_str)

end

local function html_markdown()
  local args = "blocking=true"
  local method = "POST"
  local headers = {}  
  headers["Authorization"] = "Basic MjNiYzQ2YjEtNzFmNi00ZWQ1LThjNTQtODE2YWE0ZjhjNTAyOjEyM3pPM3haQ0xyTU42djJCS0sxZFhZRnBYbFBrY2NPRnFtMTJDZEFzTWdSVTRWck5aOWx5R1ZDR3VNREdJd1A="
  headers["Content-Type"] = "application/json"

  local body = {}
  body["markdown"] = markdowns[math.random(markdown_num)]
  local body_str = json.encode(body)
  -- local path = "https://172.17.0.1/api/v1/web/guest/default/markdown2html?" .. args
  local path = "https://172.17.0.1/api/v1/namespaces/_/actions/markdown2html?" .. args
  return wrk.format(method, path, headers, body_str)

end


-- autocomplete_pdf  = 0.35
-- sentiment_pdf     = 0.55
-- html_markdown_pdf = 0.85
-- img_resize_pdf    = 0.95
-- ocr_img_pdf       = 1.0
autocomplete_pdf  = 0.25
sentiment_pdf     = 0.5
html_markdown_pdf = 0.75
img_resize_pdf    = 1.0
ocr_img_pdf       = 1.0
-- read:write = 85:15
request = function()
  local coin = math.random()

  if coin < autocomplete_pdf then
    return autocomplete()
  elseif coin < sentiment_pdf then
    return sentiment_analysis()
  elseif coin < html_markdown_pdf then
    return html_markdown()
  elseif coin < img_resize_pdf then
    return img_resize()
  else
    return ocr_img()
  end

  -- return ocr_img()
  -- return autocomplete()
  -- return img_resize()
  -- return sentiment_analysis()
  -- return html_markdown()

  -- if coin <= 0.5 then
  --   return compute_py()
  -- else
  --   return hello_py()
  -- end
end

response = function(status, headers, body)
  t = socket.gettime()*1000 -- ms
  -- local fn = "/yanqi/wrk2/resp_log/" .. tostring(t) .. ".txt"
  -- file = io.open(fn, "w+")
  resp = {}
  resp["status"] = status
  resp["headers"] = headers
  resp["body"] = body
  -- print(json.encode(resp))
  
  -- io.write(json.encode(resp))
  -- io.close(file)
end
