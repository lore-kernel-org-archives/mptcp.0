Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1669B2F26
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 09:19:32 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id s7so9452775edd.3
        for <mptcp@lists.linux.dev>; Tue, 08 Feb 2022 01:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=uev/EgZQzfnDj//vaeyOF8QAPN7yuaUC91czERvE264=;
        b=4kbM83iIZu8lpwsHcSUjENVxzgYaDzhyzmALLIM4BAH56yd6DpWOg5Tx483yqGMnCs
         zV34J4yeaU7Vs7EghqH3MInTC69T4raiDFvQmEsh07/EXTwc3rTFVlEEiOJd4yQzg/bA
         +Z9x4sOziQQYJEClFghbSZ6J1hqqvwl10rAjE4YD/Eug/LxkHJVYR5Ki+3KbokjU8d2l
         niFfRbPsVyupD+B+JJLidcBoXv0hpxDcd1ZnOtNHGa7rUF4LMQA0Box6rwDMhHmKApmw
         fguUlN5CNVctARVH/uo45F9aPkaZvVwlGDka4BtKLUCZBcnJi+SZKzQeGMm9VCr6+fJ4
         YeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=uev/EgZQzfnDj//vaeyOF8QAPN7yuaUC91czERvE264=;
        b=p1vw+QzVbC9csKCbSvn5sAHzaXJpNZA8XTvaynfgL4wKt2otpUQXCMz7yylHGuAY8A
         B1adrADAhEH12kX6x8gDY1zTXwiwrUvZOMD1qWqysGXy89KI87i5UWIz88jzV+VIiVcQ
         Olvs5iw8NrorJnK2VMS/1IStXtL+WcvUGnSbEsQmUTVDvXbn8IEGymnKTj/Z0yz4IW5q
         4Bo0IIZiviJGTyKabTdmAwoVffacocn8AxUjuDmnKkcJyh+fvbQwIknSIPaJxMcyS/i9
         n1C5BqC2nh53w79jIvrRja581Up/b1Y+qKK8OZPGagy3H/Ih96M2rCw+wabFONTHfI1x
         Dwcw==
X-Gm-Message-State: AOAM533vZTp2EhgSz8H28Bn+H37ZBQ9N/yPDpB6QZGIh1V5BK3DN7v07
	VhkokUEOU/uRWv0cpZHmLA78VV2kboYJnrvD1DQ=
X-Google-Smtp-Source: ABdhPJwxrxEabh1HHuAakdR4ZkWOG0SdjDJN21Sz6otH7ws6wBy6Nhl0zFFa56ojUgARVmGGUvlpmg==
X-Received: by 2002:a05:6402:4411:: with SMTP id y17mr3494946eda.175.1644311970237;
        Tue, 08 Feb 2022 01:19:30 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:ba0f:5a93:d93e:ce85? ([2a02:578:8593:1200:ba0f:5a93:d93e:ce85])
        by smtp.gmail.com with ESMTPSA id n14sm925184eja.219.2022.02.08.01.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 01:19:29 -0800 (PST)
Message-ID: <aaf31301-4f25-b08e-6344-c3b837eaba43@tessares.net>
Date: Tue, 8 Feb 2022 10:19:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: increase timeout to 20
 minutes
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20220208091013.749627-1-matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220208091013.749627-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 08/02/2022 10:10, Matthieu Baerts wrote:
> With the increase number of tests, one CI instance, using a debug kernel
> config and not recent hardware, takes around 10 minutes to execute the
> slowest MPTCP test: mptcp_join.sh.
> 
> Even if most CIs don't take that long to execute these tests --
> typically max 10 minutes to run all selftests -- it will helpi some of
> them if the timeout is increased.
> 
> The timeout could be disabled but it is always good to have an extra
> safeguard, just in case.
> 
> Please note that on slow public CIs with kernel debug settings, it has
> been observed it can easily take up to 45 minutes to execute all tests
> in this very slow environment with other jobs running in parallel.
> The slowest test, mptcp_join.sh takes ~30 minutes in this case.
> 
> In such environments, the selftests timeout set in the 'settings' file
> is disabled because this environment is known as being exceptionnaly
> slow. It has been decided not to take such exceptional environments into
> account and set the timeout to 20min.
> 
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> 
> Notes:
>     On my CI at Tessares, another machine is now used with a different host
>     kernel. mptcp_join.sh selftest is now regularly taking more than 10
>     minutes when testing with a debug kernel.
> 
>     v2:
>      - from 1h to 20 min (Mat) and adapt the commit message to explain why
>        this don't cover all cases that have been observed.

I hope you don't mind if I apply this patch now so my CI stops
complaining about all modifications of the export branch. I can fix it
later if needed.

- 87dac6279023: selftests: mptcp: increase timeout to 20 minutes
- ec54f23ec607: tg:msg: fix typo
- Results: a206ca2f7274..7b9f56739735

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220208T091856
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
