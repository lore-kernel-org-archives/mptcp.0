Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D152B2FAE
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 15:22:11 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id dv25so21377337ejb.12
        for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 08:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2V60/Q43SUUV6xklIm6HNy21ZEmh0LT8ByrpyLg8wys=;
        b=7I4ycoNZG2sddQ5vZNYU8mwW1jxwHMmQ2c4vh+KBc+69y5Z5hblG5ZOWLkoZEabH3E
         LN8kuwOEVnqGqe2x+M1xKwaAWvhIKRJcI3CvPop6jFTmxE/0Ar6zQm/y0MnFrB4zRzsT
         D22FlsTHANNWU+E8tStTguhRvb3xvPYn1TXKzmYTkrEkF2UlEw7ZkTCdtL6+uSDPbIG+
         zaE5HAF7AxZoI06WIcJqP2qQLsWZHWnnkJqK5jZSdwpBTHOcdK2e4gkNOfYRGJLbqMAZ
         FU6SoQWglN4rSOO8LUbr2RJ6a7Xw0FZQeRFcvHVh3HvZ5DU+SvMRSyUJ0FcR36iKJYKz
         0G/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2V60/Q43SUUV6xklIm6HNy21ZEmh0LT8ByrpyLg8wys=;
        b=mfYs+0YARh6ZDzSYioUpkun33xHJNmVrkaqQzl4kaDANGiXXymmNjd46DaPpDqjWAS
         N89na50Hnpc063N0ZXYGUOVGFMe2iJ8kqf+Ch+5K5XPnnE/cljUMe3+K42rg0sY5y58F
         bj/2wnFfTYuEc2hgcz4x1Mqv4G1R+rP3vjoWkfQQoYo/JP1CV/Y+u8qN8FJ2Xrk8wifV
         ZBTymo//Btn2VHlV6Iq6w3Pl8uqPsqiy1X2kegw3tOb+2UUrhatkgwtUMHGGI+lFrusC
         JRTUl31toRRH+XzIby9FkgD2cEqMlAKgv1jRdzpcKnDCxyaXsMp4HdrAUHvL9i68GCBj
         A2Hg==
X-Gm-Message-State: ACrzQf3pk9jtYf5rseM0x60+8L/JLbyFkBS3Tr0sv0z/FRhtkcqe27Cn
	z8N0CwTnb4i9G/L3ue/Ruui5pg==
X-Google-Smtp-Source: AMsMyM4hw9XV3bccypEK7grMKAXRA8SAjYYIWG7ZiArNmqcLEa9UL/mCfgHUZka6TYMSujp8dfonEg==
X-Received: by 2002:a17:907:25cd:b0:77b:9672:38e7 with SMTP id ae13-20020a17090725cd00b0077b967238e7mr24098444ejc.10.1664292129856;
        Tue, 27 Sep 2022 08:22:09 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:2223:8b8e:70fe:8d48? ([2a02:578:8593:1200:2223:8b8e:70fe:8d48])
        by smtp.gmail.com with ESMTPSA id ne13-20020a1709077b8d00b0073dc4385d3bsm969578ejc.105.2022.09.27.08.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:22:09 -0700 (PDT)
Message-ID: <15a476f0-c5e4-7999-a23c-73ab0b6c60c5@tessares.net>
Date: Tue, 27 Sep 2022 17:22:08 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH mptcp-next v11 1/4] mptcp: add
 mptcp_setsockopt_fastopen
Content-Language: en-GB
To: Dmytro Shytyi <dmytro@shytyi.net>, Paolo Abeni <pabeni@redhat.com>,
 mptcp@lists.linux.dev
References: <20220925232601.25252-1-dmytro@shytyi.net>
 <20220925232601.25252-2-dmytro@shytyi.net>
 <84be9c0419af677897836e5af900596bc4713767.camel@redhat.com>
 <7b093482-2c18-7657-92be-e2784001eeff@tessares.net>
 <17582987-b035-a1b7-195f-289e3d9e7edd@shytyi.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <17582987-b035-a1b7-195f-289e3d9e7edd@shytyi.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Dmytro,

On 27/09/2022 06:01, Dmytro Shytyi wrote:
> Hello Paolo, Matthieu,
> 
> 
> On 9/26/2022 5:01 PM, Matthieu Baerts wrote:
>> Hi Dmytro, Paolo,
>>
>> On 26/09/2022 16:50, Paolo Abeni wrote:
>>> On Mon, 2022-09-26 at 01:25 +0200, Dmytro Shytyi wrote:
>>>> Add set MPTFO socket option for MPTCP. This option is needed for
>>>> the listen socket to accept MPTFO.
>>>>
>>>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>>>> ---
>>>>   net/mptcp/Makefile   |  2 +-
>>>>   net/mptcp/fastopen.c | 37 +++++++++++++++++++++++++++++++++++++
>>>>   net/mptcp/protocol.h |  5 +++++
>>>>   net/mptcp/sockopt.c  |  3 +++
>>>>   4 files changed, 46 insertions(+), 1 deletion(-)
>>>>   create mode 100644 net/mptcp/fastopen.c
>>>>
>>>> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
>>>> index 8a7f68efa35f..c42ad8609876 100644
>>>> --- a/net/mptcp/Makefile
>>>> +++ b/net/mptcp/Makefile
>>>> @@ -2,7 +2,7 @@
>>>>   obj-$(CONFIG_MPTCP) += mptcp.o
>>>>     mptcp-y := protocol.o subflow.o options.o token.o crypto.o
>>>> ctrl.o pm.o diag.o \
>>>> -       mib.o pm_netlink.o sockopt.o pm_userspace.o sched.o
>>>> +       mib.o pm_netlink.o sockopt.o pm_userspace.o sched.o fastopen.o
>>>>     obj-$(CONFIG_SYN_COOKIES) += syncookies.o
>>>>   obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
>>>> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
>>>> new file mode 100644
>>>> index 000000000000..086cbad49979
>>>> --- /dev/null
>>>> +++ b/net/mptcp/fastopen.c
>>>> @@ -0,0 +1,37 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0
>>>> + * MPTCP Fast Open Mechanism. Copyright (c) 2021-2022, Dmytro SHYTYI
>>>> + */
>>>> +
>>>> +#include "protocol.h"
>>>> +
>>>> +int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk,
>>>> sockptr_t optval,
>>>> +                      unsigned int optlen)
>> I think we should keep everything related to the sockoptions in
>> net/mptcp/sockopt.c, no?
> 
> I have multiple functions that are related to fastopen in fastopen.c.
> Probably it is not a bad idea to to keep all fastopen details in one file?

We already have a file dedicated to all socket options. I don't think we
should have an exception for TFO, especially if there is nothing
specific to TFO thanks to tcp_setsockopt().

Also, you can use the new mptcp_setsockopt_first_sf_only() helper I sent
a few minutes ago on the ML. For TCP_FASTOPEN sockopt, you now need a
commit similar to "mptcp: add TCP_FASTOPEN_NO_COOKIE support" by just
adding "TCP_FASTOPEN" in three different places in sockopt.c, see:


https://lore.kernel.org/mptcp/20220927150306.1552795-1-matthieu.baerts@tessares.net/T/

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
