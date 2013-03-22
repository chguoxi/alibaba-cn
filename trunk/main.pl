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
my $debug_log = './debug.txt';
my $cookie_file = "./cookies.txt";
my $cookie = 
my $url = "http://search.china.alibaba.com/company/company_search.htm?showStyle=popular&keywords=%C0%B6%D1%C0&biztype=1&pageSize=30&filt=y&offset=3&n=y&beginPage=";
#模拟头信息
my @header=(
'User-Agent'=>'Mozilla/5.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; iCafeMedia; .NET CLR 2.0.50727; CIBA)',  
'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',  
'Accept-Charset' => 'gzip, deflate',  
'Accept-Language' => 'zh-cn',  
'Cookie'=> 'ali_apache_track=c_ms=1|c_mt=3|c_mid=changioux|c_lid=changioux; last_mid=changioux; _cn_slid_=x1Oajx0Jr3; __last_loginid__=changioux; ali_beacon_id=14.20.111.98.1363879189452.4; cna=BPvaCK/7v3QCASpnGXRalEvp; ali_apache_id=14.20.111.98.78296179192665.3; ali_ab=14.20.111.98.1363879435980.4; ad_prefer="2013/03/22 19:31:18"; h_keys="%u84dd%u7259"; alicnweb=lastlogonid%3Dchangioux%7Ctouch_tb_at%3D1363888150666%7Cshow_inter_tips%3Dfalse; lzstat_uv=16986923641911766888|3131015@3131022; xman_f=lvbkG+dGS4iq79MMl0ZIwm5kQ88dIHUgoWjakpZ3HxTPidgVE4reVpDDDEraTGvabwfOJAqH6v4cgEC7bHrG+XyrcVEuQCsU6Cm32yDFxWz0bpByB1Lbew==; __utma=226363722.2044208712.1363880794.1363880794.1363880794.1; __utmz=226363722.1363880794.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); history=keywords%5E%0Akeywords%09blue%20tooth; track_cookie=n&null; JSESSIONID=owlFof1-s5JP5X3CvBKKz0UCJF-ZNggn0O-l4a5; _tmp_ck_0="HczaDBl1NzHJuJmJ7STMExbUDdy650OtwjrJt8gKIGE78FfcL88IVp6C7ijQexV3vVwGBRhTaCA%2BH%2BwGMrfwl2%2Bbm%2BjRoeRyosYZgSJYD66o8v8jknpe4Tx23%2FliqB1vsl3g7koYDI95CUZs8snCRO4RYqCi6jJ2vJ97XA6tl0GmUYXM71wLHlwpM04QOPrVN3WTgyApiJUQd3Dj2%2F7hQN6PyqRO0ygBTLL3%2FSQ6YfJ%2BvDjsATzpIOt8znCnAwUcR15jo7ShFLepEp%2BcVKjqTuEsnztQpTucQIl8ZTJA68nQUVJXs8gSuFf1brR1KzMY6ptPpl%2BbTpYCMYKiDIu%2BJhBMDjkgWdPv8I1DoAP4ttXH6U73wrz8XTlfoO6cl4LGx6kFX%2Bf6%2F1vasuJJRkbPUTiCB2b90qoFWCADgyROw8sB3aqiQCqXIHUgvHmt2froqyWs%2FWL49%2B%2FDQkJXAjYAmh4vo59liUDX%2BzgAzTg%2B8qwfuZt%2FoFrqQ1rLUevF%2F%2FgJZutox%2Fy2ufYpKx0rk88KfP%2BmlbqaRC4NYGDjQMBjy6qUGVsOtuQaSoW3s3NcvxEYEeNki4IUbhI%3D"; ali_apache_sid=14.20.111.98.22065239882494.3|1363941682; _tmp_hny_0="AhAPwLGenDsU2obBvfytDoU5Pe3Yt%2FDQI2PxkxMi78mZ0mZAVGmigYSZMUjbhfRMQyex3TR7%2BmBFehDDqhPryotnP9MkGrcaY3zW0hbfrHZkwKBtbgWkpQzzFaUYiN2alWz6U79Th%2Btfz1Jhih507Sgh3BCTPqBvUPNynQ8Fct7Ri9oJwFPk%2FGuRrb8MQESFnD0SK4zumD6URH6ss5DOcLnmPo0SJmPNkICH1sqm93fU4Eb728m9h%2BxFMOJzc9vzsyN5sW4fpwP3ML5RtlNSRG0JbzviJYx3aIuwtn9sIHD44oHkCS%2FLV5Cn6TkS1cCyr9hmgbTxkYu3dH6SuuVZQA%3D%3D"; _csrf_token=1363951872147; __cn_logon__=true; __cn_logon_id__=changioux; ali_apache_tracktmp="c_w_signed=Y"; cn_tmp="Z28mC+GqtZ1wTymD+6P2MdA5Ew+sMLFs0iBLbKzXnFNo3vZ3waFmgzb/YfdmuxEr+KaeAan3pPDXsVmkTdySAkjmCCRr+LVlY8DnbKvPiLJzXJkUUI62s0Ie6na1ixxAITUX2IrbyYInDJbEInhR5WehUumRAZJ6hIg5bP4qs0FktMMt7TIEv+XMqEIb0vcbkaOfMleYC0W8LfaA8Ei/O60wK+70h5UvDt55R2PGcpQ="'  
);  
#保存主页的URL
open DATA,">data/data.txt";
open DEBUG,">$debug_log";
#用户代理
my $ua = LWP::UserAgent->new();
#抓取页面
foreach my $i($start_page..$end_page){
	my $response = $ua->get($url.$i,@header);
	#编码
	my $content = encode_utf8($response->decoded_content);
	#去掉空白
	$content =~s/[\r\n]*|<br>|<br\s*\/>//mg;

	my @curl = $content =~m/<a\s*class=\"Title\"\s*gotoDetail=\"2\"\s*href=\"(.*?)\".*?\/>/g;

	foreach my $curl(@curl){
		if(index($curl,'?')>0){
			$curl = substr($curl,0,index($curl,'?'));
		}
		
		my $contact_url = $curl."/page/contactinfo.htm";
		my $contact_response = $ua->get($contact_url,@header);
		my $contact_html = encode_utf8($contact_response->decoded_content);
		$contact_html =~s/[\r\n]*|<br>|<br\s*\/>|\&nbsp;|\s{2,}//mg;
		#公司名
		my @company= $contact_html =~m/<h4>(.*?)<\/h4>/g;
		#联系人和职位
		my @contactor = $contact_html =~m/<a\s*href=.*?class=\"membername\".*?>(.*?)<\/a>(.*?)<a*/g;
		#电话
		#处理中文编码
		my $telephone_cn = encode_utf8("电话：");
		my @tel = $contact_html =~m/<dt>$telephone_cn<\/dt><dd>(.*?)<\/dd/g;
		#手机
		#处理中文编码
		my $mobilephone_cn = encode_utf8("移动电话：");
		my @mobile = $contact_html =~m/<dt>$mobilephone_cn<\/dt><dd>(.*?)<\/dd/g;
		
		#地址
		#处理中文编码
		my $address_cn = encode_utf8("地址：");
		my @address = $contact_html =~m/<dt>$address_cn<\/dt><dd\s*class\s*=\s*\"address\">(.*?)<\/dd/g;
		
		#公司主页
		#处理中文编码
		my $page_cn = encode_utf8("公司主页：");
		my @page = $contact_html =~m/<dt>$page_cn<\/dt><dd><div><a\s*href=\"(.*?)\".*?<\/div><\/dd/g;
		
		#print @company[0]."\n";
		#print @contactor[0]."\n";
		#print @tel[0]."\n";
		#print @mobile[0]."\n";
		#print @address[0]."\n";
		#print @page;
		
		my $sql = "INSERT INTO `company`.`digital` ( `company`, `contactor`, `tel`, `mobie`, `address`, `page`) VALUES ('@company[0]', '@contactor[0]@contactor[1]', '@tel[0]', '@mobile[0]', '@address[0]', '@page');\r\n";
		syswrite(DATA,$sql);
		print 'getting '.$curl.'....';
	}
	sleep(5);
}

#syswrite(DEBUG,$content);
#print $response->decoded_content;