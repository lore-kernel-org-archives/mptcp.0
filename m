Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E11023A9
	for <mptcp@lists.linux.dev>; Wed, 22 Jan 2025 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545236; cv=none; b=LIRY09Rfh63x6aEnGOFar82K2LYpGXtJmaBDa5nLbFMbrSdAaBejHGZrWbovJTngWDoXFcOUKUBHIb6AbwWlT0NtWTvAwvOQTS1RhqLPTSxzvVkG5BPe9N/z1Vfgc3RVAf8klmTzbK9kjXfzOxH6kaiY6WooKh6pixO7n32QEMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545236; c=relaxed/simple;
	bh=Mj21JFZZTx9afjryb2/knqFu2g0lldESn7YXItcPIw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=De5QdNYEsdcYjTyJACIXoFZk6U3G4gGhj3y19NukIg1V1TBsyOkhnU3tC1Jw6DBuOUMtz8YCe60WF30884qGHJJ/xOgMjH1VNdTRHFbcFH9ZhgDgk8G+gJRIm4mq9WawgT4KLukF1f1oe3/Fr7TrKgIppgj43w388PFKm/5gAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyGOFQEi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyGOFQEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A46FC4CED6;
	Wed, 22 Jan 2025 11:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737545233;
	bh=Mj21JFZZTx9afjryb2/knqFu2g0lldESn7YXItcPIw8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nyGOFQEi08uXet0r/g1Vu2veMb2KVe36p9OLuKiu6gKoQSLpGLH5C362bDiRagirV
	 MTkRC55+kIgoETjC7wMk6fK1JmHuIaBL/Nz5G6TGX08sdlPXpwEpAt2QHE2+catdjs
	 GcIlGmxUmh5LcbNANfOuOcdAGMEUjuCqvQ5cNRCRkqhiiuJ/35zm9XE3CtZAyU+Ih2
	 H1BDeTBy91R/GtI4GQV9iymSj3iHq3LaMNO3EHV+r5ku0o6w99kHhh+2GxShRU/Lpg
	 7WXXRxdZYavV7dFp5fVO0AvSvblkj0RqN/ODk54CMMCRVtK641zrYAh71/LG785DtE
	 GknGWItmuj7Nw==
Message-ID: <1f4e97a3-8752-47a0-8b49-9d6a9c904c09@kernel.org>
Date: Wed, 22 Jan 2025 12:27:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] mptcp: drop __mptcp_fastopen_gen_msk_ackseq()
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <e96b1f70660ffd750c09c051991e2b65a7d1b492.1737398231.git.pabeni@redhat.com>
 <58a57216-3bc9-4ca5-9b08-70e85e9135ec@kernel.org>
 <28a55bdd-a362-49ad-a63a-e0e9367e47fc@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <28a55bdd-a362-49ad-a63a-e0e9367e47fc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 21/01/2025 15:31, Paolo Abeni wrote:
> On 1/21/25 12:55 PM, Matthieu Baerts wrote:
>> On 20/01/2025 19:39, Paolo Abeni wrote:
>>> When we will move the whole RX path under the msk socket lock, updating
>>> the already queued skb for passive fastopen socket at 3rd ack time will
>>> be extremely painful and race prone
>>>
>>> The map_seq for already enqueued skbs is used only to allow correct
>>> coalescing with later data; preventing collapsing to the first skb of
>>> a fastopen connect we can completely remove the
>>> __mptcp_fastopen_gen_msk_ackseq() helper.
>>
>> Thank you for having looked at that!
>>
>> It looks good to me, just one question below.

(...)

>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index b1ece280e139..2c1232bfd722 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>> @@ -130,7 +130,8 @@ struct mptcp_skb_cb {
>>>  	u64 map_seq;
>>>  	u64 end_seq;
>>>  	u32 offset;
>>> -	u8  has_rxtstamp:1;
>>> +	u8  has_rxtstamp;
>>> +	u8  cant_coalesce;
>>
>> Out of curiosity: while do you prefer to use a "full" u8, instead of one
>> bit in the previous u8, or a bool? Is it a small optimisation because
>> this new item is used in the fast path? We have free space there, so
>> that's fine, but just wondering :)
> 
> This is a minor optimization vs bitfield usage, I should have mentioned it.
> 
> With this patch, the 'cant_coalesce' field will be tested in fast path
> frequently - almost on every packet.
> 
> Testing a bitfield generates worse code - the CPU has to mask out the
> unrelevant bits. With u8 (or a bool) the CPU can load directly the
> relevant byte with a single operation. In a similar way, single byte
> store operations are faster.
> 
> Both u8 or bool could achieve the above. I preferred u8 because 'it was
> already there'.

Thank you for your reply! OK, that's what I had in mind, and not an
accident.

I can add this in the commit message when applying the patch, if there
is no objection:

To fix this, a new item has been added to the mptcp_skb_cb structure.
Because it will be frequently tested in the fast path -- almost on every
packet -- and because there is free space there, a single byte is used
instead of a bitfield. This micro optimisation reduces the number of CPU
operation to do the associated check.

Other than that, the modification looks good to me:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

