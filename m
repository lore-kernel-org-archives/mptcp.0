Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BAB3C05
	for <mptcp@lists.linux.dev>; Fri, 21 Apr 2023 14:17:51 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-94ef8b88a5bso234999566b.2
        for <mptcp@lists.linux.dev>; Fri, 21 Apr 2023 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682086669; x=1684678669;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLnsrJyrCO6n+VuCLvqhZWTnCSMjOiNlh3UsSL0MFo4=;
        b=cnAWQIB5wSqPyjTT07T3vvFQ/o86VfpSj7kO3og8/8o8t0Rz/jD8EhtTE1INzqhIEd
         V+jrVfEa1dDyRZO+yQpw+THkH1LFBzHA+gSaMWGNLxVXwAb3RMnG8v+hq1oKiNz7WzYe
         MGCniUylgw/RXWqaQKW/qs3m7krYigVOeWQR1dy4amMhaYQimwOcnVN3leF8GhiqqGbh
         m5ydv98sxCsvjEQIBM0s1Rrn8y0PY7v36MSi1pptymc0XMf6ifiRcDUf6JJITTxvrEZ9
         aw0VeKq/tRb5bT9q1/r/UjTdAktPFgqMddstUENtfNKYtjW8edN4lHgAYadVg5CEIaKw
         21Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086669; x=1684678669;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLnsrJyrCO6n+VuCLvqhZWTnCSMjOiNlh3UsSL0MFo4=;
        b=DLoKmAjkhQwhZyscAIASUs1bCskchAWZZ4H/M/Y8WMDpn9qRWTlD0yeeHD85+tDklK
         jwZNDz/HtYeWzbWVrVVFcNovN77cFJ1P/fpJ0Gii1BDksnYdHDh4aVlUrQIVJKBHYaYa
         oZx4ErRi9FD2mBzOsoh/qw8PN2cke0s3k1VDOY5xrdSwFLgPVMyuB0lLeDTuDvrvrjCM
         /ZmFDv/rYBCPY4moSO2Vr+wIFTN3X0AND0SWGDA6lbuZj9S430N55UASngmdm8I9jL7+
         Vxjz3eW0w2DVx3Nk2V/0z4beMjBnLvEvYCiN/h7ylQKF8lEs+DB8JJ5LUA/Gr89bK+BY
         dllA==
X-Gm-Message-State: AAQBX9eWwpypSGLlN6kfvklr4+DnX6pBQaekfEkDilz5ABm0L0fJ+Fb3
	jIpQIrnZtKxmwheGVTx6x8Y2sHvSELo/oeulrF1ueQ==
X-Google-Smtp-Source: AKy350ZZzgZ+VMWZW6H3mGvAL7h9MkLsqIb6j0Yp6UG6YJRisZpfpYuWVgcALC+ngN6Gd03kJ/vzWA==
X-Received: by 2002:a17:906:3b0e:b0:94e:f349:2a30 with SMTP id g14-20020a1709063b0e00b0094ef3492a30mr2443305ejf.58.1682086669472;
        Fri, 21 Apr 2023 07:17:49 -0700 (PDT)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id jo2-20020a170906f6c200b009538cc79241sm2116762ejb.56.2023.04.21.07.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 07:17:49 -0700 (PDT)
Message-ID: <95c4951a-5131-eba2-ad19-11fc4d2c6b31@tessares.net>
Date: Fri, 21 Apr 2023 16:17:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v8 5/5] selftests: mptcp: update userspace pm
 subflow tests
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1681960259.git.geliang.tang@suse.com>
 <177f9ca7d30f810324bf46705ac7d977461ffc2d.1681960259.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <177f9ca7d30f810324bf46705ac7d977461ffc2d.1681960259.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 20/04/2023 05:11, Geliang Tang wrote:
> Update userspace pm subflow selftests, by sending the a remove_addrs
> command together before the remove_subflows command. This will get a
> RM_ADDR in chk_rm_nr().

(what's the reason? To align with what is done by the in-kernel PM?)
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 9a9b6e9b28ab..795c141a11f5 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -923,6 +923,7 @@ do_transfer()
>  				sleep 1
>  				sp=$(grep "type:10" "$evts_ns2" |
>  				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
> +				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id

Also here, probably better to remove the subflow, and then send the
ADD_ADDR not to have the other peer closing the subflow before the next
step here below.

But I guess it will not be possible to send the destroy after the remove
because we will remove the local address from the list, no?

Maybe better not to test that then? I mean: I don't really see why the
client would need to send a remove address if the subflow was still
working well. It would send a remove address if the linked local address
got lost (e.g. link down) but why doing both?

Cheers,
Matt

>  				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
>  									rip $da rport $dp token $tk
>  			fi
> @@ -3137,7 +3138,7 @@ userspace_tests()
>  		pm_nl_set_limits $ns1 0 1
>  		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
>  		chk_join_nr 1 1 1
> -		chk_rm_nr 0 1
> +		chk_rm_nr 1 1
>  		kill_events_pids
>  	fi
>  }

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
