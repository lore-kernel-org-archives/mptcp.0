Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64212583
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 15:23:30 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f6e68cc738so46042355e9.1
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685546609; x=1688138609;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7C8RJXuCjjCdSL/TDZC70//4TiZ70PPS1K4AG/2ndww=;
        b=UKRr1qYNUz8gE9oGYjlT6MdyFuhAPBcIoddyMfxbgo28c2HF3nFqq9hBPm2TmtJ872
         k+qyA2OX1slJdEeJD31xs0RX1SGLmt3uiG5xtPC5vdhVca3R+7VKPt3JcJLQH7QkmEW3
         mjlyaMiEiA9TRXXeEAr73wtSNlweMxC4i8O2funcUSlePtDUwJWIBCbhV59O2piI03gE
         3Z7tAA8T86fQgdjXOb/rMOaVXL9dJd3cQcUctvNOlLcRKUGdE4PhxHCLba6y7GdJa7Bs
         sPT+gKYwYGyMCwVpQTCWN1XkfbSwp9k1OpPpKIF6D1CFBUzKrZhpThGvTfsfl9dslgIb
         lD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685546609; x=1688138609;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7C8RJXuCjjCdSL/TDZC70//4TiZ70PPS1K4AG/2ndww=;
        b=fTVGCsbw7DsDO/0i/MGDtlB0h4xIgWwthhknt1uHyQa+tmzH4H1EuE6dS6JzQH/3R9
         dVz/5gyYnU5cjKLg7aisk5J56Ujavf51bTDxS1MqcHfzszVy6uxFUiPg9cUQ9U1LGBpS
         KlHOLJMoVd7vcwJzQtokKcufIIm/MlUFbSOfUrpD/Xa2qdLCL3V9by+7oXCyFRd62L3e
         lnYLgMbKURIw0A/j36ZGwoDxuXYXx5rY3VcrEfgB6D6M410CaQysa9Rg7oUZLnXSGHDS
         b45bLSVAraiMyjldJEvP6hXnGfrOKncio2p7CyYn5vfwnlADLBEVxYzUCZG8uPl4UNKJ
         nNxg==
X-Gm-Message-State: AC+VfDzvCl8pO6HrU9VzGnetXdFuCdrL0Q9AFCQql3suq+nRLI6nfFc6
	8Lzc4HOT8fq4AW7//jyPNjiSG/4w/ZusiPdbabynazpY
X-Google-Smtp-Source: ACHHUZ52p77S6GcLZ31R1F2MkMGKInsunxAR1A9K7RXMY2ckFuFfVntqca1fH0UmjQQBjLIMytrdnQ==
X-Received: by 2002:adf:e5c7:0:b0:30a:e3da:efe5 with SMTP id a7-20020adfe5c7000000b0030ae3daefe5mr4450537wrn.32.1685546609040;
        Wed, 31 May 2023 08:23:29 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:b1d9:81ac:cb3:35d0? ([2a02:578:8593:1200:b1d9:81ac:cb3:35d0])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d54cd000000b003063db8f45bsm7201802wrv.23.2023.05.31.08.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 08:23:28 -0700 (PDT)
Message-ID: <14fae2d2-35fa-daf9-e269-4131fffe0ae6@tessares.net>
Date: Wed, 31 May 2023 17:23:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v15 7/7] selftests: mptcp: set endpoint out of
 transfer
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1685523463.git.geliang.tang@suse.com>
 <46e0ef22b358efde64e3783c4cce79dbcc45f417.1685523463.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <46e0ef22b358efde64e3783c4cce79dbcc45f417.1685523463.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 31/05/2023 10:58, Geliang Tang wrote:
> This patch moves endpoint settings out of do_transfer() into a new
> function pm_nl_set_endpoint(), then addr_nr_ns1 and addr_nr_ns2
> arguments can be removed for do_transfer() and run_tests().

(...)

> @@ -2276,7 +2302,7 @@ remove_tests()
>  		pm_nl_set_limits $ns2 0 2
>  		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -		run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
> +		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 -2 speed_10 "" 1

Why did you switch from slow to speed_10 here? (see below for more
questions)

Same below ↓

>  		chk_join_nr 2 2 2
>  		chk_rm_nr 2 2
>  	fi

(...)

> @@ -2350,7 +2376,7 @@ remove_tests()
>  		pm_nl_set_limits $ns2 1 3
>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>  		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> -		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
> +		run_tests_bg $ns1 $ns2 10.0.1.1 0 -8 -8 speed_10 "" 1
>  		chk_join_nr 3 3 3
>  		chk_add_nr 1 1
>  		chk_rm_nr 1 3 invert simult
> @@ -2363,7 +2389,7 @@ remove_tests()
>  		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>  		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> -		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
> +		run_tests_bg $ns1 $ns2 10.0.1.1 0 -8 -8 speed_10 "" 1
>  		chk_join_nr 3 3 3
>  
>  		if mptcp_lib_kversion_ge 5.18; then
> @@ -2381,7 +2407,7 @@ remove_tests()
>  		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
>  		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
>  		pm_nl_set_limits $ns2 3 3
> -		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
> +		run_tests_bg $ns1 $ns2 10.0.1.1 0 -8 -8 speed_10 "" 1
>  		chk_join_nr 3 3 3
>  		chk_add_nr 3 3
>  		chk_rm_nr 3 3 invert simult
> @@ -2394,7 +2420,7 @@ remove_tests()
>  		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
>  		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
>  		pm_nl_set_limits $ns2 3 3
> -		run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
> +		run_tests_bg $ns1 $ns2 10.0.1.1 0 -8 0 speed_10 "" 1
>  		chk_join_nr 1 1 1
>  		chk_add_nr 3 3
>  		chk_rm_nr 3 1 invert
> @@ -2405,7 +2431,7 @@ remove_tests()
>  		pm_nl_set_limits $ns1 0 1
>  		pm_nl_set_limits $ns2 0 1
>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -		run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
> +		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 -9 speed_10 "" 1
>  		chk_join_nr 1 1 1
>  		chk_rm_nr 1 1
>  	fi
> @@ -2415,7 +2441,7 @@ remove_tests()
>  		pm_nl_set_limits $ns1 0 1
>  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>  		pm_nl_set_limits $ns2 1 1
> -		run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
> +		run_tests_bg $ns1 $ns2 10.0.1.1 0 -9 0 speed_10 "" 1
>  		chk_join_nr 1 1 1
>  		chk_add_nr 1 1
>  		chk_rm_nr 1 1 invert

(...)

> @@ -2501,7 +2527,7 @@ ipv6_tests()
>  		pm_nl_set_limits $ns1 0 1
>  		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
>  		pm_nl_set_limits $ns2 1 1
> -		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
> +		run_tests_bg $ns1 $ns2 dead:beef:1::1 0 -1 0 speed_10 "" 1
>  		chk_join_nr 1 1 1
>  		chk_add_nr 1 1
>  		chk_rm_nr 1 1 invert
> @@ -2513,7 +2539,7 @@ ipv6_tests()
>  		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
>  		pm_nl_set_limits $ns2 1 2
>  		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
> -		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
> +		run_tests_bg $ns1 $ns2 dead:beef:1::1 0 -1 -1 speed_10 "" 1
>  		chk_join_nr 2 2 2
>  		chk_add_nr 1 1
>  		chk_rm_nr 1 1

(...)

> @@ -2647,7 +2673,7 @@ mixed_tests()
>  		pm_nl_set_limits $ns2 2 4
>  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>  		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
> -		run_tests $ns1 $ns2 dead:beef:1::1 0 0 fullmesh_1 slow
> +		run_tests_bg $ns1 $ns2 dead:beef:1::1 0 0 fullmesh_1 speed_10 "" 1
>  		chk_join_nr 4 4 4
>  	fi
>  }
> @@ -2660,7 +2686,7 @@ backup_tests()
>  		pm_nl_set_limits $ns1 0 1
>  		pm_nl_set_limits $ns2 0 1
>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
> -		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
> +		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 0 speed_10 nobackup 1
>  		chk_join_nr 1 1 1
>  		chk_prio_nr 0 1
>  	fi
> @@ -2671,7 +2697,7 @@ backup_tests()
>  		pm_nl_set_limits $ns1 0 1
>  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>  		pm_nl_set_limits $ns2 1 1
> -		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
> +		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 0 speed_10 backup 1
>  		chk_join_nr 1 1 1
>  		chk_add_nr 1 1
>  		chk_prio_nr 1 1
> @@ -2683,7 +2709,7 @@ backup_tests()
>  		pm_nl_set_limits $ns1 0 1
>  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
>  		pm_nl_set_limits $ns2 1 1
> -		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
> +		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 0 speed_10 backup 1
>  		chk_join_nr 1 1 1
>  		chk_add_nr 1 1
>  		chk_prio_nr 1 1

(...)

> @@ -2825,7 +2851,7 @@ add_addr_ports_tests()
>  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
>  		pm_nl_set_limits $ns2 1 2
>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
> +		run_tests_bg $ns1 $ns2 10.0.1.1 0 -1 -1 speed_10
>  		chk_join_nr 2 2 2
>  		chk_add_nr 1 1 1
>  		chk_rm_nr 1 1
> @@ -2838,7 +2864,7 @@ add_addr_ports_tests()
>  		pm_nl_set_limits $ns2 1 3
>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>  		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> -		run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
> +		run_tests_bg $ns1 $ns2 10.0.1.1 0 -8 -2 speed_10 "" 1
>  		chk_join_nr 3 3 3
>  		chk_add_nr 1 1
>  		chk_rm_nr 1 3 invert simult

(...)

> @@ -3122,7 +3148,7 @@ fullmesh_tests()
>  		pm_nl_set_limits $ns1 4 4
>  		pm_nl_set_limits $ns2 4 4
>  		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
> -		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup,nofullmesh
> +		run_tests_bg $ns1 $ns2 10.0.1.1 0 0 0 speed_10 nobackup,nofullmesh 1
>  		chk_join_nr 2 2 2
>  		chk_prio_nr 0 1
>  		chk_rm_nr 0 1
Does it mean that this selftest will be even slower than before?

(also, that's quite a lot of modifications, it might be a bit annoying
for the backports but I think it will help for the maintenance)

(just an idea: if we want to reduce the number of args, we could also
pass env vars to the different functions)

  speed=speed_10 sfflags=nobackup,nofullmesh wait_join=1 \
      run_tests_bg $ns1 $ns2 10.0.1.1

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
