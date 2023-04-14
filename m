Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E4F20F6
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 14:18:25 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id si1so15782472ejb.10
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 07:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681481904; x=1684073904;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCzybXTqqxLbvbkZ2m2XMZhLgqKtE+ao/TxpksnHoRg=;
        b=0eU+w/meetxot+H+w1GQUdAF/sMuA7retQn508oZQ+6jhkn3Ymy0uxXBjrbWADNOQa
         qKwsTW9qCiljFn4xugYcEOlmcxfAilekbcLm+VOmH0TbOEmXjUhEQdnntbyi/12JCnA0
         3SISuGySdYXFV1DElocumJGjP6dDu4p3RDH74tKdebJGmLJqMnp3JxqA0+bs9IalYI/E
         yt0CMAa+c5afGXk2lH26QjUMBagrsS+D1rEN4XBetj/8jwwWgZgfzMNXEfr82mr3jHgY
         ZWVf0P8+zQiwU/VBLZK3UTgzbqNEvGwipAPpcgoEm/P+j3rDXDUXS528kwC7T0n4wA2t
         6EGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681481904; x=1684073904;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCzybXTqqxLbvbkZ2m2XMZhLgqKtE+ao/TxpksnHoRg=;
        b=loueufXRACqP4Non/ra5YIgkyK3QBve1Hb9T3sSIntHEfJ5tJL5Plx3AtbBy4tiaLd
         ZNlpg48c4XAANVT0+6KBUdXZUxgiHG8N7e7tVNJzpRjBqSFJXf70+OXDLb0+7jcpYr5Y
         r7z2ovdSWYvw3RLr7weTNUUu/ez46CN4R+ucHubWnxA5/g/EKcU8M7ZDtxXbgsWThny9
         TcMB0HiI2cIDGyYCSxZpaRLpONN6o+DKYhbMSvVhbBcTMosKpj+5PT0+CadDMopPslGv
         90ffSnFL573duoRYglkxIBd9BLuVM5JgxfSJe1gqQ0T10WH1xG7IQ4cY4FtrNZCyNkzF
         0IrQ==
X-Gm-Message-State: AAQBX9ffcYyVjMkoC07hARv3b/jjepK1jmODtZc0TDiXQIMHUUqFoZbC
	q3X4v6zwbatBecnxiC7YhIY0VHCKmmTRRrwtqIWEeQ==
X-Google-Smtp-Source: AKy350YiI1kl9M28T3SXeO56Waq5Dok2IQhqgJkmDDQht2hUm9N5mAu+u3YuIhYeokxPafriAYbobg==
X-Received: by 2002:a17:906:99d0:b0:94e:6eb3:abc4 with SMTP id s16-20020a17090699d000b0094e6eb3abc4mr7883334ejn.4.1681481903809;
        Fri, 14 Apr 2023 07:18:23 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:1bc7:dfef:4735:71a6? ([2a02:578:8593:1200:1bc7:dfef:4735:71a6])
        by smtp.gmail.com with ESMTPSA id hr29-20020a1709073f9d00b0094a3ff153b7sm2492949ejc.199.2023.04.14.07.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 07:18:23 -0700 (PDT)
Message-ID: <253658b4-bae6-4f88-6a3e-f89f1f12a9af@tessares.net>
Date: Fri, 14 Apr 2023 16:18:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-net v3 2/2] selftests: mptcp: join: fix ShellCheck
 warnings
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20230404-mptcp-selftests-join-busybox-shellcheck-v3-0-eab5dd7bc996@tessares.net>
 <20230404-mptcp-selftests-join-busybox-shellcheck-v3-2-eab5dd7bc996@tessares.net>
Cc: Paolo Abeni <pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230404-mptcp-selftests-join-busybox-shellcheck-v3-2-eab5dd7bc996@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 12/04/2023 11:20, Matthieu Baerts wrote:
> Most of the code had an issue according to ShellCheck.
> 
> That's mainly due to the fact it incorrectly believes most of the code
> was unreachable because it's invoked by variable name, see how the
> "tests" array is used.
> 
> Once SC2317 has been ignored, three small warnings were still visible:
> 
>  - SC2155: Declare and assign separately to avoid masking return values.
> 
>  - SC2046: Quote this to prevent word splitting: can be ignored because
>    "ip netns pids" can display more than one pid.
> 
>  - SC2166: Prefer [ p ] || [ q ] as [ p -o q ] is not well defined.
> 
> This probably didn't fix any actual issues but it might help spotting
> new interesting warnings reported by ShellCheck as just before,
> ShellCheck was reporting issues for most lines making it a bit useless.

FYI, I just applied this patch 2/2 in our tree (feat. for net-next). It
looks safe and it was the same as the v1. It can then be sent to netdev
with other patches we have queued.

I did *not* apply patch 1/2 which is for -net and has been modified in
the v3.

New patches for t/upstream:
- d646e2c330bc: selftests: mptcp: join: fix ShellCheck warnings
- Results: 7bdeec74989b..5758a3d12afe (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230414T141344

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
