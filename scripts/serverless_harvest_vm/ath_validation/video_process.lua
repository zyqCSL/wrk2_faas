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
    -- ocr_img_jpg[i] = mime."b64(temp)
    ocr_img_jpg[i] = f:read("*all")
    f:close()
    -- print(ocr_img_dir .. tostring(i) .. ".jpg cached")
  else
    -- print(ocr_img_dir .. tostring(i) .. ".jpg doesn't exist")
  end
end 

for i = 1, ocr_img_png_num do 
  f = io.open(ocr_img_dir .. tostring(i) .. ".png", "rb")
  if f then 
    -- local temp = f:read("*all")
    -- ocr_img_png[i] = mime."b64(temp)
    ocr_img_png[i] = f:read("*all")
    f:close()
    -- print(ocr_img_dir .. tostring(i) .. ".png cached")
  else
    -- print(ocr_img_dir .. tostring(i) .. ".png doesn't exist")
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
    -- img_resize_jpg[i] = mime."b64(temp)
    img_resize_jpg[i] = f:read("*all")
    f:close()
    -- print(img_resize_dir .. tostring(i) .. ".jpg cached")
  else
    -- print(img_resize_dir .. tostring(i) .. ".jpg doesn't exist")
  end
end 

for i = 1, img_resize_png_num do 
  f = io.open(img_resize_dir .. tostring(i) .. ".png", "rb")
  if f then
    -- local temp = f:read("*all")
    -- img_resize_png[i] = mime."b64(temp)
    img_resize_png[i] = f:read("*all")
    f:close()
    -- print(img_resize_dir .. tostring(i) .. ".png cached")
  else
    -- print(img_resize_dir .. tostring(i) .. ".png doesn't exist")
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
    -- print(sentiment_dir .. tostring(i)  .. ".txt doesn't exist")
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
    -- print(markdown_dir .. tostring(i) .. ".txt doesn't exist")
  end
end

------ image-process ---------
image_process_dir = wrk2_path .. "/scripts/serverless_harvest_vm/faas_data/image_process_base64/"
image_names = {
  "b64_austrilia.jpg",  "b64_dubai.jpg",    "b64_halloween.jpg",  "b64_og.jpg.png",   "b64_raptor.jpg",      "b64_tiger.jpg",
  "b64_building.jpg",   "b64_earth.jpg",    "b64_island.jpg",     "b64_oldarch.jpg",  "b64_rome.jpg",        "b64_tomcat2.jpg",
  "b64_Chthon.jpg",     "b64_f35a.jpg",     "b64_j20.jpg",        "b64_puffin.jpg",   "b64_star-wars.jpg",   "b64_tomcat3.jpg",
  "b64_Darvasa.jpg",    "b64_gundam2.jpg",  "b64_Nature.jpeg",    "b64_rafale.jpg",   "b64_Stonehenge.jpg",  "b64_tomcat.jpg",
  "b64_dog.jpg",        "b64_gundam3.jpg",  "b64_nature.jpg",     "b64_raptor2.jpg",  "b64_stones.jpg",      "b64_water.jpg",
  "b64_drone.png",      "b64_gundam.jpg",   "b64_news141.jpg",    "b64_raptor3.jpg",  "b64_sunflower.jpg",   "b64_wave.jpg"}
image_data = {}
image_data_num = 36

for i = 1, image_data_num do
  image_name = image_names[i] 
  f = io.open(image_process_dir .. image_name, "r")
  if f then
    image_data[image_name] = f:read("*all")
    f:close()
    -- print(markdown_dir .. tostring(i) .. ".txt cached")
  else
    -- print(markdown_dir .. tostring(i) .. ".txt doesn't exist")
  end
end

------ video-process ---------
video_process_dir = wrk2_path .. "/scripts/serverless_harvest_vm/faas_data/video_process_base64/"
video_names = {
  "b64_360.avi",  "b64_bird.avi",             "b64_dolbycanyon.avi",  "b64_grb_2.avi",        "b64_small.avi",
  "b64_640.avi",  "b64_cbw3.avi",             "b64_drop.avi",         "b64_lion-sample.avi",  "b64_star_trails.avi",
  "b64_720.avi",  "b64_DLP_PART_2_768k.avi",  "b64_flame.avi",        "b64_P6090053.avi",     "b64_video-sample.avi"}
video_data = {}
video_data_num = 15

for i = 1, video_data_num do
  video_name = video_names[i] 
  f = io.open(video_process_dir .. video_name, "r")
  if f then
    video_data[video_name] = f:read("*all")
    f:close()
    -- print(markdown_dir .. tostring(i) .. ".txt cached")
  else
    -- print(markdown_dir .. tostring(i) .. ".txt doesn't exist")
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

local function autocomplete()
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

  local path = "https://172.17.0.1/api/v1/web/guest/default/img-resize?" .. args
  -- below only works with json inputs
  -- local path = "https://172.17.0.1/api/v1/namespaces/_/actions/img-resize?" .. args

  -- print("before return in ocr_img")
  
  return wrk.format(method, path, headers, body)
end


-- local function markdown_to_html()
-- end

local function ocr_img()
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

  local path = "https://172.17.0.1/api/v1/web/guest/default/ocr-img?" .. args
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

local function chameleon()
  -- print("in chameleon")

  -- curl -X POST -H "Content-Type: image/jpeg" --data-binary @./pitontable.jpg 
  -- https://172.17.0.1/api/v1/web/guest/default/ocr-img -k -v >output.txt
  local args = "blocking=true"
  local method = "POST"
  local headers = {}  
  headers["Authorization"] = "Basic MjNiYzQ2YjEtNzFmNi00ZWQ1LThjNTQtODE2YWE0ZjhjNTAyOjEyM3pPM3haQ0xyTU42djJCS0sxZFhZRnBYbFBrY2NPRnFtMTJDZEFzTWdSVTRWck5aOWx5R1ZDR3VNREdJd1A="
  headers["Content-Type"] = "application/json"
  local body = {}
  body["rows"] = tostring(math.random(200, 1000))
  body["cols"] = tostring(math.random(200, 1000))
  local body_str = json.encode(body)
  -- print(body_str)
  local path = "https://172.17.0.1/api/v1/namespaces/_/actions/chameleon?" .. args
  -- below only works with json inputs
  -- local path = "https://172.17.0.1/api/v1/namespaces/_/actions/ocr-img?" .. args

  -- print("before return in chameleon")
  -- print(wrk.format(method, path, headers, body_str))
  return wrk.format(method, path, headers, body_str)

end

local function float_operation()
  -- print("in ocr_img")

  -- curl -X POST -H "Content-Type: image/jpeg" --data-binary @./pitontable.jpg 
  -- https://172.17.0.1/api/v1/web/guest/default/ocr-img -k -v >output.txt
  local args = "blocking=true"
  local method = "POST"
  local headers = {}  
  headers["Authorization"] = "Basic MjNiYzQ2YjEtNzFmNi00ZWQ1LThjNTQtODE2YWE0ZjhjNTAyOjEyM3pPM3haQ0xyTU42djJCS0sxZFhZRnBYbFBrY2NPRnFtMTJDZEFzTWdSVTRWck5aOWx5R1ZDR3VNREdJd1A="
  headers["Content-Type"] = "application/json"

  local body = {}
  body["N"] = math.random(500000, 5000000)
  local body_str = json.encode(body)
  local path = "https://172.17.0.1/api/v1/namespaces/_/actions/float_op?" .. args
  -- below only works with json inputs
  -- local path = "https://172.17.0.1/api/v1/namespaces/_/actions/ocr-img?" .. args

  -- print("before return in ocr_img")
  return wrk.format(method, path, headers, body_str)

end

function linpack()
  -- print("in ocr_img")
  -- curl -X POST -H "Content-Type: image/jpeg" --data-binary @./pitontable.jpg 
  -- https://172.17.0.1/api/v1/web/guest/default/ocr-img -k -v >output.txt
  local args = "blocking=true"
  local method = "POST"
  local headers = {}  
  headers["Authorization"] = "Basic MjNiYzQ2YjEtNzFmNi00ZWQ1LThjNTQtODE2YWE0ZjhjNTAyOjEyM3pPM3haQ0xyTU42djJCS0sxZFhZRnBYbFBrY2NPRnFtMTJDZEFzTWdSVTRWck5aOWx5R1ZDR3VNREdJd1A="
  headers["Content-Type"] = "application/json"

  local body = {}
  body["N"] = math.random(10, 500)
  local body_str = json.encode(body)
  local path = "https://172.17.0.1/api/v1/namespaces/_/actions/linpack?" .. args
  -- below only works with json inputs
  -- local path = "https://172.17.0.1/api/v1/namespaces/_/actions/ocr-img?" .. args

  -- print("before return in ocr_img")
  return wrk.format(method, path, headers, body_str)
end

function matmult()
  -- print("in ocr_img")
  -- curl -X POST -H "Content-Type: image/jpeg" --data-binary @./pitontable.jpg 
  -- https://172.17.0.1/api/v1/web/guest/default/ocr-img -k -v >output.txt
  local args = "blocking=true"
  local method = "POST"
  local headers = {}  
  headers["Authorization"] = "Basic MjNiYzQ2YjEtNzFmNi00ZWQ1LThjNTQtODE2YWE0ZjhjNTAyOjEyM3pPM3haQ0xyTU42djJCS0sxZFhZRnBYbFBrY2NPRnFtMTJDZEFzTWdSVTRWck5aOWx5R1ZDR3VNREdJd1A="
  headers["Content-Type"] = "application/json"

  local body = {}
  body["N"] = math.random(1000, 4000)
  local body_str = json.encode(body)
  local path = "https://172.17.0.1/api/v1/namespaces/_/actions/matmult?" .. args
  -- below only works with json inputs
  -- local path = "https://172.17.0.1/api/v1/namespaces/_/actions/ocr-img?" .. args

  -- print("before return in ocr_img")
  return wrk.format(method, path, headers, body_str)
end

function pyaes()
  -- print("in ocr_img")
  -- curl -X POST -H "Content-Type: image/jpeg" --data-binary @./pitontable.jpg 
  -- https://172.17.0.1/api/v1/web/guest/default/ocr-img -k -v >output.txt
  local args = "blocking=true"
  local method = "POST"
  local headers = {}  
  headers["Authorization"] = "Basic MjNiYzQ2YjEtNzFmNi00ZWQ1LThjNTQtODE2YWE0ZjhjNTAyOjEyM3pPM3haQ0xyTU42djJCS0sxZFhZRnBYbFBrY2NPRnFtMTJDZEFzTWdSVTRWck5aOWx5R1ZDR3VNREdJd1A="
  headers["Content-Type"] = "application/json"

  local body = {}
  body["length"] = math.random(100, 1000)
  body["iteration"] = math.random(50, 500)
  local body_str = json.encode(body)
  local path = "https://172.17.0.1/api/v1/namespaces/_/actions/pyaes?" .. args
  -- below only works with json inputs
  -- local path = "https://172.17.0.1/api/v1/namespaces/_/actions/ocr-img?" .. args

  -- print("before return in ocr_img")
  return wrk.format(method, path, headers, body_str)
end


function image_process()
  -- print("in ocr_img")

  -- curl -X POST -H "Content-Type: image/jpeg" --data-binary @./pitontable.jpg 
  -- https://172.17.0.1/api/v1/web/guest/default/ocr-img -k -v >output.txt
  local args = "blocking=true"
  local method = "POST"
  local headers = {}  
  headers["Authorization"] = "Basic MjNiYzQ2YjEtNzFmNi00ZWQ1LThjNTQtODE2YWE0ZjhjNTAyOjEyM3pPM3haQ0xyTU42djJCS0sxZFhZRnBYbFBrY2NPRnFtMTJDZEFzTWdSVTRWck5aOWx5R1ZDR3VNREdJd1A="
  headers["Content-Type"] = "application/json"

  local body = {}
  local image_name = image_names[math.random(image_data_num)]
  body["image"] = image_data[image_name]
  local body_str = json.encode(body)
  local path = "https://172.17.0.1/api/v1/namespaces/_/actions/image_process?" .. args
  -- below only works with json inputs
  -- local path = "https://172.17.0.1/api/v1/namespaces/_/actions/ocr-img?" .. args

  -- print("before return in ocr_img")
  return wrk.format(method, path, headers, body_str)

end

function video_process()
  -- print("in ocr_img")

  -- curl -X POST -H "Content-Type: image/jpeg" --data-binary @./pitontable.jpg 
  -- https://172.17.0.1/api/v1/web/guest/default/ocr-img -k -v >output.txt
  local args = "blocking=true"
  local method = "POST"
  local headers = {}  
  headers["Authorization"] = "Basic MjNiYzQ2YjEtNzFmNi00ZWQ1LThjNTQtODE2YWE0ZjhjNTAyOjEyM3pPM3haQ0xyTU42djJCS0sxZFhZRnBYbFBrY2NPRnFtMTJDZEFzTWdSVTRWck5aOWx5R1ZDR3VNREdJd1A="
  headers["Content-Type"] = "application/json"

  local body = {}
  local video_name = video_names[math.random(video_data_num)]
  body["video"] = video_data[video_name]
  body["video_name"] = video_name
  local body_str = json.encode(body)
  local path = "https://172.17.0.1/api/v1/namespaces/_/actions/video_process?" .. args
  -- below only works with json inputs
  -- local path = "https://172.17.0.1/api/v1/namespaces/_/actions/ocr-img?" .. args

  -- print("before return in ocr_img")
  
  return wrk.format(method, path, headers, body_str)

end


autocomplete_pdf  = 0.0
sentiment_pdf     = 0.0
html_markdown_pdf = 0.0
img_resize_pdf    = 0.0
ocr_img_pdf       = 0.0
chameleon_pdf     = 0.0
float_operation_pdf = 0.0
linpack_pdf = 0.0
matmult_pdf = 0.0
pyaes_pdf = 0.0
image_process_pdf = 0.0
video_process_pdf = 1.0


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

  elseif coin < ocr_img_pdf then
    return ocr_img()

  elseif coin < chameleon_pdf then
    return chameleon()

  elseif coin < float_operation_pdf then
    return float_operation()

  elseif coin < linpack_pdf then
    return linpack()

  elseif coin < matmult_pdf then
    return matmult()

  elseif coin < pyaes_pdf then
    return pyaes()

  elseif coin < image_process_pdf then
    return image_process()

  elseif coin < video_process_pdf then
    return video_process()
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
