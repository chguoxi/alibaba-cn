use strict;
use Encode;
use utf8; 
use LWP::UserAgent;
use HTTP::Cookies;
#开始页
my $start_page = 1;
#介绍页
my $end_page = 247;
#调试文件
#my $debug_log = './debug.txt';
my $cookie_file = "./cookies.txt";
my $url = "http://search.china.alibaba.com/company/company_search.htm?showStyle=popular&keywords=%C0%B6%D1%C0&biztype=1&pageSize=30&filt=y&offset=3&n=y&beginPage=";
#模拟头信息
my @header=(  
'User-Agent'=>'Mozilla/5.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; iCafeMedia; .NET CLR 2.0.50727; CIBA)',  
'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',  
'Accept-Charset' => 'gzip, deflate',  
'Accept-Language' => 'zh-cn',  
'Cookie'=> 'JSESSIONID=UsJeI5zfiIBHCN87rzFLrCkM1-Xl4aj0O-rscF; _tmp_ck_0=EAjXG8y53ZRqUzTkeOaalD7yLLYssPlpgh2%2FhhjNI%2Fl2E8S502i9JViaxb6daBbpOkW6AQqKPW6an%2FqVpIUrZRAqgy6yJ7QsFPu4KHzry5w0ZI6eCKNpWrPWZV9vAS6dZCxkVklaYV481q2TPkelgVRFsDwxstUQzQhzThkqWCBHIyluDV0G2Bcz82quEl%2Fyt6qselt47o6CQZVEfVp4j8FpXVaKBg9B6bKsEFjt5wlIIkAAgjtSihb5sHsvrA7qWRY3UDRrc5kA6qTn9ySy8dEhBFQpUuwkTfYk%2F4DlFuBH0cCETKKLZoPq46AolIreSGKKLlW5%2Fz9IpFCxGWXmZiC9wuxugNUvDXG6gtAXfUjOdABRp64%2FIknjrSUWCqgXIfxrHbr3sliyUvpwkRTwNQRVS2YGhZ0aEE3E1dPK%2F%2BgcywdUDvmUQWJ47PtoZqXJsKIXkU4wl2MRdBj%2BkYGl6u1YT%2BxSIYl6jQf2ZvNO5Rb0GkXwob3xKLjUaJmIMSjMjX7FOma9Xi6cKeDSPhhNBxFwMO4Kpv0szehFebwRYUdKZfBJscM1fyB6BLQ%2FAiff; __cn_logon__=true; ali_apache_track=c_ms=1|c_mt=3|c_mid=changioux|c_lid=changioux; ali_apache_tracktmp=c_w_signed=Y; last_mid=changioux; _cn_slid_=x1Oajx0Jr3; __last_loginid__=changioux; _csrf_token=1363879622150; ali_beacon_id=14.20.111.98.1363879189452.4; _tmp_hny_0="AhAPwLGenDsU2obBvfytDm7VG1WaUbmuTjAeWbFVKLHY%2B5VzeqyD2SBFUF1MhsieKh%2FL4d6yRGyJefeC%2F3l04Akok13PWRvRdVjD5NHeaHCeM7Ld7nW937GRcXmFyjF2spgs1%2FuCd%2ByUqXRKQudyx%2FBx93AHiKq0lILQLU1zT%2BHV3v4B0jpDfps06Vq6iGgfZwsPbpw7sH1H0WN9dFH%2B5h9negGscvzWK86hHdZ07f%2BX2Lo5IuwBpgppnFCC1ZqxVv0kbz0TvVKqtYBbgkxBA%2BjkpqD7uVf1Sc2eyenKmi4wotbvvweu%2FX2wowoQj5n2MciTQnzwj49DjfiWajlsQA%3D%3D"; cna=BPvaCK/7v3QCASpnGXRalEvp; ali_apache_id=14.20.111.98.78296179192665.3; ali_apache_sid=14.20.111.98.78296179192665.3|1363880992; track_cookie=n&null; ali_ab=14.20.111.98.1363879435980.4; ad_prefer="2013/03/22 00:58:02"; h_keys="%u84dd%u7259"; alicnweb=lastlogonid%3Dchangioux%7Ctouch_tb_at%3D1363882750607%7Cshow_inter_tips%3Dfalse; _t_ck_0="uVtTdtHUfdw8qqIjQivxanh2ENeKlN8a2UAtJYlRaQA6jHwKXxQYGBo4gbwDSOa0UQePuofqY0Ygb30wLpd6YH%2FvSiGVVnrs3byeYAxIn2rpdh7eOz23Y%2BdtlP1iqeCsVuJFZVLNcNcqXaZeQn%2Fxp%2B9O2%2FadpLpbVnC4qjuAqzRM6%2BkT01vvEadTkJa6uDyFDiV9cpzQBTs%2FRahtbFFgzn1XM%2BSlLQtJD9awY3CFCdWR%2BW2m9qKiOZ4svHjEZ6eL5yZ8e0%2BLpHEQkS7MGMSLYdsDH5gAhhXML2Fi0%2Fw%2FYhGqYg7SRKc0j5jOZh%2FlZ%2BK7FB438RfAzZCiVey7UTfudQ%3D%3D"; _t_ck_sum=uVtTdtHUfdw8qqI; lzstat_uv=16986923641911766888|3131015@3131022; lzstat_ss=2505343211_1_1363909334_3131015|2737058869_0_1363908330_3131022; __cn_logon_id__=changioux; cn_tmp="Z28mC+GqtZ1wTymD+6P2MdA5Ew+sMLFs0iBLbKzXnFNo3vZ3waFmgzb/YfdmuxEr+KaeAan3pPBbfxpRO/yNpEPGuZrdgQf7tNME9lJriZxm+NBnUmIVmjIV/fr5QgpHbXG6evtOeB0keL6dUBSQ0G6Mzi6/HMJXr5piidvtlGgrh/dJ1WEp5QGw+sJ6I7z5+Z5NnuqaBW7DeesEwrQQ6e/V5INExeafPK8BjsFRwuQ="; acs_usuc_t=acs_rt=8b2144a37e114b3a9c63aa87d322ea4e; xman_t=snfwR5Ss+5boQEREboekvn7cU8yZ2W4OTimC6WB4iP8o7g4XuViTv7F1BLBm9Fcw; acs_t=1TMLVouV2pVoD06p7cH7BsbbSqK+hwBr/v7na0YCj9QpB+VPKVXH1F3AJbqANrW1; xman_f=lvbkG+dGS4iq79MMl0ZIwm5kQ88dIHUgoWjakpZ3HxTPidgVE4reVpDDDEraTGvabwfOJAqH6v4cgEC7bHrG+XyrcVEuQCsU6Cm32yDFxWz0bpByB1Lbew==; __utma=226363722.2044208712.1363880794.1363880794.1363880794.1; __utmc=226363722; __utmz=226363722.1363880794.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); history=keywords%5E%0Akeywords%09blue%20tooth; lzpg_2706934_uv=1898336683624810833; lzpg_2706934_ss=2138452489_0_1363885059; _ITBU_IS_FIRST_VISITED_=n'  
);  
#保存主页的URL
open DATA,">data/data.txt";
#open DEBUG,">$debug_log";
#用户代理
my $ua = LWP::UserAgent->new();
#抓取页面
my $response = $ua->get($url,@header);
#编码
my $content = encode_utf8($response->decoded_content);

syswrite(DEBUG,$content);
#print $response->decoded_content;