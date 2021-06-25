Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC48B168
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 03:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=vds+V
	1WOY5EmHR2yanwsue+B6t+0juVB7oBGCUlUeZQ=; b=OPNL61cZxAU7Ms6ckJ3Fc
	0okvIZn4xQr2XK3NTxsH+U3CiIvgbf53V8rqJHMnVpYQns0QJu4f0CZrirblWpOa
	ZBiav796+Kg3W+od+ldp8eMDDPM0C/QmhOc+mYf6cct1JY7E32PeycWRXXL7cH69
	g/wOQoywHB2fmofy/08Gik=
Received: from [10.8.0.206] (unknown [36.111.140.26])
	by smtp8 (Coremail) with SMTP id DMCowACnfzBiTNVgja+1Lg--.7988S2;
	Fri, 25 Jun 2021 11:24:19 +0800 (CST)
Subject: Re: [PATCH mptcp-net v6 5/5] selftests: mptcp: update case multiple
 subflows limited by server
From: Jianguo Wu <wujianguo106@163.com>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com, mathew.j.martineau@linux.intel.com
References: <1624589330-2579-1-git-send-email-wujianguo106@163.com>
 <1624589330-2579-6-git-send-email-wujianguo106@163.com>
Message-ID: <a597ba47-d79d-c132-7b04-d810d5c52cec@163.com>
Date: Fri, 25 Jun 2021 11:24:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1624589330-2579-6-git-send-email-wujianguo106@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:DMCowACnfzBiTNVgja+1Lg--.7988S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWfCrW8XF1Utr1xtrW7XFb_yoW8Jw17p3
	yxAw13tF1xtFy3Gw17GF4UXF4rWrs0yFZYk3WUW3s8Zrn8G3ZrWrWxKw13ta9F9rsYva9I
	yayxK3Wvq3WDX3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jg8nOUUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiUQO8kGDEMvMuMAAAsF



On 2021/6/25 10:48, wujianguo106@163.com wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> After patch "mptcp: fix syncookie process if mptcp can not_accept new subflow",
> If a new subflow is limited, MP_JOIN SYN is dropped, and no SYN/ACK will be replied.
> So in case "multiple subflows limited by server", the expected SYN/ACK number
> should be 1.
> 

Sorry, forgot to add:
Reported-by: kernel test robot <oliver.sang@intel.com>

> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 523c7797f30a..37b7da3cd5ca 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1398,7 +1398,7 @@ syncookies_tests()
>  	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
>  	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
>  	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "subflows limited by server w cookies" 2 2 1
> +	chk_join_nr "subflows limited by server w cookies" 2 1 1
>  
>  	# test signal address with cookies
>  	reset_with_cookies
> 

