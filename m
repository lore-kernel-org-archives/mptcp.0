Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93643168B9
	for <mptcp@lists.linux.dev>; Wed, 16 Aug 2023 16:32:54 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so65773685e9.3
        for <mptcp@lists.linux.dev>; Wed, 16 Aug 2023 09:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692203572; x=1692808372;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0rjkLF4xPnpOArpvH+KCr2tXPQ0QDU028E6ed/qNnAk=;
        b=GtPHdsGQzq0eaaQ6SIDNj8gi10cPkYBuduJDomGeOImUUe7UqbGyzqjFLFM6mWT2d9
         Iq6Vm/PM2AXiEMSHGs3aIjvZVXuUCnLCvQxBnWiW5mXJ13RnftMS86yNbC9jHCcFfzhE
         D00HZZY69tvcA4TmW93mXL8HHficJCBMLekMhVltJZpPgWn6vWSL3LdSlS03ZqwQeZDH
         QrctyhGQkL7CGigirgySc+peMxxoVSG5SWiWjys9EqJWG0WEE5sO5rsTrOvQEWKfzt7X
         JAWpswRfpQqPlrt5UJ5cot7D8Yv2fi6HW/cTorVakSom2NGP2DRg9WgrYXOYNkeFYGi7
         OitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692203572; x=1692808372;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0rjkLF4xPnpOArpvH+KCr2tXPQ0QDU028E6ed/qNnAk=;
        b=UdJiIqwdWcOZ3LMUtDVCXv5oA27234lY+gDFb6obbF1gh2wOBdGUHL8DWRpbKfJJWB
         hvuLM3qedDbS2apooKo4TTP5AUBFcr/8IhuF2wI8FcjuuRYePdPZ2oZNQ15OOPF4/pIM
         DONnVAEGGv1GLwnUS3IlTNoSSae5Qfrx9lMaHjc/5QfqsBM4v2rmrGRZUKfum+jZ3S9D
         R7JSiGnQ2SUbaWxNndtateCLdnGaxh6RlNols3/HAQ4RTXZz0NzR2fz0hU/m5902BHqg
         t44yfjJq8yu0lt5Hdrt69zgn9F/ObAIRFPQvnz2y6QmuzR6NzY4GflAwN5ztgB8zXgFu
         U2fQ==
X-Gm-Message-State: AOJu0Yws7k9p0VZwAt8mQmOkXHWHUs65UPr1deUyDd8C+DcxRt+V5g0Q
	fM1TlxjZmtbCfCs5OEm8qgHdUw==
X-Google-Smtp-Source: AGHT+IF4NTide4ha0auT5LEgAw140DoxOG9QIC+g8fDINeQq+pqLJ82g+KP/7/3V4y8GSM0mYbR0lQ==
X-Received: by 2002:a05:6000:4b:b0:317:f18b:a94f with SMTP id k11-20020a056000004b00b00317f18ba94fmr1983386wrx.1.1692203572418;
        Wed, 16 Aug 2023 09:32:52 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:9191:2283:c4d7:5cd7? ([2a02:578:8593:1200:9191:2283:c4d7:5cd7])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d6507000000b003143b14848dsm21626245wru.102.2023.08.16.09.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 09:32:52 -0700 (PDT)
Message-ID: <b8c15e79-8995-4333-a01f-0b3204f467ee@tessares.net>
Date: Wed, 16 Aug 2023 18:32:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2 4/4] selftests: mptcp: remove id 0 subflow &
 address
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1691564649.git.geliang.tang@suse.com>
 <e03195dc58397af6258c193c6a5a8fe457d20c33.1691564649.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <e03195dc58397af6258c193c6a5a8fe457d20c33.1691564649.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 09/08/2023 09:06, Geliang Tang wrote:
> This patch adds selftests for userpsace PM to remove id 0 subflow and
> id 0 address.
> 
> A new helper userspace_pm_rm_id_0_subflow_or_address_ns2() is added,
> in it use
> 
>         ./pm_nl_ctl dsf token $tk id 0
> 
> to remove id 0 subflow, and use
> 
>         ./pm_nl_ctl rem token $tk id 0
> 
> to remove id 0 address.

See my comment on patch 2/4: OK for the "./pm_nl_ctl rem token $tk id 0"
but not for "dsf id 0" for -net to fix issue #379.

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index ee1f89a872b3..52f081738c36 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3320,6 +3320,15 @@ userspace_pm_rm_sf_addr_ns2()
>  	wait_rm_sf $ns2 1
>  }
>  
> +userspace_pm_rm_id_0_subflow_or_address_ns2()

It might be useful to either add a comment about what the parameter are
(# $1: command (rem/dsf)) and/or use an dedicated local env var (local
cmd=${1}) otherwise we need to read the code to know which parameters
need to be given.


> +{
> +	local tk
> +
> +	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
> +	ip netns exec $ns2 ./pm_nl_ctl "$1" token $tk id 0
> +	sleep 0.5
> +}
> +
>  userspace_tests()
>  {
>  	# userspace pm type prevents add_addr
> @@ -3434,6 +3443,46 @@ userspace_tests()
>  		kill_events_pids
>  		wait $tests_pid
>  	fi
> +
> +	# userspace pm remove id 0 subflow
> +	if reset_with_events "userspace pm remove id 0 subflow" &&
> +	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
> +		set_userspace_pm $ns2
> +		pm_nl_set_limits $ns1 0 2
> +		speed=10 \
> +			run_tests $ns1 $ns2 10.0.1.1 &
> +		local tests_pid=$!
> +		wait_mpj $ns2
> +		userspace_pm_add_sf 10.0.1.2 0

Is it not going to create a subflow using the same IPs as the original
subflow? Is it on purpose? It looks confusing.

> +		userspace_pm_add_sf 10.0.3.2 20
> +		chk_join_nr 2 2 2
> +		chk_mptcp_info subflows 2 subflows 2
> +		userspace_pm_rm_id_0_subflow_or_address_ns2 dsf

Linked to my comment on patch 2/4, here we should do something like:

> ip netns exec $ns2 ./pm_nl_ctl dsf token $tk lip $sa lport $sp rip $da rport $dp token $tk     

where the source IP + port and destination IP + port are the ones from
the initial connection (10.0.1.2 -> 10.0.1.1?)

WDYT?

> +		chk_mptcp_info subflows 1 subflows 1
> +		chk_rm_nr 0 2
> +		kill_events_pids
> +		wait $tests_pid
> +	fi
> +
> +	# userspace pm remove id 0 address
> +	if reset_with_events "userspace pm remove id 0 address" &&
> +	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
> +		set_userspace_pm $ns2
> +		pm_nl_set_limits $ns1 0 2
> +		speed=10 \
> +			run_tests $ns1 $ns2 10.0.1.1 &
> +		local tests_pid=$!
> +		wait_mpj $ns2
> +		userspace_pm_add_sf 10.0.1.2 0

(same here: are you not creating a new subflow with the same IPs as the
original one? It might be confusing, no? But maybe on purpose? In this
case, please add a comment)

> +		userspace_pm_add_sf 10.0.3.2 20
> +		chk_join_nr 2 2 2
> +		chk_mptcp_info subflows 2 subflows 2
> +		userspace_pm_rm_id_0_subflow_or_address_ns2 rem
> +		chk_mptcp_info subflows 1 subflows 1
> +		chk_rm_nr 2 0
> +		kill_events_pids
> +		wait $tests_pid
> +	fi
>  }
>  
>  endpoint_tests()

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
