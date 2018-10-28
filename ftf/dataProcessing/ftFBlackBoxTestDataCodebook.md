---
params:
 title: "FlipTheFleet Test Black Box Data: Codebook"
 subtitle: "Exploration of test data"
title: 'FlipTheFleet Test Black Box Data: Codebook'
subtitle: 'Exploration of test data'
author: 'Ben Anderson (b.anderson@soton.ac.uk, `@dataknut`)'
date: 'Last run at: 2018-10-18 15:44:06'
output:
  bookdown::html_document2:
    toc: true
    toc_float: TRUE
    toc_depth: 2
    keep_md: TRUE
    self_contained: no
  bookdown::pdf_document2:
    toc: true
    toc_depth: 2
  bookdown::word_document2:
    toc: true
    toc_depth: 2
bibliography: '/Users/ben/bibliography.bib'
---





\newpage

# Citation

If you wish to use any of the material from this report please cite as:

 * Anderson, B. (2018) FlipTheFleet Test Black Box Data: Codebook: Exploration of test data, [Centre for Sustainability](http://www.otago.ac.nz/centre-sustainability/), University of Otago: Dunedin, New Zealand.

This work is (c) 2018 the University of Southampton.

\newpage

# About

## Circulation


Report circulation:

 * Restricted to: [NZ GREEN Grid](https://www.otago.ac.nz/centre-sustainability/research/energy/otago050285.html) project partners and contractors.
 
## Purpose

This report is intended to: 

 * load and test preliminary 'black box' EV monitoring data provided for assessment purposes by [FlipTheFleet](http://flipthefleet.org/).

## Requirements:

 * test dataset stored at /Volumes/hum-csafe/Research Projects/GREEN Grid/externalData/flipTheFleet/raw/

## History


Generally tracked via our git.soton [repo](https://git.soton.ac.uk/ba1e12/nzGREENGrid):

 * [history](https://git.soton.ac.uk/ba1e12/nzGREENGrid/commits/master)
 * [issues](https://git.soton.ac.uk/ba1e12/nzGREENGrid/issues)
 
Specific history of this code:

 * https://github.com/CfSOtago/GREENGrid/tree/master/analysis/ev

## Support


This work was supported by:

 * The [University of Otago](https://www.otago.ac.nz/);
 * The [University of Southampton](https://www.southampton.ac.uk/);
 * The New Zealand [Ministry of Business, Innovation and Employment (MBIE)](http://www.mbie.govt.nz/) through the [NZ GREEN Grid](https://www.otago.ac.nz/centre-sustainability/research/energy/otago050285.html) project;
 * [SPATIALEC](http://www.energy.soton.ac.uk/tag/spatialec/) - a [Marie Skłodowska-Curie Global Fellowship](http://ec.europa.eu/research/mariecurieactions/about-msca/actions/if/index_en.htm) based at the University of Otago’s [Centre for Sustainability](http://www.otago.ac.nz/centre-sustainability/staff/otago673896.html) (2017-2019) & the University of Southampton's Sustainable Energy Research Group (2019-2020).

We do not 'support' the code but if you notice a problem please check the [issues](https://github.com/CfSOtago/GREENGrid/issues) on our [repo](https://github.com/CfSOtago/GREENGrid) and if it doesn't already exist, please open a new one.
 

# Load data files

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:get fileNames)Data files to be loaded</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> fileList </th>
   <th style="text-align:left;"> fullPath </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> EVBlackBox export 2018-06-10-233146.csv.gz </td>
   <td style="text-align:left;"> /Volumes/hum-csafe/Research Projects/GREEN Grid/externalData/flipTheFleet/raw/EVBlackBox export 2018-06-10-233146.csv.gz </td>
  </tr>
  <tr>
   <td style="text-align:left;"> EVBlackBox export 2018-09-08-081400.csv.gz </td>
   <td style="text-align:left;"> /Volumes/hum-csafe/Research Projects/GREEN Grid/externalData/flipTheFleet/raw/EVBlackBox export 2018-09-08-081400.csv.gz </td>
  </tr>
</tbody>
</table>

In this section we load, merge and describe the data files from /Volumes/hum-csafe/Research Projects/GREEN Grid/externalData/flipTheFleet/. 


```
## Parsed with column specification:
## cols(
##   .default = col_integer(),
##   `Reg No` = col_character(),
##   `Date (GPS)` = col_character(),
##   `Time (GPS)` = col_time(format = ""),
##   Latitude = col_double(),
##   Longitude = col_double(),
##   Altitude = col_double(),
##   `Speed (GPS)` = col_double(),
##   `Speed (Speedometer)` = col_double(),
##   `Course (deg)` = col_double(),
##   SOC = col_double(),
##   AHr = col_double(),
##   `Pack volts` = col_double(),
##   `Pack amps` = col_double(),
##   `Pack 1 temp (C)` = col_double(),
##   `Pack 2 temp (C)` = col_double(),
##   `Pack 3 temp (C)` = col_double(),
##   `Pack 4 temp (C)` = col_double(),
##   `12V battery (amps)` = col_double(),
##   Hx = col_double(),
##   VIN = col_character()
##   # ... with 16 more columns
## )
```

```
## See spec(...) for full column specifications.
```

```
## Parsed with column specification:
## cols(
##   .default = col_integer(),
##   `Reg No` = col_character(),
##   `Date (GPS)` = col_character(),
##   `Time (GPS)` = col_time(format = ""),
##   Latitude = col_double(),
##   Longitude = col_double(),
##   Altitude = col_double(),
##   `Speed (GPS)` = col_double(),
##   `Speed (Speedometer)` = col_double(),
##   `Course (deg)` = col_double(),
##   SOC = col_double(),
##   AHr = col_double(),
##   `Pack volts` = col_double(),
##   `Pack amps` = col_double(),
##   `Pack 1 temp (C)` = col_double(),
##   `Pack 2 temp (C)` = col_double(),
##   `Pack 3 temp (C)` = col_character(),
##   `Pack 4 temp (C)` = col_double(),
##   `12V battery (amps)` = col_double(),
##   Hx = col_double(),
##   VIN = col_character()
##   # ... with 91 more columns
## )
```

```
## See spec(...) for full column specifications.
```

# Location inference

The raw data has latitude and longitude. This is very discosive, although there are some errors. For example in the sample selected below there are 0 values (off the coast of West Africa). Clearly nonsense...

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:getTestGeo)Summary of test geo data</caption>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:left;">   Longitude </th>
   <th style="text-align:left;">    Latitude </th>
   <th style="text-align:left;">    Altitude </th>
   <th style="text-align:left;"> ambient_temp_1 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> Min.   :  0.0 </td>
   <td style="text-align:left;"> Min.   :-36.87 </td>
   <td style="text-align:left;"> Min.   :  0.00 </td>
   <td style="text-align:left;"> Length:100 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1st Qu.:174.7 </td>
   <td style="text-align:left;"> 1st Qu.:-36.69 </td>
   <td style="text-align:left;"> 1st Qu.: 25.32 </td>
   <td style="text-align:left;"> Class :character </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> Median :174.7 </td>
   <td style="text-align:left;"> Median :-36.67 </td>
   <td style="text-align:left;"> Median : 51.20 </td>
   <td style="text-align:left;"> Mode  :character </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> Mean   :169.5 </td>
   <td style="text-align:left;"> Mean   :-35.58 </td>
   <td style="text-align:left;"> Mean   : 55.31 </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 3rd Qu.:174.7 </td>
   <td style="text-align:left;"> 3rd Qu.:-36.63 </td>
   <td style="text-align:left;"> 3rd Qu.: 86.60 </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> Max.   :174.8 </td>
   <td style="text-align:left;"> Max.   :  0.00 </td>
   <td style="text-align:left;"> Max.   :106.50 </td>
   <td style="text-align:left;"> NA </td>
  </tr>
</tbody>
</table>

Figure \@ref(fig:mapAllLocations) maps the location of a subset of the observations in the dataset. If we selected just one vehicle and zoomed our map to the location at 01:00 - 04:00 when speed is 0 then we would probably determine their home. We could also determine other places visited at other times... This indicates how [disclosive GPS Lat/Long can be](http://toddwschneider.com/posts/analyzing-1-1-billion-nyc-taxi-and-uber-trips-with-a-vengeance/) even if address data is not provided.

<div class="figure">
<!--html_preserve--><div id="htmlwidget-b2d4cd653e661f1074c4" style="width:672px;height:480px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-b2d4cd653e661f1074c4">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addMarkers","args":[[-36.86866105,-36.8639405166667,-36.85305315,-36.8509167833333,-36.8410275333333,-36.8360697333333,-36.83034915,-36.8246325333333,-36.8166240666667,-36.80936225,-36.801162,-36.7937492166667,-36.7863088,-36.77803735,-36.76851655,-36.7607903833333,-36.7549223166667,-36.7503908333333,-36.74477225,-36.73668535,-36.7264389833333,-36.71770475,-36.7101269,-36.70079715,-36.6916746166667,-36.6831672833333,-36.6781856166667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6713942666667,-36.6268850166667,-36.62689195,-36.6268924,-36.6268935666667,-36.6268927,-36.6268917666667,-36.62689185,-36.6268917666667,-36.6268923333333,-36.6268933333333,-36.6268935333333,-36.6268941,-36.6268951833333,-36.6268955166667,-36.626896,-36.6268962833333,-36.6268973333333,-36.6268981166667,-36.6269075833333,-36.6269058666667,-36.6269062833333,-36.6269089833333,-36.6269095166667,-36.6269124666667,-36.6269114666667,-36.6269120333333,-36.6269121666667,-36.6269133166667,-36.6269131666667,-36.6269128666667,-36.6269119166667,-36.6269108666667,-36.6269089,-36.6269077333333],[174.744198733333,174.75177755,174.755711766667,174.7539166,174.7450745,174.741896983333,174.745702816667,174.7494711,174.750442066667,174.756028583333,174.761279433333,174.756567433333,174.751480783333,174.746347366667,174.74087105,174.7367221,174.730185333333,174.7256124,174.721475866667,174.71842865,174.714755883333,174.712049766667,174.706932716667,174.70476,174.703143466667,174.698512383333,174.68775445,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.6821547,174.738341633333,174.738327283333,174.7383259,174.73832115,174.73831875,174.738314366667,174.738311783333,174.7383101,174.7383038,174.738298766667,174.73829735,174.738294883333,174.7382941,174.738296166667,174.73829655,174.73829775,174.7382976,174.738296666667,174.73827635,174.738272183333,174.7382706,174.7382672,174.738265566667,174.738263666667,174.738262983333,174.738261166667,174.738258883333,174.738256366667,174.73825515,174.738255366667,174.738255916667,174.738256633333,174.738257,174.738256766667],null,null,null,{"interactive":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250},["22","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","20","20","20","21","21","21","21","21","21","21","21","21","21","20","20","20","20","19","19","19","19","19","19","19","19","19","19","19","19","19","19","19","19","19","20","20","20","20","20","20","20","20","20","20","20","20","20","20","20","20","20","20","16","16","16","16","16","16","16","16","16","16","16","16","16","16","16","16"],null,null,null,["22","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","20","20","20","21","21","21","21","21","21","21","21","21","21","20","20","20","20","19","19","19","19","19","19","19","19","19","19","19","19","19","19","19","19","19","20","20","20","20","20","20","20","20","20","20","20","20","20","20","20","20","20","20","16","16","16","16","16","16","16","16","16","16","16","16","16","16","16","16"],{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[-36.86866105,-36.6268850166667],"lng":[174.6821547,174.761279433333]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption">(\#fig:mapAllLocations)Map of sample of observations</p>
</div>


## Derived variables

Create some useful derived variables.


```r
# create derived 
ftfT <- GREENGrid::createDerivedFtF(ftfDT)
```

```
## Warning: 17472 failed to parse.
```

If there is a 'failed to parse' message it suggests some dates and times could not be correctly parsed by ` GREENGrid::createDerivedFtF()`. We can check this using by comparing the original and parsed variables:


```
## Date (GPS)
```

```
##    Length     Class      Mode 
##     46741 character character
```

```
## rDate
```

```
##         Min.      1st Qu.       Median         Mean      3rd Qu. 
## "2018-05-01" "2018-05-24" "2018-07-19" "2018-07-07" "2018-08-12" 
##         Max.         NA's 
## "2018-09-08"      "17472"
```

```
## Time (GPS)
```

```
##   Length   Class1   Class2     Mode 
##    46741      hms difftime  numeric
```

```
## rTime
```

```
##   Length   Class1   Class2     Mode 
##    46741      hms difftime  numeric
```

```
## rDateTime
```

```
##                  Min.               1st Qu.                Median 
## "2018-05-01 12:42:27" "2018-05-24 21:12:53" "2018-07-19 08:24:43" 
##                  Mean               3rd Qu.                  Max. 
## "2018-07-08 00:58:29" "2018-08-12 09:58:54" "2018-09-08 15:27:48" 
##                  NA's 
##               "17472"
```

```
## rDow
```

```
##   Sun   Mon   Tue   Wed   Thu   Fri   Sat  NA's 
##  3480  3259  3954  3450  4216  5391  5519 17472
```

It looks like the dates don't always parse. Check a few...

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:checkDates)Example rows where date failed to parse</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Date (GPS) </th>
   <th style="text-align:left;"> rDate </th>
   <th style="text-align:left;"> Time (GPS) </th>
   <th style="text-align:left;"> rTime </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
  </tr>
</tbody>
</table>

Doesn't look like we can do much about these...

## Preventing geo-disclosure

To avoid any risk of location disclosure we next infer a very coarse geo-location at each time point so that we can remove the potentially disclosive GPS data before moving on to the analysis. 

Note that this does not necessarily render this dataset _completely safe_ ([anonymised](https://www.ukdataservice.ac.uk/manage-data/legal-ethical/anonymisation)) as there may well be other variables that provide sufficient information either on their own or together which would [enable identification](https://www.ukdataservice.ac.uk/manage-data/legal-ethical/anonymisation) of the car and it's owner.


```r
ftfDT <- GREENGrid::inferLocationFtF(ftfT)

plotDT <- ftfDT[, .(nObs = .N), 
                keyby = .(geoLoc, obsHour, rDow)]

ggplot(plotDT, aes(x = obsHour, y = nObs)) + 
  geom_col() + 
  facet_grid(rDow ~ geoLoc)
```

```
## Warning: Removed 2 rows containing missing values (position_stack).
```

<div class="figure">
<img src="ftFBlackBoxTestDataCodebook_files/figure-html/inferLoc-1.png" alt="Check inferred location"  />
<p class="caption">(\#fig:inferLoc)Check inferred location</p>
</div>

Figure \@ref(fig:inferLoc) shows the results of this inference. Does it look like a reasonable guestimate of location?

# Make safe version

We now create a unique EV ID by hashing the `Reg No` and then removing the following variables before we do anything else as they are potentially disclosive:

 * `Reg No`
 * `Latitude`
 * `Longitude` 
 * `Course (deg)` 
 


That gives us a data file with:

 * 46,741 rows of data
 * 228 columns (variables)
 * 2 EVs

# Codebook

Describe data to create codebook:


```
## ftfSafeDT 
## 
##  228  Variables      46741  Observations
## ---------------------------------------------------------------------------
## Time after power on (s) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0    13928        1     4571     5311      163      285 
##      .25      .50      .75      .90      .95 
##      735     2347     6629    11449    15845 
## 
## lowest :    23    24    25    26    27, highest: 32581 32611 32678 32744 32811
## ---------------------------------------------------------------------------
## Date (GPS) 
##        n  missing distinct 
##    29269    17472       97 
## 
## lowest : 01-05-2018 01-06-2018 01-08-2018 01-09-2018 02-05-2018
## highest: 30-07-2018 30-08-2018 31-05-2018 31-07-2018 31-08-2018
## ---------------------------------------------------------------------------
## Time (GPS) [secs] 
##        n  missing distinct 
##    29269    17472    21091 
## 
## lowest : 00:00:06 00:00:13 00:00:25 00:00:34 00:00:35
## highest: 23:59:34 23:59:35 23:59:40 23:59:41 23:59:51
## ---------------------------------------------------------------------------
## Altitude 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    30889    15852     1901        1    40.91    42.96     0.00     0.90 
##      .25      .50      .75      .90      .95 
##    18.10    32.20    41.40    57.92    93.96 
## 
## lowest : -953.9 -461.0 -387.8 -293.5 -293.2, highest:  766.2  771.4  778.8  787.2  949.3
## ---------------------------------------------------------------------------
## Speed (GPS) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    30889    15852       61    0.545    14.96    24.66     0.00     0.00 
##      .25      .50      .75      .90      .95 
##     0.00     0.00     0.00    74.08    90.75 
## 
## lowest :   0.000   1.852   3.704   5.556   7.408
## highest: 103.712 105.564 107.416 109.268 111.120
## ---------------------------------------------------------------------------
## Speed (Speedometer) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0     7976    0.748    22.43    32.79     0.00     0.00 
##      .25      .50      .75      .90      .95 
##     0.00     0.00    46.61    85.18    96.80 
## 
## lowest :   0.00   2.75   2.76   2.80   2.84, highest: 108.75 109.31 109.79 110.30 111.82
## ---------------------------------------------------------------------------
## GIDs 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0      437     0.83    272.7    438.8        0        0 
##      .25      .50      .75      .90      .95 
##        0        0      155     1280     1616 
## 
## lowest :    0   18   19   20   21, highest: 2192 2200 2208 2216 8184
## ---------------------------------------------------------------------------
## SOC 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0    40457        1    63.73    22.64    30.44    36.90 
##      .25      .50      .75      .90      .95 
##    50.09    64.55    78.46    90.44    96.58 
##                                                     
## Value          0    20    40    60    80   100  1680
## Frequency    301  1892  9440 16641 13628  4837     2
## Proportion 0.006 0.040 0.202 0.356 0.292 0.103 0.000
## ---------------------------------------------------------------------------
## AHr 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0      234        1    56.75    6.236    47.37    47.40 
##      .25      .50      .75      .90      .95 
##    47.52    60.06    60.44    60.97    61.59 
##                                                                       
## Value          0    47    48    60    61    62    63    64   132   133
## Frequency    301 10307  1895 24026  7116  1857   834   352    38    15
## Proportion 0.006 0.221 0.041 0.514 0.152 0.040 0.018 0.008 0.001 0.000
## ---------------------------------------------------------------------------
## Pack volts 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0      799    0.976    284.1    186.4      0.0      0.0 
##      .25      .50      .75      .90      .95 
##      0.0    378.0    386.5    392.0    396.5 
## 
## lowest :    0.000  269.856  337.344  340.320  341.664
## highest: 5612.448 5698.464 5735.904 5759.712 5783.520
## ---------------------------------------------------------------------------
## Pack amps 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0    21171        1    4.655    24.31  -13.965   -9.074 
##      .25      .50      .75      .90      .95 
##   -8.064   -5.265    8.599   45.199   56.826 
## 
## lowest : -126.984 -125.991 -125.844 -125.565 -125.524
## highest:  240.901  241.660  244.159  246.862  255.329
## ---------------------------------------------------------------------------
## max_cp (mV) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33274    13467      662        1     4333    798.4     3801     3843 
##      .25      .50      .75      .90      .95 
##     3928     4002     4050     4117     4136 
## 
## lowest :  3556  3589  3591  3597  3599, highest: 65038 65039 65040 65294 65295
## ---------------------------------------------------------------------------
## min_cp (mV) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33274    13467      557        1     3957    134.6     3776     3819 
##      .25      .50      .75      .90      .95 
##     3905     3986     4033     4097     4126 
## 
## lowest :    0   14   15   16  271, highest: 4127 4128 4129 4130 4131
## ---------------------------------------------------------------------------
## avg_cp (mV) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33274    13467      798        1     4156    466.2     3792     3833 
##      .25      .50      .75      .90      .95 
##     3919     3995     4042     4110     4132 
## 
## lowest :  2811  3514  3545  3559  3564, highest: 58463 59359 59749 59997 60245
## ---------------------------------------------------------------------------
## cp_diff (mV) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33274    13467      303    0.996      376    720.7        9        9 
##      .25      .50      .75      .90      .95 
##       12       16       19       25       31 
## 
## lowest :     5     6     7     8     9, highest: 65024 65025 65280 65281 65295
## ---------------------------------------------------------------------------
## Pack 1 temp (C) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468      297        1    17.14    4.695     11.5     12.3 
##      .25      .50      .75      .90      .95 
##     14.1     16.2     19.8     22.4     24.7 
## 
## lowest :  8.2  8.3  8.4  8.5  8.6, highest: 41.2 41.5 41.8 42.0 42.1
## ---------------------------------------------------------------------------
## Pack 2 temp (C) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33244    13497      283        1    16.53    4.476     11.1     11.9 
##      .25      .50      .75      .90      .95 
##     13.7     15.8     18.9     21.6     23.7 
## 
## lowest :  7.6  7.8  8.0  8.1  8.2, highest: 38.6 38.8 38.9 39.0 39.1
## ---------------------------------------------------------------------------
## Pack 3 temp (C) 
##        n  missing distinct 
##    12296    34445      181 
## 
## lowest : 10   10.1 10.2 10.3 10.4, highest: 9.5  9.6  9.7  9.8  9.9 
## ---------------------------------------------------------------------------
## Pack 4 temp (C) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33221    13520      256        1     15.1    4.167     10.2     10.8 
##      .25      .50      .75      .90      .95 
##     12.3     14.6     17.5     20.3     21.9 
## 
## lowest :  6.5  6.6  6.7  7.1  7.2, highest: 32.7 32.8 33.0 33.1 33.2
## ---------------------------------------------------------------------------
## cp_1 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33274    13467      982        1     1042     3768    -4042    -4019 
##      .25      .50      .75      .90      .95 
##    -3936     3900     4032     4105     4128 
##                                                                       
## Value      -4100 -4000 -3900 -3800 -3700 -3600 -3500  3500  3600  3700
## Frequency   1132  6437  3225  1285   231    29     1     1    32   468
## Proportion 0.034 0.193 0.097 0.039 0.007 0.001 0.000 0.000 0.001 0.014
##                                         
## Value       3800  3900  4000  4100  4300
## Frequency   2136  3860  8469  5967     1
## Proportion 0.064 0.116 0.255 0.179 0.000
## ---------------------------------------------------------------------------
## cp_2 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33274    13467      973        1     1846     3198    -4033    -4002 
##      .25      .50      .75      .90      .95 
##    -3815     3951     4038     4107     4132 
##                                         
## Value      -4000 -3500  3500  4000 25000
## Frequency   8788   180   609 23696     1
## Proportion 0.264 0.005 0.018 0.712 0.000
## ---------------------------------------------------------------------------
## cp_3 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33274    13467      978        1     1264     3967    -4038    -4015 
##      .25      .50      .75      .90      .95 
##    -3931     3905     4033     4107     4132 
##                                              
## Value      -51000  -4000      0   4000  51000
## Frequency       1  11921      2  21261     89
## Proportion  0.000  0.358  0.000  0.639  0.003
## ---------------------------------------------------------------------------
## cp_4 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33274    13467      983        1     1624     3385    -4035    -4008 
##      .25      .50      .75      .90      .95 
##    -3866     3937     4034     4104     4133 
##                                                                       
## Value      -4100 -4000 -3900 -3800 -3700 -3600 -3500  -500     0   500
## Frequency    878  5387  2307  1061   184    28     5     1     2    89
## Proportion 0.026 0.162 0.069 0.032 0.006 0.001 0.000 0.000 0.000 0.003
##                                               
## Value       3600  3700  3800  3900  4000  4100
## Frequency     36   515  2431  4424  9719  6207
## Proportion 0.001 0.015 0.073 0.133 0.292 0.187
## ---------------------------------------------------------------------------
## cp_5 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33274    13467     1039        1     1995     3328    -4034    -4002 
##      .25      .50      .75      .90      .95 
##    -3775     3953     4033     4107     4132 
## 
## lowest : -65295 -63247 -57615 -57102 -55055, highest:  60430  60686  60943  62991  65294
## ---------------------------------------------------------------------------
## cp_6 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33274    13467     1029        1     2026     3312    -4033    -3994 
##      .25      .50      .75      .90      .95 
##    -3758     3956     4033     4108     4132 
## 
## lowest : -65295 -63503 -57615 -57358 -54031, highest:  61199  63503  64527  64783  65295
## ---------------------------------------------------------------------------
## cp_7 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33274    13467     1071        1      987     4033    -4046    -4023 
##      .25      .50      .75      .90      .95 
##    -3949     3886     4028     4104     4131 
## 
## lowest : -65039 -57871 -57614 -55567 -49423, highest:  60942  61198  61455  63503  64783
## ---------------------------------------------------------------------------
## cp_8 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33274    13467     1047        1     1312     3877    -4042    -4020 
##      .25      .50      .75      .90      .95 
##    -3926     3910     4030     4104     4133 
## 
## lowest : -41487  -4133  -4127  -4124  -4123, highest:  61198  61455  63759  64782  65039
## ---------------------------------------------------------------------------
## cp_9 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33274    13467     1054        1     1642     3635    -4037    -4011 
##      .25      .50      .75      .90      .95 
##    -3877     3935     4033     4108     4131 
## 
## lowest : -65039 -63246 -61455 -56591 -55567, highest:  59918  60175  62223  63246  63503
## ---------------------------------------------------------------------------
## cp_10 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33274    13467     1036        1     1648     3659    -4037    -4011 
##      .25      .50      .75      .90      .95 
##    -3886     3934     4035     4108     4131 
## 
## lowest : -64784 -56591 -51983 -24847  -4132, highest:  60175  61199  63502  63759  64526
## ---------------------------------------------------------------------------
## cp_11 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33274    13467     1074        1     1682     3643    -4037    -4010 
##      .25      .50      .75      .90      .95 
##    -3871     3937     4033     4106     4131 
## 
## lowest : -64014 -60943 -57359 -56335 -56078, highest:  60943  61967  64014  64271  65294
## ---------------------------------------------------------------------------
## cp_12 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33274    13467     1051        1     1703     3646    -4037    -4010 
##      .25      .50      .75      .90      .95 
##    -3868     3939     4034     4104     4131 
## 
## lowest : -65039 -56847  -4132  -4127  -4123, highest:  60175  62735  63502  63759  64782
## ---------------------------------------------------------------------------
## cp_13 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1068        1     1820     3531    -4033    -4006 
##      .25      .50      .75      .90      .95 
##    -3837     3943     4033     4107     4127 
## 
## lowest : -63503 -61455 -60431 -55823 -55310, highest:  62479  63502  63759  64526  65040
## ---------------------------------------------------------------------------
## cp_14 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1044        1     1753     3572    -4037    -4008 
##      .25      .50      .75      .90      .95 
##    -3852     3940     4033     4106     4131 
## 
## lowest : -64783 -61199 -58895 -58638 -55311, highest:  59662  63503  64526  64527  64783
## ---------------------------------------------------------------------------
## cp_15 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1075        1     1358     3858    -4038    -4017 
##      .25      .50      .75      .90      .95 
##    -3918     3914     4028     4103     4131 
## 
## lowest : -64527 -62479 -61455 -56334 -55567, highest:  59918  60942  62223  64526  64783
## ---------------------------------------------------------------------------
## cp_16 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1046        1     1935     3433    -4033    -4006 
##      .25      .50      .75      .90      .95 
##    -3809     3944     4029     4103     4132 
## 
## lowest : -64782 -61455 -44047  -4133  -4132, highest:  61454  62479  63758  63759  64783
## ---------------------------------------------------------------------------
## cp_17 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1040        1     2381     2970    -4024    -3980 
##      .25      .50      .75      .90      .95 
##     3791     3966     4035     4107     4132 
## 
## lowest : -63246 -54031 -50703 -47375 -43791, highest:  62223  63246  63503  64526  65039
## ---------------------------------------------------------------------------
## cp_18 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1015        1     2409     2949    -4024    -3977 
##      .25      .50      .75      .90      .95 
##     3795     3967     4035     4106     4132 
## 
## lowest : -50703 -47119 -43791 -11791  -4133, highest:  62223  63246  63503  64526  64783
## ---------------------------------------------------------------------------
## cp_19 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1081        1     1594     3707    -4037    -4011 
##      .25      .50      .75      .90      .95 
##    -3890     3931     4037     4106     4131 
## 
## lowest : -64526 -54287 -50959 -49679 -46351, highest:  61199  63502  63759  64526  65039
## ---------------------------------------------------------------------------
## cp_20 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1046        1     1993     3381    -4030    -3997 
##      .25      .50      .75      .90      .95 
##    -3790     3954     4038     4106     4133 
## 
## lowest : -46095 -42767 -24079 -13327  -4134, highest:  62478  62479  63758  63759  64783
## ---------------------------------------------------------------------------
## cp_21 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1028        1     2467     2892    -4020    -3974 
##      .25      .50      .75      .90      .95 
##     3804     3969     4038     4109     4132 
## 
## lowest : -49423  -4133  -4132  -4128  -4127, highest:  62479  63246  64526  64783  65039
## ---------------------------------------------------------------------------
## cp_22 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1008        1     2463     2900    -4020    -3974 
##      .25      .50      .75      .90      .95 
##     3804     3969     4038     4109     4132 
## 
## lowest : -49423  -4133  -4132  -4128  -4127, highest:  62223  63246  63503  64526  64784
## ---------------------------------------------------------------------------
## cp_23 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1046        1     1848     3522    -4028    -4002 
##      .25      .50      .75      .90      .95 
##    -3840     3944     4037     4108     4131 
## 
## lowest : -51471  -4132  -4131  -4127  -4123, highest:  63247  63503  64014  64271  65294
## ---------------------------------------------------------------------------
## cp_24 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1043        1     2086     3298    -4026    -3990 
##      .25      .50      .75      .90      .95 
##    -3696     3957     4039     4106     4133 
## 
## lowest : -64527 -55567 -51983 -26127  -4134, highest:  60942  61199  63759  64526  64783
## ---------------------------------------------------------------------------
## cp_25 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1051        1     1981     3405    -4032    -3998 
##      .25      .50      .75      .90      .95 
##    -3798     3951     4035     4108     4131 
## 
## lowest : -4132 -4126 -4123 -4122 -4121, highest: 61455 63759 64015 64526 64783
## ---------------------------------------------------------------------------
## cp_26 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1029        1     1785     3572    -4033    -4006 
##      .25      .50      .75      .90      .95 
##    -3855     3939     4032     4108     4131 
## 
## lowest : -56591 -27151  -4132  -4127  -4123, highest:  63759  64526  64527  64783  64784
## ---------------------------------------------------------------------------
## cp_27 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1060        1     2100     3270    -4028    -3993 
##      .25      .50      .75      .90      .95 
##     3483     3951     4033     4103     4131 
## 
## lowest : -56591 -45071 -29711 -27407  -4137, highest:  60942  62479  63503  64526  65039
## ---------------------------------------------------------------------------
## cp_28 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1054        1     1523     3772    -4037    -4015 
##      .25      .50      .75      .90      .95 
##    -3902     3918     4029     4099     4131 
## 
## lowest : -4132 -4128 -4127 -4123 -4122, highest: 61198 61455 63759 64782 65039
## ---------------------------------------------------------------------------
## cp_29 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1039        1     2178     3209    -4025    -3989 
##      .25      .50      .75      .90      .95 
##     3715     3958     4033     4105     4132 
## 
## lowest : -64526 -48398  -4133  -4132  -4128, highest:  63502  64015  64526  64783  65039
## ---------------------------------------------------------------------------
## cp_30 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1034        1     1811     3549    -4033    -4006 
##      .25      .50      .75      .90      .95 
##    -3847     3941     4030     4104     4131 
## 
## lowest : -64782 -47630  -4132  -4128  -4127, highest:  60175  62735  63502  63759  65039
## ---------------------------------------------------------------------------
## cp_31 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1073        1     1657     3698    -4032    -4010 
##      .25      .50      .75      .90      .95 
##    -3885     3931     4032     4103     4131 
## 
## lowest : -46094  -4132  -4131  -4127  -4123, highest:  62222  62735  63502  63759  65039
## ---------------------------------------------------------------------------
## cp_32 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1047        1     2101     3298    -4030    -3998 
##      .25      .50      .75      .90      .95 
##    -3670     3953     4034     4104     4132 
## 
## lowest : -49679 -46350  -4133  -4127  -4124, highest:  60175  62478  62479  63758  63759
## ---------------------------------------------------------------------------
## cp_33 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1055        1     2446     2949    -4021    -3975 
##      .25      .50      .75      .90      .95 
##     3797     3966     4033     4104     4132 
## 
## lowest : -63502 -50959 -49679 -21775  -8719, highest:  62735  62991  63502  63759  65295
## ---------------------------------------------------------------------------
## cp_34 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1059        1     1805     3572    -4033    -4006 
##      .25      .50      .75      .90      .95 
##    -3851     3939     4033     4105     4131 
## 
## lowest : -63502 -59918 -50959 -43791 -21519, highest:  61455  62735  63502  63759  65039
## ---------------------------------------------------------------------------
## cp_35 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1098        1     1739     3840    -4033    -4010 
##      .25      .50      .75      .90      .95 
##    -3881     3929     4029     4103     4131 
## 
## lowest : -64526 -60942 -51983 -45071 -21519, highest:  62735  63502  63759  64526  65039
## ---------------------------------------------------------------------------
## cp_36 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1055        1     1880     3730    -4030    -4003 
##      .25      .50      .75      .90      .95 
##    -3849     3941     4034     4106     4132 
## 
## lowest : -62478 -49679 -22799 -12303  -4134, highest:  62990  63758  63759  64782  64783
## ---------------------------------------------------------------------------
## cp_37 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1101        1     1770     3802    -4038    -4010 
##      .25      .50      .75      .90      .95 
##    -3863     3937     4034     4103     4131 
## 
## lowest : -63502 -62479 -59151 -58127 -56847, highest:  63502  64014  64015  64526  65039
## ---------------------------------------------------------------------------
## cp_38 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1039        1     2253     3383    -4029    -3992 
##      .25      .50      .75      .90      .95 
##     3710     3957     4032     4103     4131 
## 
## lowest : -50703 -36367 -23567 -12047  -5903, highest:  61966  63246  63503  64526  64783
## ---------------------------------------------------------------------------
## cp_39 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1073        1     1577     3946    -4037    -4011 
##      .25      .50      .75      .90      .95 
##    -3908     3922     4028     4108     4131 
## 
## lowest : -63502 -49679 -38927 -35599 -24079, highest:  62222  62479  63502  64015  65039
## ---------------------------------------------------------------------------
## cp_40 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1060        1     1585     3955    -4038    -4012 
##      .25      .50      .75      .90      .95 
##    -3905     3920     4027     4103     4132 
## 
## lowest : -51983 -50959 -48655 -13583  -7439, highest:  62990  63502  63759  64782  65039
## ---------------------------------------------------------------------------
## cp_41 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1063        1     2084     3539    -4029    -3994 
##      .25      .50      .75      .90      .95 
##    -3785     3954     4033     4109     4132 
## 
## lowest : -64526 -61454 -54287 -53007 -50959, highest:  62223  62479  63502  64526  65039
## ---------------------------------------------------------------------------
## cp_42 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1038        1     2232     3398    -4029    -3990 
##      .25      .50      .75      .90      .95 
##     3702     3959     4034     4109     4132 
## 
## lowest : -64014 -63502 -52239 -50959 -47375, highest:  61454  62734  63502  63503  64783
## ---------------------------------------------------------------------------
## cp_43 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1097        1     1573     3970    -4037    -4015 
##      .25      .50      .75      .90      .95 
##    -3908     3922     4034     4107     4132 
## 
## lowest : -64782 -64270 -55823 -53519 -50703, highest:  62735  63758  64015  64782  65039
## ---------------------------------------------------------------------------
## cp_44 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1080        1     1864     3738    -4035    -4008 
##      .25      .50      .75      .90      .95 
##    -3851     3941     4035     4106     4133 
## 
## lowest : -64526 -62734 -52239 -51215 -47631, highest:  61711  62734  62735  64014  64016
## ---------------------------------------------------------------------------
## cp_45 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1087        1     1594     3931    -4037    -4015 
##      .25      .50      .75      .90      .95 
##    -3901     3929     4033     4108     4131 
## 
## lowest : -62991 -55823 -55822 -53519 -52239, highest:  62734  62990  63502  64015  64782
## ---------------------------------------------------------------------------
## cp_46 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1047        1     1811     3797    -4034    -4010 
##      .25      .50      .75      .90      .95 
##    -3873     3941     4034     4109     4131 
## 
## lowest : -43791 -32015  -4135  -4132  -4131, highest:  63502  63759  64782  64783  65039
## ---------------------------------------------------------------------------
## cp_47 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1079        1     1634     3930    -4037    -4014 
##      .25      .50      .75      .90      .95 
##    -3904     3926     4032     4108     4135 
## 
## lowest : -43791 -32015  -4140  -4136  -4135, highest:  62478  62479  63502  64526  65039
## ---------------------------------------------------------------------------
## cp_48 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1071        1     1634     3934    -4038    -4011 
##      .25      .50      .75      .90      .95 
##    -3902     3926     4034     4107     4132 
## 
## lowest : -45071 -33295  -4136  -4133  -4127, highest:  63502  63759  64782  64783  65039
## ---------------------------------------------------------------------------
## cp_49 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1091        1     1593     3934    -4039    -4011 
##      .25      .50      .75      .90      .95 
##    -3891     3934     4033     4108     4131 
## 
## lowest : -65040 -61455 -55823 -55310 -53263, highest:  63758  64014  64015  64526  65039
## ---------------------------------------------------------------------------
## cp_50 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1051        1     1483     4004    -4039    -4015 
##      .25      .50      .75      .90      .95 
##    -3914     3922     4026     4109     4135 
## 
## lowest : -63759 -56847 -56846 -54543 -53263, highest:  63759  64014  64782  64783  65039
## ---------------------------------------------------------------------------
## cp_51 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1074        1     2178     3433    -4033    -4000 
##      .25      .50      .75      .90      .95 
##     3679     3956     4031     4108     4131 
## 
## lowest : -62735 -56847 -56590 -54543 -53263, highest:  64014  64015  64526  64527  65039
## ---------------------------------------------------------------------------
## cp_52 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1051        1     2102     3505    -4035    -4001 
##      .25      .50      .75      .90      .95 
##    -3765     3956     4033     4109     4132 
## 
## lowest : -63759 -57871 -57614 -54287 -53007, highest:  63502  63759  64015  64526  64783
## ---------------------------------------------------------------------------
## cp_53 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1065        1     1453     4024    -4038    -4012 
##      .25      .50      .75      .90      .95 
##    -3913     3926     4033     4109     4132 
## 
## lowest : -61199 -56591 -56078 -54031 -53007, highest:  62223  63246  63503  64526  64783
## ---------------------------------------------------------------------------
## cp_54 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1044        1     1860     3711    -4038    -4006 
##      .25      .50      .75      .90      .95 
##    -3846     3949     4033     4109     4132 
## 
## lowest : -64783 -61455 -55567 -55566 -53263, highest:  62478  62479  63758  63759  64782
## ---------------------------------------------------------------------------
## cp_55 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1070        1     1515     3974    -4041    -4014 
##      .25      .50      .75      .90      .95 
##    -3909     3928     4032     4111     4131 
## 
## lowest : -65039 -61455 -55567 -55566 -53263, highest:  62478  62735  63502  63759  64782
## ---------------------------------------------------------------------------
## cp_56 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1054        1     1811     3763    -4034    -4003 
##      .25      .50      .75      .90      .95 
##    -3857     3948     4035     4110     4132 
## 
## lowest : -64784 -61199 -55566 -55311 -54543, highest:  61454  62479  62734  63503  64783
## ---------------------------------------------------------------------------
## cp_57 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1043        1     1881     3699    -4037    -4005 
##      .25      .50      .75      .90      .95 
##    -3850     3948     4032     4109     4132 
## 
## lowest : -63759 -57871 -56334 -55567 -54287, highest:  62479  63502  63759  64526  64783
## ---------------------------------------------------------------------------
## cp_58 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33273    13468     1043        1     2005     3591    -4038    -4002 
##      .25      .50      .75      .90      .95 
##    -3805     3953     4033     4109     4132 
## 
## lowest : -63759 -56847 -56846 -54543 -53263, highest:  62735  63502  63759  64782  65039
## ---------------------------------------------------------------------------
## cp_59 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1049        1     2014     3594    -4033    -4001 
##      .25      .50      .75      .90      .95 
##    -3805     3953     4033     4109     4132 
## 
## lowest : -63759 -57871 -56591 -56334 -54287, highest:  62479  63502  63759  64526  64783
## ---------------------------------------------------------------------------
## cp_60 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1066        1     1785     3798    -4034    -4003 
##      .25      .50      .75      .90      .95 
##    -3864     3946     4035     4109     4132 
## 
## lowest : -62479 -57871 -56591 -55566 -54287, highest:  62479  63758  63759  64782  64783
## ---------------------------------------------------------------------------
## cp_61 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1070        1     1505     3997    -4037    -4015 
##      .25      .50      .75      .90      .95 
##    -3904     3930     4033     4108     4131 
## 
## lowest : -62479 -56591 -56334 -54287 -53007, highest:  63502  63759  64526  64782  64783
## ---------------------------------------------------------------------------
## cp_62 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1048        1     2000     3595    -4033    -3998 
##      .25      .50      .75      .90      .95 
##    -3805     3953     4029     4108     4132 
## 
## lowest : -62479 -56591 -56334 -54287 -53007, highest:  63502  63759  64526  64527  64783
## ---------------------------------------------------------------------------
## cp_63 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1048        1     2078     3603    -4030    -3995 
##      .25      .50      .75      .90      .95 
##    -3789     3953     4030     4109     4132 
## 
## lowest : -65039 -62223 -57615 -57358 -55311, highest:  62223  63502  63503  64526  64783
## ---------------------------------------------------------------------------
## cp_64 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1066        1     2017     3650    -4033    -3999 
##      .25      .50      .75      .90      .95 
##    -3806     3953     4033     4109     4132 
## 
## lowest : -64015 -62735 -56847 -56846 -54543, highest:  63502  63758  63759  64783  65039
## ---------------------------------------------------------------------------
## cp_65 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1041        1     2100     3603    -4026    -3995 
##      .25      .50      .75      .90      .95 
##    -3795     3955     4034     4110     4133 
## 
## lowest : -62223 -51983 -51726 -45839 -41231, highest:  63246  63502  64526  64783  65039
## ---------------------------------------------------------------------------
## cp_66 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1071        1     1641     3976    -4037    -4010 
##      .25      .50      .75      .90      .95 
##    -3894     3934     4032     4109     4132 
## 
## lowest : -65039 -64783 -61455 -55567 -55566, highest:  62479  63758  63759  64782  65038
## ---------------------------------------------------------------------------
## cp_67 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1051        1     1730     3940    -4035    -4010 
##      .25      .50      .75      .90      .95 
##    -3887     3936     4034     4112     4131 
## 
## lowest : -61455 -49935 -49934 -42767 -14863, highest:  63759  64015  64782  65038  65039
## ---------------------------------------------------------------------------
## cp_68 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1051        1     2090     3645    -4030    -3995 
##      .25      .50      .75      .90      .95 
##    -3800     3957     4035     4110     4132 
## 
## lowest : -61199 -51214 -45071 -15119  -4130, highest:  63504  63758  63760  64782  64783
## ---------------------------------------------------------------------------
## cp_69 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1040        1     2011     3717    -4030    -3999 
##      .25      .50      .75      .90      .95 
##    -3828     3950     4033     4107     4133 
## 
## lowest : -57871 -51215 -47375 -46095 -28687, highest:  63502  63758  63759  64782  65040
## ---------------------------------------------------------------------------
## cp_70 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1055        1     1474     4102    -4038    -4011 
##      .25      .50      .75      .90      .95 
##    -3914     3924     4029     4107     4132 
## 
## lowest : -65040 -64016 -62736 -55567 -55566, highest:  63502  63758  64782  64783  65039
## ---------------------------------------------------------------------------
## cp_71 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1065        1     1950     3737    -4033    -4001 
##      .25      .50      .75      .90      .95 
##    -3832     3950     4033     4107     4132 
## 
## lowest : -57871 -57614 -55567 -54287 -50959, highest:  62479  63502  63758  64526  64783
## ---------------------------------------------------------------------------
## cp_72 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1075        1     1754     3902    -4035    -4008 
##      .25      .50      .75      .90      .95 
##    -3875     3939     4030     4109     4133 
## 
## lowest : -65040 -62479 -57871 -56591 -56590, highest:  62479  63758  64014  64782  64783
## ---------------------------------------------------------------------------
## cp_73 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1080        1     2037     3647    -4033    -3998 
##      .25      .50      .75      .90      .95 
##    -3802     3952     4030     4106     4132 
## 
## lowest : -64783 -57615 -57358 -55311 -53007, highest:  63246  63503  64526  64527  64783
## ---------------------------------------------------------------------------
## cp_74 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1052        1     2083     3606    -4033    -3998 
##      .25      .50      .75      .90      .95 
##    -3784     3953     4031     4106     4132 
## 
## lowest : -64784 -63759 -61199 -56591 -55311, highest:  63246  63503  64526  64782  64783
## ---------------------------------------------------------------------------
## cp_75 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1068        1     1440     4108    -4037    -4012 
##      .25      .50      .75      .90      .95 
##    -3922     3914     4027     4106     4132 
## 
## lowest : -65039 -62223 -56591 -56078 -53007, highest:  62223  63246  63502  64526  64783
## ---------------------------------------------------------------------------
## cp_76 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1066        1     1806     3850    -4035    -4008 
##      .25      .50      .75      .90      .95 
##    -3863     3940     4032     4106     4133 
## 
## lowest : -65039 -64015 -62735 -55567 -55566, highest:  61455  63502  63758  63759  64782
## ---------------------------------------------------------------------------
## cp_77 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1051        1     1584     4038    -4038    -4011 
##      .25      .50      .75      .90      .95 
##    -3905     3929     4033     4110     4132 
## 
## lowest : -64015 -50190 -48655 -42767  -4137, highest:  62223  62478  63758  64015  65038
## ---------------------------------------------------------------------------
## cp_78 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1043        1     1562     4056    -4038    -4015 
##      .25      .50      .75      .90      .95 
##    -3916     3923     4033     4110     4132 
## 
## lowest : -50190 -47887 -41999  -4137  -4132, highest:  62734  62991  63247  64271  65294
## ---------------------------------------------------------------------------
## cp_79 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1080        1     1410     4130    -4041    -4018 
##      .25      .50      .75      .90      .95 
##    -3926     3916     4035     4111     4131 
## 
## lowest : -64272 -63503 -61967 -55055 -54542, highest:  62734  63247  64014  64271  65294
## ---------------------------------------------------------------------------
## cp_80 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1076        1     1611     4007    -4038    -4011 
##      .25      .50      .75      .90      .95 
##    -3900     3932     4033     4109     4132 
## 
## lowest : -62224 -60687 -54799 -54542 -52495, highest:  64014  64015  64271  64527  65295
## ---------------------------------------------------------------------------
## cp_81 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1050        1     2070     3637    -4029    -3997 
##      .25      .50      .75      .90      .95 
##    -3796     3956     4034     4109     4132 
## 
## lowest : -63247 -58639 -57359 -56846 -55055, highest:  62734  63247  64014  64272  65294
## ---------------------------------------------------------------------------
## cp_82 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1069        1     1757     3906    -4037    -4010 
##      .25      .50      .75      .90      .95 
##    -3881     3938     4034     4108     4131 
## 
## lowest : -64271 -58639 -57870 -56079 -55055, highest:  63246  63247  64014  64272  65294
## ---------------------------------------------------------------------------
## cp_83 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1051        1     1425     4138    -4037    -4015 
##      .25      .50      .75      .90      .95 
##    -3923     3918     4029     4108     4131 
## 
## lowest : -64527 -63247 -57103 -56590 -54799, highest:  62478  63247  63502  64782  64783
## ---------------------------------------------------------------------------
## cp_84 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1049        1     1992     3707    -4030    -3999 
##      .25      .50      .75      .90      .95 
##    -3821     3952     4035     4109     4133 
## 
## lowest : -64527 -62991 -57359 -56846 -54799, highest:  62991  64014  64271  65294  65295
## ---------------------------------------------------------------------------
## cp_85 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1075        1     1499     4085    -4042    -4015 
##      .25      .50      .75      .90      .95 
##    -3908     3926     4029     4108     4131 
## 
## lowest : -65039 -63759 -57871 -56591 -56334, highest:  63502  63758  63759  64527  64784
## ---------------------------------------------------------------------------
## cp_86 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1066        1     1407     4167    -4041    -4019 
##      .25      .50      .75      .90      .95 
##    -3930     3912     4032     4108     4136 
## 
## lowest : -7183 -4137 -4132 -4129 -4128, highest: 63502 63503 64526 64783 65039
## ---------------------------------------------------------------------------
## cp_87 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1050        1     1468     4133    -4038    -4012 
##      .25      .50      .75      .90      .95 
##    -3922     3918     4029     4109     4132 
## 
## lowest : -8463 -4137 -4132 -4128 -4127, highest: 63758 63759 64526 64783 65039
## ---------------------------------------------------------------------------
## cp_88 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1080        1     1774     3897    -4034    -4007 
##      .25      .50      .75      .90      .95 
##    -3879     3940     4036     4109     4132 
## 
## lowest : -65295 -63759 -56847 -56846 -55567, highest:  62735  63502  63758  64782  65039
## ---------------------------------------------------------------------------
## cp_89 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1065        1     1975     3719    -4036    -4004 
##      .25      .50      .75      .90      .95 
##    -3825     3949     4036     4109     4131 
## 
## lowest : -64272 -62223 -60687 -59406 -54542, highest:  62991  64014  64271  65294  65295
## ---------------------------------------------------------------------------
## cp_90 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1064        1     1538     4071    -4041    -4014 
##      .25      .50      .75      .90      .95 
##    -3912     3926     4032     4112     4131 
## 
## lowest : -63503 -63247 -60430 -58639 -58126, highest:  62223  62734  64014  64527  65038
## ---------------------------------------------------------------------------
## cp_91 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1084        1     1538     4063    -4037    -4014 
##      .25      .50      .75      .90      .95 
##    -3910     3926     4032     4111     4131 
## 
## lowest : -63503 -61967 -59150 -57359 -56846, highest:  63246  63247  64014  64271  65294
## ---------------------------------------------------------------------------
## cp_92 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1035        1     2224     3546    -4026    -3990 
##      .25      .50      .75      .90      .95 
##    -3701     3956     4035     4110     4129 
## 
## lowest : -60430 -51471 -32527 -12559  -4130, highest:  62734  64271  64272  65294  65295
## ---------------------------------------------------------------------------
## cp_93 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1083        1     1767     3914    -4035    -4007 
##      .25      .50      .75      .90      .95 
##    -3879     3937     4030     4107     4133 
## 
## lowest : -63247 -62991 -57359 -56846 -54799, highest:  62991  64270  64271  65038  65039
## ---------------------------------------------------------------------------
## cp_94 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1059        1     2066     3678    -4033    -3999 
##      .25      .50      .75      .90      .95 
##    -3802     3953     4033     4109     4132 
## 
## lowest : -65039 -62223 -57615 -56591 -56078, highest:  62223  63503  64526  64782  64783
## ---------------------------------------------------------------------------
## cp_95 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1074        1     1852     3870    -4033    -4003 
##      .25      .50      .75      .90      .95 
##    -3862     3944     4033     4109     4132 
## 
## lowest : -63248 -61967 -56079 -55822 -53775, highest:  64014  64270  64271  65294  65295
## ---------------------------------------------------------------------------
## cp_96 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    33272    13469     1080        1     1815     3927    -4030    -4001 
##      .25      .50      .75      .90      .95 
##    -3866     3937     4036     4106     4129 
## 
## lowest : -4125 -4124 -4121 -4120 -4119, highest: 62735 63502 63759 64782 65038
## ---------------------------------------------------------------------------
## 12V battery (amps) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0      623    0.823   -22.33    38.33 -128.000 -128.000 
##      .25      .50      .75      .90      .95 
##    0.000    0.000    0.000    1.605    2.340 
## 
## lowest : -128.00000 -127.99609 -127.99219 -127.98828 -127.98438
## highest:   29.08594   29.57422   29.82031   39.88281   40.61719
## ---------------------------------------------------------------------------
## Hx 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0      801        1    77.45     16.7    50.38    50.43 
##      .25      .50      .75      .90      .95 
##    50.60    86.20    87.32    88.87    90.68 
## 
## lowest :   0.00000  10.49805  12.99805  20.49805  22.99805
## highest: 605.49805 610.49805 615.49805 620.49805 625.49805
## ---------------------------------------------------------------------------
## VIN 
##        n  missing distinct 
##    19213    27528        3 
##                                                              
## Value           AZE0-120351       ZE0-003619 ZE0-003619003619
## Frequency              6889            12323                1
## Proportion            0.359            0.641            0.000
## ---------------------------------------------------------------------------
## 12V battery (volts) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0       39    0.779    5.691    6.456     0.00     0.00 
##      .25      .50      .75      .90      .95 
##     0.00     0.00    12.96    12.96    12.96 
## 
## lowest :  0.00 11.68 11.76 11.84 11.92, highest: 14.32 14.40 14.48 14.64 14.72
## ---------------------------------------------------------------------------
## 12V battery (dashboard) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0       47    0.277    1.313    2.359      0.0      0.0 
##      .25      .50      .75      .90      .95 
##      0.0      0.0      0.0     12.1     12.8 
## 
## lowest :  0.0 10.5 10.6 10.7 10.8, highest: 14.6 14.7 14.8 15.0 25.5
## ---------------------------------------------------------------------------
## ACC (V) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0      514    0.983    12.72   0.5995    12.03    12.61 
##      .25      .50      .75      .90      .95 
##    12.64    12.66    12.83    12.89    13.98 
##                                                                       
## Value        0.0  11.5  12.0  12.5  13.0  13.5  14.0  14.5  16.0  31.5
## Frequency    301   261  2574 29563 10137   152  3433   280     1     1
## Proportion 0.006 0.006 0.055 0.632 0.217 0.003 0.073 0.006 0.000 0.000
##                                         
## Value       34.0  35.0  60.0  63.0  64.0
## Frequency      1     1     1     1    34
## Proportion 0.000 0.000 0.000 0.000 0.001
## ---------------------------------------------------------------------------
## ODO 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0     5159    0.452     7601    12770        0        0 
##      .25      .50      .75      .90      .95 
##        0        0        0    35373    53611 
##                                                                       
## Value          0 32000 32500 33000 33500 34000 34500 35000 35500 36000
## Frequency  38251   392   468   447   631   579   580   584   556   609
## Proportion 0.818 0.008 0.010 0.010 0.013 0.012 0.012 0.012 0.012 0.013
##                                               
## Value      36500 53000 53500 54000 54500 55000
## Frequency    404   346   772   833  1045   244
## Proportion 0.009 0.007 0.017 0.018 0.022 0.005
## ---------------------------------------------------------------------------
## SOH 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0      218    0.976    60.62       40     0.00     0.00 
##      .25      .50      .75      .90      .95 
##     0.00    72.38    92.37    93.02    94.11 
##                                                                       
## Value          0    72    73    91    92    93    94    95    96    97
## Frequency  13470 11996   350   475 11598  6363   932   371   309   877
## Proportion 0.288 0.257 0.007 0.010 0.248 0.136 0.020 0.008 0.007 0.019
## ---------------------------------------------------------------------------
## SOH (version 2) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0      515    0.974    59.94    40.57     0.00     0.00 
##      .25      .50      .75      .90      .95 
##     0.00    72.39    92.37    93.01    94.11 
##                                                                       
## Value          0    52    72    73    91    92    93    94    95    96
## Frequency  13897    57 11189   673   412 11601  6381   966   369   353
## Proportion 0.297 0.001 0.239 0.014 0.009 0.248 0.137 0.021 0.008 0.008
##                 
## Value         97
## Frequency    843
## Proportion 0.018
## ---------------------------------------------------------------------------
## ambient_temp_1 
##        n  missing distinct 
##    12487    34254       20 
##                                                                       
## Value          0    10    11    12    13    14    15    16    17    18
## Frequency    104   265   985  1057   687  2145  1011  1231  1516   462
## Proportion 0.008 0.021 0.079 0.085 0.055 0.172 0.081 0.099 0.121 0.037
##                                                                       
## Value         19    20    21    22     4     5     6     7     8     9
## Frequency    433    53    44     3   278    24   239   730   414   806
## Proportion 0.035 0.004 0.004 0.000 0.022 0.002 0.019 0.058 0.033 0.065
## ---------------------------------------------------------------------------
## cabin_temp_1 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    20465    26276       84    0.901    115.2    98.23    11.67    13.89 
##      .25      .50      .75      .90      .95 
##    17.22    75.00   214.00   214.00   214.00 
## 
## lowest :   0.000000   2.777778   3.333333   3.888889   4.444444
## highest:  83.000000  84.000000  85.000000 101.111111 214.000000
## ---------------------------------------------------------------------------
## cabin_temp_2 
##        n  missing distinct 
##    12487    34254       37 
## 
## lowest : 0   214 51  52  53 , highest: 81  82  83  84  85 
## ---------------------------------------------------------------------------
## QC count 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0       25    0.818    67.54    80.18        0        0 
##      .25      .50      .75      .90      .95 
##        0        0      168      172      175 
## 
## lowest :   0 122 123 124 125, highest: 171 172 173 174 175
## ---------------------------------------------------------------------------
## L1/L2 count 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0      232    0.822    725.6    888.8        0        0 
##      .25      .50      .75      .90      .95 
##        0        0     1914     1966     1985 
##                                                                       
## Value          0  1120  1140  1160  1180  1200  1220  1240  1260  1280
## Frequency  26285   879   994   784   686   768   873   821   768  1246
## Proportion 0.562 0.019 0.021 0.017 0.015 0.016 0.019 0.018 0.016 0.027
##                                                     
## Value       1300  1900  1920  1940  1960  1980  2000
## Frequency    254    83  3573  2330  2159  2524  1714
## Proportion 0.005 0.002 0.076 0.050 0.046 0.054 0.037
## ---------------------------------------------------------------------------
## Charger (amps) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0       15    0.486    3.146    5.043     0.00     0.00 
##      .25      .50      .75      .90      .95 
##     0.00     0.00     0.00    15.62    15.62 
##                                                                           
## Value       0.0000 15.5000 15.5625 15.6250 15.6875 15.7500 15.8125 15.8750
## Frequency    37392      19    2128    6089     835      30      33      98
## Proportion   0.800   0.000   0.046   0.130   0.018   0.001   0.001   0.002
##                                                                   
## Value      15.9375 16.0000 16.0625 16.1250 16.1875 33.3750 33.4375
## Frequency       35       6       2      17       2       8      47
## Proportion   0.001   0.000   0.000   0.000   0.000   0.000   0.001
## ---------------------------------------------------------------------------
## Charger (V) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0      144    0.601    40.88    67.91    0.000    0.000 
##      .25      .50      .75      .90      .95 
##    0.000    0.000    1.055  240.117  241.852 
## 
## lowest :   0.000000   1.054688   1.562500   2.250000   3.976562
## highest: 248.406250 248.585938 249.093750 249.273438 249.445312
## ---------------------------------------------------------------------------
## h_volt_1 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0     4439        1    377.8    16.11    361.5    366.2 
##      .25      .50      .75      .90      .95 
##    373.8    381.0    386.9    392.2    396.4 
##                                                                       
## Value          0     5    60    80   170   245   335   340   345   350
## Frequency    301     1     1     1     1     1     1     4    24   171
## Proportion 0.006 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.001 0.004
##                                                                       
## Value        355   360   365   370   375   380   385   390   395   655
## Frequency    641  1644  2875  4606  6181 10014 10004  5739  4493    38
## Proportion 0.014 0.035 0.062 0.099 0.132 0.214 0.214 0.123 0.096 0.001
## ---------------------------------------------------------------------------
## Motor temp 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0       86    0.975    25.12    25.15        0        0 
##      .25      .50      .75      .90      .95 
##        0       23       31       68       73 
## 
## lowest :  0  6  7  8  9, highest: 88 89 90 91 92
## ---------------------------------------------------------------------------
## inverter_2 temp 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0       67      0.6       13    20.73        0        0 
##      .25      .50      .75      .90      .95 
##        0        0       17       63       67 
## 
## lowest :  0  8  9 10 11, highest: 81 82 83 84 86
## ---------------------------------------------------------------------------
## inverter_4 temp 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0       65    0.599    13.32    21.25        0        0 
##      .25      .50      .75      .90      .95 
##        0        0       16       64       69 
## 
## lowest :  0  6  7  8  9, highest: 78 79 80 81 82
## ---------------------------------------------------------------------------
## motor_amp (1) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0      940    0.763    372.3    666.8        0        0 
##      .25      .50      .75      .90      .95 
##        0        0       69      286     4025 
## 
## lowest :    0    1    2    3    4, highest: 4091 4092 4093 4094 4095
## ---------------------------------------------------------------------------
## motor_amp (2) 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0      714    0.759    367.2    658.8        0        0 
##      .25      .50      .75      .90      .95 
##        0        0       68      271     4042 
## 
## lowest :    0    1    2    3    4, highest: 4091 4092 4093 4094 4095
## ---------------------------------------------------------------------------
## throttle 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0      131     0.67    10.06     15.5        0        0 
##      .25      .50      .75      .90      .95 
##        0        0       21       36       44 
## 
## lowest :   0   1   2   3   4, highest: 145 146 148 157 199
## ---------------------------------------------------------------------------
## target_regen_braking_1 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0      260    0.042     6.38    12.68        0        0 
##      .25      .50      .75      .90      .95 
##        0        0        0        0        0 
## 
## lowest :    0    2    6   10   14, highest: 1802 1874 1918 2042 2110
## ---------------------------------------------------------------------------
## target_regen_braking_2 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    46741        0      519    0.088    34.78     68.5        0        0 
##      .25      .50      .75      .90      .95 
##        0        0        0        0        0 
## 
## lowest :    0    4    8   12   16, highest: 3904 3920 4024 4088 4092
## ---------------------------------------------------------------------------
## is_climate_on 
##        n  missing distinct 
##    34254    12487        2 
##                       
## Value      false  true
## Frequency  33222  1032
## Proportion  0.97  0.03
## ---------------------------------------------------------------------------
## climate_power 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    34254    12487       16    0.162  0.05993   0.1157      0.0      0.0 
##      .25      .50      .75      .90      .95 
##      0.0      0.0      0.0      0.0      0.5 
##                                                                       
## Value       0.00  0.25  0.50  1.00  1.50  2.00  2.50  3.00  3.50  4.00
## Frequency  32292     4  1053   571   105    53    44    22    28    16
## Proportion 0.943 0.000 0.031 0.017 0.003 0.002 0.001 0.001 0.001 0.000
##                                               
## Value       4.50  5.00  5.50  6.00  6.50  7.00
## Frequency     16    18    14     9     6     3
## Proportion 0.000 0.001 0.000 0.000 0.000 0.000
## ---------------------------------------------------------------------------
## ambient_510 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    34254    12487       67    0.937   -6.432    8.123  -15.000  -14.444 
##      .25      .50      .75      .90      .95 
##  -13.333  -11.111    0.000    0.000    6.111 
## 
## lowest : -18.33333 -17.77778 -17.22222 -16.66667 -16.11111
## highest:  17.22222  18.33333  18.88889  19.44444  92.77778
## ---------------------------------------------------------------------------
## climate_point 
##        n  missing distinct     Info     Mean      Gmd 
##    34254    12487        9    0.844    19.44    20.84 
##                                                                 
## Value          0    36    37    38    39    40    41    42    43
## Frequency  18037     1   915   577   967  2205  2736  7041  1775
## Proportion 0.527 0.000 0.027 0.017 0.028 0.064 0.080 0.206 0.052
## ---------------------------------------------------------------------------
## ambient_54a 
##        n  missing distinct     Info     Mean      Gmd 
##    34254    12487        1        0        0        0 
##                 
## Value          0
## Frequency  34254
## Proportion     1
## ---------------------------------------------------------------------------
## speed1_355 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    34254    12487     3455    0.327    778.9     1417        0        0 
##      .25      .50      .75      .90      .95 
##        0        0        0     3282     7312 
## 
## lowest :     0   294   295   298   311, highest: 11400 11478 11524 11574 11735
## ---------------------------------------------------------------------------
## speed2_355 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    34254    12487     3456    0.337     1099     2033        0        0 
##      .25      .50      .75      .90      .95 
##        0        0        0     3901     8149 
## 
## lowest :     0   311   312   316   330, highest: 12170 12219 12271 12443 65535
## ---------------------------------------------------------------------------
## dash_units1 
##        n  missing distinct    value 
##     5251    41490        1       km 
##                
## Value        km
## Frequency  5251
## Proportion    1
## ---------------------------------------------------------------------------
## dash_odo_units2 
##        n  missing distinct    value 
##     5251    41490        1       km 
##                
## Value        km
## Frequency  5251
## Proportion    1
## ---------------------------------------------------------------------------
## gear 
##        n  missing distinct 
##    17945    28796        5 
##                                         
## Value          D     E     N     P     R
## Frequency   1957 14016     3  1842   127
## Proportion 0.109 0.781 0.000 0.103 0.007
## ---------------------------------------------------------------------------
## vcm_soc 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    34254    12487      777    0.571    16.02    25.41     0.00     0.00 
##      .25      .50      .75      .90      .95 
##     0.00     0.00     0.00    70.00    80.83 
## 
## lowest :   0.0  16.1  16.4  17.4  17.6, highest:  97.5  97.6  97.7  97.8 102.3
## ---------------------------------------------------------------------------
## vcm_hv_bat_volt 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    34254    12487      112    0.572    186.6    282.7        0        0 
##      .25      .50      .75      .90      .95 
##        0        0        0      763      773 
##                                                                       
## Value          0   680   690   700   710   720   730   740   750   760
## Frequency  25820     6     7    39    98   387   521  1034  1198  2173
## Proportion 0.754 0.000 0.000 0.001 0.003 0.011 0.015 0.030 0.035 0.063
##                                   
## Value        770   780   790  1020
## Frequency   1443   843   679     6
## Proportion 0.042 0.025 0.020 0.000
## ---------------------------------------------------------------------------
## vcm_hv_bat_current 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    34254    12487      440    0.556   -544.2     4130   -12289     -257 
##      .25      .50      .75      .90      .95 
##        0        0        0     3072     3840 
## 
## lowest : -32768 -32513 -32512 -32257 -32001, highest:  32255  32256  32511  32512  32767
## ---------------------------------------------------------------------------
## vcm_hv_bat_temp 
##        n  missing distinct     Info     Mean      Gmd 
##    34254    12487        7    0.569    22.66    34.95 
##                                                     
## Value          0    80   100   120   140   160   255
## Frequency  25800  4170  3842   245   151    39     7
## Proportion 0.753 0.122 0.112 0.007 0.004 0.001 0.000
## ---------------------------------------------------------------------------
## hist_l1l2_count 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    34254    12487      141    0.894    627.3    608.3        0        0 
##      .25      .50      .75      .90      .95 
##        0     1117     1196     1241     1257 
##                                                                       
## Value          0  1110  1120  1130  1140  1150  1160  1170  1180  1190
## Frequency  16189   206  1438   961  1596  1536  1301   583   965   841
## Proportion 0.473 0.006 0.042 0.028 0.047 0.045 0.038 0.017 0.028 0.025
##                                                                       
## Value       1200  1210  1220  1230  1240  1250  1260  1270  1280  1290
## Frequency   1390   961  1384   559  1286   846  1414   725    40    33
## Proportion 0.041 0.028 0.040 0.016 0.038 0.025 0.041 0.021 0.001 0.001
## ---------------------------------------------------------------------------
## hist_qc_count 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    34254    12487       17    0.849    72.86     69.7        0        0 
##      .25      .50      .75      .90      .95 
##        0      132      140      140      140 
##                                                                       
## Value          0   131   132   133   134   135   136   137   138   139
## Frequency  16189   142  3827    38    10    99    41    98    53   822
## Proportion 0.473 0.004 0.112 0.001 0.000 0.003 0.001 0.003 0.002 0.024
##                                                     
## Value        140   141   142   143   144   145   146
## Frequency  12081   847     1     1     3     1     1
## Proportion 0.353 0.025 0.000 0.000 0.000 0.000 0.000
## ---------------------------------------------------------------------------
## hist_avg_temp_per_drive <35 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    18065    28676      359        1     5084    109.7     4945     4958 
##      .25      .50      .75      .90      .95 
##     4991     5081     5162     5214     5239 
## 
## lowest : 4933 4934 4935 4936 4937, highest: 5302 5303 5304 5305 5306
## ---------------------------------------------------------------------------
## hist_avg_temp_per_drive 35-40 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        4    0.546    156.3    1.077 
##                                   
## Value        154   155   156   157
## Frequency   4170    55    85 13755
## Proportion 0.231 0.003 0.005 0.761
## ---------------------------------------------------------------------------
## hist_avg_temp_per_drive 40-45 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        3    0.542    5.764   0.3612 
##                             
## Value          5     6     7
## Frequency   4271 13793     1
## Proportion 0.236 0.764 0.000
## ---------------------------------------------------------------------------
## hist_avg_temp_per_drive 45-50 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_avg_temp_per_drive 50-55 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_avg_temp_per_drive 55-60 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_avg_temp_per_drive 60-65 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_avg_temp_per_drive >65 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_avg_temp_per_charge <35 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    18065    28676      151        1     1242    54.41     1170     1179 
##      .25      .50      .75      .90      .95 
##     1201     1242     1283     1307     1316 
## 
## lowest : 1165 1166 1167 1169 1170, highest: 1346 1347 1348 1349 1350
## ---------------------------------------------------------------------------
## hist_avg_temp_per_charge 35-40 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        4    0.546    35.29     1.08 
##                                   
## Value         33    34    35    36
## Frequency   4201    54    53 13757
## Proportion 0.233 0.003 0.003 0.762
## ---------------------------------------------------------------------------
## hist_avg_temp_per_charge 40-45 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_avg_temp_per_charge 45-50 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_avg_temp_per_charge 50-55 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_avg_temp_per_charge 55-60 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_avg_temp_per_charge 60-65 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_avg_temp_per_charge >65 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_max_temp_per_drive <35 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    18065    28676      360        1     5064    109.3     4925     4939 
##      .25      .50      .75      .90      .95 
##     4971     5061     5141     5193     5218 
## 
## lowest : 4913 4914 4915 4916 4917, highest: 5282 5283 5284 5285 5286
## ---------------------------------------------------------------------------
## hist_max_temp_per_drive 35-40 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        4    0.541    173.3    1.071 
##                                   
## Value        171   172   173   174
## Frequency   4157    44    54 13810
## Proportion 0.230 0.002 0.003 0.764
## ---------------------------------------------------------------------------
## hist_max_temp_per_drive 40-45 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        3    0.548    8.521   0.7285 
##                             
## Value          7     8     9
## Frequency   4310    32 13723
## Proportion 0.239 0.002 0.760
## ---------------------------------------------------------------------------
## hist_max_temp_per_drive 45-50 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_max_temp_per_drive 50-55 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_max_temp_per_drive 55-60 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_max_temp_per_drive 60-65 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_max_temp_per_drive >65 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_max_temp_per_charge <35 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    18065    28676      177        1     1219    54.07     1149     1157 
##      .25      .50      .75      .90      .95 
##     1178     1219     1260     1285     1293 
## 
## lowest : 1143 1144 1145 1146 1147, highest: 1323 1324 1325 1326 1327
## ---------------------------------------------------------------------------
## hist_max_temp_per_charge 35-40 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        5    0.546     54.3    1.077 
##                                         
## Value         52    53    54    55    56
## Frequency   4170    55    85 13754     1
## Proportion 0.231 0.003 0.005 0.761 0.000
## ---------------------------------------------------------------------------
## hist_max_temp_per_charge 40-45 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        2    0.542    2.764   0.3611 
##                       
## Value          2     3
## Frequency   4271 13794
## Proportion 0.236 0.764
## ---------------------------------------------------------------------------
## hist_max_temp_per_charge 45-50 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_max_temp_per_charge 50-55 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_max_temp_per_charge 55-60 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_max_temp_per_charge 60-65 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_max_temp_per_charge >65 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## hist_SOC_at_beginning_of_charge 0-20 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        4    0.936    13.47    1.215 
##                                   
## Value         12    13    14    15
## Frequency   4343  4963  4669  4090
## Proportion 0.240 0.275 0.258 0.226
## ---------------------------------------------------------------------------
## hist_SOC_at_beginning_of_charge 20-30 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        7    0.876    55.55    1.775 
##                                                     
## Value         52    53    54    55    56    57    58
## Frequency    142  3865  2175   320  2925  8601    37
## Proportion 0.008 0.214 0.120 0.018 0.162 0.476 0.002
## ---------------------------------------------------------------------------
## hist_SOC_at_beginning_of_charge 30-40 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    18065    28676       24    0.986    98.62    5.294       91       92 
##      .25      .50      .75      .90      .95 
##       96       99      102      105      107 
## 
## lowest :  90  91  92  93  94, highest: 109 110 111 112 113
## ---------------------------------------------------------------------------
## hist_SOC_at_beginning_of_charge 40-50 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    18065    28676       15    0.976      143    3.423      137      137 
##      .25      .50      .75      .90      .95 
##      142      143      145      147      147 
##                                                                       
## Value        136   137   138   139   140   141   142   143   144   145
## Frequency     65  1842   663   714   775    98   973  4032  3326  1403
## Proportion 0.004 0.102 0.037 0.040 0.043 0.005 0.054 0.223 0.184 0.078
##                                         
## Value        146   147   148   149   150
## Frequency   1040  3101     7    24     2
## Proportion 0.058 0.172 0.000 0.001 0.000
## ---------------------------------------------------------------------------
## hist_SOC_at_beginning_of_charge 50-60 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    18065    28676       19    0.974    203.1    4.239      197      198 
##      .25      .50      .75      .90      .95 
##      199      203      206      208      208 
##                                                                       
## Value        197   198   199   200   201   202   203   204   205   206
## Frequency   1495  2474   712   818   238   348  4031   112  1172  3759
## Proportion 0.083 0.137 0.039 0.045 0.013 0.019 0.223 0.006 0.065 0.208
##                                                                 
## Value        207   208   209   210   211   212   213   214   215
## Frequency    290  2239   112   200     9    28     7    16     5
## Proportion 0.016 0.124 0.006 0.011 0.000 0.002 0.000 0.001 0.000
## ---------------------------------------------------------------------------
## hist_SOC_at_beginning_of_charge 60-70 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    18065    28676       12     0.98    93.61    3.949       89       89 
##      .25      .50      .75      .90      .95 
##       91       93       97       99       99 
##                                                                       
## Value         89    90    91    92    93    94    95    96    97    98
## Frequency   2201  1816  3399   591  1899   617  2757   240   112  1232
## Proportion 0.122 0.101 0.188 0.033 0.105 0.034 0.153 0.013 0.006 0.068
##                       
## Value         99   100
## Frequency   3185    16
## Proportion 0.176 0.001
## ---------------------------------------------------------------------------
## hist_SOC_at_beginning_of_charge 70-85 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        3    0.514    87.73   0.4388 
##                             
## Value         86    87    88
## Frequency    950  2959 14156
## Proportion 0.053 0.164 0.784
## ---------------------------------------------------------------------------
## hist_SOC_at_beginning_of_charge >85 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0       84        0 
##                 
## Value         84
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## unknown_group7_0 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        2    0.548    14.76   0.3652 
##                       
## Value         14    15
## Frequency   4342 13723
## Proportion  0.24  0.76
## ---------------------------------------------------------------------------
## unknown_group7_1 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        5     0.82    59.64   0.8149 
##                                         
## Value         58    59    60    61    62
## Frequency    139  9207  6499  1420   800
## Proportion 0.008 0.510 0.360 0.079 0.044
## ---------------------------------------------------------------------------
## unknown_group7_2 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    18065    28676       12    0.971    156.3    4.521      151      151 
##      .25      .50      .75      .90      .95 
##      152      156      160      162      162 
##                                                                       
## Value        151   152   153   154   155   156   157   158   159   160
## Frequency   2601  3889    93    71  1927   697   121    82  2354  4000
## Proportion 0.144 0.215 0.005 0.004 0.107 0.039 0.007 0.005 0.130 0.221
##                       
## Value        162   163
## Frequency   2192    38
## Proportion 0.121 0.002
## ---------------------------------------------------------------------------
## unknown_group7_3 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    18065    28676       32    0.979    339.2    8.256      328      331 
##      .25      .50      .75      .90      .95 
##      333      340      343      351      351 
## 
## lowest : 328 329 330 331 332, highest: 355 356 358 359 360
## ---------------------------------------------------------------------------
## unknown_group7_4 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    18065    28676       63    0.997    719.4     14.6      696      700 
##      .25      .50      .75      .90      .95 
##      708      723      728      733      740 
## 
## lowest : 692 693 694 695 696, highest: 751 752 753 754 755
## ---------------------------------------------------------------------------
## unknown_group7_5 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    18065    28676       88    0.998    982.6    31.79      944      945 
##      .25      .50      .75      .90      .95 
##      952      981     1011     1019     1021 
## 
## lowest :  940  941  942  943  944, highest: 1028 1029 1030 1031 1032
## ---------------------------------------------------------------------------
## unknown_group7_6 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    18065    28676      102    0.999     1371    29.64     1335     1338 
##      .25      .50      .75      .90      .95 
##     1350     1371     1389     1409     1419 
## 
## lowest : 1334 1335 1336 1337 1338, highest: 1434 1435 1436 1437 1438
## ---------------------------------------------------------------------------
## unknown_group7_7 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    18065    28676       69    0.998     1602    21.17     1576     1578 
##      .25      .50      .75      .90      .95 
##     1584     1598     1618     1626     1632 
## 
## lowest : 1574 1575 1576 1577 1578, highest: 1640 1641 1642 1643 1644
## ---------------------------------------------------------------------------
## unknown_group9_0 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## unknown_group9_1 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## unknown_group9_2 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## unknown_group9_3 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## unknown_group9_4 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## unknown_group9_5 
##        n  missing distinct     Info     Mean      Gmd 
##    18065    28676        1        0        0        0 
##                 
## Value          0
## Frequency  18065
## Proportion     1
## ---------------------------------------------------------------------------
## unknown_group9_6 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    18065    28676       26    0.987    154.3     7.43      146      147 
##      .25      .50      .75      .90      .95 
##      147      155      160      163      165 
## 
## lowest : 146 147 148 149 150, highest: 167 168 169 170 171
## ---------------------------------------------------------------------------
## unknown_group9_7 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    18065    28676       27    0.995    291.9    9.623      279      280 
##      .25      .50      .75      .90      .95 
##      286      291      299      305      305 
## 
## lowest : 278 279 280 281 282, highest: 304 305 307 308 309
## ---------------------------------------------------------------------------
## cell_utc_date_time 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##     2252    44489      441    0.999   -43.38   0.1177   -43.52   -43.49 
##      .25      .50      .75      .90      .95 
##   -43.40   -43.40   -43.40   -43.32   -43.16 
## 
## lowest : -43.61222 -43.60444 -43.56204 -43.55616 -43.55409
## highest: -42.52802 -42.52552 -42.52552 -42.52545 -42.51972
## ---------------------------------------------------------------------------
## cell_latitude 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##     2252    44489      440    0.999    172.6  0.04169    172.6    172.6 
##      .25      .50      .75      .90      .95 
##    172.6    172.6    172.6    172.7    172.7 
## 
## lowest : 172.3860 172.3907 172.4874 172.5092 172.5200
## highest: 172.8255 172.8257 172.8318 172.8663 172.8671
## ---------------------------------------------------------------------------
## cell_longitude 
##                   n             missing            distinct 
##                2252               44489                2252 
##                Info                Mean                 Gmd 
##                   1 2018-08-03 10:33:24 1970-01-17 20:56:26 
##                 .05                 .10                 .25 
## 2018-07-13 01:37:41 2018-07-15 18:09:55 2018-07-20 15:30:24 
##                 .50                 .75                 .90 
## 2018-08-02 05:16:40 2018-08-15 04:04:51 2018-08-24 16:47:45 
##                 .95 
## 2018-08-27 06:20:58 
## 
## lowest : 2018-07-11 23:05:40 2018-07-11 23:29:40 2018-07-11 23:34:07 2018-07-11 23:56:33 2018-07-12 00:10:58
## highest: 2018-09-06 03:14:09 2018-09-06 03:17:05 2018-09-06 03:17:57 2018-09-06 03:18:47 2018-09-07 01:25:45
## ---------------------------------------------------------------------------
## ambient_54c 
##        n  missing distinct 
##    26022    20719       34 
## 
## lowest : -0.5555555555555555555555555556 -1.1111111111111111111111111111 -1.6666666666666666666666666667 0.0                             0.5555555555555555555555555556 
## highest: 7.7777777777777777777777777778  8.333333333333333333333333333   8.888888888888888888888888889   9.444444444444444444444444444   92.77777777777777777777777778  
## ---------------------------------------------------------------------------
## ambient_56f 
##        n  missing distinct    value 
##    26022    20719        1      0.0 
##                 
## Value          0
## Frequency  26022
## Proportion     1
## ---------------------------------------------------------------------------
## rDate 
##        n  missing distinct 
##    29269    17472       97 
## 
## lowest : 2018-05-01 2018-05-02 2018-05-03 2018-05-04 2018-05-05
## highest: 2018-09-04 2018-09-05 2018-09-06 2018-09-07 2018-09-08
## ---------------------------------------------------------------------------
## rTime [secs] 
##        n  missing distinct 
##    29269    17472    21091 
## 
## lowest : 00:00:06 00:00:13 00:00:25 00:00:34 00:00:35
## highest: 23:59:34 23:59:35 23:59:40 23:59:41 23:59:51
## ---------------------------------------------------------------------------
## rDateTime 
##                   n             missing            distinct 
##               29269               17472               25512 
##                Info                Mean                 Gmd 
##                   1 2018-07-08 00:58:29 1970-02-17 12:15:06 
##                 .05                 .10                 .25 
## 2018-05-05 17:29:02 2018-05-08 13:05:36 2018-05-24 21:12:53 
##                 .50                 .75                 .90 
## 2018-07-19 08:24:43 2018-08-12 09:58:54 2018-08-27 16:54:10 
##                 .95 
## 2018-09-04 12:57:43 
## 
## lowest : 2018-05-01 12:42:27 2018-05-01 12:43:08 2018-05-01 12:44:16 2018-05-01 12:44:30 2018-05-01 12:45:53
## highest: 2018-09-08 15:23:07 2018-09-08 15:23:57 2018-09-08 15:24:48 2018-09-08 15:26:54 2018-09-08 15:27:48
## ---------------------------------------------------------------------------
## rDow 
##        n  missing distinct 
##    29269    17472        7 
##                                                     
## Value        Sun   Mon   Tue   Wed   Thu   Fri   Sat
## Frequency   3480  3259  3954  3450  4216  5391  5519
## Proportion 0.119 0.111 0.135 0.118 0.144 0.184 0.189
## ---------------------------------------------------------------------------
## obsHour 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##    29269    17472       24    0.996    9.343    7.816        1        1 
##      .25      .50      .75      .90      .95 
##        3        9       16       19       21 
## 
## lowest :  0  1  2  3  4, highest: 19 20 21 22 23
## ---------------------------------------------------------------------------
## homeMinLat 
##        n  missing distinct     Info     Mean      Gmd 
##    46741        0        1        0   -43.37        0 
##                     
## Value      -43.37455
## Frequency      46741
## Proportion         1
## ---------------------------------------------------------------------------
## homeMaxLat 
##        n  missing distinct     Info     Mean      Gmd 
##    46741        0        1        0   -36.63        0 
##                     
## Value      -36.62688
## Frequency      46741
## Proportion         1
## ---------------------------------------------------------------------------
## homeMinLon 
##        n  missing distinct     Info     Mean      Gmd 
##    46741        0        1        0    172.6        0 
##                    
## Value      172.5778
## Frequency     46741
## Proportion        1
## ---------------------------------------------------------------------------
## homeMaxLon 
##        n  missing distinct     Info     Mean      Gmd 
##    46741        0        1        0    174.7        0 
##                    
## Value      174.7384
## Frequency     46741
## Proportion        1
## ---------------------------------------------------------------------------
## geoLoc 
##        n  missing distinct 
##    30889    15852        2 
##                             
## Value          Home Not home
## Frequency     20852    10037
## Proportion    0.675    0.325
## ---------------------------------------------------------------------------
## evID 
##        n  missing distinct 
##    46741        0        2 
##                                                    
## Value      97bcda40ef879efb497bc4e62be99a0ac6d3a59d
## Frequency                                     34254
## Proportion                                    0.733
##                                                    
## Value      b96bb2b1c72af9031800a8ac18d27d01d634ee76
## Frequency                                     12487
## Proportion                                    0.267
## ---------------------------------------------------------------------------
```






# Save safe data out

Save the safe data for future use and gzip it.


```
## Gziping /Volumes/hum-csafe/Research Projects/GREEN Grid/externalData/flipTheFleet/safe/ftfSafeLatestAll.csv
```

```
## Gzipped /Volumes/hum-csafe/Research Projects/GREEN Grid/externalData/flipTheFleet/safe/ftfSafeLatestAll.csv
```

Gzipped the file to reduce it from 40.39 MB to 4.68 MB.

# Runtime




Analysis completed in 30.59 seconds ( 0.51 minutes) using [knitr](https://cran.r-project.org/package=knitr) in [RStudio](http://www.rstudio.com) with R version 3.5.1 (2018-07-02) running on x86_64-apple-darwin15.6.0.

# R environment

R packages used:

 * base R - for the basics [@baseR]
 * data.table - for fast (big) data handling [@data.table]
 * lubridate - date manipulation [@lubridate]
 * ggplot2 - for slick graphics [@ggplot2]
 * readr - for csv reading/writing [@readr]
 * Hmisc - for describe [@Hmisc]
 * knitr - to create this document & neat tables [@knitr]
 * GREENGrid - for local NZ GREEN Grid project utilities

Session info:


```
## R version 3.5.1 (2018-07-02)
## Platform: x86_64-apple-darwin15.6.0 (64-bit)
## Running under: macOS High Sierra 10.13.6
## 
## Matrix products: default
## BLAS: /Library/Frameworks/R.framework/Versions/3.5/Resources/lib/libRblas.0.dylib
## LAPACK: /Library/Frameworks/R.framework/Versions/3.5/Resources/lib/libRlapack.dylib
## 
## locale:
## [1] en_NZ.UTF-8/en_NZ.UTF-8/en_NZ.UTF-8/C/en_NZ.UTF-8/en_NZ.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
##  [1] kableExtra_0.9.0   GREENGrid_0.1.0    skimr_1.0.3       
##  [4] leaflet_2.0.2      codebook_0.6.3     Hmisc_4.1-1       
##  [7] Formula_1.2-3      survival_2.42-3    lattice_0.20-35   
## [10] readr_1.1.1        lubridate_1.7.4    ggplot2_3.0.0     
## [13] dplyr_0.7.6        data.table_1.11.8  dkUtils_0.0.0.9000
## 
## loaded via a namespace (and not attached):
##  [1] httr_1.3.1          jsonlite_1.5        viridisLite_0.3.0  
##  [4] splines_3.5.1       shiny_1.1.0         assertthat_0.2.0   
##  [7] highr_0.7           latticeExtra_0.6-28 yaml_2.2.0         
## [10] pillar_1.3.0        backports_1.1.2     glue_1.3.0         
## [13] digest_0.6.17       RColorBrewer_1.1-2  promises_1.0.1     
## [16] checkmate_1.8.5     rvest_0.3.2         colorspace_1.3-2   
## [19] htmltools_0.3.6     httpuv_1.4.5        Matrix_1.2-14      
## [22] plyr_1.8.4          pkgconfig_2.0.2     labelled_1.1.0     
## [25] haven_1.1.2         bookdown_0.7        purrr_0.2.5        
## [28] xtable_1.8-3        scales_1.0.0        later_0.7.5        
## [31] htmlTable_1.12      tibble_1.4.2        openssl_1.0.2      
## [34] withr_2.1.2         nnet_7.3-12         lazyeval_0.2.1     
## [37] magrittr_1.5        crayon_1.3.4        mime_0.5           
## [40] evaluate_0.11       forcats_0.3.0       xml2_1.2.0         
## [43] foreign_0.8-70      tools_3.5.1         hms_0.4.2          
## [46] stringr_1.3.1       munsell_0.5.0       cluster_2.0.7-1    
## [49] bindrcpp_0.2.2      compiler_3.5.1      rlang_0.2.2        
## [52] grid_3.5.1          rstudioapi_0.8      htmlwidgets_1.3    
## [55] crosstalk_1.0.0     miniUI_0.1.1.1      labeling_0.3       
## [58] base64enc_0.1-3     rmarkdown_1.10      gtable_0.2.0       
## [61] reshape2_1.4.3      R6_2.3.0            gridExtra_2.3      
## [64] knitr_1.20          bindr_0.1.1         rprojroot_1.3-2    
## [67] stringi_1.2.4       Rcpp_0.12.19        rpart_4.1-13       
## [70] acepack_1.4.1       tidyselect_0.2.4    xfun_0.3
```

# References