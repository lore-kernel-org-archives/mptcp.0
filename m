Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9EA173
	for <mptcp@lists.linux.dev>; Mon, 17 Jan 2022 21:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1642456329; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=hDc+/nhly/UH7GR2bkFK4IyJEss9gUAiYaihCCQxg0ma8up5PTk6OCzIVI2cXxVfhXLn4KTx9PbI6eMWUM1fCw1ngfo71fMdk9i0NYhd+ygff9S5YDbwq7jPdVeoMw5eh+bEbvirH7zb8JxaDNEu3zVe3yNZUBo+NqqEDOaHDQ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1642456329; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=BvEEz6eCE5EvD3GErLa9sec6lWufbDhsXPch8+t5xJ8=; 
	b=K3/YepFDbUZnP8xUswa4Rkh8wHfyaf+aHFNwZcM8X2k2X5LPGnU6vCKasIRy2ucBxtOmlLizBN1ycvGQNVpjNWcXpps0pGChQnRM6lHEWehL1LIpggeHcsBZbvGxs6TXAETcVA/AXT1c3tu+wKg+oWf0KnWq63ekU1VvnLygDwQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1642456329;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=BvEEz6eCE5EvD3GErLa9sec6lWufbDhsXPch8+t5xJ8=;
	b=avp6ov0Q7Q5I2lChf1lfQcFdUvUAlyRRTo3pNImQuX8cNVWgiOpdS+fwcwK+XrcL
	O5NQf5WX9tuG4IsHI2F0fHVOgSBhbsZCxx73QUmajGw7kavMtvhl71sToBejDeqC6z4
	R6d/1ZqdFa0wGv6XFxGC753J3mQXb7Zny1gzBrA0=
Received: from [192.168.100.116] (vps-f3afed4e.vps.ovh.net [198.244.151.99]) by mx.zoho.eu
	with SMTPS id 1642456327433324.72992795277935; Mon, 17 Jan 2022 22:52:07 +0100 (CET)
Subject: Re: [PATCH net-next v2] net: mptcp, Fast Open Mechanism
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
 Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220116001259.203319-1-dmytro@shytyi.net>
 <449d3338d759e9f72f33e7c37e1b9956bdda77f4.camel@redhat.com>
 <9f700f12472bddc0d9d899773d2a211bfe8517f6.camel@redhat.com>
 <e5c6e1a3-0963-e26c-3e0e-8d7ea7126116@tessares.net>
From: Dmytro SHYTYI <dmytro@shytyi.net>
Message-ID: <fc9d81f0-e2a8-70a4-6ba0-285d3306d7db@shytyi.net>
Date: Mon, 17 Jan 2022 21:51:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e5c6e1a3-0963-e26c-3e0e-8d7ea7126116@tessares.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello Matthieu,

On 17/01/2022 10:22, Matthieu Baerts wrote:
> Hi Dmytro,
> 
> On 17/01/2022 11:03, Paolo Abeni wrote:
>> On Mon, 2022-01-17 at 10:58 +0100, Paolo Abeni wrote:
>>>> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
>>>> index 48d8a363319e..d7092234d442 100644
>>>> --- a/include/linux/tcp.h
>>>> +++ b/include/linux/tcp.h
>>>> @@ -54,7 +54,14 @@ static inline unsigned int tcp_optlen(const struct sk_buff *skb)
>>>>   /* TCP Fast Open */
>>>>   #define TCP_FASTOPEN_COOKIE_MIN	4	/* Min Fast Open Cookie size in bytes */
>>>>   #define TCP_FASTOPEN_COOKIE_MAX	16	/* Max Fast Open Cookie size in bytes */
>>>> +
>>>> +#if IS_ENABLED(CONFIG_MPTCP)
>>>> +#define TCP_FASTOPEN_COOKIE_SIZE 4	/* the size employed by MPTCP impl. */
>>>> +#else
>>>>   #define TCP_FASTOPEN_COOKIE_SIZE 8	/* the size employed by this impl. */
>>>> +#endif
>>>
>>> You really need to document this kind of changes in the code, possibly
>>> referring to the RFC bits requiring it.
>>
>> Note that MPC + syn currently uses 24 bytes of TCP option spaces, and
>> MPC + syn + ack is using 32 bytes, to there is enough room for 8 bytes
>> cookies.
> 
> Indeed, in MPTCPv1 (RFC8684), there is more space in the MPC+SYN as
> mentioned in the Appendix B you referred to.
> 
> Also, you cannot change the value here depending on the kernel
> configuration: that will break TFO for "plain" TCP I suppose.

I agree. I might find other way to enter this particular case if needed 
at all.

> Adding this feature is quite complex because our primary goal is not to
> have any impact on TCP connections without MPTCP. Any modification in
> TCP code needs to be very well justified to be accepted upstream.

Indeed. :)

> Do not hesitate to join one of our weekly meeting and/or IRC channel [1]
> to discuss about the implementation of this feature. Because of the
> task's complexity, it is probably better to discuss than having long and
> probably discouraging feedback loops by email. WDYT?
> 
> [1] https://github.com/multipath-tcp/mptcp_net-next/wiki#resources

I will try to participate. Thank you for invitation!

> Cheers,
> Matt
> 

Best regards,
Dmytro.
