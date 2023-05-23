Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640BF1F922
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 14:49:27 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3f41d087b3bso76083065e9.0
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684853365; x=1687445365;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MsMOAv8kPiMXkIj/NqNuIzRM/r7ncq0rzWjvuWyKHwI=;
        b=Umhr5cd+b3CJHhF8KOLNl13a4nesowr6RBi4GCmoz2E38eO0oQ8/tvHxmRWAYc6pZC
         /0AgTEOCzfpqesXN2AdFvnUC32mbRRhJ/2oIkD4SqzYwVlibvtIxDUwZ4rS7kmDcAiYI
         NoRPeGreTvZYshYlfFmNCU9VbR6rvIyueQAlnnuZlz1T4TUYTdea36vCMqF0g4mHY6HX
         utN822enHPVftkf16gbdhOdqGqVwqcewLRANw4evEkrt3Cf5jGuVGKAkhprZCxH4MhPV
         siQ7J4kZHjpRmoSJBiv3rXQjNcgaEI/scM+Sa0CmR8UD3dh+hSH2tKcGK3Q/oWt0CAII
         oerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684853365; x=1687445365;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MsMOAv8kPiMXkIj/NqNuIzRM/r7ncq0rzWjvuWyKHwI=;
        b=VzC8XXkjmouSbZgA1T71PqQ6Asnq24DcpXE0TWKY0E32mtkZkJaQdlAz7yNrwK6Ny6
         +tbkx0MKkB3uNN0ST0G8IdmgP0zsl5vRBDNPD+nYJJXeS3SJBLjlI8AROnCdVr9QtP3J
         +baYlTWKEdbdbP2ATa/lRbWojLn3CK2f7LgOyvVSBHblqwNXOeebUwxthrjXVL3gtAOw
         8YvjmPRNO+zWtt1skgrg3ZhxhTxnrtq9X3VCduxjHtSMKzaGO2UOQmM4sGzaGGOhmOJ0
         rSxp/o/dGSaGr8Nik3zPebbOD4fx1ufWv2Cw5/OLYTzYAWKcWyjjLQSpPt0vCo0KikYE
         ceQg==
X-Gm-Message-State: AC+VfDx5qgp6dn6NhITHRl5SBbx5iHLB6kyi7HZx9dq8brBVWWGMyQVG
	vVGN1OQQUCeQYUlvFLoFAZKmsg==
X-Google-Smtp-Source: ACHHUZ5SlJaNS8w575mj2RQY1JQtEySbYOOd2W9FpvcUBuFlX9Zen90IiyJB843NptFuEGY3FhAuUA==
X-Received: by 2002:a1c:c903:0:b0:3f5:6e5:1688 with SMTP id f3-20020a1cc903000000b003f506e51688mr10602687wmb.2.1684853365550;
        Tue, 23 May 2023 07:49:25 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6cb1:7d36:3be3:30d? ([2a02:578:8593:1200:6cb1:7d36:3be3:30d])
        by smtp.gmail.com with ESMTPSA id z14-20020a7bc7ce000000b003f4b6bcbd8bsm11989893wmk.31.2023.05.23.07.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 07:49:25 -0700 (PDT)
Message-ID: <b941cf62-bd4d-c6ee-d242-ef94fde16d7b@tessares.net>
Date: Tue, 23 May 2023 16:49:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v14 5/5] selftests: mptcp: update userspace pm
 subflow tests
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684760588.git.geliang.tang@suse.com>
 <844d9f8c87bc733488eba77a4a77e7040e87d8ed.1684760588.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <844d9f8c87bc733488eba77a4a77e7040e87d8ed.1684760588.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/05/2023 15:12, Geliang Tang wrote:
> To align with what is done by the in-kernel PM, update userspace pm
> subflow selftests in mptcp_join.sh and userspace_pm.sh, by sending
> the a remove_addrs command together after the remove_subflows command.
> This will get a RM_ADDR in chk_rm_nr().
> 
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Fixes: 5e986ec46874 ("selftests: mptcp: userspace pm subflow tests")
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh   | 3 ++-
>  tools/testing/selftests/net/mptcp/userspace_pm.sh | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index a42745e60976..46c2095d6e3a 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -939,6 +939,7 @@ do_transfer()
>  				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
>  				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
>  									rip $da rport $dp token $tk
> +				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id

Linked to my comment on patch 4/5, this should be done before the
previous line: "pm_nl_ctl rem" then "pm_nl_ctl dsf".

>  			fi
>  			counter=$((counter + 1))
>  			add_nr_ns2=$((add_nr_ns2 - 1))
> @@ -3210,7 +3211,7 @@ userspace_tests()
>  		pm_nl_set_limits $ns1 0 1
>  		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
>  		chk_join_nr 1 1 1
> -		chk_rm_nr 0 1
> +		chk_rm_nr 1 1
>  		kill_events_pids
>  	fi
>  }
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index b1eb7bce599d..02465ffa075f 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -621,6 +621,7 @@ test_subflows()
>  	:>"$server_evts"
>  	ip netns exec "$ns1" ./pm_nl_ctl dsf lip dead:beef:2::1 lport "$sport" rip\
>  	   dead:beef:2::2 rport "$client6_port" token "$server6_token" > /dev/null 2>&1
> +	ip netns exec "$ns1" ./pm_nl_ctl rem id 23 token "$server6_token" > /dev/null 2>&1

Same here and the 2 below: "pm_nl_ctl rem" then "pm_nl_ctl dsf".

>  	sleep 0.5
>  	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server6_token" "$AF_INET6"\
>  			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
> @@ -660,6 +661,7 @@ test_subflows()
>  	:>"$server_evts"
>  	ip netns exec "$ns1" ./pm_nl_ctl dsf lip 10.0.2.1 lport "$sport" rip 10.0.2.2 rport\
>  	   $new4_port token "$server4_token" > /dev/null 2>&1
> +	ip netns exec "$ns1" ./pm_nl_ctl rem id 23 token "$server4_token" > /dev/null 2>&1
>  	sleep 0.5
>  	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
>  			      "10.0.2.2" "$new4_port" "23" "$client_addr_id" "ns1" "ns2"
> @@ -737,6 +739,7 @@ test_subflows()
>  	:>"$client_evts"
>  	ip netns exec "$ns2" ./pm_nl_ctl dsf lip dead:beef:2::2 lport "$sport" rip\
>  	   dead:beef:2::1 rport $app6_port token "$client6_token" > /dev/null 2>&1
> +	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client6_token" > /dev/null 2>&1
>  	sleep 0.5
>  	verify_subflow_events $client_evts $SUB_CLOSED $client6_token $AF_INET6 "dead:beef:2::2"\
>  			      "dead:beef:2::1" "$app6_port" "23" "$server_addr_id" "ns2" "ns1"

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
