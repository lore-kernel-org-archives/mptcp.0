Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3792F83
	for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618831510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WyHYuLDaUKOD645KFl3asU44k92VBPMQZeHlSmW6zsg=;
	b=LeFn0ieEr+ojJmUKJXwOnxv0P11z2q4N5KEQAQfK7DqjiTNLUbswETo6fBvL3dUzRsAWwH
	Kea7ebp4Xatt7Ge7ZznqEyg3wfsEYNe8+QclfBivMpIEKsveE7rTx/qYhcnnFNFyLgQbOD
	aTWWRz/mqQ1x9IkNPB4E87J2fuKoKls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-bi6lSuVXNnOCvSC1PpFjHA-1; Mon, 19 Apr 2021 07:24:04 -0400
X-MC-Unique: bi6lSuVXNnOCvSC1PpFjHA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29F7264172;
	Mon, 19 Apr 2021 11:24:01 +0000 (UTC)
Received: from ovpn-114-242.ams2.redhat.com (ovpn-114-242.ams2.redhat.com [10.36.114.242])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9D0532953C;
	Mon, 19 Apr 2021 11:23:57 +0000 (UTC)
Message-ID: <1e0b273694aeb1a01ebb7728d7a80d2da3db16d5.camel@redhat.com>
Subject: Re: [PATCH v4 2/2] selftests: mptcp: add a test case for MSG_PEEK
From: Paolo Abeni <pabeni@redhat.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>, mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net, 
	fw@strlen.de, geliangtang@gmail.com, qitiepeng@chinatelecom.cn
Date: Mon, 19 Apr 2021 13:23:56 +0200
In-Reply-To: <1618800836-76736-2-git-send-email-liyonglong@chinatelecom.cn>
References: <1618800836-76736-1-git-send-email-liyonglong@chinatelecom.cn>
	 <1618800836-76736-2-git-send-email-liyonglong@chinatelecom.cn>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2021-04-19 at 10:53 +0800, Yonglong Li wrote:
> Extend mptcp_connect tool with MSG_PEEK support and add a test case in
> mptcp_connect.sh that checks the data recvived from/after recv() with
> MSG_PEEK.
> 
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c  | 48 +++++++++++++++++++++-
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 17 ++++++++
>  2 files changed, 63 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 2f207cf..d88e1fd 100644
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
> @@ -73,6 +80,8 @@ static void die_usage(void)
>  	fprintf(stderr, "\t-M mark -- set socket packet mark\n");
>  	fprintf(stderr, "\t-u -- check mptcp ulp\n");
>  	fprintf(stderr, "\t-w num -- wait num sec before closing the socket\n");
> +	fprintf(stderr,
> +		"\t-P [saveWithPeek|saveAfterPeek] -- save data with/after MSG_PEEK form tcp socket\n");
>  	exit(1);
>  }
>  
> @@ -331,6 +340,8 @@ static size_t do_write(const int fd, char *buf, const size_t len)
>  
>  static ssize_t do_rnd_read(const int fd, char *buf, const size_t len)
>  {
> +	int ret = 0;
> +	char tmp[16384];
>  	size_t cap = rand();
>  
>  	cap &= 0xffff;
> @@ -340,7 +351,17 @@ static ssize_t do_rnd_read(const int fd, char *buf, const size_t len)
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
> @@ -819,6 +840,26 @@ int parse_mode(const char *mode)
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
> +	fprintf(stderr,
> +		"\t\t\"saveWithPeek\" - recv data with flags 'MSG_PEEK' and save the peek data into file\n");
> +	fprintf(stderr,
> +		"\t\t\"saveAfterPeek\" - read and save data into file after recv with flags 'MSG_PEEK'\n");
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
> @@ -846,7 +887,7 @@ static void parse_opts(int argc, char **argv)
>  {
>  	int c;
>  
> -	while ((c = getopt(argc, argv, "6jr:lp:s:hut:m:S:R:w:M:")) != -1) {
> +	while ((c = getopt(argc, argv, "6jr:lp:s:hut:m:S:R:w:M:P:")) != -1) {
>  		switch (c) {
>  		case 'j':
>  			cfg_join = true;
> @@ -899,6 +940,9 @@ static void parse_opts(int argc, char **argv)
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
> index 385cdc9..319d166 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -23,6 +23,8 @@ rcvbuf=0
>  options_log=true
>  do_tcp=0
>  filesize=0
> +peekmode=""
> +testpeek=false
>  
>  if [ $tc_loss -eq 100 ];then
>  	tc_loss=1%
> @@ -393,6 +395,10 @@ do_transfer()
>  		extra_args="$extra_args -m $testmode"
>  	fi
>  
> +	if $testpeek; then
> +		extra_args="$extra_args -P $peekmode"
> +	fi
> +
>  	if [ -n "$extra_args" ] && $options_log; then
>  		options_log=false
>  		echo "INFO: extra options: $extra_args"
> @@ -732,6 +738,17 @@ for sender in $ns1 $ns2 $ns3 $ns4;do
>  	run_tests "$ns4" $sender dead:beef:3::1
>  done
>  
> +testpeek=true
> +options_log=true
> +peekmode="saveAfterPeek"
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

LGTM! and to checkpatch, also!

Acked-by: Paolo Abeni <pabeni@redhat.com>

