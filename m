Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0014416407
	for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 21:12:08 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-99c136ee106so1748888866b.1
        for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 14:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695935527; x=1696540327; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=btmwtTn1A1G1F4JOotB+OLOZCB81N0nzg+QnC9bAMz8=;
        b=rD+j34iOKMpImUPTZwSd5ciNWrgFxepQV8ZCm/pUToHDbHlonaFny0XGho9KayeKuF
         t/arGglIVomKpGtblfB4Zhx/c7lSM3vFtLYEmel8Lon/uygJsWh86iQJruzuxKR343kQ
         8i+Ej4HpkkFfLwfu+Fnkz7EQBua3tdkawlnUI9p1YOm3wVwCVriHh4AwaTCojRCC5pfB
         7/R+ZOMdMnbwRCv/lncn0EJVR7U6QP6WGNzLoZKd1ATDkOZX9k5rUk/kZVUJ3DWYgftu
         DY5Bcnl/EFT7llEbmmkWUtI1xdpGrUXjPmNHCXrV6QxkN8fyJtoHYLXNN5zzqoElf18a
         toLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695935527; x=1696540327;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btmwtTn1A1G1F4JOotB+OLOZCB81N0nzg+QnC9bAMz8=;
        b=W39eH2vEENk5VICoCR1ZQMmw7QPUK4Pt4kGo89wNC60jfjp1+ZpnZkmmhjZvJll9Y6
         XoszlT88b6gnuxq6HUwPYQBDa/cOH5vjIgD9ar9Jld5asslgZXJ6gKZ8w3zjG3OW1uqN
         0c2FEHfUSI4dPRlkXQEF9q8MoQLBmqcVJPhOxzRA1nZSzeTeJUv0cCA2hfxL76vcGxcy
         RtmiFmlHxo+vhWyTsk7ShUUc3AwIF+UPOiVvDyUcIoXqwzRIiN+DoqgM10QwhF6c0Iks
         yo3pQzzl1pgGXc63fQ8E4uk3EOM7cGt/6BM21zskU+TYU87+Y+RMjURekDo8zWBboLsO
         Oarw==
X-Gm-Message-State: AOJu0YwMpTW4rVqCjPnXvCDo5OY0R0T/TTqdPC1K6BWaU7PHXuD0qe1C
	WsGAsdVqX7z+yfVoangLWWtVpKV5NGK0yTfmxWtlvA==
X-Google-Smtp-Source: AGHT+IGUnPePSmdVL23+OrfQVMC+oDMMC4w552pLRhJLmOWruz63Ak2GL/Oia5G/cbRpSsSja6PJBw==
X-Received: by 2002:a17:907:270e:b0:9b2:6db8:e0fa with SMTP id w14-20020a170907270e00b009b26db8e0famr2005987ejk.41.1695935527180;
        Thu, 28 Sep 2023 14:12:07 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ff86:e30:98cd:120? ([2a02:578:8593:1200:ff86:e30:98cd:120])
        by smtp.gmail.com with ESMTPSA id mh2-20020a170906eb8200b00992b2c55c67sm11403464ejb.156.2023.09.28.14.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 14:12:06 -0700 (PDT)
Message-ID: <54e302bf-806f-4d33-9180-283460e6f4d7@tessares.net>
Date: Thu, 28 Sep 2023 23:12:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 10/29] selftests: mptcp: add
 chk_subflows_total helper
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1695631132.git.geliang.tang@suse.com>
 <e3811cedfae23f2486096957a95ae77fa01e2181.1695631132.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <e3811cedfae23f2486096957a95ae77fa01e2181.1695631132.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/09/2023 10:41, Geliang Tang wrote:
> This patch adds a new helper chk_subflows_total(), in it use the newly
> added counter mptcpi_subflows_total to get the "correct" amount of
> subflows, including the initial one. To be compatible with old 'ss'
> version without this counter, get the total subflows using this 'ss'
> command:
> 
>         ss -ti | grep -c tcp-ulp-mptcp.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 37 ++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 92285ef592fb..3e24ab7bc221 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1862,7 +1862,7 @@ chk_mptcp_info()
>  	local cnt2
>  	local dump_stats
>  
> -	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
> +	print_check "mptcp_info ${info1:0:15}=$exp1:$exp2"
>  
>  	cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info1" "$info1")
>  	cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info2" "$info2")
> @@ -1883,6 +1883,37 @@ chk_mptcp_info()
>  	fi
>  }
>  
> +# $1: subflows in ns1 ; $2: subflows in ns2
> +# number of all subflows, including the initial subflow.
> +chk_subflows_total()
> +{
> +	local cnt1
> +	local cnt2
> +	local info="subflows_total"
> +
> +	if [ $(ss -N $ns1 -inmHM | mptcp_lib_get_info_value $info $info) ]; then

Shellcheck just told me it would be better with quotes and '-n' because
you want to check if the output is not empty:

  if [ -n "$(...)" ]

Do not hesitate to use shellcheck, it is quite useful ;-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
