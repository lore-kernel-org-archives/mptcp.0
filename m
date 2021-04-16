Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A4D17F
	for <mptcp@lists.linux.dev>; Fri, 16 Apr 2021 14:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618582695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LogXWH2ZCgNxq2de0CssawhNnHp7ObFD2rzowpWmRtQ=;
	b=A7M+hGiFmb9nJpioo31h0TTwBInyCtGvvAeaG1j0UGd5WAOgE0SUMKNCWgLfScMUhHgUbT
	NqyYpQO4kgJ4ET496VYphdwG+QVl53Cv78zryiOU6kmhHrUx0jTfZPDpzZujKLCkEGikP7
	/7RaNNYOeH3yRuRYBj8fb7fVotHDu4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-raVspcwLM2OuRnJIbG2yGA-1; Fri, 16 Apr 2021 10:18:11 -0400
X-MC-Unique: raVspcwLM2OuRnJIbG2yGA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EE2F80A1AC;
	Fri, 16 Apr 2021 14:18:09 +0000 (UTC)
Received: from ovpn-114-195.ams2.redhat.com (ovpn-114-195.ams2.redhat.com [10.36.114.195])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DA164610F1;
	Fri, 16 Apr 2021 14:18:05 +0000 (UTC)
Message-ID: <af1a6a9bc1caad48c8fc1e1cd5260585a89e583b.camel@redhat.com>
Subject: Re: [PATCH v3 2/2] selftests: mptcp: add a test case for MSG_PEEK
From: Paolo Abeni <pabeni@redhat.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>, mptcp@lists.linux.dev, 
	mptcp@lists.01.org
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net, 
	fw@strlen.de, qitiepeng@chinatelecom.cn
Date: Fri, 16 Apr 2021 16:18:04 +0200
In-Reply-To: <1618565378-148180-2-git-send-email-liyonglong@chinatelecom.cn>
References: <1618565378-148180-1-git-send-email-liyonglong@chinatelecom.cn>
	 <1618565378-148180-2-git-send-email-liyonglong@chinatelecom.cn>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2021-04-16 at 17:29 +0800, Yonglong Li wrote:
> Extend mptcp_connect tool with MSG_PEEK support and add a test case in
> mptcp_connect.sh that checks the data recvived from/after recv() with
> MSG_PEEK.
> 
> eg: sh mptcp_connect.sh -4 -m poll -P
> 
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c  | 45 +++++++++++++++++++++-
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 38 +++++++++++++++++-
>  2 files changed, 80 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 2f207cf..668a041 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -45,7 +45,14 @@ enum cfg_mode {
>  	CFG_MODE_SENDFILE,
>  };
>  
> +enum cfg_peek {
> +	CFG_NONE_PEEK,
> +	CFG_WITH_PEEK,
> +	CFG_AFTER_PEEK,
> +};
> +
>  static enum cfg_mode cfg_mode = CFG_MODE_POLL;
> +static enum cfg_peek cfg_peek = CFG_NONE_PEEK;
>  static const char *cfg_host;
>  static const char *cfg_port	= "12000";
>  static int cfg_sock_proto	= IPPROTO_MPTCP;
> @@ -73,6 +80,7 @@ static void die_usage(void)
>  	fprintf(stderr, "\t-M mark -- set socket packet mark\n");
>  	fprintf(stderr, "\t-u -- check mptcp ulp\n");
>  	fprintf(stderr, "\t-w num -- wait num sec before closing the socket\n");
> +	fprintf(stderr, "\t-P [saveWithPeek|saveAfterPeek] -- save data with/after MSG_PEEK form tcp socket \n");
>  	exit(1);
>  }
>  
> @@ -331,6 +339,8 @@ static size_t do_write(const int fd, char *buf, const size_t len)
>  
>  static ssize_t do_rnd_read(const int fd, char *buf, const size_t len)
>  {
> +	int ret = 0;
> +	char tmp[16384];
>  	size_t cap = rand();
>  
>  	cap &= 0xffff;
> @@ -340,7 +350,17 @@ static ssize_t do_rnd_read(const int fd, char *buf, const size_t len)
>  	else if (cap > len)
>  		cap = len;
>  
> -	return read(fd, buf, cap);
> +	if (cfg_peek == CFG_WITH_PEEK) {
> +		ret = recv(fd, buf, cap, MSG_PEEK);
> +		ret = (ret < 0) ? ret : read(fd, tmp, ret);
> +	} else if (cfg_peek == CFG_AFTER_PEEK) {
> +		ret = recv(fd, buf, cap, MSG_PEEK);
> +		ret = (ret < 0) ? ret : read(fd, buf, cap);
> +	} else {
> +		ret = read(fd, buf, cap);
> +	}
> +
> +	return ret;
>  }
>  
>  static void set_nonblock(int fd)
> @@ -819,6 +839,24 @@ int parse_mode(const char *mode)
>  	return 0;
>  }
>  
> +int parse_peek(const char *mode)
> +{
> +	if (!strcasecmp(mode, "saveWithPeek"))
> +		return CFG_WITH_PEEK;
> +	if (!strcasecmp(mode, "saveAfterPeek"))
> +		return CFG_AFTER_PEEK;
> +
> +	fprintf(stderr, "Unknown: %s\n", mode);
> +	fprintf(stderr, "Supported MSG_PEEK mode are:\n");
> +	fprintf(stderr, "\t\t\"saveWithPeek\" - recv data with flags 'MSG_PEEK' and save the peek data into file \n");
> +	fprintf(stderr, "\t\t\"saveAfterPeek\" - read data form socket and save it into file after recv with flags 'MSG_PEEK' \n");
> +
> +	die_usage();
> +
> +	/* silence compiler warning */
> +	return 0;
> +}
> +
>  static int parse_int(const char *size)
>  {
>  	unsigned long s;
> @@ -846,7 +884,7 @@ static void parse_opts(int argc, char **argv)
>  {
>  	int c;
>  
> -	while ((c = getopt(argc, argv, "6jr:lp:s:hut:m:S:R:w:M:")) != -1) {
> +	while ((c = getopt(argc, argv, "6jr:lp:s:hut:m:S:R:w:M:P:")) != -1) {
>  		switch (c) {
>  		case 'j':
>  			cfg_join = true;
> @@ -899,6 +937,9 @@ static void parse_opts(int argc, char **argv)
>  		case 'M':
>  			cfg_mark = strtol(optarg, NULL, 0);
>  			break;
> +		case 'P':
> +			cfg_peek = parse_peek(optarg);
> +			break;
>  		}
>  	}
>  
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 385cdc9..6f77e04 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -3,7 +3,7 @@
>  
>  time_start=$(date +%s)
>  
> -optstring="S:R:d:e:l:r:h4cm:f:t"
> +optstring="S:R:d:e:l:r:h4cm:f:tP"
>  ret=0
>  sin=""
>  sout=""
> @@ -23,6 +23,8 @@ rcvbuf=0
>  options_log=true
>  do_tcp=0
>  filesize=0
> +testpeek=false
> +peekmode=""
>  
>  if [ $tc_loss -eq 100 ];then
>  	tc_loss=1%
> @@ -47,6 +49,7 @@ usage() {
>  	echo -e "\t-R: set rcvbuf value (default: use kernel default)"
>  	echo -e "\t-m: test mode (poll, sendfile; default: poll)"
>  	echo -e "\t-t: also run tests with TCP (use twice to non-fallback tcp)"
> +	echo -e "\t-P: test MSG_PEEK flags of recv() function"
>  }
>  
>  while getopts "$optstring" option;do
> @@ -104,6 +107,10 @@ while getopts "$optstring" option;do
>  	"t")
>  		do_tcp=$((do_tcp+1))
>  		;;
> +	"P")
> +		testpeek=true
> +		peekmode="saveWithPeek"
> +		;;

I'm sorry, it looks like I was not clear enough. I think this test need
to be enabled by default. Just drop this chunck and the above one.

>  	if [ -n "$extra_args" ] && $options_log; then
>  		options_log=false
>  		echo "INFO: extra options: $extra_args"
> @@ -706,6 +717,31 @@ echo "on ns3eth4"
>  
>  tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${reorder_delay}ms $tc_reorder
>  
> +if $testpeek; then
> +	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
> +	if [ $ret -ne 0 ] ;then
> +		echo "FAIL: Could not even run loopback test" 1>&2
> +		exit $ret
> +	fi
> +	run_tests_lo "$ns1" $sender dead:beef:1::1 1
> +	if [ $ret -ne 0 ] ;then
> +		echo "FAIL: Could not even run loopback v6 test" 2>&1
> +		exit $ret
> +	fi
> +
> +	#set peekmode="saveAfterPeek" and test again
> +	options_log=true
> +	peekmode="saveAfterPeek"
> +	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
> +	run_tests_lo "$ns1" $sender dead:beef:1::1 1
> +	
> +	time_end=$(date +%s)
> +	time_run=$((time_end-time_start))
> +	echo "Time: ${time_run} seconds"
> +	
> +	exit $ret
> +fi

With the tests always enabled you can change the above chunk in:

---
@@ -718,6 +718,16 @@ for sender in $ns1 $ns2 $ns3 $ns4;do
        run_tests "$ns4" $sender dead:beef:3::1
 done
 
+options_log=true
+peekmode="saveWithPeek"
+run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
+run_tests_lo "$ns1" $sender dead:beef:1::1 1
+
+options_log=true
+peekmode="saveAfterPeek"
+run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
+run_tests_lo "$ns1" $sender dead:beef:1::1 1
+
 time_end=$(date +%s)
 time_run=$((time_end-time_start))
---

that is: doing peek tests once after all the "normal" ones.

As Geliang noted, there are a few checkpatch violation (long lines,
needed whitespaces), please address them too, thanks!

/P

