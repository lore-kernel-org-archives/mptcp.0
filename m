Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753C528E2
	for <mptcp@lists.linux.dev>; Fri, 21 Apr 2023 11:32:45 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-94f7a0818aeso204179966b.2
        for <mptcp@lists.linux.dev>; Fri, 21 Apr 2023 04:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682076763; x=1684668763;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qPQ9Sj4CK3+QKDEX+s69XpBU2xmQa6pveitta2OjQQc=;
        b=f5RseHu2tZPAP1zqlslUIkrlCjard2FS8Gxd4zsQsWlUbemGBC5q743NBWq+JgxGXi
         jyVLytJdzHOn1+Uq20z7Pf3n6u0JX3JnyoWDugUFq/LLT6fceCfV6ZN0zhpaFiPDQgQ7
         L9Ozg/d8qzXZ3g4uUYKv5sn2GGFZBJ1RNl2bb69YWKTVlXYMBSCDt4ksaLSwModEMdcY
         SueGrULh9Lql/9f0J0ODuGSs5klmJtPS2dyoAudnLVS7OinvlUE6dw1mj6gUbZypxCaF
         q47wusS2Yc/F1qYY5FawUKiYZhRSjqoP0mwJ8ro6qzaIjXg85EXNW9qhWw3AnCtfnfaX
         A5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682076763; x=1684668763;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qPQ9Sj4CK3+QKDEX+s69XpBU2xmQa6pveitta2OjQQc=;
        b=javdJ4LUt0rwZ4ayOE55Mpd0O2JBM3Z4xoaL4aSy2ljBiDcE+zaVwOgB9dL27Q/KmI
         eS6zO2upKpeKLWjSaKGOn5HPYSDGJjXzPm/jvBu+qbnNnxqEP/3RgO1eYYshKKFRtOC0
         4P94OP1mG7VTav+K/RHfENJXaqe7bcefZ80U2ZffkBovFwGF2ZN/WQykK/p89wlDUu73
         qnnU1ITVdk9ASy4ax+bShkQLePdU9iOUWsCDC03HlFt/9F4D1fylg+9tOaWxmvJfEYZJ
         8FX9jRGCz2fOlWAxmTbRGIo1ARtwZyAAOFCV7gpLi9vlxvCi88+Y+NbRl5DS9wd5jxSq
         9F8g==
X-Gm-Message-State: AAQBX9es/ChWU3OJSXOaFYUWEGBsjuZW4nlVUBaF+5rHQvlsFuaOEhoS
	RJ7ZBi0sTDAFZpMcA5w0VejD1LBn8AgdZeL7wtCaY58T
X-Google-Smtp-Source: AKy350ZxfmLxa58XCGfqg9nykLqTYPo1GiGv8pWrkqAyn8kJvezsBNG7f1yZhZzcxYFBPw0ZFRLUWQ==
X-Received: by 2002:a17:906:5a5d:b0:94a:6071:d613 with SMTP id my29-20020a1709065a5d00b0094a6071d613mr1977439ejc.64.1682076763431;
        Fri, 21 Apr 2023 04:32:43 -0700 (PDT)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090610c800b0093313f4fc3csm1943209ejv.70.2023.04.21.04.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 04:32:43 -0700 (PDT)
Message-ID: <ec7e4def-0a36-d564-2be9-885937e4d4be@tessares.net>
Date: Fri, 21 Apr 2023 13:32:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 mptcp-next 2/3] selftests: mptcp: add explicit check
 for new mibs
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1681481877.git.pabeni@redhat.com>
 <0ea2ad27bcfb589e1d6e0c00f14a7a3c30a97824.1681481877.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <0ea2ad27bcfb589e1d6e0c00f14a7a3c30a97824.1681481877.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 14/04/2023 16:19, Paolo Abeni wrote:
> Instead of duplicating the all existing TX check with
> the TX side, add the new ones on selected test cases.

Good idea!

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 095ddd747ffc..f6ce10130ded 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1579,6 +1579,44 @@ chk_add_nr()
>  	[ "${dump_stats}" = 1 ] && dump_stats
>  }
>  
> +chk_add_tx_nr()
> +{
> +	local add_tx_nr=$1
> +	local echo_tx_nr=$2
> +	local dump_stats
> +	local timeout
> +	local count
> +
> +	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
> +
> +	printf "%-${nr_blank}s %s" " " "add TX"
> +	count=$(ip netns exec $ns1 nstat -as MPTcpExtAddAddrTx | grep MPTcpExtAddAddrTx | awk '{print $2}')
> +	[ -z "$count" ] && count=0

In order to support running this on old kernels, could we check if the
counter is available first and skip the checks if not?

e.g. by using "nstat" with "-z" and return if '[ -z "${count}" ]'?

We could also exit if there is no counter if
${SELFTESTS_MPTCP_LIB_EXTRA_CHECKS} is set, see:

https://patchwork.kernel.org/project/mptcp/patch/20230406-mptcp-issue-368-selftests-old-kernels-v1-8-246ac567724d@tessares.net/

(We should add a helper to do this exit if the variable is set so we
make sure this doesn't happen when our CI does the tests, always with
the same version for the selftests and the kernel)

> +
> +	# if the test configured a short timeout tolerate greater then expected
> +	# add addrs options, due to retransmissions
> +	if [ "$count" != "$add_tx_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_tx_nr" ]; }; then
> +		echo "[fail] got $count ADD_ADDR[s] TX, expected $add_tx_nr"
> +		fail_test
> +		dump_stats=1
> +	else
> +		echo -n "[ ok ]"
> +	fi
> +
> +	echo -n " - echo TX "
> +	count=$(ip netns exec $ns2 nstat -as MPTcpExtEchoAddTx | grep MPTcpExtEchoAddTx | awk '{print $2}')
> +	[ -z "$count" ] && count=0

(if you use "nstat" with "-z", you don't need this line)

> +	if [ "$count" != "$echo_tx_nr" ]; then
> +		echo "[fail] got $count ADD_ADDR echo[s] TX, expected $echo_tx_nr"
> +		fail_test
> +		dump_stats=1
> +	else
> +		echo "[ ok ]"
> +	fi
> +
> +	[ "${dump_stats}" = 1 ] && dump_stats
> +}
> +
>  chk_rm_nr()
>  {
>  	local rm_addr_nr=$1
> @@ -1654,6 +1692,26 @@ chk_rm_nr()
>  	echo "$extra_msg"
>  }
>  
> +chk_rm_tx_nr()
> +{
> +	local rm_addr_tx_nr=$1
> +
> +	printf "%-${nr_blank}s %s" " " "rm TX "
> +	count=$(ip netns exec $ns2 nstat -as MPTcpExtRmAddrTx | grep MPTcpExtRmAddrTx | awk '{print $2}')
> +	[ -z "$count" ] && count=0

Same here: skip the check if 'nstat -asz' return nothing?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
