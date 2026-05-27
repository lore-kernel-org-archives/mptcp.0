Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1AC3DFC88
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876117; cv=none; b=A/A3mYVGkInLdNVdBhVutxQw/Pe38y1UeSrVDl+qjxAYz4EqrR4K3PT6Orp1xaXaUSAqXWkc0cxhZXsC3dJhKFBVIYfO+ig6DoIUq9ORBKq5MPaGif7OYjJwJEuXVUda+q3L0sN5MhyOS+Du/O58Ee09wECtZLIECEdLzfFQjOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876117; c=relaxed/simple;
	bh=jBKdwosuabF1oZ5I5d6AMauLEn+1tMWYbdxKfsmg2Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=ck48oAOZxX1a/G6g73lqLRQf5TGnpRGqncHIEd5NNS0zf14rKmcHalwWWQTJSoCwl35i1OTH5a9GTDzljxLx8PNb+LDQW75JfE9gsOCCrlNKOaHnyUajc/Kef4JR/899jBbBSTMHJDRLhYdQ+6WzxYjmXKh3VLMaeBjlxpqZwO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dlp3/0S/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dlp3/0S/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779876113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzbSyLr7XrEWvjUv5+wSw4Zp51YHrkCVSH4WUGMeDKw=;
	b=Dlp3/0S/XMxSWk2PJpaOWaiJs1CLHN5mjZQO8WzGg/uOnDrN0V8s0HXLVLRsjW4QZ2uLSh
	id1N1Psa7mPU5bDTvH3mhotvJlczQD0QUbdPneUWDZ8BLyxdM0ZpSqxoEpSwOURp5344yc
	2agFc8V2qlYUlCma4yV5zBGlXwy4xtk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-WtZ8DCOxMkaUAmMomjfplQ-1; Wed, 27 May 2026 06:01:52 -0400
X-MC-Unique: WtZ8DCOxMkaUAmMomjfplQ-1
X-Mimecast-MFC-AGG-ID: WtZ8DCOxMkaUAmMomjfplQ_1779876111
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bd2a8eb9281so1322525166b.3
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 03:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779876111; x=1780480911;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lzbSyLr7XrEWvjUv5+wSw4Zp51YHrkCVSH4WUGMeDKw=;
        b=DgA4megaweMVq6IdRl0SaFtWmGI69v5xZ6vdohSPkJAMrmE0f4E1IeoekbAnABt9qi
         dSGt4lP31ggwtd8Z7fwPuNzmBKlV8wrLgAGrZGb+o6qhImjGpLJtIhCDjOnpyNsspje/
         lGiGRwTK7qf+ayvgpGhEczfcK6puoXXFopRCKouAL5loHDpBsVQ/U9uZyhffEA7X8rvj
         8WY0YEtwUiK6nZJsLJ7NrXcuT30f+Qu1HlAoiB14XlBblCauAkJlobxtXP+fi2xuv3eR
         ObgagT/lQVM7UyDSpt+/bHqogfNKaSUqD9oKUtzbRuc1wZWf3X0P/eO+ytLTKQ0TPtX3
         NFlg==
X-Forwarded-Encrypted: i=1; AFNElJ+/QawwG73bcVbSjDm9Y78fTY2QU4+DTjhmJ01rCC+LMBW9ndDMAj2KVA0SiRoRwgVqC5L0Bg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHuZZTBNhNd6RHZwjqQ9PBaljk8yB2zVpBQvGttLvPnm+Se3Y4
	gxuAMNtgyGEIG47dBBRkrp8CMxm+aY4Yz37FpTTjna1+QMnhogOFtYggICI0J8kSyiQNawdKqzK
	Pb8h9FRThtbZq+rjRwrX0gukV6W2fO80Vbt7D8ypifxqrnvcK8MQh8qhATs5tDPnA
X-Gm-Gg: Acq92OEvp/sVEnAlyw07Krv/0cOjtpMJN1u0CHGiQ5IVASzAB4qjimiP/gBkLYa5vSx
	ZMIOhXdx1Rvfeoxf+muKo5vjnQAOOPpauw7xKiGAFCg/pk5BKpRLeYcc+Ak9VqxLLYy/UK/e7m2
	bvd2WxTScBrWgieg2FVM+99B2dLUa8AtrkxyBMigdzCr96g/ztpX83UeN/mfLeW3mTtPkp9/OIx
	m4+dk6VauFkuR2LKRhT4H/BPd6CSSUrpaiq4FN0ZRjZGKcqQc7ramjx7TjKfHYT/NraVIrdmc8s
	qYyjbRNJKgfRoZlhrABkmFpdCazcSz7HeQW5xlAFyRUrxqnjxvR9p4inAbw1BgLTMmdC5KHm1i4
	CSG78G1TLoaOYQo1F9efhXJXwNUYL3IBPWTQDe7QFwoN7tHdEYQLcmFNkrsx/wmFqcULK
X-Received: by 2002:a17:907:1c02:b0:be2:cf3b:acb0 with SMTP id a640c23a62f3a-be2cf4aef94mr424938566b.12.1779876110935;
        Wed, 27 May 2026 03:01:50 -0700 (PDT)
X-Received: by 2002:a17:907:1c02:b0:be2:cf3b:acb0 with SMTP id a640c23a62f3a-be2cf4aef94mr424916466b.12.1779876108455;
        Wed, 27 May 2026 03:01:48 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a2908sm4833139f8f.18.2026.05.27.03.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 03:01:47 -0700 (PDT)
Message-ID: <76116a98-e6c3-4991-b4cd-d52c354e01ca@redhat.com>
Date: Wed, 27 May 2026 12:01:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 mptcp-next 7/9] mptcp: implemented OoO queue pruning
To: gang.yan@linux.dev
References: <cover.1779485511.git.pabeni@redhat.com>
 <b67f85e91abafcdc87d4b0b8e479f715489ed6f2.1779485511.git.pabeni@redhat.com>
 <9c1d28dbc379eff6cc09e9b02a6b77beafcdc4f2@linux.dev>
 <1445abca-9a84-46df-be7d-8f7b656772a1@redhat.com>
 <6d38bd40e238fa4e578a629e8db789f36fc46ebb@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Geliang Tang <geliang@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
In-Reply-To: <6d38bd40e238fa4e578a629e8db789f36fc46ebb@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PLDhYr6srX5q0nYHVwdqnztZ0Ts0PWx1hP6aSAHOUlA_1779876111
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/27/26 7:30 AM, gang.yan@linux.dev wrote:
> May 26, 2026 at 2:50 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@redhat.com?to=%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:
>> On 5/26/26 5:13 AM, gang.yan@linux.dev wrote:
>>> May 23, 2026 at 5:43 AM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@redhat.com?to=%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:
>>>> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
>>>>  index ef65e2df709f..d9bd4f4afcc0 100644
>>>>  --- a/net/mptcp/mib.c
>>>>  +++ b/net/mptcp/mib.c
>>>>  @@ -87,6 +87,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>>>>  SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
>>>>  SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
>>>>  SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
>>>>  + SNMP_MIB_ITEM("OfoPruned", MPTCP_MIB_OFO_PRUNED),
>>>>  };
>>>>  
>>>>  /* mptcp_mib_alloc - allocate percpu mib counters
>>>>  diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
>>>>  index c84eb853d499..18f35f7e0a2d 100644
>>>>  --- a/net/mptcp/mib.h
>>>>  +++ b/net/mptcp/mib.h
>>>>  @@ -90,6 +90,7 @@ enum linux_mptcp_mib_field {
>>>>  MPTCP_MIB_WINPROBE, /* MPTCP-level zero window probe */
>>>>  MPTCP_MIB_BACKLOGDROP, /* Backlog over memory limit */
>>>>  MPTCP_MIB_RCVPRUNED, /* Dropped due to memory constrains */
>>>>  + MPTCP_MIB_OFO_PRUNED, /* MPTCP-level OoO queue pruned */
>>>>  __MPTCP_MIB_MAX
>>>>  };
>>>>  
>>>>  diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>>  index 03d6f8658467..f446e22148b9 100644
>>>>  --- a/net/mptcp/protocol.c
>>>>  +++ b/net/mptcp/protocol.c
>>>>  @@ -373,6 +373,43 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
>>>>  skb_dst_drop(skb);
>>>>  }
>>>>  
>>>>  +/* "Inspired" from the TCP version */
>>>>  +static void mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
>>>>  +{
>>>>  + struct mptcp_sock *msk = mptcp_sk(sk);
>>>>  + struct rb_node *node, *prev;
>>>>  + bool pruned = false;
>>>>  + u64 mem;
>>>>  +
>>>>  + if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
>>>>  + return;
>>>>  +
>>>>  + node = &msk->ooo_last_skb->rbnode;
>>>>  +
>>>>  + do {
>>>>  + struct sk_buff *skb = rb_to_skb(node);
>>>>  +
>>>>  + /* Stop pruning if the incoming skb would land in OoO tail. */
>>>>  + if (after64(seq, MPTCP_SKB_CB(skb)->map_seq))
>>>>  + break;
>>>>  +
>>>>  + pruned = true;
>>>>  + prev = rb_prev(node);
>>>>  + rb_erase(node, &msk->out_of_order_queue);
>>>>  + mptcp_drop(sk, skb);
>>>>  + msk->ooo_last_skb = rb_to_skb(prev);
>>>>  +
>>>>  + mem = (unsigned int)atomic_read(&sk->sk_rmem_alloc);
>>>>  + if (mem < sk->sk_rcvbuf)
>>>>  + break;
>>>>
>>>  Hi Paolo,
>>>  
>>>  Thanks for the v8. While going through the code, I ran into a
>>>  point that I'm not entirely sure about.
>>>  
>>>  TCP‘s design uses sk->sk_rcvbuf >> 3 (one eighth of the buffer)
>>>  as a goal. It we use sk->sk_rcvbuf here, the loop may break after
>>>  deleting just one packet, right? This may fail to free enough space
>>>  for the incoming out‑of‑order packet, leading to repeated pruning
>>>  calls and potential packet drops.
>>>
>> Thank you for your review.
>>
>> Yes, here there is some difference vs plain TCP and I think it's for the
>> better.
>>
>> TCP tries to make a "significant" amount of space in the receiver buffer
>> while MPTCP tries to make room for a single packet.
>>
>> Both strategies make sense in their respective context: TCP invokes
>> tcp_prune_ofo_queue() only after collapsing, and the latter is very CPU
>> intensive; if tcp_prune_ofo_queue() would make room for a single packet,
>> the next incoming one could still trigger collapsing and burn a lot of
>> CPU cycles (note that this bad chain of events could still happen if
>> sk_rcvbuf / 8 is not bigger than 2 packets).
>>
>> MPTCP (intentionally, as per discussion in the last iterations here)
>> does not perform collapsing, and directly does pruning when over limit.
>> Pruning is relatively cheap - computational complexity wise we could do
>> it for each incoming packet with "no issues", at least compared to
>> collapsing.
>>
>> Dropping the minimal amount of packets to fit the incoming one, allows
>> MPTCP to minimize the need for reinjections (for packets already acked
>> at the TCP-level, which we really should avoid). I think overall this
>> compromise is a better fit for MPTCP.
>>
>> BTW did you have the chance to perform testing on top of this revision?
>>
> 
> Hi Paolo,
> 
> Yes, I've tested v8 many times — hundreds of runs. And the tls.c part works
> fine too.
> 
> I also spotted some issues with MPTCP TLS adaptation, but those are unrelated
> to v8. I'll reply in Geliang's thread about them soon.

Thank you for testing. I'll send a v9 to try to get sashiko comments on
remaining patches, but no real changes in it. Feel free to add your
formal Tested-by tag, if you want :)

Thanks,

Paolo

