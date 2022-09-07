Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E5389A5
	for <mptcp@lists.linux.dev>; Wed,  7 Sep 2022 17:22:33 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id b16so20752475edd.4
        for <mptcp@lists.linux.dev>; Wed, 07 Sep 2022 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=iIa/6NLr+bR0e1oZ9ZufHCAugWOyCTCQtQ0QLUnnu3s=;
        b=T26uZijEIeu9vtkXBEsBX+gFmCRmlBo8HUmx11SqOWMKO4LRhtMK6hmP6jywjX1ilo
         mmpbofLYq0bDAxXMr9koF5U3LRn0kmqlMkj6jJrHXb6NVwW+iN+d0Zm09VyXm5RDg00i
         ZsiUyGj9QQP+FbJ3WQwhECXGR0fssKHXf+S4LeonF2pHowCgJi1ZC+bU5Kv+qUFcEHcI
         HAl4HTY68e0ELoY4oxCWoxsrBolTgJTrB0eD8L7BoSbbvmd3DsPRuyLzSkZkPCYCXvEP
         HgFtIZBtYd6YbVVKM0HgsflVCyzXWjbHrqCFN0rAuB2XKKYr+LhV1LlOFt5BoVkkXkxQ
         ilQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=iIa/6NLr+bR0e1oZ9ZufHCAugWOyCTCQtQ0QLUnnu3s=;
        b=pMcnV0VKY9kL2TubNgPifn0m7IT+3+V+zQGoMV2zGmxwbfd/XgHB/DB0cZ724RAhgb
         rRqWweDE9qYQi3snpy4L1ApDJmAEsGPdZ5u93/Qx8sKS88cRC3ugZFT4CfQWdxTxgfZI
         RZuEYxqZtlXbQpFOm4JhfNUeHo+Oe66/vEhJrSyYOyYV8P1rUL2UL1txR0yzx/1nfg5t
         5O3BvQY57o2ZZiJwYnH7hi4/7MxwJjjThI0TsWs4h5g7QE+gKgqysucq1HMuEIeHbzNe
         Gqvyf0mdaCju2pE6tZoFkLczlMBSKYiuwyV+ASVaUI/Yash2sKF00iEtCOlcImSPBOEX
         2IHg==
X-Gm-Message-State: ACgBeo0SzFUE+hxOPMn3124BUp24+T5IvLQlRaLCILuwCAZC36Kcflof
	yRBCvgjeoQZMpm9ET8IwCn26E00VcGq0VxMx
X-Google-Smtp-Source: AA6agR4i2GpwKZTmt2s/4ETfJHOlaNUgbQHYvbvV1n/4Yz4YAJrLfE516ZT0GEt+TWugb3H+hk+HSQ==
X-Received: by 2002:a05:6402:1388:b0:447:a3a4:6152 with SMTP id b8-20020a056402138800b00447a3a46152mr3954098edv.13.1662571351292;
        Wed, 07 Sep 2022 10:22:31 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6db7:c94e:7f7:7f98? ([2a02:578:8593:1200:6db7:c94e:7f7:7f98])
        by smtp.gmail.com with ESMTPSA id td13-20020a1709078c8d00b0073c9db65819sm1628ejc.47.2022.09.07.10.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 10:22:31 -0700 (PDT)
Message-ID: <d7a536f8-ac96-0b8b-7460-2a240aeb2d32@tessares.net>
Date: Wed, 7 Sep 2022 19:22:30 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 mptcp-next 3/3] selftests: mptcp: update and extend
 fastclose test-cases
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <5e26963328ae04aa375089a713ec40f5eb6adacd.1662051551.git.pabeni@redhat.com>
 <27d535b3cc0cd665ba6404056aa51fb4a1628f44.1662051551.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <27d535b3cc0cd665ba6404056aa51fb4a1628f44.1662051551.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 01/09/2022 19:31, Paolo Abeni wrote:
> After the previous patches, the MPTCP protocol can generate
> fast-closes on both ends of the connection. Rework the relevant
> test-case to carefully trigger the fast-close code-path on a
> single end at the time, while ensuring than a predictable amount
> of data is spooled on both ends.
> 
> Additionally add another test-cases for the passive socket
> fast-close.

Thank you for the v3!

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 24d4e9cb617e..ee6df83c55f3 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c

(...)

> @@ -381,8 +382,6 @@ static size_t do_rnd_write(const int fd, char *buf, const size_t len)
>  		do_w = cfg_do_w;
>  
>  	bw = write(fd, buf, do_w);
> -	if (bw < 0)
> -		perror("write");

Should we skip the sleep done here just below and return bw directly in
case of error?
Or is it more like an small opti not really needed?

>  
>  	/* let the join handshake complete, before going on */
>  	if (cfg_join && first) {
> @@ -571,7 +570,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
>  		.fd = peerfd,
>  		.events = POLLIN | POLLOUT,
>  	};
> -	unsigned int woff = 0, wlen = 0;
> +	unsigned int woff = 0, wlen = 0, total_wlen = 0, total_rlen = 0;
>  	char wbuf[8192];
>  
>  	set_nonblock(peerfd, true);
> @@ -597,7 +596,16 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
>  		}
>  
>  		if (fds.revents & POLLIN) {
> -			len = do_rnd_read(peerfd, rbuf, sizeof(rbuf));
> +			ssize_t rb = sizeof(rbuf);
> +
> +			/* limit the total amount of read data to the trunc value*/
> +			if (cfg_truncate > 0) {
> +				if (rb + total_rlen > cfg_truncate)
> +					rb = cfg_truncate - total_rlen;
> +				len = read(peerfd, rbuf, rb);
> +			} else {
> +				len = do_rnd_read(peerfd, rbuf, sizeof(rbuf));
> +			}
>  			if (len == 0) {
>  				/* no more data to receive:
>  				 * peer has closed its write side
> @@ -612,10 +620,14 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
>  
>  			/* Else, still have data to transmit */
>  			} else if (len < 0) {
> +				/* ignore errors on I/O operation when the peer is fastclosing */
> +				if (cfg_truncate < 0)

(it is confusing to me to use negative values for a special case
(requiring an addional comment each time) instead of using a new
dedicated option with a clear name but probably just me :) )

> +					return 0;
>  				perror("read");
>  				return 3;
>  			}
>  
> +			total_rlen += len;
>  			do_write(outfd, rbuf, len);
>  		}
>  

(...)

> @@ -1262,8 +1295,15 @@ static void parse_opts(int argc, char **argv)
>  {
>  	int c;
>  
> -	while ((c = getopt(argc, argv, "6c:hi:I:jlm:M:o:p:P:r:R:s:S:t:T:w:")) != -1) {
> +	while ((c = getopt(argc, argv, "6c:f:hi:I:jlm:M:o:p:P:r:R:s:S:t:T:w:")) != -1) {
>  		switch (c) {
> +		case 'f':

Maybe better to update the die_usage() function if you don't mind.

> +			cfg_truncate = atoi(optarg);
> +
> +			/* when receiving a fastclose, ignore PIPE signals */
> +			if (cfg_truncate < 0)
> +				signal(SIGPIPE, handle_signal);
> +			break;
>  		case 'j':
>  			cfg_join = true;
>  			cfg_mode = CFG_MODE_POLL;
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 2957fe414639..0f4c9c4bcb5b 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

(...)

> @@ -707,9 +718,29 @@ do_transfer()
>  	fi
>  
>  	local flags="subflow"
> +	local extra_cl_args=""
> +	local extra_srv_args=""
> +	local trunc_size=""
>  	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
> +		if [ ${test_link_fail} -le 1 ]; then
> +			echo "fastclose tests need test_link_fail argument"
> +			return 0

Probably clearer to exit directly with an error, to be sure the CI
catches this, no?
Or do you think it is not needed?

> +		fi
> +
>  		# disconnect
> -		extra_args="$extra_args -I ${addr_nr_ns2:10}"
> +		trunc_size=${test_link_fail}
> +		local side=${addr_nr_ns2:10}
> +
> +		if [ ${side} = "client" ]; then
> +			extra_cl_args="-f ${test_link_fail}"
> +			extra_srv_args="-f -1"
> +		elif [ ${side} = "server" ]; then
> +			extra_srv_args="-f ${test_link_fail}"
> +			extra_cl_args="-f -1"
> +		else
> +			echo "wrong/unknown fastclose spec ${side}"
> +			return 0

Same here.

> +		fi
>  		addr_nr_ns2=0
>  	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
>  		userspace_pm=1

(...)

> @@ -1188,12 +1221,23 @@ chk_fclose_nr()
>  {
>  	local fclose_tx=$1
>  	local fclose_rx=$2
> +	local ns_invert=${3:-""}

(I'm not sure why you need to default to an empty string but that's a
detail :) )

>  	local count
>  	local dump_stats
> +	local ns_tx=$ns2
> +	local ns_rx=$ns1
> +	local extra_msg=""
> +
> +	if [[ $ns_invert = "invert" ]]; then
> +		ns_tx=$ns1
> +		ns_rx=$ns2
> +		extra_msg="   invert"
> +	fi
>  
>  	printf "%-${nr_blank}s %s" " " "ctx"
> -	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPFastcloseTx | awk '{print $2}')
> +	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPFastcloseTx | awk '{print $2}')
>  	[ -z "$count" ] && count=0
> +	[ "$count" != "$fclose_tx" ] && extra_msg="$extra_msg,tx=$count"

detail: if we are not in the "invert" mode, extra_msg will be empty: no
need to add the 3 spaces? or init extra_msg with these 3 spaces?

>  	if [ "$count" != "$fclose_tx" ]; then
>  		echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
>  		fail_test

(...)

> @@ -1236,7 +1283,7 @@ chk_rst_nr()
>  	printf "%-${nr_blank}s %s" " " "rtx"
>  	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPRstTx | awk '{print $2}')
>  	[ -z "$count" ] && count=0
> -	if [ "$count" != "$rst_tx" ]; then
> +	if [ $count -lt $rst_tx ]; then

Why is it fine if we send (and below receive) more than expected?

>  		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
>  		fail_test
>  		dump_stats=1
> @@ -1247,7 +1294,7 @@ chk_rst_nr()
>  	echo -n " - rstrx "
>  	count=$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPRstRx | awk '{print $2}')
>  	[ -z "$count" ] && count=0
> -	if [ "$count" != "$rst_rx" ]; then
> +	if [ "$count" -lt "$rst_rx" ]; then
>  		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
>  		fail_test
>  		dump_stats=1
> @@ -2801,11 +2848,18 @@ fullmesh_tests()
>  fastclose_tests()
>  {
>  	if reset "fastclose test"; then
> -		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_2
> +		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_client

clearer :)

>  		chk_join_nr 0 0 0
>  		chk_fclose_nr 1 1
>  		chk_rst_nr 1 1 invert
>  	fi
> +
> +	if reset "fastclose server test"; then
> +		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_server
> +		chk_join_nr 0 0 0
> +		chk_fclose_nr 1 1 invert
> +		chk_rst_nr 1 1
> +	fi
>  }
>  
>  pedit_action_pkts()

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
