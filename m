Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712005;
	b=zXSk8pa//ZGnG0bmYutDAEsDRrC8RUUt37gDT3dgIyE9vpt10op6VfO6e9LUkvY6v/ud
	 HmMRwuxoD/G2tJdFtYaf85BOvqlV3yr0b2q1QwqoP+qCAx71HW9+sCHCMEGSU10AspTjF
	 sV25H5+qanEqAIx4PjMouTET9sH7kqScPq6RwkFtzj9qvKndemfJprf4WLPXzdb4dmz+l
	 jl5rBQu0c0WSE0+eVkOuy6qrPHqPxMLHgJ88Nr9nhQ8xEsnlELY4sdNuVjgcJwkcBkTwi
	 aXCSnyFVrL/SFKrPvMuI0VpQ+SnppGI73yZwOrxWATcG96iImiBT65EViIZFY7XxLpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712005;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Cc:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=bd45wiOajzgLB8+XZmYdlEmTEig8tS3+F/qOAFOI1wo=;
	b=v2yaSxJf6GNw30nh3s+kaJBqf1p7VUFb34MNY6ij+LSkYRwXZeP/0O1JOgcXOouEyZvQ
	 qhZ7eyq53RaYwgc8e11B/qdm2mfqAi0WGt8scCJbWNi42MVWJiQNZvnvAYgRm9oYTyPgH
	 hWG1JUH5Iz/UcKBotgERaQJKbbkZvWdsVwCaLAlDoNmskukHrUc9ffTCXUA6DuXSmKdXy
	 LLgCVjNQoT9laL5UI7bOQ6P3z4qltvr+J/WXsZxCehZcCtpgzT+inmyo8Xnvuo5UKSo12
	 lChF/MHS3VqCx/9EHgux95Zs3AhT7LQ5e3uLFpInkoY1u0gQsMYZ1NmlzjbX+kacbXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECv2Oa9S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C729606A31C;
	Thu, 26 Nov 2026 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECv2Oa9S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8063F1F000C4;
	Thu, 26 Nov 2026 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795712005;
	bh=bd45wiOajzgLB8+XZmYdlEmTEig8tS3+F/qOAFOI1wo=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=ECv2Oa9SzY7rsSfNIeJXAw+4n4OBebQiDnXfPwYKf6eR8H0XhJFpOY7ActmRl54fJ
	 YYmtAKJQIrAs0G83FbTrdGcowXl299xIU+fgetl2nelYgZJ7FpxSXHGgDhJoWoJqck
	 aB0rs21KEJBJe/x7YqDCV7jPOZl25oNSnk3WPvAB3iMlS9OhhUYBgZj7v4bxU8zOnz
	 F/f3WSFPv3zEZ3oH1t5AK/t2LI5BZsYlUCiSLx4UIPU8rooiqW+EUhTXEnRagoaVl6
	 85R7nb8c5WbXlA+R9fXbHmpbf8jkFXDjQGoAVtGE5ZvkMKTqyyPnRt5e3mS8XiloTA
	 8Z43mFV5fPCxQ==
Message-ID: <9ff56380-0de5-470b-a1a4-d89d752c6e16@kernel.org>
Date: Thu, 26 Nov 2026 17:53:22 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3 29/50] mptcp: don't resend data acked without
 MPTCP opts
Content-Language: fr
To: sashiko-reviews@lists.linux.dev
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
 <20261124-mptcp-cmason-fixes-v3-29-416c0920c73f@kernel.org>
 <sashiko-outbox-232141@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <sashiko-outbox-232141@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/2026 23:36, sashiko-bot@kernel.org wrote:
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index f9b65d0c6290a..05b9c66aaed63 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
> 
> [ ... ]
> 
>> @@ -1287,11 +1291,16 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>>  	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
>>  		return sk->sk_state != TCP_CLOSE;
>>  
>> -	/* MPTCP opt acking the old data, not an infinite map: no fallback */
>> -	if (unlikely(subflow->old_data_pending) && mp_opt.suboptions &&
>> -	    !(mp_opt.use_map && !mp_opt.data_len) &&
>> -	    !before(TCP_SKB_CB(skb)->ack_seq, subflow->old_data_end))
>> -		subflow->old_data_pending = 0;
>> +	/* MPTCP opts, not an infinite map: the peer did not fall back */
>> +	if (mp_opt.suboptions && !(mp_opt.use_map && !mp_opt.data_len)) {
>> +		u32 ack_seq = TCP_SKB_CB(skb)->ack_seq;
>> +
>> +		if (after(ack_seq, subflow->opt_ack_seq))
>> +			subflow->opt_ack_seq = ack_seq;
>> +		if (unlikely(subflow->old_data_pending) &&
>> +		    !before(ack_seq, subflow->old_data_end))
>> +			subflow->old_data_pending = 0;
>> +	}
> 
> [Severity: Medium]
> Can calling check_fully_established() before updating subflow->opt_ack_seq
> falsely reset a passive TFO subflow?

The push done there for a TFO child only sends new data: no resend nor
probe, so no reset. No need to change, but I can clarify the commit message.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

