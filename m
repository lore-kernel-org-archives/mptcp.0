Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1486571
	for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 01:10:44 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:51420.868818287
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-5ed08c9250294270be38ef3f319a1c6b (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id C95AF2800AB;
	Mon, 19 Apr 2021 09:10:30 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id 5ed08c9250294270be38ef3f319a1c6b for qitiepeng@chinatelecom.cn;
	Mon Apr 19 09:10:36 2021
X-Transaction-ID: 5ed08c9250294270be38ef3f319a1c6b
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH v3 2/2] selftests: mptcp: add a test case for MSG_PEEK
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev,
 Geliang Tang <geliangtang@gmail.com>
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
 fw@strlen.de, qitiepeng@chinatelecom.cn
References: <1618565378-148180-1-git-send-email-liyonglong@chinatelecom.cn>
 <1618565378-148180-2-git-send-email-liyonglong@chinatelecom.cn>
 <af1a6a9bc1caad48c8fc1e1cd5260585a89e583b.camel@redhat.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <763714b8-c792-a437-9751-7bf3c116bd53@chinatelecom.cn>
Date: Mon, 19 Apr 2021 09:10:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <af1a6a9bc1caad48c8fc1e1cd5260585a89e583b.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi Geliang, Paolo,

Thanks for your review. I will prepare a v3 patch as your suggestions.

On 2021/4/16 22:18, Paolo Abeni wrote:
> On Fri, 2021-04-16 at 17:29 +0800, Yonglong Li wrote:
>> Extend mptcp_connect tool with MSG_PEEK support and add a test case in
>> mptcp_connect.sh that checks the data recvived from/after recv() with
>> MSG_PEEK.
>>
>> eg: sh mptcp_connect.sh -4 -m poll -P
>>
>> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_connect.c  | 45 +++++++++++++++++++++-
>>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 38 +++++++++++++++++-
>>  2 files changed, 80 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> index 2f207cf..668a041 100644
>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> @@ -45,7 +45,14 @@ enum cfg_mode {
>>  	CFG_MODE_SENDFILE,
>>  };
>>  
>> +enum cfg_peek {
>> +	CFG_NONE_PEEK,
>> +	CFG_WITH_PEEK,
>> +	CFG_AFTER_PEEK,
>> +};
>> +
>>  static enum cfg_mode cfg_mode = CFG_MODE_POLL;
>> +static enum cfg_peek cfg_peek = CFG_NONE_PEEK;
>>  static const char *cfg_host;
>>  static const char *cfg_port	= "12000";
>>  static int cfg_sock_proto	= IPPROTO_MPTCP;
>> @@ -73,6 +80,7 @@ static void die_usage(void)
>>  	fprintf(stderr, "\t-M mark -- set socket packet mark\n");
>>  	fprintf(stderr, "\t-u -- check mptcp ulp\n");
>>  	fprintf(stderr, "\t-w num -- wait num sec before closing the socket\n");
>> +	fprintf(stderr, "\t-P [saveWithPeek|saveAfterPeek] -- save data with/after MSG_PEEK form tcp socket \n");
>>  	exit(1);
>>  }
>>  
>> @@ -331,6 +339,8 @@ static size_t do_write(const int fd, char *buf, const size_t len)
>>  
>>  static ssize_t do_rnd_read(const int fd, char *buf, const size_t len)
>>  {
>> +	int ret = 0;
>> +	char tmp[16384];
>>  	size_t cap = rand();
>>  
>>  	cap &= 0xffff;
>> @@ -340,7 +350,17 @@ static ssize_t do_rnd_read(const int fd, char *buf, const size_t len)
>>  	else if (cap > len)
>>  		cap = len;
>>  
>> -	return read(fd, buf, cap);
>> +	if (cfg_peek == CFG_WITH_PEEK) {
>> +		ret = recv(fd, buf, cap, MSG_PEEK);
>> +		ret = (ret < 0) ? ret : read(fd, tmp, ret);
>> +	} else if (cfg_peek == CFG_AFTER_PEEK) {
>> +		ret = recv(fd, buf, cap, MSG_PEEK);
>> +		ret = (ret < 0) ? ret : read(fd, buf, cap);
>> +	} else {
>> +		ret = read(fd, buf, cap);
>> +	}
>> +
>> +	return ret;
>>  }
>>  
>>  static void set_nonblock(int fd)
>> @@ -819,6 +839,24 @@ int parse_mode(const char *mode)
>>  	return 0;
>>  }
>>  
>> +int parse_peek(const char *mode)
>> +{
>> +	if (!strcasecmp(mode, "saveWithPeek"))
>> +		return CFG_WITH_PEEK;
>> +	if (!strcasecmp(mode, "saveAfterPeek"))
>> +		return CFG_AFTER_PEEK;
>> +
>> +	fprintf(stderr, "Unknown: %s\n", mode);
>> +	fprintf(stderr, "Supported MSG_PEEK mode are:\n");
>> +	fprintf(stderr, "\t\t\"saveWithPeek\" - recv data with flags 'MSG_PEEK' and save the peek data into file \n");
>> +	fprintf(stderr, "\t\t\"saveAfterPeek\" - read data form socket and save it into file after recv with flags 'MSG_PEEK' \n");
>> +
>> +	die_usage();
>> +
>> +	/* silence compiler warning */
>> +	return 0;
>> +}
>> +
>>  static int parse_int(const char *size)
>>  {
>>  	unsigned long s;
>> @@ -846,7 +884,7 @@ static void parse_opts(int argc, char **argv)
>>  {
>>  	int c;
>>  
>> -	while ((c = getopt(argc, argv, "6jr:lp:s:hut:m:S:R:w:M:")) != -1) {
>> +	while ((c = getopt(argc, argv, "6jr:lp:s:hut:m:S:R:w:M:P:")) != -1) {
>>  		switch (c) {
>>  		case 'j':
>>  			cfg_join = true;
>> @@ -899,6 +937,9 @@ static void parse_opts(int argc, char **argv)
>>  		case 'M':
>>  			cfg_mark = strtol(optarg, NULL, 0);
>>  			break;
>> +		case 'P':
>> +			cfg_peek = parse_peek(optarg);
>> +			break;
>>  		}
>>  	}
>>  
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> index 385cdc9..6f77e04 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> @@ -3,7 +3,7 @@
>>  
>>  time_start=$(date +%s)
>>  
>> -optstring="S:R:d:e:l:r:h4cm:f:t"
>> +optstring="S:R:d:e:l:r:h4cm:f:tP"
>>  ret=0
>>  sin=""
>>  sout=""
>> @@ -23,6 +23,8 @@ rcvbuf=0
>>  options_log=true
>>  do_tcp=0
>>  filesize=0
>> +testpeek=false
>> +peekmode=""
>>  
>>  if [ $tc_loss -eq 100 ];then
>>  	tc_loss=1%
>> @@ -47,6 +49,7 @@ usage() {
>>  	echo -e "\t-R: set rcvbuf value (default: use kernel default)"
>>  	echo -e "\t-m: test mode (poll, sendfile; default: poll)"
>>  	echo -e "\t-t: also run tests with TCP (use twice to non-fallback tcp)"
>> +	echo -e "\t-P: test MSG_PEEK flags of recv() function"
>>  }
>>  
>>  while getopts "$optstring" option;do
>> @@ -104,6 +107,10 @@ while getopts "$optstring" option;do
>>  	"t")
>>  		do_tcp=$((do_tcp+1))
>>  		;;
>> +	"P")
>> +		testpeek=true
>> +		peekmode="saveWithPeek"
>> +		;;
> 
> I'm sorry, it looks like I was not clear enough. I think this test need
> to be enabled by default. Just drop this chunck and the above one.
> 
>>  	if [ -n "$extra_args" ] && $options_log; then
>>  		options_log=false
>>  		echo "INFO: extra options: $extra_args"
>> @@ -706,6 +717,31 @@ echo "on ns3eth4"
>>  
>>  tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${reorder_delay}ms $tc_reorder
>>  
>> +if $testpeek; then
>> +	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
>> +	if [ $ret -ne 0 ] ;then
>> +		echo "FAIL: Could not even run loopback test" 1>&2
>> +		exit $ret
>> +	fi
>> +	run_tests_lo "$ns1" $sender dead:beef:1::1 1
>> +	if [ $ret -ne 0 ] ;then
>> +		echo "FAIL: Could not even run loopback v6 test" 2>&1
>> +		exit $ret
>> +	fi
>> +
>> +	#set peekmode="saveAfterPeek" and test again
>> +	options_log=true
>> +	peekmode="saveAfterPeek"
>> +	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
>> +	run_tests_lo "$ns1" $sender dead:beef:1::1 1
>> +	
>> +	time_end=$(date +%s)
>> +	time_run=$((time_end-time_start))
>> +	echo "Time: ${time_run} seconds"
>> +	
>> +	exit $ret
>> +fi
> 
> With the tests always enabled you can change the above chunk in:
> 
> ---
> @@ -718,6 +718,16 @@ for sender in $ns1 $ns2 $ns3 $ns4;do
>         run_tests "$ns4" $sender dead:beef:3::1
>  done
>  
> +options_log=true
> +peekmode="saveWithPeek"
> +run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
> +run_tests_lo "$ns1" $sender dead:beef:1::1 1
> +
> +options_log=true
> +peekmode="saveAfterPeek"
> +run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
> +run_tests_lo "$ns1" $sender dead:beef:1::1 1
> +
>  time_end=$(date +%s)
>  time_run=$((time_end-time_start))
> ---
> 
> that is: doing peek tests once after all the "normal" ones.
> 
> As Geliang noted, there are a few checkpatch violation (long lines,
> needed whitespaces), please address them too, thanks!
> 
> /P
> 
> 
