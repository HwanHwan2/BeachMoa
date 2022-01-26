<!DOCTYPE html>
<html lang="en" dir="ltr">
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>업비트(upbit) 시세조회</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet"
    	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
    	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
    	crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/10.0.0/css/bootstrap-slider.css" />
    <style>
      body{
        color:silver;
      }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    
    <script>
    function comma(str) {
        str = String(str);
        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    }
    function setUpbitData(){
      $.ajax({
        url: "https://api.upbit.com/v1/market/all",
        dataType: "json"
      }).done(function(markets){
        //$("#tmp").html( JSON.stringify(markets) );
        let arr_krw_markets = "";
        let arr_korean_name = [];
        for(var i = 0; i < markets.length;i++){
          if( markets[i].market.indexOf("KRW") > -1 ){
            arr_krw_markets += markets[i].market+(",");
            arr_korean_name.push(markets[i].korean_name.replace("코인",""));
          }
        }
        arr_krw_markets = arr_krw_markets.substring(0, arr_krw_markets.length-1);
        //$("#tmp").html( arr_krw_markets );
        $.ajax({
          url: "https://api.upbit.com/v1/ticker?markets=" +arr_krw_markets,
          dataType: "json"
        }).done(function(tickers){
          $("#table_ticker > tbody > tr").remove();
          //alert($("#table_ticker > tbody > tr").length);
          for(let i = 0;i < tickers.length;i++){
            let rowHtml = "<tr><td>"+arr_korean_name[i].replace("코인","").replace("토큰","")+"</td>";
            rowHtml += "<td>" + comma(tickers[i].trade_price)+"</td>"
            if(tickers[i].signed_change_rate*100 > 0){
            	rowHtml += "<td style='color:green; font-weight:bold'>+" + comma((tickers[i].signed_change_rate*100).toFixed(2))+"%</td>"
            }else{
              	rowHtml += "<td style='color:red; font-weight:bold'>" + comma((tickers[i].signed_change_rate*100).toFixed(2))+"%</td>"
            }
            rowHtml += "<td>" + comma((tickers[i].acc_trade_price_24h>1000000 ? ( tickers[i].acc_trade_price_24h / 1000000 ) : tickers[i].acc_trade_price_24h ).toFixed(0)) + (tickers[i].acc_trade_price_24h>1000000 ? "백만" : "") + "</td>"
            rowHtml += "<td>" + comma((tickers[i].prev_closing_price))+"</td>"
            rowHtml += "</tr>";
            $("#table_ticker > tbody:last").append(rowHtml);
            //markets[i].korean_name
          } // end for...
        })  //done(function(tickers){
      }) // end done(function(markets){
      .fail(function(){
        //alert("업비트 API 접근 중 에러.")}
        $("#tmp").text( "API 접근 중 에러." );
      })
      setTimeout(setUpbitData, 1000);
    }
    $(function() {
      setUpbitData();
    });
    </script>
  </head>
  <body>
    <div id='tmp' style="color:pink;">
    </div>
    <br /><br />
    <div style="width:600px; height:600px; overflow:scroll">
    <table id="table_ticker" class="table text-center">
    <caption style="text-align:center">업비트 시세현황</caption>
      <thead>
      <tr>
        <td>한글명</td>
        <td>현재가</td>
        <td>전일대비</td>
        <td>거래대금</td>
        <td>전일종가</td>
      </tr>
      </thead>
      <tbody>
      </tbody>
    </table>
    </div>
    <br /><br /><br />
    <div id='tmp2'>

    </div>


  </body>
</html>