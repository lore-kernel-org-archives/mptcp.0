Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9043F14289
	for <mptcp@lists.linux.dev>; Thu, 17 Aug 2023 16:37:15 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fe501e0b4cso677575e9.1
        for <mptcp@lists.linux.dev>; Thu, 17 Aug 2023 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692290234; x=1692895034;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3U5ICqQV2cVgG134J66Q+tciQ4CRRf8+wjFNJdYoSYo=;
        b=AZLpA6uC2Q87vRNCraHYUYvbxkSV+5dMLp4vzybeT20ExFLTvJdqe7PjJEzbYAlTb6
         ywiyLuxWsTg0p4oh7sS9x98rxtoJgzFmGqjbkM5/xbFPVFU6O3PkvrOqeXyA8fU+TXKq
         jJslbEVL106H8ZDP6UrUUy75/nQc9mJrNmtt8BAMeO66WzxSbF1f0sHRuVYJxFTrvAh9
         UMz8LldJv7ghx/zFbRWX4r/Cj2XLwVAxAtDbJPUKsxFTf0SBsWrMmYa3gbNJbVpj6/lo
         FmG1xCz4dE+GjB3pbD80wwHnuGpjo/ZGAFjDtfReB91KLySxJ1eotatdgseO6pedASri
         SSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692290234; x=1692895034;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3U5ICqQV2cVgG134J66Q+tciQ4CRRf8+wjFNJdYoSYo=;
        b=LlPCJEeeNpTqekLsPbCn6vwy4pqGCt+QRiTvInuCBsUCXoJktYYs4EpkRRx8QKGM0r
         lq1pVJ7ocf82IMDv7nSWnwTnTfPMc1Q2+wgMpTZuS/mc280NuCiap7b20WIzJVFu8omj
         nYQGv0cORePc9A08LL6dKXAAvw1BJ59pQpRS3+0NTIG40pXVKzZ3UldhFzyfQSU6DEm2
         atCriZ3g9hDM/A6oUiCYBK/PZn8ktp/JOUjBAhZSQ8xtQppJJ8X39OE4VZ5s2tBryxSQ
         iuv5QfCOXPimTsS6yB7IQeWxS6nNMB0C9BVu1UQvoxZ4JFU8lLL63O8sUe0dag/fijqc
         WqOA==
X-Gm-Message-State: AOJu0YygY1x3HnziDRdO74WPKVK6UrTWQy4GVwqwHY4DOR9UclPM57rD
	eB5v35kf8MasqVKQRpNEXwW7XEecRnbSFCDQ5Uo=
X-Google-Smtp-Source: AGHT+IHigg2TYmROEczwhHM9zjJQTWuZBNYh88BuDrjoTp92qm/N2smLPVjhjDfA8p/OhJY+dLVwYQ==
X-Received: by 2002:a05:600c:2193:b0:3fe:21a9:2feb with SMTP id e19-20020a05600c219300b003fe21a92febmr191344wme.33.1692290234091;
        Thu, 17 Aug 2023 09:37:14 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c88:d59b:1c03:4962? ([2a02:578:8593:1200:c88:d59b:1c03:4962])
        by smtp.gmail.com with ESMTPSA id l22-20020a7bc456000000b003fe1afb99a9sm59723wmi.11.2023.08.17.09.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 09:37:13 -0700 (PDT)
Message-ID: <1a3dade8-a6b0-4ed8-b2bb-d83fde104751@tessares.net>
Date: Thu, 17 Aug 2023 18:37:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 3/3] selftests: mptcp: remove id 0 subflow &
 address
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1692281317.git.geliang.tang@suse.com>
 <4d399e6564e6a4c2ea3fda6f6f4f7ca50dd6c0ac.1692281317.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <4d399e6564e6a4c2ea3fda6f6f4f7ca50dd6c0ac.1692281317.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 17/08/2023 16:10, Geliang Tang wrote:
> This patch adds selftests for userpsace PM to remove id 0 subflow and
> id 0 address.
> 
> A new helper userspace_pm_rm_id_0_subflow_or_address_ns2() is added,
> in it use
> 
>         ./pm_nl_ctl dsf lip 10.0.1.2 lport $sp \
> 			rip 10.0.1.1 rport $dp token $tk
> 
> to remove id 0 subflow, and use
> 
>         ./pm_nl_ctl rem token $tk id 0
> 
> to remove id 0 address.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index ee1f89a872b3..2d7ac76697bc 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3320,6 +3320,26 @@ userspace_pm_rm_sf_addr_ns2()
>  	wait_rm_sf $ns2 1
>  }
>  
> +# $1: command (rem/dsf)

(now it is more a "type" and not a command and it can be 'subflow' or
'address')

> +userspace_pm_rm_id_0_subflow_or_address_ns2()
> +{
> +	local tk da dp sp
> +
> +	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
> +	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
> +	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
> +	sp=$(sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")

Most of these parameters are only needed to remove a subflow, not to
remove an address. Would it not be better to have two different helpers?
Also below, just after having called this helper, there is a check on
the "type": so fine to call different helpers from there, no?

(see below, maybe better without the for-loop?)


Note that if you wanted to have a helper because the "sed" command are
not very readable, you can always have helpers to get the token, etc. e.g.

  tk=$(evts_get_token "${evts_ns2}")

you can even have something more generic:

  # $1: info name ; $2: ns
  evts_get_info()
  {
          sed -n "s/.*\(${1}:\)\([0-9.]\+\).*$/\2/p;q" "${2}"
  }

  tk=$(evts_get_info token "${evts_ns2}")

But this can also be done after in commits for net-next, not like here
for -net.

> +
> +	if [ "$1" == "subflow" ]; then
> +		ip netns exec $ns2 ./pm_nl_ctl dsf lip 10.0.1.2 lport $sp \
> +				rip $da rport $dp token $tk
> +	elif [ "$1" == "address" ]; then
> +		ip netns exec $ns2 ./pm_nl_ctl rem token $tk id 0
> +	fi
> +
> +	sleep 0.5
> +}
> +
>  userspace_tests()
>  {
>  	# userspace pm type prevents add_addr
> @@ -3434,6 +3454,32 @@ userspace_tests()
>  		kill_events_pids
>  		wait $tests_pid
>  	fi
> +
> +	# userspace pm remove id 0 subflow & address
> +	for type in "subflow" "address"; do
> +		if reset_with_events "userspace pm remove id 0 $type" &&

I think it would be clearer, for the "subflow" case, to say that we
remove the "initial subflow", not all subflows with local id 0.

(see below, maybe better without the for-loop?)

> +		   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
> +			set_userspace_pm $ns2
> +			pm_nl_set_limits $ns1 0 2
> +			speed=10 \
> +				run_tests $ns1 $ns2 10.0.1.1 &
> +			local tests_pid=$!
> +			wait_mpj $ns2
> +			userspace_pm_add_sf 10.0.2.2 0

Oh I guess here you check that we can create a new subflow using ID 0 to
validate patch 1/3, right? Maybe better to have a dedicated test  for
that? Or modify an existing one ("userspace pm create destroy subflow")
to add a new subflow from ID 0? → if you add this test, maybe better to
place it just after the first patch of this series.

> +			userspace_pm_add_sf 10.0.3.2 20
> +			chk_join_nr 2 2 2
> +			chk_mptcp_info subflows 2 subflows 2
> +			userspace_pm_rm_id_0_subflow_or_address_ns2 "$type"
> +			if [ "$type" == "subflow" ]; then

(if you have 'if' here, I wonder if it is still interesting to have a
for-loop here: we already have have many tests that are similar but one
or two lines are different ; also, it might help to find the test
without the variable)

WDYT? Maybe the for loop is still better?

If you split, maybe better to split the commits? From what I understood,
removing the initial subflow was working before this series but it was
not tested. Only sending the RM_ADDR for ID 0 was not working, right?
Then we could have one test validating the creation of a new subflow
with ID 0 + destroy the initial subflow. And a second one to send a
remove address with ID 0 (or edit an existing one like "userspace pm add
& remove address")

> +				chk_rm_nr 0 1
> +			elif [ "$type" == "address" ]; then
> +				chk_rm_nr 1 0
> +			fi
> +			chk_mptcp_info subflows 2 subflows 1
> +			kill_events_pids
> +			wait $tests_pid
> +		fi
> +	done
>  }
>  
>  endpoint_tests()

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
