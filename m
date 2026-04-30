Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B32542EECE
	for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560692; cv=none; b=SNOhDuQZmOl3Cwldv5FJVkO5njCbjNMLM6bDOH1Z+tPh/vvXgGCjoMKhBPeZQSMmqXRqEEsPopKLMEFL5S26ioyGkJaGhVxrKXDrzqIrnFROVL5vvFlia/5ts/yQaGB7pmeEU+/YbT+w3XOVvwTU8sH2i+FpvAigJjwz7n5w+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560692; c=relaxed/simple;
	bh=COBVhiewa0Z6IF38Vif6Si89+CfYflIzkPYKo6HFZsY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cIwjg1up7dch0kywAqLi7t2pTkS8B+ekbFhwlSGMWr4QMbwkMYKWirJjS+w1RiQljmgIx12pnz2kwUZsTpjaOXHAlfH6W6wzTDSh0Fkq/GGUldyOvyv3q3vymypo/TKUNu0FukKHB1aR0pp/xGMIQCV/SXeOzq/0onWs/DMhl94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFQbilSa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFQbilSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7688CC2BCB3;
	Thu, 30 Apr 2026 14:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777560692;
	bh=COBVhiewa0Z6IF38Vif6Si89+CfYflIzkPYKo6HFZsY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=qFQbilSaNHmZmbZ3VRRAInuf8QGaHi1XpkytadZvlhc0qh4tYJ4cWxAO9mGfIeG+H
	 6KN1BlZHZxTz2xAGvzAfgVlVhiWsCGYDg1u7xm6a+58CQ35Z6oL2p4BhldQl4Zbv4v
	 aHXZfjveMymypnN4Z374R1zMSAFaU+vKHADN6FsHjBRvHVh1x17gaQUZjsrYcHSrnY
	 3ccm/umMAyJNZC63YQoqQ/Www+5ZGAuOPSwEiCKwZN7Uz1ngJnTG9v94q+tH6GvrFM
	 8PcJ80Y7SOpa6N3A/UT39VepSagp3wwOW4RxMqxPFfe/z0p3caU994kIK98sAh6CUJ
	 JBVhFyQdol1DA==
Message-ID: <43bd881a-4e98-46df-875a-c34f9b637fb8@kernel.org>
Date: Thu, 30 Apr 2026 16:51:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: fix rx timestamp corruption on fastopen
Content-Language: fr
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <eaeec8e58b36820e2c592b7a88681f3c188cb64a.1777460572.git.pabeni@redhat.com>
 <177755934008.1566930.11036454276948716689.b4-review@b4>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <177755934008.1566930.11036454276948716689.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 30/04/2026 16:29, Matthieu Baerts wrote:
> On Wed, 29 Apr 2026 13:06:02 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
>> The skb cb offset containing the timestamp presence flag is cleared
>> before loading such information. Cache such value before MPTCP CB
>> initialization.
> 
> Good catch, thank you for the patch!
> 
>>
>>
>> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
>> index 82ec15bcfd7f..082c46c0f50e 100644
>> --- a/net/mptcp/fastopen.c
>> +++ b/net/mptcp/fastopen.c
>> @@ -40,12 +41,13 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
>>  	 */
>>  	tp->copied_seq += skb->len;
>>  	subflow->ssn_offset += skb->len;
>> +	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
>>  
>>  	/* Only the sequence delta is relevant */
>>  	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
> 
> From sashiko:
> 
>   Does this assignment result in a zero-extension issue?
> 
>   While not introduced by this patch, since skb->len is an unsigned int,
>   applying the unary - operator results in a large positive unsigned int rather
>   than a negative value.
> 
>   When this is assigned to map_seq, which is a u64, it gets zero-extended
>   instead of sign-extended. Downstream in mptcp_inq_hint(), the calculation:
> 
>   READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq
> 
>   could underflow if msk->ack_seq is 0, resulting in a massive 64-bit value.
> 
>   Could this trigger a fallback where ioctl(FIONREAD) falsely reports INT_MAX
>   bytes available?
> 
>   If a peer sends a TCP Fast Open SYN packet with a payload, server
>   applications querying FIONREAD might attempt a 2GB allocation and crash.
> 
>   Should this be explicitly cast, such as -(u64)skb->len, before negation?
> 
> It looks like it didn't get that map_seq will be += skb->len later.

Wrong explanation: if it is += skb->len later, it will not be back to 0
without the cast.

@Paolo: do you remember why it is set to -(u32)skb->len here?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

