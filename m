Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B134BA3F
	for <mptcp@lists.linux.dev>; Wed, 17 Sep 2025 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126155; cv=none; b=lnQFWROS1ORt8LU+4nLgBwXps1TYPfk5bk0Ibs3xZm8Qxmac347NIv5Fe6uQtLRUvuH2wITYyEt0BZZJdfwyqGe0c8EQC1WM+i0ldSqZY/rjXjQoR3F2f/SmPmEr5s/CfBkPAvnE00zfRwBMXPxGLj8H3HUYC+VEuJZjC8lOIak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126155; c=relaxed/simple;
	bh=kW16OeM050hdQqzorhXmCj1PBYsO8pA2Cab8/rnxymA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d5bwFxOJ7VsSYJVWJvUcYqrfGnwyCdfZlZRi2d5nUW1eGHov9BrmV2RMxAIbDRBK1vv7wee2/GqjagYDavFiHpwv7xv7Ih2BONYcM19kXpZ/8nFo1ejDbLqMsICq5fooZu0qI+rZhGnrmgA2RKXpLGCjIQlT2C+RaNGaTKzuHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0yWlvL/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0yWlvL/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758126152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3MNqtLKP7wasLTCYo3zALeksXkINPwwIuN6TLGU0ec=;
	b=B0yWlvL/yLhW8UlbfNC1BgC65p6VWQ2RyfTyuB5SeQGrmoYPrIC9rLNZ+e9pDbG6RSDyDr
	+5ZAY8on3il4n6ojIvPoP82muzA+v15lglCuZZt8t3AMZXJ/2LWGUeU31WDZV7hrNsInHD
	FbC/AGLZRhg73UeuqxECS0vjL0RpIxw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-gSbyklglNP-mZLGEYRpvOA-1; Wed, 17 Sep 2025 12:22:31 -0400
X-MC-Unique: gSbyklglNP-mZLGEYRpvOA-1
X-Mimecast-MFC-AGG-ID: gSbyklglNP-mZLGEYRpvOA_1758126150
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45dd66e1971so57087125e9.2
        for <mptcp@lists.linux.dev>; Wed, 17 Sep 2025 09:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758126149; x=1758730949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3MNqtLKP7wasLTCYo3zALeksXkINPwwIuN6TLGU0ec=;
        b=j5aWKjahPliubzAUgjPD3hIbK9/D7YYavU0LTap3i4GDNoi06NnAjjzNtH3KCpbf32
         vE3mZX4ET/bEmtLsk6ZmtmokiONl2Gwr61z9zlbqO9KNW/B2FJoeSV7KCdlCxQPngRjg
         Om+EVoWNkr55klLHLkMXsCg8c+4Lw/IbRojyRzpXhvr/ssuSNuHb9L1GbeQ/IxUlURdY
         B6B88ZM8snR6271VJ/svHuKQbKSt8Vzfkn7j/gSUSHLKn7f+Bzs8Fpw5DCbpf9AXFJw2
         P2SrLauHYlvYaoJuOJ9jQoEzmZRA6aK/R+LVpNJHoRtEKNAFUUjRwGlYXl2XBjYNmSlD
         h6dA==
X-Forwarded-Encrypted: i=1; AJvYcCX9w6QejTANFWYOq/P19Jc6AcpNm/oalIVJttiEfCyAGNNivnxdPkkwAljvwSyTEXQXo8SOUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YznLNLHMGPQEFAgTpRZFQXPP/GPsscRbEJqlfVw7OMeB8v6LHWj
	E23LKCtaDPoyn1/PxOTGXMVVHRJqRCKDC8NIrdwxwdQwL2iBLvf7MfQ/AOTTQF9jZN97qt/+7VX
	rmPYJ+YX7a38czk7kDvFGfF7ju4l1VCtl18+RTSzfDVVKD4wMCfTmDZJszFHvUOpg
X-Gm-Gg: ASbGnctn0+z2msqbcW2PRSCJt+4VbiwPnFim7GbgnWFThh3hAKCyKtttdY97UFhFbtn
	wD6o0ZQGFRW/fo9d3Jmr4yr0Y3Enkot5ZYDcI3YK1+CWKaMf0oCJ3zn7ViqCRc0OhgOSCoQsQIj
	8eGD4q4X5WSRiNMqzpVh9njEr0cBuVkkk/KKdroXMyNxk6KlmRJu+aGswuW/OZyITrSFYAs6Fuq
	XaYUqXHCFFlRFNUs1VTqvM+RXsMu4Z1JQ1VsVh5GOmemskWHcMtmQzqwhmpluKC50MG8jEa8VuU
	ZZLeE2jNhoI6xUgjhGOBA41Q9hIknOM/wL5w718Fxg9UMLcyjWOHdSYKoRhAc3HW11zIEizMILa
	cV1m+JKudA1uU
X-Received: by 2002:a05:600c:470f:b0:458:b01c:8f with SMTP id 5b1f17b1804b1-46201f8a42amr31664865e9.8.1758126149416;
        Wed, 17 Sep 2025 09:22:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSNZ8vPUmfWm1HPbHc16JtokIlOeUqyjo+1zdJWm72y2u6H2qjfIJn5kQ5SZUHF6b3TAmajA==
X-Received: by 2002:a05:600c:470f:b0:458:b01c:8f with SMTP id 5b1f17b1804b1-46201f8a42amr31664525e9.8.1758126148962;
        Wed, 17 Sep 2025 09:22:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdf0bbf24sm3496229f8f.63.2025.09.17.09.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 09:22:28 -0700 (PDT)
Message-ID: <75975b2c-e3a7-4d13-8ec5-10e1e03685e2@redhat.com>
Date: Wed, 17 Sep 2025 18:22:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [MPTCP next 04/12] mptcp: introduce the mptcp_init_skb helper.
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <cover.1758039775.git.pabeni@redhat.com>
 <e070cc84b7d00a3b0ec31f95c810fe2e7bf85059.1758039775.git.pabeni@redhat.com>
 <bb6f1b55c71e6af09b363d27990e14640436dcfc.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <bb6f1b55c71e6af09b363d27990e14640436dcfc.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9xCHx9ZLGaYLaTVpgsIwvqq13aUfFnWX-_JGsxPRfo8_1758126150
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/17/25 9:48 AM, Geliang Tang wrote:
> On Tue, 2025-09-16 at 18:27 +0200, Paolo Abeni wrote:
>> Factor out all the skb initialization step in a new helper and
>> use it. Note that this change moves the MPTCP CB initialization
>> earlier: we can do such step as soon as the skb leaves the
>> subflow socket receive queues.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  net/mptcp/protocol.c | 46 ++++++++++++++++++++++++------------------
>> --
>>  1 file changed, 25 insertions(+), 21 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 671c51cb9539c..879157a1f4fb1 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -323,27 +323,11 @@ static void mptcp_data_queue_ofo(struct
>> mptcp_sock *msk, struct sk_buff *skb)
>>  		mptcp_rcvbuf_grow(sk);
>>  }
>>  
>> -static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock
>> *ssk,
>> -			     struct sk_buff *skb, unsigned int
>> offset,
>> -			     size_t copy_len)
>> +static void mptcp_init_skb(struct sock *ssk,
>> +			   struct mptcp_subflow_context *subflow,
> 
> subflow and ssk parameters are redundant, we can just use ssk.

I added the subflow argument explicitly since the caller already had it
handy to avoid an additional mptcp_subflow_ctx(). Perhaps the compiler
is smart enough to generate the same code, let me try...

> 
>> +			   struct sk_buff *skb, int offset, int
>> copy_len)
>>  {
>> -	struct mptcp_subflow_context *subflow =
>> mptcp_subflow_ctx(ssk);
>> -	struct sock *sk = (struct sock *)msk;
>> -	struct sk_buff *tail;
>> -	bool has_rxtstamp;
>> -
>> -	__skb_unlink(skb, &ssk->sk_receive_queue);
>> -
>> -	skb_ext_reset(skb);
>> -	skb_orphan(skb);
>> -
>> -	/* try to fetch required memory from subflow */
>> -	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
>> -		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
>> -		goto drop;
>> -	}
>> -
>> -	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
>> +	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
>>  
>>  	/* the skb map_seq accounts for the skb offset:
>>  	 * mptcp_subflow_get_mapped_dsn() is based on the current
>> tp->copied_seq
>> @@ -355,6 +339,24 @@ static bool __mptcp_move_skb(struct mptcp_sock
>> *msk, struct sock *ssk,
>>  	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
>>  	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
>>  
>> +	__skb_unlink(skb, &ssk->sk_receive_queue);
>> +
>> +	skb_ext_reset(skb);
> 
> skb_orphan(skb) call was moved from here to after mptcp_init_skb(), but
> was then completely removed in patch 11. I'm a bit confused by this. I
> think it might be better to retain skb_orphan(skb) call here. Or
> perhaps the addition of skb_dst_drop(skb) has made skb_orphan(skb)
> unnecessary. I'd like to consult on this point.

Patch 11 replaces the skb_orphan() call with an open-code optimized
version of it, as skb_orphan() in this case is really just a skb_rfree()
I'll expand the commit message in patch 11 to make it clearer.

> 
>> +	skb_dst_drop(skb);
>> +}
>> +
>> +static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sk_buff
>> *skb)
> 
> The parameter 'msk' was changed to 'struct sock *sk' in patch 9. We can
> directly adopt 'struct sock *sk' here as well.

Will do.

Thanks,

Paolo

