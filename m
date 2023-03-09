Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F8F2F2E
	for <mptcp@lists.linux.dev>; Thu,  9 Mar 2023 08:38:36 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id az36so594383wmb.1
        for <mptcp@lists.linux.dev>; Thu, 09 Mar 2023 00:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678351115;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTCUKw8EaUojAFnj1Vxr/jDoO6jOqfgU1ynmazOE3c4=;
        b=lV+38JV3XeCTfVH/5M9gwJ4c9/6aHNlO/h/IoqfvtaVlHvS9w+Bziq3enYyOwwB5hV
         OphwAIX7hso2+4N14uj07n86aFA4ycOI0szsl7R9gPoafPqWkvK2kuNpzn6dOUr9hzBN
         YbqWWLdjSxE6xP+f0WnSKSInFNGQeEWph1s9NFFyVMmrot+lJi1b3+jv9xad82ZklT7q
         82x9uJFdfKtCXwrm24NB8Z7QpVo+PHNUjH2A6VgYK26WC1FY6lzHD+rqgr6KE9uuYhyL
         jA4XT2wqSJ8jdPjdFpmQ7ywb1Esxieio3y+0YKaK/0LGtM98D7XQt48ZC8n8pfZpO/1v
         SS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351115;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTCUKw8EaUojAFnj1Vxr/jDoO6jOqfgU1ynmazOE3c4=;
        b=VsNetBJjgmcqyODTQUupsHCxOSmADfY4NmajyOV9WMCNFmIQxkVDDpL59IW/72qORy
         PnwTIx0UEiMfpNgaLEpkr8LWcZyB+yfv51qHsRONbEXz7v25VAGlU0JmhHaanNST1uM1
         wdtjLVLZ2+iBkhTojVXRNRI39HCM93oV8d68N6889nDXgCDy03sVGMdlmlKnW9T7CPLh
         wd68NXfsAqHqe1GcbU8Waqm79IAjH5vprkvtglYr0QPgjOE5HitKkOot0fFnaaavgeW+
         4cJTmhj4rAe7RMMtFmsVpL9J3HC0KIv5ciaVJTD0340dCaQl8i/6wZb1Of+uUkOJkEwu
         ewGg==
X-Gm-Message-State: AO0yUKXgCK26DBPaWVBYZQD8gPHypIMA18/pISA+IuqKXCXd0+Xl5Yf6
	PGuarMfWtY0UxRG9mWAtnD13PQ==
X-Google-Smtp-Source: AK7set/ZhVnkt2cmD7V61auJNjZPIdul7o9sjPljwqRNZ9jH/uQfTo2kX6+nTlBzNPE/bW23lvioTw==
X-Received: by 2002:a05:600c:3504:b0:3ea:e677:5017 with SMTP id h4-20020a05600c350400b003eae6775017mr18643666wmq.8.1678351114919;
        Thu, 09 Mar 2023 00:38:34 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:cf48:2681:518b:ac83? ([2a02:578:8593:1200:cf48:2681:518b:ac83])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c444f00b003e2232d0960sm1884112wmn.23.2023.03.09.00.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 00:38:34 -0800 (PST)
Message-ID: <91a93914-4bd0-12f2-0eee-684ca8215fc1@tessares.net>
Date: Thu, 9 Mar 2023 09:38:34 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: add mptcp_info tests
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <9b5a84ef14899800a8a0036cceae0406e016596f.1678327360.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <9b5a84ef14899800a8a0036cceae0406e016596f.1678327360.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 09/03/2023 03:04, Geliang Tang wrote:
> This patch adds the mptcp_info fields tests in endpoint_tests(). Add a
> new function chk_mptcp_info() to check the given number of the given
> mptcp_info field.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/330
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v2:
>  - use '-D' option instead of '-i'.
> v3:
>  - add tests in endpoint_tests() instead.
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 42e3bd1a05f5..625d24d94576 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1719,6 +1719,46 @@ chk_subflow_nr()
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
> +	if [[ $nr_info = "subflows_"* ]]; then
> +		info="subflows"
> +		nr_info=${nr_info:9}
> +	else
> +		echo "[fail] $nr_info"
> +		fail_test
> +		dump_stats=1

Do you mind if I replace "dump_stats=1" by a "return 1" when applying
the patch? No need to do the rest that will probably cause bash errors
below.

And while at it, I just change the 'echo' to say:

  [fail] unsupported argument: $nr_info

> +	fi
> +
> +	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
> +
> +	cnt1=$(ss -N $ns1 -inmHM | grep "$info:" |
> +		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
> +	[ -z $cnt1 ] && cnt1=0
> +	cnt2=$(ss -N $ns2 -inmHM | grep "$info:" |
> +		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
> +	[ -z $cnt2 ] && cnt2=0
> +	if [ $cnt1 != $nr_info -o $cnt2 != $nr_info ]; then

While at it, I will also add double quotes around variables just in case
the parsing fails and return a few words [1] and use "||" instead of
"-o" [2]

[1] https://www.shellcheck.net/wiki/SC2086
[2] https://www.shellcheck.net/wiki/SC2166

Also, do you plan to add a similar test but with the userspace pm?


Apart from that and if you are OK with the suggested modifications, the
rest looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
