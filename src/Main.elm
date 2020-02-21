module Main exposing (main)

import Array
import Browser
import Dict
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Html
import Html.Attributes
import Html.Parser
import LineChart exposing (..)
import LineChart.Area
import LineChart.Axis
import LineChart.Axis.Intersection
import LineChart.Axis.Line
import LineChart.Axis.Range
import LineChart.Axis.Tick
import LineChart.Axis.Ticks
import LineChart.Axis.Title
import LineChart.Colors
import LineChart.Container
import LineChart.Dots
import LineChart.Events
import LineChart.Grid
import LineChart.Interpolation
import LineChart.Junk
import LineChart.Legends
import LineChart.Line


dataMhlwAsString : String
dataMhlwAsString =
    """１, １, 1/15, 30代, 男, 神奈川県, なし, 38名特定 健康観察終了
２, ２, 1/24, 40代, 男, 中国 （武漢市）, なし, 32名特定 健康観察終了
３, ３, 1/25, 30代, 女, 中国 （武漢市）, なし, ７名特定 健康観察終了
４, ４, 1/26, 40代, 男, 中国 （武漢市）, No.19, ２名特定 健康観察終了
５, ５, 1/28, 40代, 男, 中国 （武漢市）, なし, ３名特定 健康観察終了
６, ６, 1/28, 60代, 男, 奈良県, No.８ No.13, 22名特定 健康観察終了
７, ７, 1/28, 40代, 女, 中国 （武漢市）, なし, ２名特定 健康観察終了
８, ８, 1/29, 40代, 女, 大阪府, No.６, ２名特定 健康観察終了
９, 10, 1/30, 50代, 男, 三重県, なし, ３名特定 健康観察終了
10, 11, 1/30, 30代, 女, 中国 （湖南省）, なし, ４名特定 健康観察終了
11, 12, 1/30, 20代, 女, 京都府, なし, なし
12, 13, 1/31, 20代, 女, 千葉県, No.６, １名特定 健康観察終了
13, 17, 2/4, 30代, 女, 中国 （武漢市）, No.20, ６名特定 健康観察実施中
14, 19, 2/4, 50代, 男, 中国 （湖北省）, No.４, 調査中
15, 20, 2/5, 40代, 男, 中国 （武漢市）, No.17, ６名特定 健康観察実施中
16, 21, 2/5, 20代, 男, 京都府, 調査中, １名特定 健康観察実施中
17, 26, 2/11, 50代, 男, 神奈川県, 調査中, 調査中
18, 27, 2/13, 80代, 女, 神奈川県, No.28 No.48, 調査中, Old women mother of taxi driver
19, 28, 2/13, 70代, 男, 東京都, 調査中, 調査中, taxi driver?
20, 29, 2/13, 50代, 男, 和歌山県, No.31, 調査中
21, 30, 2/13, 20代, 男, 千葉県, 調査中, 調査中
22, 31, 2/14, 70代, 男, 和歌山, No.29, 調査中
23, 32, 2/14, 60代, 女, 沖縄県, 調査中, 調査中
24, 33, 2/14, 50代, 女, 東京都, No.28, 調査中
25, 34, 2/14, 70代, 男, 東京都, No.28, 調査中
26, 35, 2/14, 60代, 男, 愛知県, 調査中, ３名特定 健康観察実施中
27, 36, 2/14, 50代, 男, 北海道, 調査中, ４５名特定 健康観察実施中
28, 37, 2/14, 30代, 男, 神奈川県, 調査中, 調査中
29, 38, 2/15, 50代, 男, 和歌山県, No.29, 調査中
30, 39, 2/15, 50代, 女, 和歌山県, No.29, 調査中
31, 40, 2/15, 60代, 男, 和歌山県, No.29 No.50 No.51, 調査中
32, 41, 2/15, 40代, 男, 東京都, No.45, 調査中
33, 42, 2/15, 60代, 女, 東京都, No.28, 調査中
34, 43, 2/15, 60代, 女, 愛知県, No.35 No.44, 調査中
35, 44, 2/16, 60代, 男, 愛知県, No.43 No.53 No.59, 調査中
36, 45, 2/16, 30代, 男, 東京都, No.41, 調査中
37, 46, 2/16, 60代, 男, 調査中, 調査中, 調査中
38, 47, 2/16, 60代, 男, 調査中, No.28, 調査中
39, 48, 2/17, 40代, 女, 神奈川, No.27, 調査中
40, 49, 2/17, 50代, 男, 東京都, 調査中, 調査中
41, 50, 2/17, 80代, 女, 和歌山県, No.40, 調査中
42, 51, 2/17, 50代, 男, 和歌山県, No.40, 調査中
43, 52, 2/17, 50代, 男, 和歌山県, 調査中, 調査中
44, 53, 2/17, 60代, 男, 愛知県, No.44 No.59, 調査中
45, 54, 2/18, 60代, 男, 和歌山県, No.22, 調査中
46, 55, 2/18, 30代, 男, 和歌山県, 調査中, 調査中
47, 56, 2/18, 80代, 男, 東京都, 調査中, 調査中
48, 57, 2/18, 20代, 男, 東京都, 調査中, 調査中
49, 58, 2/18, 50代, 男, 東京都, 調査中, 調査中
50, 59, 2/18, 60代, 男, 愛知県, No.44 No.53, 調査中"""


type alias RowMhlw =
    { age : Int
    , closeContactsituation : CloseContactSituation
    , date : Date
    , gender : Gender
    , location : Location
    , new : Int
    , old : Int
    , surroundingPatients : SurroundingPatients
    }


dataMhlw : List RowMhlw
dataMhlw =
    process dataMhlwAsString


type alias RowBno =
    { cases : Int
    , comment : String
    , date : Date
    , time : { hours : Int, minutes : Int }
    , url : String
    }


dataBno : List RowBno
dataBno =
    -- February 22
    [ { cases = 4, date = { month = 2, day = 22 }, time = { hours = 14, minutes = 10 }, comment = "4 new cases in Aichi Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200222/k10012297571000.html" }
    , { cases = 1, date = { month = 2, day = 22 }, time = { hours = 14, minutes = 0 }, comment = "1 new case in Tokyo, Japan", url = "https://www3.nhk.or.jp/news/html/20200222/k10012297481000.html" }
    , { cases = 1, date = { month = 2, day = 22 }, time = { hours = 13, minutes = 30 }, comment = "1 new case in Chiba Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200222/k10012297461000.html" }
    , { cases = 1, date = { month = 2, day = 22 }, time = { hours = 13, minutes = 10 }, comment = "1 new case in Tochigi Prefecture, Japan. The patient is a former passenger of the “Diamond Princess” cruise ship", url = "https://www3.nhk.or.jp/news/html/20200222/k10012297561000.html" }
    , { cases = 4, date = { month = 2, day = 22 }, time = { hours = 13, minutes = 5 }, comment = "4 new cases in Kanagawa Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200222/k10012297531000.html" }
    , { cases = 1, date = { month = 2, day = 22 }, time = { hours = 12, minutes = 47 }, comment = "1 new case in Ishikawa Prefecture, Japan", url = "https://news.tv-asahi.co.jp/news_society/articles/000176998.html" }
    , { cases = 9, date = { month = 2, day = 22 }, time = { hours = 11, minutes = 30 }, comment = "9 new cases in Hokkaido Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200222/k10012297291000.html" }
    , { cases = 1, date = { month = 2, day = 22 }, time = { hours = 7, minutes = 59 }, comment = "1 new case in Wakayama Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200222/k10012297331000.html?utm_int=all_side_ranking-social_005" }
    , { cases = 1, date = { month = 2, day = 22 }, time = { hours = 4, minutes = 30 }, comment = "1 new case in Chiba Prefecture, Japan. The other case mentioned in the article was previously reported", url = "https://www3.nhk.or.jp/shutoken-news/20200222/1000044458.html" }
    , { cases = 1, date = { month = 2, day = 22 }, time = { hours = 3, minutes = 0 }, comment = "1 new case in Chiba Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200222/k10012297181000.html" }

    -- February 21
    , { cases = 1, date = { month = 2, day = 21 }, time = { hours = 23, minutes = 52 }, comment = "1 new case in Kumamoto Prefecture, Japan", url = "https://this.kiji.is/603727373012026465" }
    , { cases = 1, date = { month = 2, day = 21 }, time = { hours = 19, minutes = 50 }, comment = "1 new case in Kumamoto Prefecture, Japan. The other case mentioned in the article was previously reported", url = "https://www3.nhk.or.jp/news/html/20200221/k10012296691000.html" }
    , { cases = 1, date = { month = 2, day = 21 }, time = { hours = 13, minutes = 30 }, comment = "1 new case in Kumamoto Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200221/k10012296691000.html" }
    , { cases = 2, date = { month = 2, day = 21 }, time = { hours = 12, minutes = 44 }, comment = "2 new cases in Aichi Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200221/k10012296561000.html" }
    , { cases = 3, date = { month = 2, day = 21 }, time = { hours = 11, minutes = 45 }, comment = "3 new cases in Tokyo, Japan", url = "https://www3.nhk.or.jp/news/html/20200221/k10012296311000.html" }
    , { cases = 1, date = { month = 2, day = 21 }, time = { hours = 11, minutes = 40 }, comment = "1 new case in Chiba Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200221/k10012296171000.html" }
    , { cases = 1, date = { month = 2, day = 21 }, time = { hours = 11, minutes = 37 }, comment = "1 new case in Ishikawa Prefecture", url = "https://www3.nhk.or.jp/news/html/20200221/k10012296081000.html" }
    , { cases = 1, date = { month = 2, day = 21 }, time = { hours = 11, minutes = 35 }, comment = "1 new case in Saitama Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200221/k10012295991000.html" }
    , { cases = 3, date = { month = 2, day = 21 }, time = { hours = 3, minutes = 18 }, comment = "3 new cases in Hokkaido Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200221/k10012295301000.html" }

    -- February 20
    , { cases = 1, date = { month = 2, day = 20 }, time = { hours = 14, minutes = 21 }, comment = "1 new case in Kanagawa Prefecture", url = "https://www3.nhk.or.jp/news/html/20200220/k10012294581000.html" }
    , { cases = 1, date = { month = 2, day = 20 }, time = { hours = 13, minutes = 43 }, comment = "1 new case in Fukuoka Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200220/k10012294541000.html" }
    , { cases = 1, date = { month = 2, day = 20 }, time = { hours = 11, minutes = 0 }, comment = "1 new case in Aichi Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200220/k10012294341000.html" }
    , { cases = 1, date = { month = 2, day = 20 }, time = { hours = 9, minutes = 38 }, comment = "1 new case in Chiba Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200220/k10012294231000.html" }
    , { cases = 1, date = { month = 2, day = 20 }, time = { hours = 9, minutes = 37 }, comment = "1 new case in Kanagawa Prefecture", url = "https://www3.nhk.or.jp/news/html/20200220/k10012294011000.html" }
    , { cases = 1, date = { month = 2, day = 20 }, time = { hours = 9, minutes = 36 }, comment = "1 new case in Okinawa Prefecture,", url = "https://www3.nhk.or.jp/news/html/20200220/k10012294021000.html" }
    , { cases = 1, date = { month = 2, day = 20 }, time = { hours = 9, minutes = 35 }, comment = "1 new case in Hokkaido Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200220/k10012293901000.html" }
    , { cases = 2, date = { month = 2, day = 20 }, time = { hours = 6, minutes = 15 }, comment = "2 new cases in Japan", url = "https://www3.nhk.or.jp/shutoken-news/20200220/1000044359.html" }
    , { cases = 1, date = { month = 2, day = 20 }, time = { hours = 2, minutes = 31 }, comment = "1 new case in Fukuoka Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200220/k10012293351000.html" }

    -- February 19
    , { cases = 1, date = { month = 2, day = 19 }, time = { hours = 12, minutes = 25 }, comment = "1 new case in Aichi Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200219/k10012292821000.html" }
    , { cases = 3, date = { month = 2, day = 19 }, time = { hours = 11, minutes = 45 }, comment = "3 new cases in Tokyo, Japan", url = "https://www3.nhk.or.jp/news/html/20200219/k10012292791000.html" }
    , { cases = 1, date = { month = 2, day = 19 }, time = { hours = 10, minutes = 10 }, comment = "1 new case in Japan", url = "https://www3.nhk.or.jp/news/html/20200219/k10012292561000.html" }
    , { cases = 1, date = { month = 2, day = 19 }, time = { hours = 9, minutes = 10 }, comment = "1 new case in Okinawa Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200219/k10012292401000.html" }
    , { cases = 1, date = { month = 2, day = 19 }, time = { hours = 8, minutes = 40 }, comment = "1 new case in Hokkaido Prefecture", url = "https://www3.nhk.or.jp/news/html/20200219/k10012292301000.html" }
    , { cases = 1, date = { month = 2, day = 19 }, time = { hours = 3, minutes = 22 }, comment = "1 new case in Hokkaido Prefecture, Japan", url = "https://www3.nhk.or.jp/sapporo-news/20200219/7000018076.html" }
    , { cases = 2, date = { month = 2, day = 19 }, time = { hours = 3, minutes = 9 }, comment = "2 new cases in Kanagawa Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200219/k10012291781000.html" }

    -- February 18
    , { cases = 1, date = { month = 2, day = 18 }, time = { hours = 13, minutes = 10 }, comment = "1 new case in Kanagawa Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200218/k10012291101000.html" }
    , { cases = 3, date = { month = 2, day = 18 }, time = { hours = 12, minutes = 3 }, comment = "3 new cases in Wakayama Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200218/k10012290631000.html" }
    , { cases = 1, date = { month = 2, day = 18 }, time = { hours = 12, minutes = 2 }, comment = "1 new case in Aichi Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200218/k10012291011000.html" }
    , { cases = 3, date = { month = 2, day = 18 }, time = { hours = 12, minutes = 1 }, comment = "3 new cases in Tokyo, Japan", url = "https://www3.nhk.or.jp/news/html/20200218/k10012290911000.html" }

    -- February 17
    , { cases = 1, date = { month = 2, day = 17 }, time = { hours = 13, minutes = 40 }, comment = "1 new case in Japan", url = "https://www3.nhk.or.jp/news/html/20200217/amp/k10012289781000.html" }
    , { cases = 4, date = { month = 2, day = 17 }, time = { hours = 7, minutes = 14 }, comment = "4 new cases in Wakayama Prefecture, Japan", url = "https://www3.nhk.or.jp/news/html/20200217/k10012289081000.html" }
    , { cases = 1, date = { month = 2, day = 17 }, time = { hours = 2, minutes = 51 }, comment = "1 new case in Japan", url = "https://www3.nhk.or.jp/news/html/20200217/k10012288721000.html" }
    , { cases = 1, date = { month = 2, day = 17 }, time = { hours = 2, minutes = 35 }, comment = "1 new case in Japan", url = "http://sagamihara-chuo-hospital.jp/topics.php?id=1&schemas=type010_1_1&topics=22#id22" }

    -- February 16
    , { cases = 1, date = { month = 2, day = 16 }, time = { hours = 10, minutes = 29 }, comment = "1 new case in Japan", url = "https://www3.nhk.or.jp/news/html/20200216/k10012288191000.html" }
    , { cases = 5, date = { month = 2, day = 16 }, time = { hours = 10, minutes = 22 }, comment = "5 new cases in Japan", url = "https://www3.nhk.or.jp/news/html/20200216/k10012288171000.html" }

    -- February 15
    , { cases = 1, date = { month = 2, day = 15 }, time = { hours = 12, minutes = 15 }, comment = "1 new case in Japan", url = "https://mainichi.jp/articles/20200215/k00/00m/040/228000c" }

    -- New year party story Feb 13th a taxi drive got infected, the mother (80s, Kanagawa) died on 13th
    -- 7 people at new year party
    -- 1 person male 40s office worker, traveled to Aichi on Shinkansen on 10th, went hospital on 12th, maybe met a Chinese person
    , { cases = 8, date = { month = 2, day = 15 }, time = { hours = 9, minutes = 5 }, comment = "8 new cases in Japan", url = "https://www3.nhk.or.jp/news/html/20200215/k10012287191000.html" }
    , { cases = 2, date = { month = 2, day = 15 }, time = { hours = 7, minutes = 3 }, comment = "2 new cases in Japan. The third case in the article was previously reported", url = "https://www3.nhk.or.jp/news/html/20200215/k10012287101000.html" }
    , { cases = 1, date = { month = 2, day = 15 }, time = { hours = 3, minutes = 18 }, comment = "1 new case in Japan", url = "https://www3.nhk.or.jp/news/html/20200215/k10012286971000.html" }

    -- February 14
    , { cases = 1, date = { month = 2, day = 14 }, time = { hours = 14, minutes = 3 }, comment = "1 new case in Japan", url = "https://www3.nhk.or.jp/news/html/20200214/k10012286511000.html" }
    , { cases = 1, date = { month = 2, day = 14 }, time = { hours = 14, minutes = 0 }, comment = "1 new case in Japan", url = "https://www3.nhk.or.jp/news/html/20200214/k10012286491000.html" }
    , { cases = 1, date = { month = 2, day = 14 }, time = { hours = 13, minutes = 54 }, comment = "1 new case in Japan", url = "https://www3.nhk.or.jp/news/html/20200214/k10012286451000.html" }
    , { cases = 1, date = { month = 2, day = 14 }, time = { hours = 13, minutes = 50 }, comment = "1 new case in Japan", url = "https://www.mhlw.go.jp/stf/newpage_09537.html" }
    , { cases = 2, date = { month = 2, day = 14 }, time = { hours = 10, minutes = 9 }, comment = "2 new cases in Japan", url = "https://www3.nhk.or.jp/news/html/20200214/k10012285891000.html" }
    , { cases = 1, date = { month = 2, day = 14 }, time = { hours = 7, minutes = 51 }, comment = "1 new case in Japan", url = "https://www.okinawatimes.co.jp/articles/-/534920" }
    , { cases = 1, date = { month = 2, day = 14 }, time = { hours = 0, minutes = 43 }, comment = "1 new case in Japan", url = "https://www3.nhk.or.jp/news/html/20200214/k10012285021000.html" }

    -- February 13
    , { cases = 1, date = { month = 2, day = 13 }, time = { hours = 12, minutes = 40 }, comment = "1 new case in Japan", url = "https://www.mhlw.go.jp/stf/newpage_09506.html" }
    , { cases = 1, date = { month = 2, day = 13 }, time = { hours = 11, minutes = 55 }, comment = "1 new case, a fatality, in Japan. This is the first death in Japan", url = "https://www.mhlw.go.jp/stf/newpage_09503.html" }
    , { cases = 1, date = { month = 2, day = 13 }, time = { hours = 11, minutes = 15 }, comment = "1 new case in Japan", url = "https://www.mhlw.go.jp/stf/newpage_09505.html" }
    , { cases = 1, date = { month = 2, day = 13 }, time = { hours = 9, minutes = 5 }, comment = "1 new case in Japan", url = "https://www.mhlw.go.jp/stf/newpage_09504.html" }

    -- February 12
    , { cases = 1, date = { month = 2, day = 12 }, time = { hours = 2, minutes = 52 }, comment = "1 new case in Japan. It is one of the quarantine officers who was working on board the “Diamond Princess” cruise ship off Yokohama. This case is not included in the total for the ship’s passengers and crew", url = "https://www.mhlw.go.jp/stf/newpage_09424.html" }

    -- February 11
    , { cases = 2, date = { month = 2, day = 11 }, time = { hours = 6, minutes = 57 }, comment = "2 new cases in Japan", url = "" }

    -- February 9
    , { cases = 1, date = { month = 2, day = 9 }, time = { hours = 3, minutes = 6 }, comment = "1 new case in Japan", url = "" }

    -- February 5
    , { cases = 1, date = { month = 2, day = 5 }, time = { hours = 19, minutes = 2 }, comment = "1 new case in Japan", url = "" }
    , { cases = 1, date = { month = 2, day = 5 }, time = { hours = 19, minutes = 1 }, comment = "1 new case in Japan", url = "" }

    -- February 4
    , { cases = 1, date = { month = 2, day = 4 }, time = { hours = 16, minutes = 49 }, comment = "1 new case in Japan", url = "" }
    , { cases = 1, date = { month = 2, day = 4 }, time = { hours = 14, minutes = 1 }, comment = "1 new case in Japan", url = "" }
    , { cases = 1, date = { month = 2, day = 4 }, time = { hours = 13, minutes = 12 }, comment = "1 new case in Japan", url = "" }

    -- February 1
    , { cases = 3, date = { month = 2, day = 1 }, time = { hours = 14, minutes = 51 }, comment = "3 new cases in Japan", url = "" }

    -- January 31
    , { cases = 2, date = { month = 1, day = 31 }, time = { hours = 20, minutes = 2 }, comment = "2 new asymptomatic cases in Japan", url = "" }
    , { cases = 1, date = { month = 1, day = 31 }, time = { hours = 10, minutes = 19 }, comment = "1 new case in Japan", url = "" }

    -- January 30
    , { cases = 1, date = { month = 1, day = 30 }, time = { hours = 13, minutes = 40 }, comment = "1 new case in Japan", url = "" }
    , { cases = 1, date = { month = 1, day = 30 }, time = { hours = 13, minutes = 30 }, comment = "1 new case in Japan", url = "" }
    , { cases = 1, date = { month = 1, day = 30 }, time = { hours = 12, minutes = 36 }, comment = "1 new case in Japan", url = "" }
    , { cases = 3, date = { month = 1, day = 30 }, time = { hours = 0, minutes = 13 }, comment = "3 new cases in Japan. Three people who were evacuated from Wuhan have tested positive for coronavirus", url = "" }

    -- January 29
    , { cases = 1, date = { month = 1, day = 29 }, time = { hours = 14, minutes = 1 }, comment = "1 new case in Japan", url = "" }

    -- January 28
    , { cases = 1, date = { month = 1, day = 28 }, time = { hours = 22, minutes = 35 }, comment = "1 new case in Japan", url = "" }
    , { cases = 2, date = { month = 1, day = 28 }, time = { hours = 9, minutes = 6 }, comment = "2 new cases in Japan. (Source 1, Source 2)", url = "" }

    -- January 26
    , { cases = 1, date = { month = 1, day = 26 }, time = { hours = 10, minutes = 55 }, comment = "1 new case in Japan", url = "" }

    -- January 25
    , { cases = 1, date = { month = 1, day = 25 }, time = { hours = 7, minutes = 0 }, comment = "1 new case in Japan", url = "" }

    -- January 23
    , { cases = 1, date = { month = 1, day = 23 }, time = { hours = 22, minutes = 21 }, comment = "1 new case in Japan", url = "" }
    ]


type alias Date =
    { day : Int, month : Int }


type
    Gender
    -- 性別
    = Male -- 男
    | Female -- 女


type
    Age
    -- 年代
    = Age Int -- 代


type Location
    = China_Wuhan
    | China_Hunan
    | China_Hubei
      --
    | Aichi
    | Chiba
    | Hokkaido
    | Kanagawa
    | Kyoto
    | Mie
    | Nara
    | Okinawa
    | Osaka
    | Tokyo
    | Wakayama
      --
    | LocationUnderInvestigation
    | Unknown String


fromStringToLocation : String -> Location
fromStringToLocation string =
    case string of
        "中国 （武漢市）" ->
            China_Wuhan

        "中国 （湖南省）" ->
            China_Hunan

        "中国 （湖北省）" ->
            China_Hubei

        --
        "愛知県" ->
            Aichi

        "千葉県" ->
            Chiba

        "北海道" ->
            Hokkaido

        "神奈川県" ->
            Kanagawa

        "神奈川" ->
            Kanagawa

        "京都府" ->
            Kyoto

        "三重県" ->
            Mie

        "奈良県" ->
            Nara

        "沖縄県" ->
            Okinawa

        "大阪府" ->
            Osaka

        "東京都" ->
            Tokyo

        "和歌山県" ->
            Wakayama

        "和歌山" ->
            Wakayama

        --
        "調査中" ->
            LocationUnderInvestigation

        _ ->
            Unknown string


process : String -> List RowMhlw
process dataRaw =
    let
        list =
            String.split "\n" dataRaw
    in
    List.map
        (\item ->
            item
                |> String.replace "０" "0"
                |> String.replace "１" "1"
                |> String.replace "２" "2"
                |> String.replace "３" "3"
                |> String.replace "４" "4"
                |> String.replace "５" "5"
                |> String.replace "６" "6"
                |> String.replace "７" "7"
                |> String.replace "８" "8"
                |> String.replace "９" "9"
                |> String.split ", "
                |> processRow
        )
        list


type
    SurroundingPatients
    -- 周囲の患者の発生※
    = SurroundingPatients (List Int)
    | NoSurroundingPatients -- なし
    | InvestigationSurroundingPatients -- 調査中


processRow : List String -> RowMhlw
processRow row =
    let
        array =
            Array.fromList row

        surroundingPatients =
            if get 6 array == "なし" || get 6 array == "調査中" then
                []

            else
                List.map (\p -> toInt p) (String.split " " <| get 6 array)
    in
    { new = toInt <| get 0 array
    , old = toInt <| get 1 array
    , date = processMonthDay <| get 2 array
    , age = toInt <| String.replace "代" "" <| get 3 array
    , gender =
        if get 4 array == "男" then
            Male

        else
            Female
    , location = fromStringToLocation <| get 5 array
    , surroundingPatients =
        if get 6 array == "なし" then
            NoSurroundingPatients

        else if get 6 array == "調査中" then
            InvestigationSurroundingPatients

        else
            SurroundingPatients (List.map (\p -> toInt p) (String.split " " <| get 6 array))
    , closeContactsituation =
        if get 7 array == "なし" then
            NoCloseContactSituation

        else if get 7 array == "調査中" then
            CloseContactSituationInvestigating

        else if String.contains "健康観察終了" (get 7 array) then
            EndOfHealthObservation (toInt (get 7 array))

        else if String.contains "健康観察実施中" (get 7 array) then
            UnderHealthObservation (toInt (get 7 array))

        else
            ERRORCloseContactSituation (get 7 array)
    }


type
    CloseContactSituation
    -- 濃厚接触者の状況
    = EndOfHealthObservation Int -- 健康観察終了
    | UnderHealthObservation Int -- 健康観察実施中
    | CloseContactSituationInvestigating -- 調査中
    | NoCloseContactSituation -- なし
    | ERRORCloseContactSituation String


get : Int -> Array.Array String -> String
get index array =
    Maybe.withDefault "" <| Array.get index array


toInt : String -> Int
toInt string =
    string
        |> String.replace "名特定 健康観察実施中" ""
        |> String.replace "名特定 健康観察終了" ""
        |> String.replace "No." ""
        |> String.toInt
        |> Maybe.withDefault 0


processMonthDay : String -> Date
processMonthDay monthDay =
    let
        array =
            Array.fromList <| String.split "/" monthDay
    in
    { month = toInt <| get 0 array
    , day = toInt <| get 1 array
    }


header : List String
header =
    -- [ "新No.", "旧No.", "確定日", "年代", "性別", "居住地", "周囲の患者の発生※", "濃厚接触者の状況" ]
    [ "New No.", "Old No.", "Confirmation Date", "Age", "Gender", "Residence", "Related Patients", "Status of close contacts" ]


type alias Point =
    { x : Float, y : Float }


data1 : List Point
data1 =
    -- [ Point 1 2, Point 6 4, Point 10 10 ]
    dataGraph1


data2 : List Point
data2 =
    dataGraph2


chartOLD : Html.Html msg
chartOLD =
    LineChart.view2 .x .y data1 data2


dot : LineChart.Dots.Shape
dot =
    LineChart.Dots.circle


dotsConfig : LineChart.Dots.Config data
dotsConfig =
    LineChart.Dots.custom (LineChart.Dots.full 4)


dotsDefault : LineChart.Dots.Config data
dotsDefault =
    LineChart.Dots.default


chart : Html.Html msg
chart =
    LineChart.viewCustom chartConfig
        [ LineChart.line LineChart.Colors.purple LineChart.Dots.circle "JMHLW" data1
        , LineChart.line LineChart.Colors.blue LineChart.Dots.square "BNO" data2
        ]


type alias Info =
    { x : Float
    , y : Float
    }


customTick : Float -> LineChart.Axis.Tick.Config msg
customTick number =
    let
        label =
            LineChart.Junk.label LineChart.Colors.black (dateToString (daysFromJanuaryFirstToDate (round number)))
    in
    LineChart.Axis.Tick.custom
        { position = number
        , color = LineChart.Colors.black
        , width = 1
        , length = 7
        , grid = True
        , direction = LineChart.Axis.Tick.negative
        , label = Just label
        }


axisCustom : LineChart.Axis.Config { a | x : Float } msg
axisCustom =
    LineChart.Axis.custom
        { title = LineChart.Axis.Title.default "Date"
        , variable = Just << .x
        , pixels = 800
        , range = LineChart.Axis.Range.padded 0 0
        , axisLine = LineChart.Axis.Line.full LineChart.Colors.gray
        , ticks = ticksConfig
        }


ticksConfig : LineChart.Axis.Ticks.Config msg
ticksConfig =
    LineChart.Axis.Ticks.floatCustom 6 customTick


chartConfig : LineChart.Config Info msg
chartConfig =
    { x = axisCustom
    , y = LineChart.Axis.default 300 "Cases" .y
    , container = LineChart.Container.responsive "line-chart-1"
    , interpolation = LineChart.Interpolation.default
    , intersection = LineChart.Axis.Intersection.default
    , legends = LineChart.Legends.default
    , events = LineChart.Events.default
    , junk = LineChart.Junk.default
    , grid = LineChart.Grid.default
    , area = LineChart.Area.default
    , line = LineChart.Line.default
    , dots = dotsConfig
    }


totalMhlw : Int -> Int
totalMhlw daysFromJanuary =
    List.foldl
        (\row acc ->
            if daysFromJanuaryFirst row.date == daysFromJanuary then
                acc + 1

            else
                acc
        )
        0
        dataMhlw


totalBno : Int -> Int
totalBno daysFromJanuary =
    List.foldl
        (\row acc ->
            if daysFromJanuaryFirst row.date == daysFromJanuary then
                acc + row.cases

            else
                acc
        )
        0
        dataBno


dateForGraph2 : Date -> Date -> (Int -> Int) -> List ( Int, Int )
dateForGraph2 start stop totalFunction =
    let
        startDate =
            daysFromJanuaryFirst start

        endDate =
            daysFromJanuaryFirst stop
    in
    List.indexedMap
        (\index _ ->
            let
                daysFromJanuary =
                    endDate - index

                total =
                    totalFunction daysFromJanuary
            in
            ( daysFromJanuary, total )
        )
        (List.repeat (endDate - startDate) 0)


dataGraph1 : List Point
dataGraph1 =
    List.foldl
        (\( day, data ) acc -> Point (toFloat day) (toFloat data) :: acc)
        []
        (dateForGraph2 { month = 1, day = 14 } { month = 2, day = 18 } totalMhlw)


dataGraph2 : List Point
dataGraph2 =
    List.foldl
        (\( day, data ) acc -> Point (toFloat day) (toFloat data) :: acc)
        []
        (dateForGraph2 { month = 1, day = 22 } { month = 2, day = 22 } totalBno)


daysFromJanuaryFirst : Date -> Int
daysFromJanuaryFirst date =
    if date.month == 1 then
        date.day

    else if date.month == 2 then
        31 + date.day

    else if date.month == 3 then
        31 + 29 + date.day

    else
        0


daysFromJanuaryFirstToDate : Int -> Date
daysFromJanuaryFirstToDate days =
    if days > 31 + 29 then
        { month = 3, day = days - 31 - 29 }

    else if days > 31 then
        { month = 2, day = days - 31 }

    else
        { month = 1, day = days }


dateToString : Date -> String
dateToString date =
    (if date.month == 1 then
        "Jan "

     else if date.month == 2 then
        "Feb "

     else
        "Mar "
    )
        ++ String.fromInt date.day


main : Html.Html msg
main =
    Html.div []
        [ Html.node "style" [] [ Html.text """
            td, th {border: 1px solid #bbb; padding: 5px}
            table  {border-collapse: collapse}
            a      {text-decoration: underline !important}
            div    {line-height: inherit !important}""" ]
        , layout [ padding 40, Font.size 16, width fill ] <|
            column [ spacing 20, width fill, width (fill |> maximum 800), centerX ]
                [ column
                    [ Border.width 1
                    , Border.color <| rgb 0.7 0.7 0.7
                    , Border.rounded 5
                    , width fill
                    ]
                    [ paragraph [ Font.center, Font.size 24, moveDown 20 ] [ text "Daily new cases of coronavirus in Japan" ]
                    , el [ width fill ] <| html <| chart
                    ]
                , paragraph [] [ text "This graph rapresent the daily new cases of coronavirus contamination in Japan, excluding the contaminations found on the “Diamond Princess” cruise ship." ]
                , paragraph [] [ text "The two lines are from two different sources: JMHLW, the \"Japanese Ministry of Health, Labour and Welfare\" and BNO News that aggregate news from several outlets." ]
                , paragraph [] [ text "The two sources have sligtly different way of counting cases and cut the day with 9 hours of difference. BNO use UTC while JMHLW use Japanese Standard Time (+9). They are also updated with different frequency." ]
                , paragraph [ Font.size 24 ] [ text "Sources" ]
                , column [ spacing 10 ]
                    [ paragraph [ Font.bold ] [ text "BNO = BNO News" ]
                    , newTabLink [] { url = "https://bnonews.com/index.php/2020/02/the-latest-coronavirus-cases/", label = paragraph [] [ text "https://bnonews.com/index.php/2020/02/the-latest-coronavirus-cases/" ] }
                    ]
                , column [ spacing 10 ]
                    [ paragraph [ Font.bold ] [ text "JMHLW = Japanese Ministry of Health, Labour and Welfare" ]
                    , newTabLink [] { url = "https://www.mhlw.go.jp/stf/newpage_09637.html", label = paragraph [] [ text "Source: https://www.mhlw.go.jp/stf/newpage_09637.html" ] }
                    ]

                -- , el [] <|
                --     html <|
                --         Html.table [ Html.Attributes.style "border" "1px solid red" ] <|
                --             [ Html.tr []
                --                 (List.map (\label -> Html.th [] [ Html.text label ]) header)
                --             ]
                --                 ++ List.map
                --                     (\row ->
                --                         Html.tr []
                --                             [ Html.td [] [ Html.text <| String.fromInt row.new ]
                --                             , Html.td [] [ Html.text <| String.fromInt row.old ]
                --                             , Html.td [] [ Html.text <| String.fromInt row.date.month ++ "/" ++ String.fromInt row.date.day ]
                --                             , Html.td [] [ Html.text <| String.fromInt row.age ]
                --                             , Html.td [] [ Html.text <| Debug.toString row.gender ]
                --                             , Html.td [] [ Html.text <| Debug.toString row.location ]
                --                             , Html.td [] [ Html.text <| Debug.toString row.surroundingPatients ]
                --                             , Html.td [] [ Html.text <| Debug.toString row.closeContactsituation ]
                --                             ]
                --                     )
                --                     dataMhlw
                , el [ width fill, Border.width 1, Border.color <| rgb 0.7 0.7 0.7 ] none
                , title
                ]
        ]


title : Element msg
title =
    column [ spacing 12, centerX ]
        [ paragraph [ Font.center ]
            [ text "Page made with "
            , newTabLink [] { url = "https://elm-lang.org/", label = text "Elm" }
            ]
        , paragraph [ Font.center ]
            [ text "Code at "
            , newTabLink [] { url = "https://github.com/tkyodev/elm-coronavirus-japan", label = text "https://github.com/tkyodev/elm-coronavirus-japan" }
            ]
        , paragraph [ Font.center ]
            [ text "Last updated on February 23, 2020 at 9:30 JST"
            ]
        ]
