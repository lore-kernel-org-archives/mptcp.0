Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250D02F25
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 09:32:30 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id a8so5464921ejc.8
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 01:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6KurUvDPfTmYBkaX61ZtRlxPnvPK8gKtsiwW4TUnBV8=;
        b=lEP8XJss889CIE/J9bWO6QwyJsuunoKe1hS5dX5VLdCBOomPUwYcatSTIT+LqVyEpJ
         27On36cF6Tv9s9OOwTCBS7iT6+fuIhsYCDzokMGBNyb6iHXAYcVgAqWSjamWR0xEP9cc
         98d2WW/LHxKF98VDxpWiTJ0ETN0JyY5NODlTZNMAaGBnlX/NcvLDlBnJxl5kATuNzx3a
         r3FmtXAwUwplIjL4KDrEnwjlzsMCEMUwk+VNOFXnGfkuNbI4622NzJp6V2OASsDT3p7q
         8cezPjhDICWwRQKP6F+3bS3UhYGnM+FZ8fM8qz5dfXozDajnKm82YMdvCsKB5136qBU2
         PLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6KurUvDPfTmYBkaX61ZtRlxPnvPK8gKtsiwW4TUnBV8=;
        b=OiL3qPUNogM9Y4Tx39rvcjikSAjzVM3rUb1GakTC3SnB5rrb7iuke11vtMhcLWWXtj
         7YvcmUMEZyTCOTnJw/TenASQ9uG65j4qIdH7Ah9Yq4HYbr+H4iaFuL3hMsxI4xaxqwgC
         pTBM/omuvKL5MvZaOfej0f1yw+c00lCMTxxdDITw5zl/c4W7tcNMKsxzKG8aBWIEXvBE
         MfBseOxPJvJSgxStjSAjntF6e6ySxSBSDQqoOrreLr2Z0+O3BpiK0uyw8Zi34g1ykKjk
         bMKmE+Zi7d2zBum738PuQAm1Fa/3nJZKJdjIz/cFZM5eD/E9eMfCAPj1VycdVTBiDmT9
         OHDw==
X-Gm-Message-State: AOAM531mK4z20SUO2pXRAW3e1GbLhTcn9JCA9FDE8RBubPUKZb7d1Jto
	iFCIzplNkNiVXTkPIZ22kMp6Aw==
X-Google-Smtp-Source: ABdhPJywkvM+Dvg64lXz1XbcJXfCmQ43hjhRKilAB8uaVUYvaaOA4F3+EqLBVpbICIz8UlJ7gE+3mw==
X-Received: by 2002:a17:907:20b1:: with SMTP id pw17mr1165926ejb.231.1644399148312;
        Wed, 09 Feb 2022 01:32:28 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:268e:dc63:f3ef:de99? ([2a02:578:8593:1200:268e:dc63:f3ef:de99])
        by smtp.gmail.com with ESMTPSA id s16sm1866173edt.91.2022.02.09.01.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 01:32:27 -0800 (PST)
Message-ID: <b4a6ec03-e323-6854-594f-ec3bc50b0a20@tessares.net>
Date: Wed, 9 Feb 2022 10:32:27 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-net v2 2/4] mptcp: fix race in incoming ADD_ADDR
 option processing.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <cover.1644346664.git.pabeni@redhat.com>
 <9055dfabebe975c34e5f741885e1c70ecb49da36.1644346664.git.pabeni@redhat.com>
 <0fcbb69f-1e23-be3c-aea0-86bafb3a68fb@tessares.net>
 <4bab507-7452-b973-279a-70a3e911906f@linux.intel.com>
 <4a0db1e5aa0f483de5ccf4e86f05eca5f9d88fce.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <4a0db1e5aa0f483de5ccf4e86f05eca5f9d88fce.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 09/02/2022 09:49, Paolo Abeni wrote:
> On Tue, 2022-02-08 at 16:54 -0800, Mat Martineau wrote:
>> On Tue, 8 Feb 2022, Matthieu Baerts wrote:
>>> On 08/02/2022 20:06, Paolo Abeni wrote:

>>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>>> index fb8d4bfcfbd6..4b6aa89d45a5 100644
>>>> --- a/net/mptcp/pm_netlink.c
>>>> +++ b/net/mptcp/pm_netlink.c
>>>> @@ -660,6 +660,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>>>>  	unsigned int add_addr_accept_max;
>>>>  	struct mptcp_addr_info remote;
>>>>  	unsigned int subflows_max;
>>>> +	bool reset_port;
>>>
>>> I'm very surprise the compiler doesn't complain about this line because
>>> reset_port can be used later while not having been set before. Is it
>>> normal with 'bool'?
>>>
>>>
>>> Setting it to false by default fixes the issue with packetdrill on my side:
>>>
>>> ---------- 8< ----------
>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>> index 4b6aa89d45a5..98b485406afa 100644
>>> --- a/net/mptcp/pm_netlink.c
>>> +++ b/net/mptcp/pm_netlink.c
>>> @@ -660,7 +660,7 @@ static void mptcp_pm_nl_add_addr_received(struct
>>> mptcp_sock *msk)
>>>        unsigned int add_addr_accept_max;
>>>        struct mptcp_addr_info remote;
>>>        unsigned int subflows_max;
>>> -       bool reset_port;
>>> +       bool reset_port = false;
>>>        int i, nr;
>>>
>>>        add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
>>> ---------- 8< ----------
>>>
>>> (I can fix the issue when applying the patch if it is easier)
>>
>> With Matthieu's reset_port fix, it's working well for me too.
> 
> Whoops, not sure how I forgot the proper initializer, and I'm also
> surprised the compiler did not warn (the latter may provide some excuse
> for the first ;)

The compiler not warning us about that bothers me :)

> Do you prerfer a formal repost or can you mangle the patch in
> patchwork?

I can do the modification just before applying the patch. I will wait
for a reply on the last question on patch 1/4 before applying it ;)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
