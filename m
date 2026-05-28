Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4D7384CFF
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985437; cv=none; b=MTfBGOHr2PA5kNmxpqCrTDq4xjP4dFR/7PiXV73MeH/Q0mEVsJhpsxbvAQvSs0XQVdXEvZcMLqsAp2RyU9On+Ej/cV70OSb9E+OVhu5y3VsH8qGTkTTlMcVt4EHv9NuHMAMkaE2G544m6+GaIhqmybo9DM6x7z0WctxzU4dgqDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985437; c=relaxed/simple;
	bh=AKCE9S+eYV41URoeRx5AvxWLG8u0Djm9cCV10iMRxdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cAS6Of26qhARJ8bMi4zlLSfhdnBrXF9USndYF+OQoYm/bgycsPL4YxixdF0hL4MxbeB/1JRxFMLXnqiJjPq0WErvVHSVpCquRjnFItmovoMywgxPq+/pC+7MasUHFBAxWS8XSBeBDwei45M2DsQPNPpiBE4g/6VSpxsaT0yUWHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=El+fv+fE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="El+fv+fE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779985435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECc0WgB1RxgJBFbIkn8gzokOQpHt0YaZoMc/sBikCmA=;
	b=El+fv+fECcIGiItS4SVcuISQJn6VtN7bkw3/HnNadPl5GYEWGc9lUBj7sP/t4taFdnBfgr
	jsGr2Id4LDwkqIF6daMR6OmvLmQdtL74RZ341nWDMLW0X8vF72ZInlK7HFLU2bm3LnPdN2
	pO3p10tSzz/z0hzRwSTPfAMEQlDNioE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-7MLpeE22O8uk3IHPdayhNQ-1; Thu, 28 May 2026 12:23:52 -0400
X-MC-Unique: 7MLpeE22O8uk3IHPdayhNQ-1
X-Mimecast-MFC-AGG-ID: 7MLpeE22O8uk3IHPdayhNQ_1779985431
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fe24773c8so68772245e9.3
        for <mptcp@lists.linux.dev>; Thu, 28 May 2026 09:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779985431; x=1780590231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECc0WgB1RxgJBFbIkn8gzokOQpHt0YaZoMc/sBikCmA=;
        b=J3XwCTWkmDtq8hJCRkVcWqdu683TYLO7Mk7kjoVLu097VPI1BVHKYgS/2IynPNqTo7
         Yc9LDJsuZQDnglS22dVLh6U5DCvJgJAQum1RnJdm61c6Sak26iJF1fL9zlu5H90Ye8xC
         WzMy9E+qyR+557Ct77nA0iHVbrX2NuO97Jq83dthPcmiVRPVusH3vPFj92O8P7M6tmPt
         Kv7vxqxs98aicX2yuBHin/7OO9ZLZ88hIDP8kzpowvHKEBbsZsd8MVyoCvxkl0bs5q61
         NPt9vyguU2au0gaNgpaSvop9+v7aMZRQJlSF4HA3O4yDkevcuUdMGIaeQ0/+SFiw0j47
         bEiw==
X-Forwarded-Encrypted: i=1; AFNElJ/99dUeJQ+fWB2ByxOg4Qm7111skuowRVx1EycezqGWyVSHbVOyZKnBLMcXkKcAhz3QEzE8tw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw42WKaEJvgfRmCwq6DB2o9nnbafsNn1MCvpQcKhqoZC5KMhY2L
	nbh7CP2s/A2ohPxYa1AwH1ybK+qB3rrIA5dDRiTM0wOho1UgAPtYsHE8ztAolz15/s6+qyzUhfc
	txmlnZ567TeuTwnaoF+Bf7OMLDw0cQconWSX8Pczdd/uHddLjyi77wm19gNZDXbky
X-Gm-Gg: Acq92OHN92/EkfBavUt1UFtmPgfSiwGzhV8ONAaR2inNcqGYCRkoPdGzmLfGc4yF/rN
	BgLl3afbXVmvnENwfT4P7bD40YnxFnf+TmyeWseM8ejtVWEs5GiCwZofQhC2EGgjy2NCU27zojI
	T69SIotHVL97lsB1cHqgemgDnah94OVLqKoJ3Fh29Mnu6xN6IRm+9Ky66VNgzi0WhMShxGhCgqS
	nyfrWX313bTioIsOwC+GA8zDpn9wl30nas/H3v7gimKBMLE5uAQYx+x83D7rK4SBEA8xIIeB71D
	XvoOgo3qaGOqv/E3WEg/x/h0EylMXccXP0jq6VaGz7ONlLGX/8GgNQaq0H3TD6GwhcKIN8iojqV
	7zUjygEqFd7LXu0jPe1BAxUf2wYZQgUx+5KXOcFTIMd9x4FAD5L1YAynzu57DJsytyQ==
X-Received: by 2002:a05:600c:821b:b0:490:845e:3a6 with SMTP id 5b1f17b1804b1-490845e0467mr120460845e9.25.1779985430727;
        Thu, 28 May 2026 09:23:50 -0700 (PDT)
X-Received: by 2002:a05:600c:821b:b0:490:845e:3a6 with SMTP id 5b1f17b1804b1-490845e0467mr120460485e9.25.1779985430253;
        Thu, 28 May 2026 09:23:50 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb54a432sm20490809f8f.3.2026.05.28.09.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 09:23:49 -0700 (PDT)
Message-ID: <62b724a5-2970-4438-80fe-2cb2caa8c603@redhat.com>
Date: Thu, 28 May 2026 18:23:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 mptcp-next 4/6] mptcp: implemented OoO queue pruning
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <cover.1779876523.git.pabeni@redhat.com>
 <94af7b55233828311a361cdd70b837805448218a.1779876523.git.pabeni@redhat.com>
 <f583b390-b5d3-4a4f-82a0-ecfb3bf71f9e@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f583b390-b5d3-4a4f-82a0-ecfb3bf71f9e@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MGXdcfhEyxTUtQ0W5mAPV2Ym0y2t2F-RdyEDJ0SdB98_1779985431
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/26 10:45 AM, Matthieu Baerts wrote:
> On 27/05/2026 20:45, Paolo Abeni wrote:
>> When moving incoming skbs in the msk receive queue and the latter
>> is above limits, prune it as needed quite alike what TCP is doing
>> at the subflow level. The main difference relies in the stop condition:
>> since MPTCP does not perform collapsing, it's better off dropping the
>> bare minimum to fit the (newer) incoming packet.
> 
> Thank you for the patch!
> 
> I have two small ideas below, but they are not blocking. If you think
> they are valid, feel free to add a Squash-to patch in the v10, or ask me
> to do the modifications.
> 
> I will apply the first 4 patches, adding this tag:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Plus this one only on this patch:
> 
> Tested-by: Gang Yan <yangang@kylinos.cn>
> 
> (...)
> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index b0a0c51e0a13..29cb10c02ed8 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -373,6 +373,45 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
>>  	skb_dst_drop(skb);
>>  }
>>  
>> +/* "Inspired" from the TCP version; main difference: stop as soon as the MPTCP
>> + * socket is under memory limit.
>> + */
>> +static void mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
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
>> +		if (after64(seq, MPTCP_SKB_CB(skb)->map_seq))
>> +			break;
>> +
>> +		pruned = true;
>> +		prev = rb_prev(node);
>> +		rb_erase(node, &msk->out_of_order_queue);
>> +		mptcp_drop(sk, skb);
>> +		msk->ooo_last_skb = rb_to_skb(prev);
>> +
>> +		mem = (unsigned int)atomic_read(&sk->sk_rmem_alloc);
> 
> Detail: why not using sk_rmem_alloc_get() here, like you did in
> __mptcp_move_skb(). Also there, sk->sk_rcvbuf is used with READ_ONCE(),
> but not here. Is it on purpose?

The READ_ONCE is omitted on purpose - this is under the msk socket lock,
can't race with write.

Raw sk_rmem_alloc access comes tcp code from C&P (inlining the
tcp_can_ingest() helper). I guess it could be replaced with
sk_rmem_alloc_get() for consistency.

>> +		if (mem < sk->sk_rcvbuf)
>> +			break;
>> +
>> +		node = prev;
>> +	} while (node);
>> +
>> +	if (pruned)
>> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFO_PRUNED);
> 
> Here, why not returning sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)
> ...
> 
>> +}
>> +
>>  static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>>  {
>>  	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
>> @@ -386,9 +425,12 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>>  	 */
>>  	if (unlikely(sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) &&
>>  	    !__mptcp_check_fallback(msk)) {
> 
> ... so here you can simply add mptcp_prune_ofo_queue(...) and not change
> what is below?

Looks good. Should I send a squash-to patch?

/P

