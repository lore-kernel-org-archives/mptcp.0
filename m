Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27FF8462
	for <mptcp@lists.linux.dev>; Wed,  8 Mar 2023 17:57:50 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso1924787wmb.0
        for <mptcp@lists.linux.dev>; Wed, 08 Mar 2023 09:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678298268;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xRXxuPZxD+UMGwiLQ5orT+/qJFNe1ZSjLKxpnBa88o=;
        b=rTihKKCu90u/4gO7LKNhz+xXrsmiDF39HPSfiUKL81poatDRAxStP+FTHAUwNRf9cW
         bRw5ZBzyxaAijO8thtJbHOuuu/4ijnzo5PXOHQ11v6XJQGJxAd6522F0Ti1twThP7lJt
         ncmLhzgmvvEfN27N/u+PW18BjjOyxsrImYnYlUpnLeApMG35/e2gsQFqeiaJmCBEc9el
         c9VeuEEFdBIqJfpmtr4XmrRMh4ymKyvN7r98dcVWrrMjdj8otEPB6t+15CS1q+90fIch
         IIeJgIRjPhlVpE9XudlBodgiY86wVkUWwqP+xLS+Y2xEPjh/jAL0ujISL5Ni5dBWdDlU
         IVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678298268;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xRXxuPZxD+UMGwiLQ5orT+/qJFNe1ZSjLKxpnBa88o=;
        b=693Y5kEnpGgzQkPTg3vjecB0f+18eHXN7xDz76worcGM6DyIHaVLTB0EPSVaW3XOPs
         knNwbj5YNQRJlAOrIp4Nr1o4uFYrmgX8z2szwHEQcNWrZKnl5Hj8l213Y3tat4KKsf+Z
         uBJypx+DG8VDtnx3jicK062iZ860PB1FRmKNut2ilYiZmDwDBlCg1lamUwGEaPeD6wDe
         GkvJlqSySApZp92LX6afx6uA+y1VcYQUChlDAtvuoYWsoHy4gFBo56sFhW3AFJv+xa4w
         1CC8PadELslk57zyxHibWtuZ2420Hw2DRpXtmVScQm2bQQ3xQwNH9dMt8ZVVMclG+XCz
         JbTg==
X-Gm-Message-State: AO0yUKVtMevp0YZCI6LH+w9Kupzzv0DQ/WJN4B40vvLOWaQfhA9HcKD4
	H71nb/zmEy1vl/0nkZYqSKH6lTIeJJx/q4mxXgk+pA==
X-Google-Smtp-Source: AK7set9KD8a1K8wPoO8xs9i2SxbVRnMsqZD0daWgW87zLtHjmt3xfedtYIGsU1kwAPTRpF1GFeFqBw==
X-Received: by 2002:a05:600c:1546:b0:3eb:2f06:c989 with SMTP id f6-20020a05600c154600b003eb2f06c989mr17476677wmg.22.1678298268551;
        Wed, 08 Mar 2023 09:57:48 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:6276:92e1:6277:20bd? ([2a02:578:8593:1200:6276:92e1:6277:20bd])
        by smtp.gmail.com with ESMTPSA id m16-20020a056000009000b002be099f78c0sm15858382wrx.69.2023.03.08.09.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 09:57:48 -0800 (PST)
Message-ID: <78633d60-f9a4-0ddc-e015-056fe6e089e6@tessares.net>
Date: Wed, 8 Mar 2023 18:57:47 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: add mptcp_info tests
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <ee1415d43a29f55bef6ac7b6cdb2625b655f4b25.1678262695.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ee1415d43a29f55bef6ac7b6cdb2625b655f4b25.1678262695.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 08/03/2023 09:06, Geliang Tang wrote:
> This patch adds the mptcp_info fields test cases, using '-D' option
> to trigger it. Add a new function chk_mptcp_info() to check the
> given number of the given mptcp_info field.

Thank you for this patch!

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/330
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v2:
>  - use '-D' option instead of '-i'.
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 42e3bd1a05f5..46742453f883 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1719,6 +1719,40 @@ chk_subflow_nr()
>  	fi
>  }
>  
> +chk_mptcp_info()
> +{
> +	local nr_info=$1
> +	local info
> +	local cnt1
> +	local cnt2
> +	local dump_stats
> +
> +	if [[ "${nr_info}" = "subflows_"* ]]; then

Should you add a "else" statement to fail if the condition is not met?

(you can "exit 1" directly if it is easier, it is an internal issue)

> +		info="subflows"
> +		nr_info=${nr_info:9}
> +	fi
> +
> +	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
> +
> +	cnt1=$(ss -N $ns1 -inmHM | grep "$info:" |
> +		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
> +	cnt2=$(ss -N $ns2 -inmHM | grep "$info:" |
> +		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
> +	if [ "$cnt1" != "$nr_info" -o "$cnt2" != "$nr_info" ]; then

Just a suggestion, maybe it doesn't make sense but why not modifying
chk_subflow_nr() to do this extra check? I mean just to avoid doing
almost the same test as "delete and re-add" but looking at other counters.

Except if you plan to look at more counters from MPTCP INFO?

We can also modify chk_subflow_nr() to use chk_mptcp_info()

> +		echo "[fail] got $cnt1:$cnt2 $info expected $nr_info"
> +		fail_test
> +		dump_stats=1
> +	else
> +		echo "[ ok ]"
> +	fi
> +
> +	if [ "${dump_stats}" = 1 ]; then
> +		ss -N $ns1 -inmHM
> +		ss -N $ns2 -inmHM
> +		dump_stats
> +	fi
> +}
> +
>  chk_link_usage()
>  {
>  	local ns=$1
> @@ -3129,6 +3163,21 @@ endpoint_tests()
>  	fi
>  }
>  
> +mptcp_info_tests()
> +{
> +	# mptcp_info subflows
> +	if reset "mptcp_info subflows"; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_20 2>/dev/null &
> +		wait_mpj $ns2
> +		chk_join_nr 1 1 1
> +		chk_mptcp_info subflows_1

It could be good to delete the endpoint and check the counters after to
make sure we have 0.

Or re-use "delete and re-add" test as discussed above where the counters
are checked before and after re-adding the endpoint. If you do that, it
might be good to also check counters at the beginning, before deleting
the endpoint.

> +		kill_tests_wait
> +	fi

Do you think we could have a similar test where the userspace pm is
used? (in this case, that will be part of "mptcp: update userspace pm
mptcp_info fields" v4 series)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
