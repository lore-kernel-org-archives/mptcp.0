Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2649D2C87
	for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 11:07:23 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id r4so8955484edi.5
        for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 04:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fL+SUyeHV+gzlsc5qsUCMIVcRgsQqDnnOXw+i09evHo=;
        b=sosggvJ21IaX7sYn6xQw4zWerRqqNQgD+xZBypGMShQ9IFTCIvritw2MbDjW4j3Ows
         ARsZr5+xINMFK8Rr6HTwQBaOAjPl8Kt8lBc43pGFhQ6gkx2ta/EPlq55bSLeU6HUxs6Z
         aSdcTopHBjKktiM25v2koOsRhhXH2SsTNgMOwykQZDbeLaJNwvUXHVjmAJHIx4d8NzdZ
         9tRNoCGIMhcscvS5T8WtIvf0nhbs/SrpxcQjZ3gOWTYn9NnogTQacGEGfYZk/ZOJQIVE
         6Q74U2km8Xrh3rrR8VwcG9pS/SI2jknulA9F6WQK5fb8ISV0tosgIgelxTOrri0xmUr7
         bzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fL+SUyeHV+gzlsc5qsUCMIVcRgsQqDnnOXw+i09evHo=;
        b=MOYqsxPGSIhXCmEdmcuCDqo14lkwd3w82AqzxH56VIkhP9C0HFR8RQ5mdoBkWgQDEX
         eokRqRqpArRsiibG2JpyQPOHWRO/VgUdTBJVP5hUCKG3LVApLCWrqsA1PPXNNXy8SAog
         2TNqh/UFd1NB73pBufdon3UGW5D2rgIobxkNNyILE5/k5iqbRhBq5Awqg/ruy/NBmBAa
         Vn8VBL1/b+6EbV8uLj7y9wiOVqv9fPVsWK0RxTVbq2QSvlY6Ql2RVP0dHtTt9B6J6QsI
         2hltUDPWqwCpBy5Nr9K/sW5EOPDLu/i56z9Eas/fIoL5vEwMpfbdwQ4CFFir7E2fhmEE
         VOxg==
X-Gm-Message-State: AOAM532wXwP5m/of80RCLnGksv9sXUaIy7SLkR4FZKVYW9jmVg7jbDfe
	hMhOA9ONpNWzISPQy/JIDUFdpg==
X-Google-Smtp-Source: ABdhPJyldPV1MF21kz5nEM6jsb/OC8LZFnGasWkd4ecDOOVqvI26PBItiSOyWp1KAgm957xxTxbQrQ==
X-Received: by 2002:a17:906:c005:: with SMTP id e5mr37245745ejz.480.1635332841305;
        Wed, 27 Oct 2021 04:07:21 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id r15sm10133427edd.96.2021.10.27.04.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 04:07:21 -0700 (PDT)
Message-ID: <0014ae81-c8b1-e3d1-4580-40bb299c17f4@tessares.net>
Date: Wed, 27 Oct 2021 13:07:20 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: Davide Caratti <dcaratti@redhat.com>
References: <98ce131530c3ae91bf2ca29e6566ca1f7debe202.1635330390.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <98ce131530c3ae91bf2ca29e6566ca1f7debe202.1635330390.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 27/10/2021 12:26, Geliang Tang wrote:
> Added the test cases for MP_FAIL, use 'tc' command to trigger the
> checksum failure.

Thank you for looking at that!

> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> index 0faaccd21447..dc7d5d1d5861 100644
> --- a/tools/testing/selftests/net/mptcp/config
> +++ b/tools/testing/selftests/net/mptcp/config
> @@ -15,3 +15,11 @@ CONFIG_NETFILTER_XTABLES=m
>  CONFIG_NETFILTER_XT_MATCH_BPF=m
>  CONFIG_NF_TABLES_IPV4=y
>  CONFIG_NF_TABLES_IPV6=y
> +CONFIG_GACT_PROB=y
> +CONFIG_NET_CLS_FLOWER=m
> +CONFIG_NET_CLS_ACT=m
> +CONFIG_NET_SCH_INGRESS=m
> +CONFIG_NET_SCH_HTB=m

I guess we no longer need HTB with the TC commands you are using.

> +CONFIG_NET_ACT_CSUM=m
> +CONFIG_NET_ACT_GACT=m

I don't think we need gact anymore if you don't need to filter some
packets, e.g; one out of 10.
Same for CONFIG_GACT_PROB.

> +CONFIG_NET_ACT_PEDIT=m> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 7ef639a9d4a6..8bf38db1d54c 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -232,6 +232,20 @@ link_failure()
>  	done
>  }
>  
> +checksum_failure()
> +{
> +	tc -n $ns2 qdisc add dev ns2eth2 clsact
> +	tc -n $ns2 filter add dev ns2eth2 egress \
> +		protocol ip prio 1000 \
> +		flower ip_proto tcp \
> +		action pedit munge offset 148 u32 invert \
> +		pipe csum tcp
> +
> +	sleep 1

This looks dangerous to me. We should probably check tc counters to see
if the pedit action did something, no?

Maybe on slow environments, one second will not be enough (or way too
much). Maybe iterating every .1 second on the counters to see if
something happened might help.

> +
> +	tc -n $ns2 qdisc del dev ns2eth2 clsact
> +}
> +
>  # $1: IP address
>  is_v6()
>  {
> @@ -419,6 +433,8 @@ do_transfer()
>  			fi
>  			sleep 1
>  			ip netns exec ${connector_ns} ./pm_nl_ctl del 0 $addr
> +		elif [ $rm_nr_ns2 -eq 10 ]; then

I'm really not a big fan of giving a number representing something but I
see we are already doing that before. Also when you use it later:

  run_tests $ns1 $ns2 10.0.1.1 2 0 -10 fast

With the IP and "fast" it is clear but not the rest. Using something
like what we do with the fullmesh (fullmesh_1: 'fullmesh' mode with one
add_addr) seems clearer to me than giving "-10" or replacing "-10" by a
variable (e.g. ${CORRUPT_PACKETS}) but OK → we should do more
modifications around that I guess.
> +fail_tests()
> +{
> +       # multiple subflows
> +       reset
> +       ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +       ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +       ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
> +       ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2 flags subflow
> +       run_tests $ns1 $ns2 10.0.1.1 2 0 -10 fast
> +       chk_join_nr "MP_FAIL test, multiple subflows" 2 2 2 1
> +}

It looks like you are using spaces instead of tabs here.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
