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

--exclude all these links
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/page_bg.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_continue_main.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_continue_right.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_continue_main.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/feed-icon-14x14.png"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_messages.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/big_box.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/628_header_bg_top.jpg"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/620_header_bg_top.jpg"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/628_header_bg_bottom.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/620_header_bg_bottom.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/302_header_bg_top.jpg"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/302_header_bg_bottom.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/429_header_bg_top.jpg"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/429_header_bg_bottom.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/qz_logo_sketchy.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_n_header.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/nav_3state2.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_nav_hover_arrow.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_menu.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_nav_li.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_tabs_li.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_tabs_a.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_bottom_edge_rough.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_big_container_bottom.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/big_box.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/btn_go.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/btn_cancel.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/addimg.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/btn_submit.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_bottom_edge_rough.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_arrow_sort.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_bottom_edge_rough.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_big_container_bottom.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_big_container_top.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_poll_result_bar.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_big_container_bottom.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bigger_box.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_email.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_yim.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_aim.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/btn_tagstyle.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_tags_graph.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_bottom_edge_rough.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_arrow_sort.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_quiz_sm.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_test_sm.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_story_sm.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_poll_sm.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_poem_sm.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_lyrics_sm.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_quiz_locked.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_test_locked.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_story_locked.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_poll_locked.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_poem_locked.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_lyrics_locked.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/delete.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/star.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/starrating.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bigger_box.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_help_question.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_bottom_edge_rough.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/horoscopes/pisces.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/horoscopes/aries.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/horoscopes/taurus.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/horoscopes/gemini.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/horoscopes/cancer.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/horoscopes/leo.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/horoscopes/virgo.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/horoscopes/libra.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/horoscopes/scorpio.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/horoscopes/sagittarius.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/horoscopes/capricorn.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/horoscopes/aquarius.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_bottom_edge_rough.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_closed.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_opened.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_friend_soundwave.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_bottom_edge_rough.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/angel.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/birthday.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/blush.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/brightidea.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/cheerful.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/clown.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/confused.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/cool.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/crying.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/evilgrin.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/excited.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/furious.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/heart.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/hungry.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/indifferent.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/love.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/mad.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/sad.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/scared.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/scaredtodeath.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/shocked.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/sick.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/sleepy.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/spin.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/tongue.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/upset.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/whistling.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/moods/winking.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_bottom_edge_rough.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_closed.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_opened.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_bottom_edge_rough.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/css/indicator.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/username.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/password.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_fp_poll_result_bar280.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_bottom_edge_rough.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/starrating.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_n_header.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/n_logo_header.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/628_header_bg_top.jpg"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/628_header_bg_bottom.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/mb_tab_left.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/mb_tab_right.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/mb_topbar.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/mb_bottombar.png"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/mb_bottombar_ie.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/nick_footer_top.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/nick_footer_bottom.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/icon_footer_bullet.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/footer_divider.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/bg_wrapper.gif"] = true
downloaded["http://quizilla.teennick.com/templates/QZ2/images/dev/macFFBgHack.png"] = true
downloaded["http://cdn.gigya.com/wildfire/js/wfapiv2.js"] = true
downloaded["http://quizilla.teennick.com/static/js/min/events-overlay-deps.js"] = true

wget.callbacks.get_urls = function(file, url, is_css, iri)
  local urls = {}
  
  if item_type == "page" then
    if string.match(url, item_value) then
      if last_http_statcode == 404 or last_http_statcode == 301 then
        if string.match(url, "http://quizilla%.teennick%.com/stories/[0-9]+") then
          local quizurl = string.gsub(url, "/stories/", "/quizzes/")
          if downloaded[quizurl] ~= true then
            table.insert(urls, { url=quizurl })
          end
        elseif string.match(url, "http://quizilla%.teennick%.com/quizzes/[0-9]+") then
          local pollurl = string.gsub(url, "/quizzes/", "/polls/")
          if downloaded[pollurl] ~= true then
            table.insert(urls, { url=pollurl })
          end
        elseif string.match(url, "http://quizilla%.teennick%.com/polls/[0-9]+") then
          local poemurl = string.gsub(url, "/polls/", "/poems/")
          if downloaded[poemurl] ~= true then
            table.insert(urls, { url=poemurl })
          end
        elseif string.match(url, "http://quizilla%.teennick%.com/poems/[0-9]+") then
          local lyricurl = string.gsub(url, "/poems/", "/lyrics/")
          if downloaded[lyricurl] ~= true then
            table.insert(urls, { url=lyricurl })
          end
        end
      elseif last_http_statcode == 200 then
        html = read_file(file)
  --      for adurl in string.gmatch(html, '(/templates/QZ2/ad%.html[^"]+)') do
  --        local baseurl = "http://quizilla.teennick.com"
  --        local fulladurl = baseurl..adurl
  --        if downloaded[fulladurl] ~= true then
  --          table.insert(urls, { url=fulladurl })
  --        end
  --      end
        for customurl in string.gmatch(html, '"(http[s]?://[^"]+)') do
          if string.match(customurl, item_value)
            or string.match(customurl, "/templates/")
            or string.match(customurl, "/media/")
            or string.match(customurl, "/data/")
            or string.match(customurl, "/nick%-assets/")
            or string.match(customurl, "cdn%.gigya%.com")
            or string.match(customurl, "/user_images/")
            or string.match(customurl, "/static/") then
            if downloaded[customurl] ~= true then
              if not string.match(customurl, "teenninck") then
                table.insert(urls, { url=customurl })
              end
              if string.match(customurl, "www%.quizilla%.teennick%.com") then
                local customurlprocessed = string.gsub(customurl, "www%.quizilla%.teennick%.com", "quizilla%.teennick%.com")
                if downloaded[customurlprocessed] ~= true then
                  table.insert(urls, { url=customurlprocessed })
                end
              elseif string.match(customurl, "www%.quizilla%.teenninck%.com") then
                local customurlprocessed = string.gsub(customurl, "www%.quizilla%.teenninck%.com", "quizilla%.teennick%.com")
                if downloaded[customurlprocessed] ~= true then
                  table.insert(urls, { url=customurlprocessed })
                end
              end
            end
          end
        end 
        for customurlnf in string.gmatch(html, '"(/[^"]+)') do
          local baseurl = "http://quizilla.teennick.com"
          local customurl = baseurl..customurlnf
          if string.match(customurl, item_value)
            or string.match(customurl, "/templates/")
          or string.match(customurl, "/media/")
            or string.match(customurl, "/data/")
            or string.match(customurl, "/nick%-assets/")
            or string.match(customurl, "cdn%.gigya%.com")
            or string.match(customurl, "/user_images/")
            or string.match(customurl, "/static/") then
            if downloaded[customurl] ~= true then
              if not string.match(customurl, "teenninck") then
                table.insert(urls, { url=customurl })
              end
            end
          end
        end 
--      for swfurl in string.gmatch(html, '<param name="movie"[^"]+"(http://www%.quizilla%.teennick%.com/[^"]+)"') do
  --        if downloaded[swfurl] ~= true then
  --          table.insert(urls, { url=swfurl })
  --        end
  --      end
  --      for swfurlb in string.gmatch(html, '<embed src="(http://www%.quizilla%.teennick%.com/[^"]+)"') do
  --        if downloaded[swfurlb] ~= true then
  --          table.insert(urls, { url=swfurlb })
  --        end
  --      end
        for pageurl in string.gmatch(html, 'mailto:[^=]+=[^=]+=(http[^"]+)">') do
          local pageurlprocessed = string.gsub(pageurl, "www%.quizilla%.teenninck%.com", "quizilla%.teennick%.com")
          table.insert(urls, { url=pageurlprocessed })
        end
        for pageurl in string.gmatch(html, 'name="quiz_title" value="([^"]+)"') do
          local urlid = string.match(url, "http[s]?://quizilla.teennick.com/[^/]+/([0-9]+)")
          local urlbase = string.match(url, "(http[s]?://quizilla.teennick.com/[^/]+/)")
          local fullpageurl = urlbase..urlid.."/"..pageurl
          if downloaded[fullpageurl] ~= true then
            table.insert(urls, { url=fullpageurl })
          end
        end
        for pageurl in string.gmatch(html, 'name="poll_title" value="([^"]+)"') do
          local urlid = string.match(url, "http[s]?://quizilla.teennick.com/[^/]+/([0-9]+)")
          local urlbase = string.match(url, "(http[s]?://quizilla.teennick.com/[^/]+/)")
          local fullpageurl = urlbase..urlid.."/"..pageurl
          if downloaded[fullpageurl] ~= true then
            table.insert(urls, { url=fullpageurl })
          end
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
            table.insert(urls, { url=(result_base..result_id_plus_1.."/") })
            table.insert(urls, { url=(result_base..result_id_plus_2.."/") })
            table.insert(urls, { url=(result_base..result_id_plus_3.."/") })
            table.insert(urls, { url=(result_base..result_id_plus_4.."/") })
            table.insert(urls, { url=(result_base..result_id_plus_5.."/") })
            table.insert(urls, { url=(result_base..result_id_plus_6.."/") })
            table.insert(urls, { url=(result_base..result_id_plus_7.."/") })
            table.insert(urls, { url=(result_base..result_id_plus_8.."/") })
            table.insert(urls, { url=(result_base..result_id_plus_9.."/") })
            table.insert(urls, { url=(result_base..result_id_plus_10.."/") })
            table.insert(urls, { url=(result_base..result_id_minus_1.."/") })
            table.insert(urls, { url=(result_base..result_id_minus_2.."/") })
            table.insert(urls, { url=(result_base..result_id_minus_3.."/") })
            table.insert(urls, { url=(result_base..result_id_minus_4.."/") })
            table.insert(urls, { url=(result_base..result_id_minus_5.."/") })
            table.insert(urls, { url=(result_base..result_id_minus_6.."/") })
            table.insert(urls, { url=(result_base..result_id_minus_7.."/") })
            table.insert(urls, { url=(result_base..result_id_minus_8.."/") })
            table.insert(urls, { url=(result_base..result_id_minus_9.."/") })
            table.insert(urls, { url=(result_base..result_id_minus_10.."/") })
            results[quiz_id] = true
          end
        end
      end
    end
  elseif item_type == "user" then
    if string.match(url, item_value) then
      html = read_file(file)
      for adurl in string.gmatch(html, '(/templates/QZ2/ad%.html[^"]+)') do
        local baseurl = "http://quizilla.teennick.com"
        local fulladurl = baseurl..adurl
        if downloaded[fulladurl] ~= true then
          table.insert(urls, { url=fulladurl })
        end
      end
      for userurl in string.gmatch(html, '"(http[s]?://[^"]+)') do
        if string.match(userurl, "/user/"..item_value)
          or string.match(userurl, "/templates/")
          or string.match(userurl, "/media/")
          or string.match(userurl, "/data/")
          or string.match(userurl, "/nick%-assets/")
          or string.match(userurl, "cdn%.gigya%.com")
          or string.match(userurl, "/user_images/")
          or string.match(userurl, "/static/") then
          if downloaded[userurl] ~= true then
            table.insert(urls, { url=userurl })
          end
        end
      end
      for userurl2 in string.gmatch(html, '"(/[^"]+)') do
        local baseurl = "http://quizilla.teennick.com"
        local fulluserurl2 = baseurl..userurl2
        if string.match(fulluserurl2, "/user/"..item_value) 
          or string.match(fulluserurl2, "/templates/")
          or string.match(fulluserurl2, "/media/")
          or string.match(fulluserurl2, "/data/")
          or string.match(fulluserurl2, "/nick%-assets/")
          or string.match(fulluserurl2, "cdn%.gigya%.com")
          or string.match(fulluserurl2, "/user_images/")
          or string.match(fulluserurl2, "/static/") then
          if downloaded[fulluserurl2] ~= true then
            table.insert(urls, { url=fulluserurl2 })
          end
        end
      end
    end
  elseif item_type == "tag" then
    if string.match(url, item_value) then
      html = read_file(file)
      for adurl in string.gmatch(html, '(/templates/QZ2/ad%.html[^"]+)') do
        local baseurl = "http://quizilla.teennick.com"
        local fulladurl = baseurl..adurl
        if downloaded[fulladurl] ~= true then
          table.insert(urls, { url=fulladurl })
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
  
  if string.match(url, "teenninck") then
    return false
  end
  
  if string.match(url, "http://quizilla%.teennick%.com/static/js/min/events%-overlay%-deps%.js") then
    return false
  end
  
  if item_type == "page" then
    if string.match(url, item_value) then
      return true
    elseif string.match(url, "/templates/")
      or string.match(url, "/media/")
      or string.match(url, "/data/")
      or string.match(url, "/nick%-assets/")
      or string.match(url, "cdn%.gigya%.com")
      or string.match(url, "/user_images/")
      or string.match(url, "/static/") then
      return true
    else
      return false
    end
  elseif item_type == "user" then
    if string.match(url, "/"..item_value) then
      return true
    elseif string.match(url, "/templates/")
      or string.match(url, "/media/")
      or string.match(url, "/data/")
      or string.match(url, "/nick%-assets/")
      or string.match(url, "cdn%.gigya%.com")
      or string.match(url, "/user_images/")
      or string.match(url, "/static/") then
      return true
    else
      return false
    end
  elseif item_type == "tag" then
    if string.match(url, "/tags/"..item_value) then
      return true
    elseif string.match(url, "/templates/")
      or string.match(url, "/media/")
      or string.match(url, "/data/")
      or string.match(url, "/nick%-assets/")
      or string.match(url, "cdn%.gigya%.com")
      or string.match(url, "/user_images/")
      or string.match(url, "/static/") then
      return true
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
  
  last_http_statcode = status_code
  
  if status_code >= 500 or
    (status_code >= 400 and status_code ~= 404) then
    if string.match(url["host"], "teennick%.com") then
      
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
  elseif status_code == 301 and string.match(url["url"], "polls") then
    return wget.actions.EXIT
  end

  tries = 0

  -- We're okay; sleep a bit (if we have to) and continue
  local sleep_time = 0.1 * (math.random(1000, 2000) / 100.0)
  -- local sleep_time = 0

  --  if string.match(url["host"], "cdn") or string.match(url["host"], "media") then
  --    -- We should be able to go fast on images since that's what a web browser does
  --    sleep_time = 0
  --  end

  if sleep_time > 0.001 then
    os.execute("sleep " .. sleep_time)
  end

  return wget.actions.NOTHING
end
