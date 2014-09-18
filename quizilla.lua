local url_count = 0
local tries = 0
local item_type = os.getenv('item_type')
local item_value = os.getenv('item_value')
dofile("urlcode.lua")
dofile("table_show.lua")
JSON = (loadfile "JSON.lua")()

load_json_file = function(file)
  if file then
    local f = io.open(file)
    local data = f:read("*all")
    f:close()
    return JSON:decode(data)
  else
    return nil
  end
end

read_file = function(file)
  if file then
    local f = assert(io.open(file))
    local data = f:read("*all")
    f:close()
    return data
  else
    return ""
  end
end

local downloaded = {}
local post_requests = {}
local results = {}

wget.callbacks.get_urls = function(file, url, is_css, iri)
  local urls = {}
  
  if item_type == "page" then
    if string.match(url, item_value) then
      html = read_file(file)
      for adurl in string.gmatch(html, '(/templates/QZ2/ad%.html[^"]+)') do
        local baseurl = "http://quizilla.teennick.com"
        local fulladurl = baseurl..adurl
        if downloaded[fulladurl] ~= true then
          table.insert(urls, { url=fulladurl })
        end
      end
      for swfurl in string.gmatch(html, '<param name="movie"[^"]+"(http://www%.quizilla%.teennick%.com/[^"]+)"') do
        if downloaded[swfurl] ~= true then
          table.insert(urls, { url=swfurl })
        end
      end
      for swfurlb in string.gmatch(html, '<embed src="(http://www%.quizilla%.teennick%.com/[^"]+)"') do
        if downloaded[swfurlb] ~= true then
          table.insert(urls, { url=swfurlb })
        end
      end
      for pageurl in string.gmatch(html, '<p class="sharelink">[^h]+(http://[^/]+/[^/]+/[0-9]+/[^  ]+)</p>') do
        local pageurlprocessed = string.gsub(pageurl, "www%.quizilla%.teenninck%.com", "quizilla%.teennick%.com")
        table.insert(urls, { url=pageurlprocessed })
      end
      if (string.match(url, "/quizzes/") and status_code_global == 200) then
        local urlid = string.match(url, "http://[^/]+/[^/]+/([0-9]+)")
        if string.match(html, '<input id="a_[0-9]+" type="[^"]+" name="answers%[[0-9]+%]" value="[0-9]+" />') then
          local input_id = string.match(html, '<input id="a_[0-9]+" type="[^"]+" name="answers%[[0-9]+%]" value="([0-9]+)" />')
          local input_id_name = string.match(html, '<input id="a_[0-9]+" type="[^"]+" name="(answers%[[0-9]+%])" value="[0-9]+" />')
          local quiz_id = string.match(html, 'name="quiz_id" value="([0-9]+)">')
          local quiz_title = string.match(html, 'name="quiz_title" value="([^"]+)">')
          if post_requests[quiz_id] ~= true then
            table.insert(urls, { url="http://quizilla.teennick.com/quizzes?task=submit",
                                 post_data=(string.gsub(string.gsub(input_id_name, "%[", "%%5B"), "%]", "%%5D").."="..input_id.."&quiz_id="..quiz_id.."&quiz_title="..quiz_title) })
            post_requests[quiz_id] = true
          end
        end
      end
      if string.match(url, "http://[^/]+/quizzes/result/[0-9]+/[0-9]+") then
        local result_id = string.match(url, "http://[^/]+/quizzes/result/[0-9]+/([0-9]+)")
        local result_base = string.match(url, "(http://[^/]+/quizzes/result/[0-9]+/)[0-9]+")
        local quiz_id = string.match(url, "http://[^/]+/quizzes/result/([0-9]+)/[0-9]+")
        if results[quiz_id] ~= true then
          local result_id_plus_1 = result_id + 1
          local result_id_plus_2 = result_id + 2
          local result_id_plus_3 = result_id + 3
          local result_id_plus_4 = result_id + 4
          local result_id_plus_5 = result_id + 5
          local result_id_plus_6 = result_id + 6
          local result_id_plus_7 = result_id + 7
          local result_id_plus_8 = result_id + 8
          local result_id_plus_9 = result_id + 9
          local result_id_plus_10 = result_id + 10
          local result_id_minus_1 = result_id - 1
          local result_id_minus_2 = result_id - 2
          local result_id_minus_3 = result_id - 3
          local result_id_minus_4 = result_id - 4
          local result_id_minus_5 = result_id - 5
          local result_id_minus_6 = result_id - 6
          local result_id_minus_7 = result_id - 7
          local result_id_minus_8 = result_id - 8
          local result_id_minus_9 = result_id - 9
          local result_id_minus_10 = result_id - 10
          table.insert(urls, { url=(result_base..result_id_plus_1) })
          table.insert(urls, { url=(result_base..result_id_plus_2) })
          table.insert(urls, { url=(result_base..result_id_plus_3) })
          table.insert(urls, { url=(result_base..result_id_plus_4) })
          table.insert(urls, { url=(result_base..result_id_plus_5) })
          table.insert(urls, { url=(result_base..result_id_plus_6) })
          table.insert(urls, { url=(result_base..result_id_plus_7) })
          table.insert(urls, { url=(result_base..result_id_plus_8) })
          table.insert(urls, { url=(result_base..result_id_plus_9) })
          table.insert(urls, { url=(result_base..result_id_plus_10) })
          table.insert(urls, { url=(result_base..result_id_minus_1) })
          table.insert(urls, { url=(result_base..result_id_minus_2) })
          table.insert(urls, { url=(result_base..result_id_minus_3) })
          table.insert(urls, { url=(result_base..result_id_minus_4) })
          table.insert(urls, { url=(result_base..result_id_minus_5) })
          table.insert(urls, { url=(result_base..result_id_minus_6) })
          table.insert(urls, { url=(result_base..result_id_minus_7) })
          table.insert(urls, { url=(result_base..result_id_minus_8) })
          table.insert(urls, { url=(result_base..result_id_minus_9) })
          table.insert(urls, { url=(result_base..result_id_minus_10) })
          results[quiz_id] = true
        end
      end
    end
  end
  
  return urls
end

wget.callbacks.download_child_p = function(urlpos, parent, depth, start_url_parsed, iri, verdict, reason)
  local url = urlpos["url"]["url"]
  local ishtml = urlpos["link_expect_html"]
  local parenturl = parent["url"]
  local wgetreason = reason

  if downloaded[url] == true then
    return false
  end
  
  if item_type == "page" then
    if string.match(url, item_value) then
      return true
    elseif string.match(url, "/templates/")
      or string.match(url, "/media/")
      or string.match(url, "cdn%.gigya%.com")
      or string.match(url, "/static/") then
      return true
    elseif string.match(url, "/tags/") then
      if string.match(parenturl, item_value) then
        return true
      else
        return false
      end
    elseif string.match(url, "/user/") then
      if string.match(url, story_creator) then
        return true
      end
    else
      return false
    end
  else
    return false
  end
  
end

wget.callbacks.httploop_result = function(url, err, http_stat)
  -- NEW for 2014: Slightly more verbose messages because people keep
  -- complaining that it's not moving or not working
  local status_code = http_stat["statcode"]
  status_code_global = status_code
  
  url_count = url_count + 1
  io.stdout:write(url_count .. "=" .. status_code .. " " .. url["url"] .. ".  \n")
  io.stdout:flush()

  if status_code >= 200 and status_code <= 399 then
    downloaded[url.url] = true
  end
  
  -- consider 403 as banned from twitpic, not pernament failure
  if status_code >= 500 or
    (status_code >= 400 and status_code ~= 404) or
    (status_code == 403 and string.match(url["host"], "twitpic%.com")) then
    if string.match(url["host"], "twitpic%.com") or
      string.match(url["host"], "cloudfront%.net") or
      string.match(url["host"], "twimg%.com") or
      string.match(url["host"], "amazonaws%.com") then
      
      io.stdout:write("\nServer returned "..http_stat.statcode.." for " .. url["url"] .. ". Sleeping.\n")
      io.stdout:flush()
      
      os.execute("sleep 10")
      
      tries = tries + 1
      
      if tries >= 5 then
        return wget.actions.ABORT
      else
        return wget.actions.CONTINUE
      end
    else
      io.stdout:write("\nServer returned "..http_stat.statcode.." for " .. url["url"] .. ". Sleeping.\n")
      io.stdout:flush()
      
      os.execute("sleep 10")
      
      tries = tries + 1
      
      if tries >= 5 then
        return wget.actions.NOTHING
      else
        return wget.actions.CONTINUE
      end
    end
  elseif status_code == 0 then
    io.stdout:write("\nServer returned "..http_stat.statcode.." for " .. url["url"] .. ". Sleeping.\n")
    io.stdout:flush()
    
    os.execute("sleep 10")
    
    tries = tries + 1
    
    if tries >= 5 then
      return wget.actions.ABORT
    else
      return wget.actions.CONTINUE
    end
  end

  tries = 0

  -- We're okay; sleep a bit (if we have to) and continue
  -- local sleep_time = 0.1 * (math.random(1000, 2000) / 100.0)
  local sleep_time = 0

  --  if string.match(url["host"], "cdn") or string.match(url["host"], "media") then
  --    -- We should be able to go fast on images since that's what a web browser does
  --    sleep_time = 0
  --  end

  if sleep_time > 0.001 then
    os.execute("sleep " .. sleep_time)
  end

  return wget.actions.NOTHING
end
