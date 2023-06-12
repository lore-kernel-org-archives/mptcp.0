Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26691DDF8
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 16:03:36 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-977e7d6945aso805966866b.2
        for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 09:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686585814; x=1689177814;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xFz8B6jFBX5jmm/9kU2CVmXTJ6Hu1ErhJc2roIPCuQU=;
        b=gQ7ot339PV/jYLuDS9/2za1nfLQvtBbcMTaAim0igE4efiEIrFI5PgeIlMbDyr0v4k
         dsmwWnQaR+pZ2v9Uj6nd9OZblQPfEES3tMQ0SYRsRA2F+AHBB+24W+Lg8/jwy1NUjboC
         l2P3FptkguW7/j+DgQVEwMfMLhebRBYc9HgY3jW0yvSfetaVBkZl01NKEuxrBOY1W9tG
         7ziw5hB+6Fn5P0tBoq4bDNicxWtRHx0ZSkGBm9b15XXLGRspj7gmwnVHxBan+7tA3yK2
         3jawLhJetlyBnLihI1B2TUFXi53iw79gNqv3oULqjD/eO595S1EiMNX1abvTuijhEi4s
         wiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686585814; x=1689177814;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFz8B6jFBX5jmm/9kU2CVmXTJ6Hu1ErhJc2roIPCuQU=;
        b=ECM2wr17gobk/IGkMaKyt0YF0q1vDxFL1HrPM35dp9x4oLp3Zf0bD327hG1Ulx1tqQ
         jVQwstVj7CmWr9EbaybOGTNm41dOL4A2/qWoEtSYfO6D1dyt98/IBEYXu6+86P9m9FGM
         CBbiZ5pu+Uw5aWmIL071zJUxD7bz2xzltSoarTo4E0ZFyLGauKss89hQGRFSUj+QCF4D
         9ikUGrhj5gajlcaoc2kRMpl5fMRtwSNZQk2GXV3aDspl7dtTP1oXLd05xK1RhzpE8+Lk
         pSQUZ3qcL8GhEVswpCLW90rBMGTU792jrM2O2H9wNGVV6CKnIHeboElemisvyaktT2UL
         92qg==
X-Gm-Message-State: AC+VfDx5Q/6wIAp2FGiz5Sh+hpOL2tluTST/COrJyguwh/ZmUzzoCrG0
	42VEGLpwX2Pym+y+cZufx8PUu7USkYNvoeNzvSo=
X-Google-Smtp-Source: ACHHUZ5cRIpxKEv/ZobIowVvU0D1xitvgw8XH57kpkRAw5QispQamGplWrXhuCFQbZqI9B2elAOyUg==
X-Received: by 2002:a17:906:eec5:b0:969:bac4:8e22 with SMTP id wu5-20020a170906eec500b00969bac48e22mr10299445ejb.26.1686585814420;
        Mon, 12 Jun 2023 09:03:34 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b0094ee3e4c934sm5352694ejd.221.2023.06.12.09.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:03:33 -0700 (PDT)
Message-ID: <02e82b50-4627-ff34-9a03-6957bf30e5b2@tessares.net>
Date: Mon, 12 Jun 2023 18:03:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v18 2/7] selftests: mptcp: test userspace pm
 out of transfer
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1686554287.git.geliang.tang@suse.com>
 <08a9ccd5c010ead677267a0bfb29869bf484ddc3.1686554287.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <08a9ccd5c010ead677267a0bfb29869bf484ddc3.1686554287.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 12/06/2023 09:19, Geliang Tang wrote:
> This patch moves userspace pm tests out of do_transfer(). Move add
> addrese test into a new function userspace_pm_add_addr(), and remove
> address test into userspace_pm_rm_addr(). Move add subflow test into
> userspace_pm_add_sf() and remove subflow into userspace_pm_rm_sf().
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 143 ++++++++++++------
>  1 file changed, 97 insertions(+), 46 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index a7973d6a40a0..556d21c4b7a5 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -589,6 +589,26 @@ wait_rm_addr()
>  	done
>  }
>  
> +rm_sf_count()
> +{
> +	get_counter "${1}" "MPTcpExtRmSubflow"
> +}

(I don't think we need a dedicated function but I'm fine with it)

(...)

> @@ -3283,11 +3320,18 @@ userspace_tests()
>  	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
>  		set_userspace_pm $ns1
>  		pm_nl_set_limits $ns2 1 1
> -		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
> +		local tests_pid=$!
> +		wait_mpj $ns1
> +		userspace_pm_add_addr 10.0.2.1 10
> +		sleep 1

(see below: move the sleep 1 in userspace_pm_add_addr()?)

>  		chk_join_nr 1 1 1
>  		chk_add_nr 1 1
> +		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
> +		wait_rm_addr $ns1 1

Here, just to be on the safe side, you can also call wait_rm_sf()
because both the address and the subflow are being removed, no?

Also, maybe the new userspace_pm_(...) functions could wait for the
events, no? I guess we will always need to wait after having called
these functions. So we can call wait_rm_addr() and wait_rm_sf() from
userspace_pm_rm_sf_addr_ns1(), no?

>  		chk_rm_nr 1 1 invert
>  		kill_events_pids
> +		wait $tests_pid
>  	fi
>  
>  	# userspace pm create destroy subflow
> @@ -3295,10 +3339,17 @@ userspace_tests()
>  	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
>  		set_userspace_pm $ns2
>  		pm_nl_set_limits $ns1 0 1
> -		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
> +		local tests_pid=$!
> +		wait_mpj $ns2
> +		userspace_pm_add_sf 10.0.3.2 20
> +		sleep 1

see above: move the sleep in userspace_pm_add_sf()?

>  		chk_join_nr 1 1 1
> +		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
> +		wait_rm_sf $ns2 1

see above: call wait_rm_sf() and wait_rm_addr() from
userspace_pm_rm_sf_addr_ns2()?

>  		chk_rm_nr 1 1
>  		kill_events_pids
> +		wait $tests_pid
>  	fi
>  }
>  

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
