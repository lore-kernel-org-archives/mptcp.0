Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A6BA4A
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 17:03:31 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so1193134wml.0
        for <mptcp@lists.linux.dev>; Wed, 04 Jan 2023 09:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u4qLzkQm+d88IvlJYCb4VJXEJ28lDdhlh5NLJNmzo94=;
        b=1BaCQL3xvDA5NKhJJ0myXfVxFx6wQr+Ne+TJef3u7aq6nvU6QZAd3C69tFfcBrDl9c
         4R9kAxDxgBa3Q4omKQgqXGoYexC996JSa0TZSm7sVux5l2Oxed1/iQYNhsbzhDUOpG2K
         qErYwkLxG0+p3/l1FKKc3a4OuuJp6Voj3FzvsnWUTZRAcwIHRm6QOmebxDvryzAQp3YR
         IH70MtT1ZoVfzXsmczE9rynRVETahIcTt/1ndGAFCkPio1a+ngrfzh/ziCrw6v1ZPLO/
         v6GMnG7t4GfX0N3n2OvC9Vddr7Zp6loJTT0t+RiGIYbu2ju7FwLTlX5PAHhbRILpwMKJ
         jR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4qLzkQm+d88IvlJYCb4VJXEJ28lDdhlh5NLJNmzo94=;
        b=RBd0b9XWqtFrCyavrWGQxN2PXaXZ5zoDNN9J994xL/KOqZ7rjQzexNqmcIiLXwLAZD
         k4B4bTo8wTwQuAsvg4V6NLqILzpehQzUeZHUxc1B4T8+cYnGE8i08FteXrJPhBO+h8O/
         V4hLFxeoO0kluaZXq82JzYvlBsCzCsHtSA1Z5GR2Y73xuCTFcGEQwebkJwrIJUIUfWJf
         MFgCyS/kfmW4GlqQu+FpAMitkS/RS847uqGP4OUHUD7H7D2pfCpv81LjXWXPmnZEMuZq
         1RCDNwns3m5Kb9I37E39CXgQvl8zywAkOuZ5f85iKauc+5KHxNPP/nA1LrMtqVknMOku
         vO4w==
X-Gm-Message-State: AFqh2krDeSm9LDchPam7YNVcXOUzDcMHkCEtO4v7l30K3s5bXw/+/Meb
	YX+fPAhV3vB/hmR7vmHKKD/1EA==
X-Google-Smtp-Source: AMrXdXtI/Q7LsZhrNy6ir7Khh4vgQnct5P43jLWY2M+rhJC2HI5PLrvE3y9f33sdQZARPRZLkcVIEQ==
X-Received: by 2002:a05:600c:34d4:b0:3cf:a39f:eb2a with SMTP id d20-20020a05600c34d400b003cfa39feb2amr34186794wmq.11.1672851810138;
        Wed, 04 Jan 2023 09:03:30 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:540d:f562:8a82:61fa? ([2a02:578:8593:1200:540d:f562:8a82:61fa])
        by smtp.gmail.com with ESMTPSA id q16-20020a05600c46d000b003d1f3e9df3csm56776914wmo.7.2023.01.04.09.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 09:03:29 -0800 (PST)
Message-ID: <7bebf3e5-1bc5-970b-9626-acd42da8f428@tessares.net>
Date: Wed, 4 Jan 2023 18:03:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mptcp-net v4 02/12] mptcp: netlink: respect v4/v6-only
 sockets
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
 <20221228101748.2518303-3-matthieu.baerts@tessares.net>
 <454ad691-ca73-f9d0-79b3-9760893bcdf4@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <454ad691-ca73-f9d0-79b3-9760893bcdf4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

Thank you for the review!

On 04/01/2023 02:35, Mat Martineau wrote:
> On Wed, 28 Dec 2022, Matthieu Baerts wrote:
> 
>> If an MPTCP socket has been created with AF_INET6 and the IPV6_V6ONLY
>> option has been set, the userspace PM would allow creating subflows
>> using IPv4 addresses, e.g. mapped in v6.
>>
>> The userspace PM will also accept creating subflows with local and
>> remote addresses having different families resulting in the creation
>> of non expected subflows.
>>
> 
> Could you clarify the consequences of a userspace PM allowing these
> subflows on unpatched kernels? Are resources leaked, or undefined
> behavior caused?

Before the parent commit, the kernel was creating a new socket using the
family of the MPTCP socket. With the parent commit, now the socket is
created using the family of the "local" address.

Depending on the subflow socket's family, different behaviours are
expected. If AF_INET is forced with a v6 address, the kernel will take
the last byte of the IP and try to connect to that. On the other hand,
if AF_INET6 is forced with a v4 address, the kernel will tries to
connect to a v4 address (v4-mapped-v6). I didn't try this specific case
but similar to what the userspace would have by using a bind(v6) and
then a connect(v4), the kernel_connect() operation will fail with EBADF
if a kernel_bind() to a (real) v6 address has been done. So if I'm not
mistaken, no resources leaked, not an undefined behaviour really but not
the expected one.

I can add that in the commit message of the v5.

>> It is then required to check the given families can be accepted. This is
>> done by using a new helper for addresses family matching, taking care of
>> IPv4 vs IPv4-mapped-IPv6 addresses. This helper will be re-used later by
>> the in-kernel path-manager to use mixed IPv4 and IPv6 addresses.
>>
>> While at it, a clear error message is now reported if there are some
>> conflicts with the families that have been passed by the userspace.
>>
>> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow
>> establishment")
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>> net/mptcp/pm.c           | 25 +++++++++++++++++++++++++
>> net/mptcp/pm_userspace.c |  7 +++++++
>> net/mptcp/protocol.h     |  3 +++
>> 3 files changed, 35 insertions(+)
>>
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index cdeb7280ac76..083f3f8322c0 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -413,6 +413,31 @@ void mptcp_pm_subflow_chk_stale(const struct
>> mptcp_sock *msk, struct sock *ssk)
>>     }
>> }
>>
>> +/* if sk is ipv4 or ipv6_only allows only same-family local and
>> remote addresses,
>> + * otherwise allow any matching local/remote pair
>> + */
>> +bool mptcp_pm_addr_families_match(const struct sock *sk,
>> +                  const struct mptcp_addr_info *loc,
>> +                  const struct mptcp_addr_info *rem)
>> +{
>> +    bool mptcp_is_v4 = sk->sk_family == AF_INET;
>> +
>> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
>> +    bool loc_is_v4 = loc->family == AF_INET ||
>> ipv6_addr_v4mapped(&loc->addr6);
>> +    bool rem_is_v4 = rem->family == AF_INET ||
>> ipv6_addr_v4mapped(&rem->addr6);
>> +
>> +    if (mptcp_is_v4)
>> +        return loc_is_v4 && rem_is_v4;
>> +
>> +    if (ipv6_only_sock(sk))
>> +        return !loc_is_v4 && !rem_is_v4;
>> +
>> +    return loc_is_v4 == rem_is_v4;
>> +#else
>> +    return mptcp_is_v4 && loc->family == AF_INET && rem->family &&
>> AF_INET;
> 
>                                                                     ^^
> 
> Looks like you intended:
> 
> +     return mptcp_is_v4 && loc->family == AF_INET && rem->family ==
> AF_INET;
> 
> Correct?

Good catch!
Thank you, I will fix that in a v5.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
