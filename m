Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCD334B681
	for <mptcp@lists.linux.dev>; Tue, 21 Oct 2025 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067284; cv=none; b=XtvOHVrWgJYuvMRka4dZuKI7BJHiezo0Bc8qPT416xyMxkkuwlYvEZJgWGe8Oh400M+WeQSsig8gV7AoMywp38XslOELTQtAwgXFLgWnCl1zQ3qM82O4Ow5kP/+DIh8GNcUX9YHcjKqLNjt86TmTLdeKUADqh5sPRceKl9jqXKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067284; c=relaxed/simple;
	bh=YooX7ADDFGaXFIrPnW+G1rD4AU0WJrAU81h3qJmmi3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivZ+em67CuEvDF+Fos5sHnziwzr5KjwQKgWQxX8F3VUqF+JapmU/oK8Ej7Scgn4fw0epESlnubHeTwOVlHt/LLe7Mn4pdvt9IkU08aMWUJKl9Jw5zvV5hdHMop22GoMnpQiKMb+xZJLvVTblW38WiMSQesFvv6C0EVNVkl5u5Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FgkpZqqT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgkpZqqT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761067280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmDD7A+9eGVsbfDyqAIaqK3746AMS6SRG5H8irxCTw8=;
	b=FgkpZqqThJFP1XqAEnxrsl2RzFpl3rTHvCA+XF4QiOQdhbCQusnS9dZojdW7ouLYkB/VOg
	uMOrtQpOWN3Cex4PvNcdwwh7MYW832l07RQC7vASri7sKD9POFenPhWABoLMAvtV4w6jGo
	Nwf690104+7ailp+WMyy7SaRZKEOgCw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-EAcKJI9xNb6xsrCewcz0sw-1; Tue, 21 Oct 2025 13:21:17 -0400
X-MC-Unique: EAcKJI9xNb6xsrCewcz0sw-1
X-Mimecast-MFC-AGG-ID: EAcKJI9xNb6xsrCewcz0sw_1761067276
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-471201dc0e9so46225335e9.2
        for <mptcp@lists.linux.dev>; Tue, 21 Oct 2025 10:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067276; x=1761672076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmDD7A+9eGVsbfDyqAIaqK3746AMS6SRG5H8irxCTw8=;
        b=IYD7GTt0eXIvo42QkhaYl3ZVLnZEPFF/0ujM2fvazUlwI/EWGX0CYotSLkDKXLMsHW
         /7cgIBKoUogpy1hvtjCYx59PNxugzi6qnYe6E9t8vbypBb2yV4lzJRZ7MeXRgtMcfaeJ
         CN3O/yw34B5ylWgUlYKmKdy24pOUtVZQspxJ5ixQwgTbAmpNCiz0/Ng+z9sVKdg/qHEd
         V+guMuhsszChTJs2vk0GvuoL1t0P+3ulUqXA3gricNfZ0ZyoY5bfLRKUYlk82rjlU9hj
         JKU9RLJrEZkM0MFujK9qWArF5CHH3531vsBiMSovO7j1igF7zA+1GYwqBvqevtnkKzcQ
         lpzQ==
X-Gm-Message-State: AOJu0YwFD1TzcUIwkKK98SgDLAdPKwW6P0dFp6gwl/IEDN675FvMeJ9D
	qwJjVAxpGNx9p1G+OrJ9ySbG0YidjmupVG8oSos3WbOLdPqZrWY4lNfPtCO1gHsVahPoRCOTJI7
	9Btz8tNSO0IAOElFrgOoYERT+ndkyrRyhPpjMscOqVcZ79NkwEHRmVv4ot6oAyyl5
X-Gm-Gg: ASbGncv2r2p479dHLziSH/m2BM1GJS4RICysB1dg1o/mdF+mLZszKbXfuR8G4SHpdRf
	lMaeun8rriURpNI1OYqcxT6iqYqUXvRqameNFMkC/Qm7vt60aVlWXDB2WPek09t1CIQ2lTR8+LF
	72t8gt1vOQWUPjN5y9S5EX1TfqKidAb3f810AiczCfivu3XhXhGzdDxps4bNT0zuRWdVskfy4KZ
	IClkLVtdQz+CAnAWYFV1cDGd1uBX97j6rQGTwknXXm8zfrRBv01RyJ1y+vogflhHqvpFpaQptCf
	XZSiEVld0rNK+hid8f67cnNVaQATlOPoH4gCWM5iagH1l52wQECYJ4MJtsSOgDPI4hSdCJZarAE
	vNc6BxElQT+oJX0Kx2A9R/hNs828cuS2Dex/WCryN3W3KAi8=
X-Received: by 2002:a05:600c:3512:b0:46e:5b74:4858 with SMTP id 5b1f17b1804b1-47117877122mr103069955e9.13.1761067276069;
        Tue, 21 Oct 2025 10:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdwTsSWnmW43FxBaalAB1XsddVPeIoth7qwvlDE5/vwYqwVGIZIas5LAiYJ7xGj3jK+/AiKQ==
X-Received: by 2002:a05:600c:3512:b0:46e:5b74:4858 with SMTP id 5b1f17b1804b1-47117877122mr103069845e9.13.1761067275636;
        Tue, 21 Oct 2025 10:21:15 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9fa8sm21695535f8f.38.2025.10.21.10.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 10:21:15 -0700 (PDT)
Message-ID: <69af34f2-5a75-4a02-a183-9609cad4abae@redhat.com>
Date: Tue, 21 Oct 2025 19:21:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 mptcp-next 10/10] mptcp: leverage the backlog for RX
 packet processing
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1759737859.git.pabeni@redhat.com>
 <1cb19d6e65591b81610cc0dd8ef5d0a38605b3f1.1759737859.git.pabeni@redhat.com>
 <156d60d8-ee80-49fb-8b8e-d0be56f7a02a@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <156d60d8-ee80-49fb-8b8e-d0be56f7a02a@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Oo6Vp786Ta9dlpFVVv5FHQBXeTDSxwhxTOvrTx-uAFo_1761067276
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/25 1:32 AM, Mat Martineau wrote:
> On Mon, 6 Oct 2025, Paolo Abeni wrote:
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 2d5d3da67d1ac..a97a92eccc502 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
> 
> ...
> 
>> @@ -3509,23 +3519,29 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
>>
>> #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
>> 				      BIT(MPTCP_RETRANSMIT) | \
>> -				      BIT(MPTCP_FLUSH_JOIN_LIST) | \
>> -				      BIT(MPTCP_DEQUEUE))
>> +				      BIT(MPTCP_FLUSH_JOIN_LIST))
>>
>> /* processes deferred events and flush wmem */
>> static void mptcp_release_cb(struct sock *sk)
>> 	__must_hold(&sk->sk_lock.slock)
>> {
>> 	struct mptcp_sock *msk = mptcp_sk(sk);
>> +	u32 delta = 0;
>>
>> 	for (;;) {
>> 		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED);
>> -		struct list_head join_list;
>> +		LIST_HEAD(join_list);
>> +		LIST_HEAD(skbs);
>> +
>> +		sk_forward_alloc_add(sk, msk->borrowed_mem);
>> +		msk->borrowed_mem = 0;
>> +
>> +		if (sk_rmem_alloc_get(sk) < sk->sk_rcvbuf)
>> +			list_splice_init(&msk->backlog_list, &skbs);
>>
>> -		if (!flags)
>> +		if (!flags && list_empty(&skbs))
>> 			break;
>>
>> -		INIT_LIST_HEAD(&join_list);
>> 		list_splice_init(&msk->join_list, &join_list);
>>
>> 		/* the following actions acquire the subflow socket lock
>> @@ -3544,7 +3560,8 @@ static void mptcp_release_cb(struct sock *sk)
>> 			__mptcp_push_pending(sk, 0);
>> 		if (flags & BIT(MPTCP_RETRANSMIT))
>> 			__mptcp_retrans(sk);
>> -		if ((flags & BIT(MPTCP_DEQUEUE)) && __mptcp_move_skbs(sk)) {
>> +		if (!list_empty(&skbs) &&
>> +		    __mptcp_move_skbs(sk, &skbs, &delta)) {
>> 			/* notify ack seq update */
>> 			mptcp_cleanup_rbuf(msk, 0);
>> 			sk->sk_data_ready(sk);
>> @@ -3552,7 +3569,9 @@ static void mptcp_release_cb(struct sock *sk)
>>
>> 		cond_resched();
>> 		spin_lock_bh(&sk->sk_lock.slock);
>> +		list_splice(&skbs, &msk->backlog_list);
>> 	}
>> +	WRITE_ONCE(msk->backlog_len, msk->backlog_len - delta);
> 
> Hi Paolo -
> 
> Given the possible multiple calls to __mptcp_move_skbs() and that the 
> spinlock is released/reacquired (and the cond_resched) in the middle, 
> would it make sense to update msk->backlog_len for each iteration of the 
> loop so __mptcp_space() and mptcp_space() don't under-report available 
> space and mptcp_cleanup_rbuf() can make incremental progress?
> 
> I know we don't want to WRITE_ONCE() more than necessary, but it seems 
> like there won't typically be more than one loop iteration. In the cases 
> where it does repeat the loop that means data is arriving quickly and 
> reporting mptcp_space accurately will be important.

That WRITE_ONCE() is intentionally out of the loop, but not as an
optimization, but for a functional goal, similar to:

https://elixir.bootlin.com/linux/v6.17.4/source/net/core/sock.c#L3190

without it, in exceptional situation, the loop could run for an
unbounded amount of time.

Given this is MPTCP-level, and packets went already through the TCP
subflow possibly such scenario is even more unlikely, but I think it's
still possible and serious enough we want to avoid it.

WRT the receive buffer utilization, it should not change much, as either
on the backlog or in the receiver buffer, the skb should be accounted
for the whole truesize.

Cheers,

Paolo


