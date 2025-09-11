Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3623F413
	for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578805; cv=none; b=S7VBPNO0kwRvZlyp45dfFCQNZbYlI6tsJZyNPQGiL5C50ZhCwHmJtwj9JmSKx8pJTW5jg3Ozc4Jl8fb0aPz48Kf59854kxBbzPB9I+YCzrVj+IngiTcbU3XA0u6u/N2WhFmniEdY2VU9Az4TIpd8xDkC3Gu5M4QM5hi/fbpluM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578805; c=relaxed/simple;
	bh=fxg62UHt8pN3Zed7RTcMwAxDq8ch28VtdO5prVRHw5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J2W31B7kADmTp4D2i86SAGhEqAjFSzpshuo0sg4g0549EK/2JBktzcieNjaNnTVi2OtV8raP0Sj/YnvTISGw7ER8gKjwjbtmrWhbN7vIX8noJekZ7Nzk6Cz9iiZupZAyLO7jyVMzqy7Lpb8BAYcvFOYrg/feuDzpMxnTx4mqLaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lflXm+3Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lflXm+3Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B34AC4CEF7;
	Thu, 11 Sep 2025 08:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757578805;
	bh=fxg62UHt8pN3Zed7RTcMwAxDq8ch28VtdO5prVRHw5k=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=lflXm+3YmYmE5Rv/3DAKXNwQ1p1f6IoCqzW5TwfSJfH1l5+DWBoUUYxbBz5yBlZMn
	 WVv85DspbvadtHy01XORHBdoJFEPZYGMVdMr6XomxNFPjIIdvld5k6WRrRZF1jP9jX
	 eQ5zZwLQUt+jGLG9NA+DxnqXurCGATTKAmeuDFF5ZiOiauAxsSn6azQa86KG3qiqLK
	 MG6YpPD3XQoAKxRgou2P9QbkFzI2cXvyKVaNg4wa0EHzB8Fox6I8YqkaZwO/zew9o3
	 1Ij+56A61667Um5UFrA4sD7ZLEN0SUmahj+eTaq1nFlRUplGf4SG7+hA3+axC9bkSI
	 yzPK4SvKYMBeA==
Message-ID: <81bfd469-fc1b-4dc5-a049-5ee470b55bda@kernel.org>
Date: Thu, 11 Sep 2025 10:20:02 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/4] mptcp: pm: netlink: only add server-side
 attr when true
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
 <20250909-mptcp-pm-user-server-side-flag-v1-1-cb8e2b8d1c0c@kernel.org>
 <732d1d85e092148ff8d8d1c82f311929a5d53ff3.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <732d1d85e092148ff8d8d1c82f311929a5d53ff3.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for the review!

On 11/09/2025 10:15, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, 2025-09-09 at 18:30 +0200, Matthieu Baerts (NGI0) wrote:
>> This attribute is a boolean. No need to add it to set it to 'false'.
>>
>> Indeed, the default value when this attribute is not set is naturally
>> 'false'. A few bytes can then be saved by not adding this attribute
>> if
>> the connection is not on the server side.
>>
>> This prepares the future deprecation of its attribute, in favour of a
>> new flag.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  Documentation/netlink/specs/mptcp_pm.yaml         | 4 ++--
>>  include/uapi/linux/mptcp_pm.h                     | 4 ++--
>>  net/mptcp/pm_netlink.c                            | 4 +++-
>>  tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
>>  4 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/netlink/specs/mptcp_pm.yaml
>> b/Documentation/netlink/specs/mptcp_pm.yaml
>> index
>> d1b4829b580ad09baf4afd73b67abd7b4ef6883a..fc47a2931014c0304efd3215cc2
>> 4485ea22e1ede 100644
>> --- a/Documentation/netlink/specs/mptcp_pm.yaml
>> +++ b/Documentation/netlink/specs/mptcp_pm.yaml
>> @@ -28,13 +28,13 @@ definitions:
>>            traffic-patterns it can take a long time until the
>>            MPTCP_EVENT_ESTABLISHED is sent.
>>            Attributes: token, family, saddr4 | saddr6, daddr4 |
>> daddr6, sport,
>> -          dport, server-side, [flags].
>> +          dport, [server-side], [flags].
>>        -
>>          name: established
>>          doc: >-
>>            A MPTCP connection is established (can start new
>> subflows).
>>            Attributes: token, family, saddr4 | saddr6, daddr4 |
>> daddr6, sport,
>> -          dport, server-side, [flags].
>> +          dport, [server-side], [flags].
>>        -
>>          name: closed
>>          doc: >-
>> diff --git a/include/uapi/linux/mptcp_pm.h
>> b/include/uapi/linux/mptcp_pm.h
>> index
>> 7359d34da446b94be148b363079120db03ba8549..bf44a5cf5b5a1e6d789632682a9
>> bedbf8090feb9 100644
>> --- a/include/uapi/linux/mptcp_pm.h
>> +++ b/include/uapi/linux/mptcp_pm.h
>> @@ -16,10 +16,10 @@
>>   *   good time to allocate memory and send ADD_ADDR if needed.
>> Depending on the
>>   *   traffic-patterns it can take a long time until the
>> MPTCP_EVENT_ESTABLISHED
>>   *   is sent. Attributes: token, family, saddr4 | saddr6, daddr4 |
>> daddr6,
>> - *   sport, dport, server-side, [flags].
>> + *   sport, dport, [server-side], [flags].
>>   * @MPTCP_EVENT_ESTABLISHED: A MPTCP connection is established (can
>> start new
>>   *   subflows). Attributes: token, family, saddr4 | saddr6, daddr4 |
>> daddr6,
>> - *   sport, dport, server-side, [flags].
>> + *   sport, dport, [server-side], [flags].
>>   * @MPTCP_EVENT_CLOSED: A MPTCP connection has stopped. Attribute:
>> token.
>>   * @MPTCP_EVENT_ANNOUNCED: A new address has been announced by the
>> peer.
>>   *   Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index
>> 483ddbb9ec406a3e965376ee5a833ae295896a02..33a6bf536c020b59717472aca2d
>> 38add26255419 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -413,7 +413,9 @@ static int mptcp_event_created(struct sk_buff
>> *skb,
>>  	if (err)
>>  		return err;
>>  
>> -	if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, READ_ONCE(msk-
>>> pm.server_side)))
>> +	/* only set when it is the server side */
>> +	if (READ_ONCE(msk->pm.server_side) &&
>> +	    nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1))
> 
> In patch 2, this will be modified to use two 'if':
> 
> 	if (READ_ONCE(msk->pm.server_side)) {
> 		flags |= MPTCP_PM_EV_FLAG_SERVER_SIDE;
> 
> 		/* only set when it is the server side */
> 		if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1))
> 			return -EMSGSIZE;
> 	}
> 
> Why don't we just use two 'if' statements here, which will make patch 2
> simpler:
> 
>        if (READ_ONCE(msk->pm.server_side)) {
>                /* only set when it is the server side */
>                if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1))
>                        return -EMSGSIZE;
>        }
> 
> WDYT?

I'm not convinced: that might make the patch 2 simpler, but then the
patch 1 will raise questions from reviewers and developers looking at
the patches in the order they have been sent: why using 2 'if'
statements while there is no need to use 2.

If we want that, I would have to add something in the commit message. I
don't think that's worth it.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

