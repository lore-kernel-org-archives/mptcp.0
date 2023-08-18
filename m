Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7DE4689
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 09:34:03 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3fe8242fc4dso6961995e9.1
        for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 02:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692351241; x=1692956041;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oUmnnQ/3IMeF+egtAsM2omocz8A4esqQMh1YjgerDfk=;
        b=FtXfqH+h7g3PVVpBZda9CgW7ja5WGmfgh8jWvZ9SjsoM3QH/dJeoOj3D8aJUsZeIyk
         yR23tIbkH6tjNtmck4l4fiLofxY1RNsGlqYg4KFm1Dsp10gOwFr7uQV8f90ztVIjlcvJ
         sdyn20ua6+xcu9dZb7ggooU+j3ABgDyeg/Q7ziV4/7Y13jxomSB9Hl5vYv/m5i5Fe+9K
         +PQ5Y+3Nsj169w5blG7e42Z6Va0sOiZBxyRy3EmRXWKWOdna1n91JZ/us9j68wMKcMgp
         PTjwBcoRiBhN2LOF2yOBswnqjrp735gFA87YZy8bOjkcJzD4cbgQP1eHsX59luW+7Gcz
         6knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692351241; x=1692956041;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUmnnQ/3IMeF+egtAsM2omocz8A4esqQMh1YjgerDfk=;
        b=C8YVfZMvmtmjsiOhg0iwYKYfhuyPmeTjwxLj3oD9B+VK6JfW90CN3qj7madjDzKjN2
         P50o0oHWx/5H3WJsa9lzZpaF1OXQgZ7Ik5JcYkeWQHSAC3WXTn9MVkVdtfkAeizCyYRT
         IIEwKc5HxQnsf8+g0FuKYKzqnu6I7VuoDP2c+V6B/oG0I75IXAInBNb2CUE0X9Ay1yd5
         lDQYGFMhTIQl+uGyS/BFnS70Ga64efV5sLRFzcKO+cFrJ03n5dOM5LYQF6LOVg7G2rdU
         NO1S3AbxzDfn/P1i1GEjgLhDbU5y+ZreoH7pNUmnvqFIsDByGAGlzbGwUcPudebNwIrw
         7n1g==
X-Gm-Message-State: AOJu0YwoSU/ox/U0w5QVWTkJTD5A01+MizsAj76yLcxRjTGDHKTL1imL
	epSEH58u6D+FVGaLsqXG0UcTafvjEXUp/2YXMM8=
X-Google-Smtp-Source: AGHT+IHCJF0fun5dOCSqoxFg+tmgugRQHbquuvJFaD2nlXPx8NkrVWy2ro8DgTO/LW96+i9/bSjS8Q==
X-Received: by 2002:a7b:cb10:0:b0:3fe:90f:8496 with SMTP id u16-20020a7bcb10000000b003fe090f8496mr1734193wmj.1.1692351241377;
        Fri, 18 Aug 2023 02:34:01 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id x22-20020a05600c21d600b003fe1cb874afsm2195852wmj.18.2023.08.18.02.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 02:34:01 -0700 (PDT)
Message-ID: <db9abb06-d74c-4e4f-bb39-380bce0b009f@tessares.net>
Date: Fri, 18 Aug 2023 11:34:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v4 6/6] selftests: mptcp: userspace pm remove
 id 0 address
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1692342519.git.geliang.tang@suse.com>
 <f59ec3473deb3ebdd2a3e34bdab23ba79086b747.1692342519.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <f59ec3473deb3ebdd2a3e34bdab23ba79086b747.1692342519.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 18/08/2023 09:12, Geliang Tang wrote:
> This patch adds a selftest for userpsace PM to remove id 0 address.
> 
> A new helper userspace_pm_rm_id_0_address_ns2() is added, in it use
> 
>         ./pm_nl_ctl rem token $tk id 0
> 
> to remove id 0 address.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 322adac0cb1b..1c5c0bbae38f 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3336,6 +3336,14 @@ userspace_pm_rm_id_0_subflow_ns2()
>  	wait_rm_sf $ns2 1
>  }
>  
> +userspace_pm_rm_id_0_address_ns2()
> +{
> +	local tk=$(evts_get_info token "$evts_ns2")
> +
> +	ip netns exec $ns2 ./pm_nl_ctl rem token $tk id 0
> +	wait_rm_addr $ns2 1
> +}
> +
>  # $1: subflows in ns1 ; $2: subflows in ns2
>  chk_subflows()
>  {
> @@ -3514,6 +3522,27 @@ userspace_tests()
>  		kill_events_pids
>  		wait $tests_pid
>  	fi
> +
> +	# userspace pm remove id 0 address
> +	if reset_with_events "userspace pm remove id 0 address" &&
> +	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
> +		set_userspace_pm $ns2
> +		pm_nl_set_limits $ns1 0 1
> +		speed=10 \
> +			run_tests $ns1 $ns2 10.0.1.1 &
> +		local tests_pid=$!
> +		wait_mpj $ns2
> +		userspace_pm_add_sf 10.0.3.2 20
> +		chk_join_nr 1 1 1
> +		chk_mptcp_info subflows 1 subflows 1
> +		chk_subflows 2 2
> +		userspace_pm_rm_id_0_address_ns2
> +		chk_rm_nr 1 0
> +		chk_mptcp_info subflows 1 subflows 1
> +		chk_subflows 1 1

When we only send a REMOVE_ADDR, why do we have one subflow that is
being removed? Is it because the other peer disconnected the subflow
linked to ID=0?

Do you mind checking this please?
Because the remove address command should not result in a host sending
both a REMOVE_ADDR and a FIN. That's up to the other host to take an
action when the REMOVE_ADDR is received, no?

Cheers,
Matt

> +		kill_events_pids
> +		wait $tests_pid
> +	fi
>  }
>  
>  endpoint_tests()

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
