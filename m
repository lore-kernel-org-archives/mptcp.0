Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617148F75
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 11:32:01 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id e18so24056513edj.3
        for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBsLNE9Pbq1fhnGAfz8/cgJdH/Th+g4OCC15xAfxUU4=;
        b=D9oXuzDQIPZfkwgqbq+FIRxpYYzvAXzSiQKnNf+iVrglFGHyWvbaNYoUK/pGfZv4ve
         /OYeP4tnAVfFfWliNdbUOo/4bHPRjRwy5/7Z6gTYubHu3K8R41IuGZDrUoNAx8xW1vs5
         rXF7KqvfYjFDQFxskdq0nAb2mwqo4SQhPx/zls+tRpvL9iczjI3W+BELXZMYjlF2tYPO
         WlSe3VbYT5f3lOXPq25837+h9aqWMOVwjxjYU/ujooLksZ37cbJ27a9Fw5Namcxyejy5
         pbMp1asBXJ7V4iyHFDW3TS2SzJKXcGVH4FFoTfL310rLzKReMlAku1D8Jj1KpUCE1V97
         g7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBsLNE9Pbq1fhnGAfz8/cgJdH/Th+g4OCC15xAfxUU4=;
        b=7y3n0VRSzEEiPOgxD2ymOCeqDLFEPfDrb87gvHzZ3IbXOiWBGRVi6Gxq1z2psudbBS
         exgHgBKDkbgaPIxx73UT8cRAaQ/+jfK5yBb5vsZEs4m8sxP4YFBiTc3bRwzwCDoDUvNn
         0PA+yKC+Fz2StkCo525HzSu4Fr54Ka/i7qOE1yO2Fc4czscPjmax1S1PZjc4fTgNaSrE
         PxZ4uvGZWRR+uMSOqk6tB4IICDHNk2Ml2JyrkX9dCtxw3pMs+ZDBw/A84+mb+wN2Sbdz
         9gYZxTdJeO+fHkkqZMWRtg031IAQIVZX47i8qEbeiwKyiVAkh55rVU2kQE4//rig/KTb
         v9kg==
X-Gm-Message-State: ACrzQf20v7rL8VVzsEw42dukAy1K48B2ML/2+RBwR+zA9G/tRexeRhTL
	Sw9Y1doVi+DIbOfcKw7PweqHcw==
X-Google-Smtp-Source: AMsMyM6dTCtDXa+kB/7hzhStTuJlGiQTrA7kBpYFKKQuVMj+hfBnhE2TZ3Bc8dYhNr77RyzQXcmCcg==
X-Received: by 2002:a05:6402:b5a:b0:458:f4c6:8039 with SMTP id bx26-20020a0564020b5a00b00458f4c68039mr26988459edb.349.1665574320167;
        Wed, 12 Oct 2022 04:32:00 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:765f:321d:fe2e:6d29? ([2a02:578:8593:1200:765f:321d:fe2e:6d29])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906058900b0078d4c72e2cesm1119190ejn.44.2022.10.12.04.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 04:31:59 -0700 (PDT)
Message-ID: <e89fc24c-36d9-3352-63e4-354dca83b171@tessares.net>
Date: Wed, 12 Oct 2022 13:31:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-next v5 3/3] selftest: mptcp: add test for mptcp
 socket in use
Content-Language: en-GB
To: menglong8.dong@gmail.com, mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
References: <20221007092922.13169-1-imagedong@tencent.com>
 <20221007092922.13169-4-imagedong@tencent.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221007092922.13169-4-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Menglong,

If you have to edit this commit (see my message on the patch 0/3), I
have some small improvements to suggest.

On 07/10/2022 11:29, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> Add the function chk_msk_inuse() to diag.sh, which is used to check the
> statistics of mptcp socket in use. As mptcp socket in listen state will
> be closed randomly after 'accept', we need to get the count of listening
> mptcp socket through 'ss' command.
> 
> mptcp_connect command with '-r' flag seems won't exit after flush_pids,
> therefore we need consider this additional statistics. But after the
> second flush_pids, it will exit.
> 
> All tests pass.
> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
>  tools/testing/selftests/net/mptcp/diag.sh | 28 +++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index 515859a5168b..d969cb45b8a9 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -141,6 +141,28 @@ chk_msk_listen()
>  	nr=$(ss -Ml $filter | wc -l)
>  }
>  
> +chk_msk_inuse()
> +{
> +	local nr listen_nr
> +	local expected=$1
> +
> +	shift 1
> +	msg=$*

Can you mark 'msg' as 'local' please?
(we regularly forget to add this keyword, it is possible it is missing
in other places)

> +
> +	nr=$(ip netns exec $ns awk '$1~/^MPTCP$/{print $3}' /proc/net/protocols)
> +	listen_nr=$(ss -N $ns -Ml | grep -c LISTEN)
> +	expected=$(($expected+$listen_nr))
> +
> +	printf "%-50s" "$msg"
> +
> +	if [ $nr != $expected ]; then
> +		echo "[ fail ] expected $expected found $nr"
> +		ret=$test_cnt
> +	else
> +		echo "[  ok  ]"
> +	fi

Could it not be possible to re-use __chk_nr()? (maybe you need to
slightly adapt it?)

> +}
> +
>  # $1: ns, $2: port
>  wait_local_port_listen()
>  {
> @@ -194,8 +216,11 @@ wait_connected $ns 10000
>  chk_msk_nr 2 "after MPC handshake "
>  chk_msk_remote_key_nr 2 "....chk remote_key"
>  chk_msk_fallback_nr 0 "....chk no fallback"
> +chk_msk_inuse 2 "msk in use statistics"
>  flush_pids
>  
> +# with '-r' flag, client won't exit after flush_pids
> +chk_msk_inuse 1 "msk in use statistics"
>  
>  echo "a" | \
>  	timeout ${timeout_test} \
> @@ -231,6 +256,9 @@ for I in `seq 1 $NR_CLIENTS`; do
>  done
>  
>  wait_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
> +chk_msk_inuse $((NR_CLIENTS*2+1)) "msk in use statistics"

Why do you expect to see msk + 1?

>  flush_pids
>  
> +chk_msk_inuse 0 "msk in use statistics"

The message "msk in use statistics" is always the same. Maybe clearer if
it is slightly different? e.g. to print something like:

after MPC handshake
....chk remote_key
....chk no fallback
....chk 2 msk in use
....chk 0 msk in use after flush
check fallback
many msk socket present
....chk many msk in use
....chk 0 msk in use after flush

WDYT?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
