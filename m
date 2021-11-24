Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423C368
	for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 09:56:54 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id v1so7828602edx.2
        for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 01:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y7/WsSSRHDgP3eykNwu2GlMZys8j4HLYPid4IniP7os=;
        b=uMYD76kVaP/sct9aXXj9c8tez9UkLOeaKJquIJMvyqwHdLsCrMpM7QZN6XWfUzvi0x
         rAQVGL7+rIsVa7UWAr0DoP/0CGJOeQB6hUVLCTJBzO+cLpiB4+yxWAX71PcpYB80GR6b
         m1oSwGxMzfL+tX0CKi1ZPZsbluaIhAoTwdrm+1MXn6LnBJRTH+6zwVNbPLb1QnBQwF2u
         5/iHHaVu5F8M/tBvwJjFDbQppR/5+XglxJGOtlNTXXdrdK3sc4geZ0zIzh6TzyCOJkbq
         kS1ICKbCUWdw/vB+fTU9M6xaINmnA6WvMTJuAYKav7UVsuPvJ6Qt33hXmekS+wgEHwyC
         NhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y7/WsSSRHDgP3eykNwu2GlMZys8j4HLYPid4IniP7os=;
        b=hSiv+qJQj3+OA2SqdswOsNn9vM104Lhbrb7tVBhuPiyutB78qZSXivN22ZJ+j+eHOn
         vlk83dMsnNcXCBfQMOJjPZh9yXwZdgT7ywe//WpTG9IN3CXQQvXVNW+llQO0DV3j8KH7
         DLqbSwUaEJ2AFsXEGr4vV1kcAlJ/54JpkPC2fBSTNYYztL3h04ilRNLWrk7Nhj4uBRCj
         1sgIXIb/JCK+YOoAxUcGDAa55fQjHtWaDjRSMzVUeruX3dEedezrUcbUzFrk1Z6Z+scU
         UKnJisxSmB80u5iaDvv3AIfMhdMvQPHobHymPXGLl4otdrlT8usQsx812aUE3F9vT1/O
         m9TQ==
X-Gm-Message-State: AOAM532mgenfzvSvVtvSzhF/HaJztrro2a2rNOQnBlZyoOr9k/BXaCTe
	9dIqMLeyk39y4AoTgeIaFPRfUg==
X-Google-Smtp-Source: ABdhPJxsyLB48ZmxtvQOCeAZaZTZ0Um/wmLLzm9sdcBgqT5/Kf6Cun6iEhVt57ZuhqDNTHnkdYb2CA==
X-Received: by 2002:a50:d741:: with SMTP id i1mr22061240edj.37.1637747812584;
        Wed, 24 Nov 2021 01:56:52 -0800 (PST)
Received: from [192.168.178.33] ([213.211.139.36])
        by smtp.gmail.com with ESMTPSA id k21sm6546968edo.87.2021.11.24.01.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 01:56:52 -0800 (PST)
Message-ID: <18e9514a-7cd1-97b7-9ebc-901f89f76612@tessares.net>
Date: Wed, 24 Nov 2021 10:56:51 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH mptcp-next 3/3] selftests: mptcp: add tests for subflow
 creation failure
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Phil Greenland <phil@quantulum.co.uk>
References: <cover.1637684792.git.pabeni@redhat.com>
 <425cdb61dc939d86534843617150634869778909.1637684792.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <425cdb61dc939d86534843617150634869778909.1637684792.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 23/11/2021 17:37, Paolo Abeni wrote:
> Verify that, when multiple endpoints are available, subflows
> creation proceed even when the first additional subflow creation
> fails - due to packet drop on the relevant link

Here you don't drop the packet but you reset it. Should we have a test
for both (REJECT/DROP) (or with an additional subflow where packets are
dropped)?

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 2684ef9c0d42..dd4488746151 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1023,6 +1023,16 @@ subflows_tests()
>  	run_tests $ns1 $ns2 10.0.1.1
>  	chk_join_nr "multiple subflows, limited by server" 2 2 1
>  
> +	# multiple subflows, with subflow creation error
> +	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> +	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT

I guess we should then add "CONFIG_IP_NF_TARGET_REJECT" in the config
file :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
