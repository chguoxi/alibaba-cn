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
my $cookie = HTTP::Cookies->new(file=>$cookie_file,autosave=>1);

my $url = "http://search.china.alibaba.com/company/company_search.htm?showStyle=popular&keywords=%C0%B6%D1%C0&biztype=1&pageSize=30&filt=y&offset=3&n=y&beginPage=";
#模拟头信息
my @header=(
'Referer'=>'http://search.china.alibaba.com/company/-C0B6D1C0.html?showStyle=popular',
'User-Agent'=>'	Mozilla/5.0 (Windows NT 5.1; rv:19.0) Gecko/20100101 Firefox/19.0',  
'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',  
'Accept-Charset' => 'gzip, deflate',  
'Accept-Language' => 'zh-cn',  
'Cookie'=> 'ali_apache_track=c_ms=1|c_mt=3|c_mid=changioux|c_lid=changioux; last_mid=changioux; _cn_slid_=x1Oajx0Jr3; __last_loginid__=changioux; ali_beacon_id=14.20.111.98.1363879189452.4; cna=BPvaCK/7v3QCASpnGXRalEvp; ali_apache_id=14.20.111.98.78296179192665.3; ali_ab=14.20.111.98.1363879435980.4; ad_prefer="2013/03/22 23:14:00"; h_keys="%u84dd%u7259"; alicnweb=lastlogonid%3Dchangioux%7Ctouch_tb_at%3D1363888150666%7Cshow_inter_tips%3Dfalse; lzstat_uv=16986923641911766888|3131015@3131022; xman_f=lvbkG+dGS4iq79MMl0ZIwm5kQ88dIHUgoWjakpZ3HxTPidgVE4reVpDDDEraTGvabwfOJAqH6v4cgEC7bHrG+XyrcVEuQCsU6Cm32yDFxWz0bpByB1Lbew==; __utma=226363722.2044208712.1363880794.1363880794.1363880794.1; __utmz=226363722.1363880794.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); history=keywords%5E%0Akeywords%09blue%20tooth; track_cookie=n&null; JSESSIONID=4xlFQf1-o5JP2zCOMTOFTt1Ll6-fzdLp0O-Z6D6; _tmp_ck_0="Qt87CIiNJbNoxAx0%2F9ByLeEL17lFn2Hstiz0%2Fmtir6m2V8tLnReuldxsvu6o8QDmQa0jB27d5NIoG5u0eA0HWDhmrmT5P71t%2FoBj7%2Bfa1u5NHYMQ81towTEyy5oUOQXqlIe7CoaPpIlYKV7oH3LA0HWgswMSjCj%2FixSvJcG5%2Fv761bMPNh2zDVeGhsTpedUOq%2BS9nE6A1p2EoCUxSr%2BFnvnBIopf4sWzaxdE%2BhjatHcaDZe87OIv62YVvm9cBKZb9PiyAyY4aFpa04OFz8mvzQ5j3KsyP7BTNkfK8GhIwu2HonsRJrZakxy%2FUWYLyjWzWcHgQePta71DrnopGrneMjL2gLmfiCQ2b6AbYUYoMVW5ImO%2BUXCId6SPJvC7M2kWuHcc5oTWURvl0souYx95OWB8IoYB3Mrb7%2B7P6xN%2F7w1l0AUn25qzt9iqWTo7JgxpZ9fK%2BG11pppYn%2Fp66%2F6slLr0v2s7sK%2FxHArC4dl5L6vdSn88WqLBOqtMVeZBTLN5%2FzpNlDKSiELig7j0lFbcYQ%3D%3D"; aliBeacon_bcookie=; ali_apache_sid=14.20.111.98.21341864417260.7|1363966217; _tmp_hny_0="AhAPwLGenDsU2obBvfytDm7VG1WaUbmurL4Mj1YTIkH0MH976EqQ4F9ACgjYtKsmXMlktE9E2jyF8HxMg84fiSZ69jQcrFGUAEzbG%2Fk24lRoWrsUZwSc5%2BdigD7xxVsKkD%2BXhA5jM5te6OjFkdeYoHaU8IYY%2BsK0F8WkiwIVNfFa6etbOjoMhfvtxiFe02EsxiUqCSgRQTRh30aXLhEFqBzyBfUcynbZj9WMenr%2F4h6WSLFxHEdUXedVMEEAcVxjlQHVDgFj%2B24q4bBvWGXaSy5hchP%2Bw1ang7zQ23cewtEAEuRxGG0LBVq%2BA%2BIq4lzWakr5TcYmQ1SkH%2BDMjUP%2BPw%3D%3D"; __cn_logon__=true; __cn_logon_id__=changioux; ali_apache_tracktmp="c_w_signed=Y"; cn_tmp="Z28mC+GqtZ1wTymD+6P2MdA5Ew+sMLFs0iBLbKzXnFNo3vZ3waFmgzb/YfdmuxEr+KaeAan3pPBdEiMr233sYRs4Zf8oQvaETJSgoaq08R9fb+iLEpEsLGb+b2x7SOuPC8AjPYh7dCgBhmhMXP5FFviAmvGEEZ3ybbs58cPbc5xnx3lNjhU7gclRpUi4VYWsvr8IIKyveOsRI16V2t+IHEuzIrZVWxc9tYcyzsZPN8A="; _csrf_token=1363964473802'  
);  
#保存主页的URL
open DATA,"+<data/data.txt";
open DEBUG,">$debug_log";
#用户代理
my $ua = LWP::UserAgent->new();
$ua->cookie_jar($cookie);
#抓取页面
foreach my $i($start_page..$end_page){
	my $response = $ua->get($url.$i,@header);
	#编码
	my $content = encode_utf8($response->decoded_content);
	#去掉空白
	$content =~s/[\r\n]*|<br>|<br\s*\/>//mg;

	my @curl = $content =~m/<a\s*class=\"Title\"\s*gotoDetail=\"2\"\s*href=\"(.*?)\".*?\/>/g;
	#syswrite(DEBUG,$content);
	#print "$content \n";die;
	
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
		
		my $sql = "INSERT INTO `company`.`digital` ( `company`, `contactor`, `tel`, `mobie`, `address`, `page`) VALUES ('@company[0]', '@contactor[0]@contactor[1]', '@tel[0]', '@mobile[0]', '@address[0]', '@page');\r\n";
		syswrite(DATA,$sql);
		print 'getting '.$curl.'....';
	}
	
}

#syswrite(DEBUG,$content);
#print $response->decoded_content;