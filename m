Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160EA2583
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 15:23:02 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so62624955e9.3
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685546581; x=1688138581;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mxrOlJT/p/dPC1wzg50MbGagjIfC5Mmj7j0qTGXP78A=;
        b=G+6+j0Hxn2TGnQzJRiI49TFTwoQb7kbm2t7CgyNVW+4kTkh0SmlheMzr59lXwjacgz
         A0TXsd6WuiWx+kRuWUEQcW56CMaAqTOWCYZU/XQ0Hq8z45g/YBr4wrKMugB9H5MTvSaX
         xRUA/R5iBU/tnfYiqYOc+2cNTTxAuERscmwTivvWS1+Z4jCqAeJZ8x7R0djg2M2KbM+E
         U3i9JaA4Sx/WbMgvxlHgOANE9FZUYPSrlKEC+YnYhCyOdXTFr+wBpOK/v7K7Zs30Sp2+
         tUcaIp45CAlcltFQm4rACWpUJI2zgIYNyfAiBGQ6L3vMdzqgHcVQu6PGl/2Nko+UDWZZ
         eg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685546581; x=1688138581;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxrOlJT/p/dPC1wzg50MbGagjIfC5Mmj7j0qTGXP78A=;
        b=bHPAG05kSpAVfV+7vvXs2txc+JHK0xDHWNT22CJLYi1ZSzpygkW3PXMbmB6dQsZ9In
         Ep6T1Bxnccp1IQDm1VAtsdceUUDM0e6+cK+RE14FrfZJ8Gg++QScSEPXFEThhfUAGgDB
         x8EQMNR7fv8V+1sCvQPWBmQDqPOLTywSuMfvC5n9IXGCrRSpxZq6OsAyw7z2D2nWFFE4
         bIlfelO0WLspnDmSw0T5PNnW72nXqZTZPVlQ7Kmdedvp14EBwKSWR8lkASQKDRSxuneF
         1lRMC3VsG4kOfbu9Q3V/hP1oMPoPDnyTqr92A3ll0Nd5qEzD//d7FGkfHY3DxGKm0Tys
         iytg==
X-Gm-Message-State: AC+VfDx6n+irUeEHOBQLZcXf5m/5lebuqHLTSPxv1+XHt1jcH5pXjxUp
	sUUlR9l7ilAXuQ/Qs26qqv9qkjBg8RQmQa1ioTyQkF1H
X-Google-Smtp-Source: ACHHUZ46XAt4HH/DZ7Eb22BOi6H0K3ey0eUc93NZYcVjlMQvCwYuBwIFyNPJIZW/BUdKow/t4jB4WA==
X-Received: by 2002:a1c:7412:0:b0:3f6:53a:6665 with SMTP id p18-20020a1c7412000000b003f6053a6665mr4880791wmc.19.1685546581131;
        Wed, 31 May 2023 08:23:01 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:b1d9:81ac:cb3:35d0? ([2a02:578:8593:1200:b1d9:81ac:cb3:35d0])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600011c100b00306c5900c10sm7217239wrx.9.2023.05.31.08.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 08:23:00 -0700 (PDT)
Message-ID: <0ba7543e-def1-6100-082c-48d0255b3abb@tessares.net>
Date: Wed, 31 May 2023 17:23:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v15 5/7] selftests: mptcp: check add_addr infos
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1685523463.git.geliang.tang@suse.com>
 <84841f847f4568ba725f38b3a0ea40d5c0bf4d36.1685523463.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <84841f847f4568ba725f38b3a0ea40d5c0bf4d36.1685523463.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 31/05/2023 10:58, Geliang Tang wrote:
> This patch checks add_addr_signal and add_addr_accepted in
> chk_mptcp_info(), and do this checks in userspace_tests()
> and endpoint_tests().
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 26 ++++++++++++-------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 75f1c69ae78b..60cdc36d280f 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1816,13 +1816,17 @@ chk_subflow_nr()
>  chk_mptcp_info()
>  {
>  	local nr_info=$1
> -	local info
> -	local cnt1
> -	local cnt2
> +	local info1 info2
> +	local cnt1 cnt2
>  	local dump_stats
>  
>  	if [[ $nr_info = "subflows_"* ]]; then
> -		info="subflows"
> +		info1="subflows"
> +		info2="subflows"
> +		nr_info=${nr_info:9}
> +	elif [[ $nr_info = "add_addr_"* ]]; then
> +		info1="add_addr_signal"
> +		info2="add_addr_accepted"
>  		nr_info=${nr_info:9}

I think it would be clearer if chk_mptcp_info() was getting 3 parameters:
- counter name for ns1
- counter name for ns2
- the expected value for both (or 2 different ones)

If you do that, you can remove this if/elif/else section.

So we would call:

  chk_mptcp_info subflows subflows 1
  chk_mptcp_info add_addr_signal add_addr_accepted 1

But you can also add helpers:

  check_mptcp_info_subflows()
  {
          chk_mptcp_info subflows subflows "${1}"
  }

  check_mptcp_info_add_addr()
  {
          chk_mptcp_info add_addr_signal add_addr_accepted "${1}"
  }

  check_mptcp_info_subflows 1
  check_mptcp_info_add_addr 1

WDYT?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
