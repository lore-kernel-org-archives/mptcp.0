Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF22182D4
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 15:31:04 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5149c76f4dbso3342104a12.1
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 08:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686324662; x=1688916662;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iS4jyVT7GyxT2GlrX/OvJ9ke+r5dKyCO6ZAEU6lTQc0=;
        b=0dThXIvnq8FxS+dfBevHc3rm1sbjy/0qLK+VfF1d8HGq+UP36j3nGiMFpqjwVjEk5F
         MCkkTpnJsy6TxLwddj53CKfHOtjguSwPYlxC8t4BrvbQo8xZX8dP4hJKHRWJ9NmlC6b/
         WAZktP4e4alUsbihvY6OwZb2bFmMw6FNVF02AC5YGyA7n7bP/wJX7YqUTLn41HKPBoKo
         t/XeoPfw30zHzd0risuz6nnEna7MtmCfrLXPs2fJf7kjhVOjiSOcWJvdQlZkQhyMIvTK
         Q0UsHP/ssqmEYAWd5l/V89gYVBWEv6LPmn/OsAMC8LmBcsw+B4Qz0JDHhLpq4vST3/8n
         pozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686324662; x=1688916662;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iS4jyVT7GyxT2GlrX/OvJ9ke+r5dKyCO6ZAEU6lTQc0=;
        b=PSZfTKHaXhS+H8fLhkYJj6s0U/6xCapxB6XVeA7JIeRSjIV8kQriQOpX+nEczRYZkI
         bCujg4HNrTSdUvItfcJLHMsLLQo1ACx+KqELzenI8YTlDNXnM/p3zDEfjAZLkvbW3lL4
         2PalKV6YNINOcP/TMZ4776sLCvfqnIe0Heka+WoaQ3iQZe5X0NGY2BlJrdKTA2nBbVFh
         Aty2bHKXvwXbsS6vMABoL47qt4NOs5cw9uTcyGwk0wFYNx1z2Bch70+Fq4o426SH6ZPi
         IMWa6HeyiUf3ERyG/5gbhN54utSmPLjcFbD/5kZK/pa3X6DOZw4TiPRoISD3JaYr//El
         S2OA==
X-Gm-Message-State: AC+VfDx9Kx474WvWHfWt6J0MY2UWkOGW3bGZs62O3J5sZhKtOaD20ACV
	YBwtvB8E0ol3NFNwW80sx+G4QXOON3KMeNK1ko63JQ==
X-Google-Smtp-Source: ACHHUZ5JeMxz0yJeJ3v2meCbQQaLRliRiR3tJdkf+nhnYjX0a9KCaJD84rDDz+Ko7CY7Xxgt5l41EQ==
X-Received: by 2002:a17:907:368d:b0:961:78c2:1d27 with SMTP id bi13-20020a170907368d00b0096178c21d27mr2386395ejc.19.1686324662359;
        Fri, 09 Jun 2023 08:31:02 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id dc18-20020a170906c7d200b0096ace7ae086sm1432055ejb.174.2023.06.09.08.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:31:02 -0700 (PDT)
Message-ID: <c04818dc-7146-aab8-f455-eceed903c49b@tessares.net>
Date: Fri, 9 Jun 2023 17:31:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v17 2/7] selftests: mptcp: test userspace pm
 out of transfer
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1686138130.git.geliang.tang@suse.com>
 <262e128b23aa36756b7c1957daf6316c64ac014c.1686138130.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <262e128b23aa36756b7c1957daf6316c64ac014c.1686138130.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 07/06/2023 13:44, Geliang Tang wrote:
> This patch moves userspace pm tests out of do_transfer(). Move add
> addrese test into a new function userspace_pm_add_addr(), and remove
> address test into userspace_pm_rm_addr(). Move add subflow test into
> userspace_pm_add_sf() and remove subflow into userspace_pm_rm_sf().

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index a7973d6a40a0..6684a60dad50 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

(...)

> +userspace_pm_rm_addr()
> +{
> +	local addr=$1
> +	local id=$2
> +	local tk sp da dp
> +
> +	tk=$(grep "type:1," "$evts_ns1" |
> +	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
> +	sp=$(grep "type:10" "$evts_ns1" |
> +	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
> +	da=$(grep "type:10" "$evts_ns1" |
> +	     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
> +	dp=$(grep "type:10" "$evts_ns1" |
> +	     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
> +	ip netns exec $ns1 ./pm_nl_ctl rem token $tk id $id
> +	ip netns exec $ns1 ./pm_nl_ctl dsf lip "::ffff:$addr" \
> +				lport $sp rip $da rport $dp token $tk> +}

(...)

> +userspace_pm_rm_sf()
> +{
> +	local addr=$1
> +	local id=$2
> +	local tk da dp sp
> +
> +	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
> +	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
> +	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
> +	sp=$(grep "type:10" "$evts_ns2" |
> +	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
> +	ip netns exec $ns2 ./pm_nl_ctl rem token $tk id $id
> +	ip netns exec $ns2 ./pm_nl_ctl dsf lip $addr lport $sp \
> +				rip $da rport $dp token $tk
> +}

These two functions (userspace_pm_rm_addr() and userspace_pm_rm_sf())
have confusing names: they both remove an address and a subflow. The
only difference is that one is doing that on ns1 and the other one on ns2.

It might be better to rename them, maybe userspace_pm_rm_sf_addr_ns1 and
_ns2, no?

See below:

>  userspace_tests()
>  {
>  	# userspace pm type prevents add_addr
> @@ -3283,11 +3300,18 @@ userspace_tests()
>  	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
>  		set_userspace_pm $ns1
>  		pm_nl_set_limits $ns2 1 1
> -		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
> +		local tests_pid=$!
> +		wait_mpj $ns1
> +		userspace_pm_add_addr 10.0.2.1 10
> +		sleep 1
>  		chk_join_nr 1 1 1
>  		chk_add_nr 1 1
> +		userspace_pm_rm_addr 10.0.2.1 10
> +		wait_rm_addr $ns1 1
>  		chk_rm_nr 1 1 invert

Here, it is strange to see that one subflow has been removed:

  chk_rm_nr 1 *1*

While we might think only one RM_ADDR has been sent
(userspace_pm_rm_addr()).

>  		kill_events_pids
> +		wait $tests_pid
>  	fi
>  
>  	# userspace pm create destroy subflow
> @@ -3295,10 +3319,17 @@ userspace_tests()
>  	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
>  		set_userspace_pm $ns2
>  		pm_nl_set_limits $ns1 0 1
> -		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
> +		local tests_pid=$!
> +		wait_mpj $ns2
> +		userspace_pm_add_sf 10.0.3.2 20
> +		sleep 1
>  		chk_join_nr 1 1 1
> +		userspace_pm_rm_sf 10.0.3.2 20
> +		wait_rm_addr $ns2 1
>  		chk_rm_nr 1 1

Here, it is strange to see that we want to remove a subflow
(userspace_pm_rm_sf()) but we wait to see RM_ADDR (wait_rm_addr()).

I would say that it sounds better to just do one action and check that
specific action but maybe it is enough to just rename the function and
hope that only checking the if the remove addr have been exchanged is
enough to know if the subflow has been removed as well (or better: add a
wait_rm_sf()).

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
