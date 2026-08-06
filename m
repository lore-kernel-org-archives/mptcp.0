Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8203379960
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034802; cv=none; b=ifoddDsa9i3S8PsrfDulBvtHrHLJ8RjZ649Pu4aLO23bEyzqtgjIMWhgDK1sHtb5XtiDSwJn2WSuZI5WuJEYCHSdFTB0Tt0PD10qQjqEU9aWtAO03uu25WxTjFjhXqnnU/5KPFwjwstuDqWb6F7QzX60sIbjQcCBWyPMulQtfEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034802; c=relaxed/simple;
	bh=73PjkmVxvGgNHF+lJCg53zVw6sB4ilPVti4TtsHuc+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UWoKXuqmHeEYLOnvYXFmB3rpciWmr+0bWYunU0Rx791PuZRZo2jSnJvgU3+nJs3VXieLIFTI9yEZyKJkj0gQnOPUw8Tek9RQ249tMTmObol5pSm4yFyIza++87245tbfy4E90elEE9lK/he8jW0T1NzqXKcO58M8gMwEUDK+Dck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnjQPSW+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnjQPSW+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380B11F00A3A;
	Thu,  6 Aug 2026 16:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786034796;
	bh=HEILB+hVmIf+AGLYg7yQOwLYR1h1+h8jh4vfqNXqMTI=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=QnjQPSW+MrqoItkd2GuOXZhbGiOxx4LChgiXtSsoLilB54gF7urHqkbiRtz4oTKYz
	 h0tyONJEayLNQehQKyjVw94uHvHfK1z7wDoTVohA77N36gtoWUk4FZHBl039Pv9Au4
	 rfg+YBXYHU583vHpDhC+gklxRu47QgGD/lyEjbd/HpFR3BtgfKWYt0BZP8BmdHXu28
	 0eRIZxkA3bABQQ0xfjyoa/S3VNEfS7Gcsshvx28X+XX8jdXEWeMRUC+Cn7hJKXSCpq
	 1ACQbteN3tIQi3CZNbSYd4FJ0dIbUQO5ZazbITz0fom30rZR2x49O7letAatQRkvGQ
	 Bv7yMRQMst0Mg==
Message-ID: <b0d961b3-7a06-4237-92b2-67d8ab2ff28b@kernel.org>
Date: Thu, 6 Aug 2026 18:46:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 mptcp-next 7/7] mptcp: implemented OoO queue pruning
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1786026372.git.pabeni@redhat.com>
 <be9dcbef291a424fdd54d19fc72f9f28fb239b81.1786026372.git.pabeni@redhat.com>
 <80572775-6e76-4c79-83e2-efdedbd3f3b8@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <80572775-6e76-4c79-83e2-efdedbd3f3b8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/08/2026 18:42, Paolo Abeni wrote:
> On 8/6/26 4:45 PM, Paolo Abeni wrote:
>> When moving incoming skbs in the msk receive queue and the latter
>> is above limits, prune it as needed quite alike what TCP is doing
>> at the subflow level. The main difference relies in the stop condition:
>> since MPTCP does not perform collapsing, it's better off dropping the
>> bare minimum to fit the (newer) incoming packet.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> Tested-by: Gang Yan <yangang@kylinos.cn>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> v<n> -> v<n+1>:
>>   - prune only for new data
>>   - reorganize the code to follow more closely TCP
>> ---
>>  net/mptcp/mib.c      |  1 +
>>  net/mptcp/mib.h      |  1 +
>>  net/mptcp/protocol.c | 81 ++++++++++++++++++++++++++++++++++++++------
>>  3 files changed, 73 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
>> index ef65e2df709f..2569385bab7c 100644
>> --- a/net/mptcp/mib.c
>> +++ b/net/mptcp/mib.c
>> @@ -87,6 +87,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>>  	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
>>  	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
>>  	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
>> +	SNMP_MIB_ITEM("OFOPruned", MPTCP_MIB_OFOPRUNED),
>>  };
>>  
>>  /* mptcp_mib_alloc - allocate percpu mib counters
>> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
>> index 9271205f682e..3a3425e258a7 100644
>> --- a/net/mptcp/mib.h
>> +++ b/net/mptcp/mib.h
>> @@ -90,6 +90,7 @@ enum linux_mptcp_mib_field {
>>  	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
>>  	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
>>  	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
>> +	MPTCP_MIB_OFOPRUNED,		/* MPTCP-level OoO queue pruned */
>>  	__MPTCP_MIB_MAX
>>  };
>>  
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 63f2c18bc01f..ec874d2ead6a 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -242,6 +242,65 @@ static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
>>  	return false;
>>  }
>>  
>> +/* "Inspired" from the TCP version; main difference: stop as soon as the MPTCP
>> + * socket is under memory limit.
>> + */
>> +static void mptcp_prune_ofo_queue(struct sock *sk,
>> +				  const struct sk_buff *in_skb)
>> +{
>> +	struct mptcp_sock *msk = mptcp_sk(sk);
>> +	struct rb_node *node, *prev;
>> +	bool pruned = false;
>> +	u64 mem;
>> +
>> +	if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
>> +		return;
>> +
>> +	node = &msk->ooo_last_skb->rbnode;
>> +
>> +	do {
>> +		struct sk_buff *skb = rb_to_skb(node);
>> +
>> +		/* Stop pruning if the incoming skb would land in OoO tail. */
>> +		if (after64(MPTCP_SKB_CB(in_skb)->map_seq,
>> +			    MPTCP_SKB_CB(skb)->map_seq))
>> +			break;
>> +
>> +		pruned = true;
>> +		prev = rb_prev(node);
>> +		rb_erase(node, &msk->out_of_order_queue);
>> +		mptcp_drop(sk, skb);
>> +		msk->ooo_last_skb = rb_to_skb(prev);
>> +
>> +		mem = (unsigned int)sk_rmem_alloc_get(sk);
>> +		if (mem <= sk->sk_rcvbuf)
>> +			break;
>> +
>> +		node = prev;
>> +	} while (node);
>> +
>> +	if (pruned)
>> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOPRUNED);
>> +}
>> +
>> +/* The stack can't drop packets for fallback socket at the msk level, or the
>> + * stream will break.
>> + */
>> +static bool mptcp_can_ingest(const struct sock *sk)
>> +{
>> +	return unlikely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk->sk_rcvbuf)) ||
>> +			__mptcp_check_fallback(mptcp_sk(sk));
> The above should obviously be: 'likely(...)'
> 
> @Matttbe: please LMK if you prefer a repost or you could adjust that
> while applying to the export branch.
No problem, I can adjust them when applying them (if there are no other
big modifications required, but I guess no).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

