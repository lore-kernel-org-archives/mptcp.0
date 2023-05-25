Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE019E7F
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 17:00:35 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f6d7abe9a4so6026485e9.2
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 10:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685034034; x=1687626034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JnHh/nrfudXPF1I5rYeBTOSrypdX55zUpzMNDHMFgrE=;
        b=lakwZcOmGy9Wvwi8JgAVLaEQrRyLgFH6WlJ8YHKXneiCVrX2mBrTZnCwEO4RYWzpfZ
         kFb1RygIsuv57YL8e3k+uzD7TNCmaFyUAO9ooWgpOOrNhB1wTWJ08ZrSWDpepynnEQ50
         Y+pfTPaeAZ2+1gHgNJzF2Qg+ATmATeZcEDgdUGN2tfc+i3YSk+Nfst8ljSJ/Q5gx0Gdm
         Wn29MnouGnAclKl6MISSj7SBHWpFrb3gtIkdzx5n4RuqFEV5pur9bQEPDzOoz0CilZqZ
         k0Ro+Xkp1lKcLXdOlWavF9u4GfW9Dc+hSYQ45S7DJ5Ui/1EobbraHUWiitdBtgeHoZWv
         4MNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685034034; x=1687626034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnHh/nrfudXPF1I5rYeBTOSrypdX55zUpzMNDHMFgrE=;
        b=TxZC0pVbxl7k7X3JKZGcpfb4K6Plkb8VhjOKWOx81Exlzca1GiE1ALmayi+uQQal43
         wkrLXVliX4SUFgNh18s0fq6eiHMjHWjrukhwIfKkWAMNnNPJHvYHYeYHrzRnHnMc0bRI
         sWKzlcZaIxx3sS0cFrG2CEBzje4WpZxrjQJR9s4OYH7Z11n1ZeJRpY3E/HGQ8mqnwP/B
         EOXMlsY9RuBi01a/cn/QDUCUl02+NxMxhP9OL6N6c+RpAlFtaNpYFYjp8kIv4wvjc7UB
         hvg3ngrKLGRiKmY+IrGYgownE/D8+aI4ewXmNLgHcDBknBu1UTG8IeK9ZS+ulMXQz/1U
         8iFQ==
X-Gm-Message-State: AC+VfDzUCy6oA1y8qBp2UDY5eYa5RkrWpYRyo/3jtAWvI97ItJDV3OOh
	RsgeuZu/TVQjNJpmwtjTol3+ug==
X-Google-Smtp-Source: ACHHUZ4Q1D5ZSAMDleERBIX2fhJW+40KzGvf8exIc1x1IdvjedeO5l3dLibb9AfhGmia8Ti18PjPMw==
X-Received: by 2002:a05:600c:2944:b0:3f1:6fea:790a with SMTP id n4-20020a05600c294400b003f16fea790amr2514767wmd.30.1685034034065;
        Thu, 25 May 2023 10:00:34 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f7f1:b30b:79e4:1a7e? ([2a02:578:8593:1200:f7f1:b30b:79e4:1a7e])
        by smtp.gmail.com with ESMTPSA id v24-20020a1cf718000000b003f60b328417sm2682035wmh.17.2023.05.25.10.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 10:00:33 -0700 (PDT)
Message-ID: <b421bdb3-70db-a122-3375-de81a048fe0c@tessares.net>
Date: Thu, 25 May 2023 19:00:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 mptcp-next 2/6] mptcp: track some aggregate data
 counters.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
References: <cover.1684997011.git.pabeni@redhat.com>
 <9da66102af6d8df4ae08a5a5ff8526f52e2f34b5.1684997011.git.pabeni@redhat.com>
 <0259fb14-db63-5156-881a-b74d07f15c8e@tessares.net>
 <ce17b935a9cf7bb11fbaf26e131f3727bddc5c55.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ce17b935a9cf7bb11fbaf26e131f3727bddc5c55.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/05/2023 18:42, Paolo Abeni wrote:
> On Thu, 2023-05-25 at 17:19 +0200, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 25/05/2023 09:17, Paolo Abeni wrote:
>>> Currently there are no data transfer counters accounting for all
>>> the subflows used by a given MPTCP socket. The user-space can compute
>>> such figures aggregating the subflow info, but that is inaccurate
>>> if any subflow is closed before the MPTCP socket itself.
>>>
>>> Add the new counters in the MPTCP socket itself and expose them
>>> via the existing diag and sockopt. While touching mptcp_diag_fill_info(),
>>> acquire the relevant locks before fetching the msk data, to ensure
>>> better data consistency
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>>  include/uapi/linux/mptcp.h |  5 +++++
>>>  net/mptcp/options.c        | 10 ++++++++--
>>>  net/mptcp/protocol.c       | 12 +++++++++++-
>>>  net/mptcp/protocol.h       |  4 ++++
>>>  net/mptcp/sockopt.c        | 22 +++++++++++++++++-----
>>>  5 files changed, 45 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
>>> index 32af2d278cb4..a124be6ebbba 100644
>>> --- a/include/uapi/linux/mptcp.h
>>> +++ b/include/uapi/linux/mptcp.h
>>> @@ -123,6 +123,11 @@ struct mptcp_info {
>>>  	__u8	mptcpi_local_addr_used;
>>>  	__u8	mptcpi_local_addr_max;
>>>  	__u8	mptcpi_csum_enabled;
>>> +	__u32	mptcpi_retransmits;
>>> +	__u64	mptcpi_bytes_retrans;
>>> +	__u64	mptcpi_bytes_sent;
>>> +	__u64	mptcpi_bytes_received;
>>> +	__u64	mptcpi_bytes_acked;
>>
>> I'm sure sure I followed correctly the discussions about that with
>> Florian: did we not want to switch to __aligned_u64 for the new fields?
>> (and why not the old ones as well if it doesn't change anything but at
>> least it would be uniformed)
>>
>> If I'm not mistaken, it would not change anything but maybe better to be
>> on the safe side?
> 
> IMHO this is the main point. I also think adding __aligned_u64 should
> not change nothing. _but_ if will change something e.g. on some
> esotheric arch, adding __aligned_u64 would break uAPI and will be very
> bad.
> 
> IMHO the safe side is not adding such annotation here.

Thank you for your reply! Sounds good to me!

And despite having 64-bit fields, "struct tcp_info" doesn't use
__aligned_u64 either. So we can always say we are "aligned" to what TCP
did :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
