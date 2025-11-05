Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0A21F37D3
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355145; cv=none; b=arCtsZ5bay0Vqmr9CZyK3320LU5nZ8QIGooQe1DvYRFD1594sgNunim9TxwxqM7RHZ0yuVSeIxnlKYAVF/yAXoX3a6x8LjMvzxK3LRcBgDZcv32it7jmOkJDuxK5gywQWHvE3pSGqM8WcgmmlSUIICImAUBr1GPGqMYKRrtjaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355145; c=relaxed/simple;
	bh=EQuTi27m+mena9DezTOqpy5pGCKftxBT1qld7CXF/8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtFZBnyHWMowl6Ad607pJ5Vum8TdJ4WTXmty3iUCgLjE/SGG/cZsbZpUuardg6Pf1UTZnAc92NvN0PdGwzeFXjuK8ICUvrVW91qmBQCD0RcsETxDeRJ6gfayJZTme4swV4+UqJViuolB1OIYXLDLdEzYfiVcy1XgFiU7+QSGB5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JG8NVryu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JG8NVryu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762355143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wumyZTzouk2B+H4+lga8Agcv+0f2gJnuqk6u1bIADAE=;
	b=JG8NVryuSLsX2z8KUAIh4orQCAh8yHwuQr3ooBVxgIKJ+RYBd5YFfY+vdrAOg/y6dLJXTV
	/sPPD9ksj9Lq+tLTgSmJfvc3dXKqpSRYNfuCfm6sDmim/6Snay7NX2Zwnur2v5YWy8ZeuY
	hTo12CHXSOhUlpy4uzSxroA4csYbaag=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-xt6me9WBO9G1auIRblyyPw-1; Wed, 05 Nov 2025 10:05:41 -0500
X-MC-Unique: xt6me9WBO9G1auIRblyyPw-1
X-Mimecast-MFC-AGG-ID: xt6me9WBO9G1auIRblyyPw_1762355141
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4721b4f3afbso28321485e9.0
        for <mptcp@lists.linux.dev>; Wed, 05 Nov 2025 07:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355141; x=1762959941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wumyZTzouk2B+H4+lga8Agcv+0f2gJnuqk6u1bIADAE=;
        b=YVPopClNJLshTDQa2SeZmPDnkgHLpyOccw6brBNe968+ohIXGWdyUnyXNYvr6H0kQF
         1YWQeK8EN49D6sAnUziIE23N2URZvkr5a3gsgaWVVmGc24wyHnQ1QlevJ5URtLyS2cOq
         i4VjFM1PZKCR//eV6gPsHwXUAQz4+pB5td8smIMAPlywQqoEGAbTxo2VaKtXZX9vg5tt
         D+HYzbyF66ofelHy4DFKiWM8JORnKT4L9k2Wkg/NU3Xm2oWEERxmZMYIAeat8NqhsCsB
         VqcRu7YAWoKkyggzfkjgutOD4nkUY0gHFjXP9fAiitlHJw2oVG7pcBvcGIto4PqIKTEw
         Iwpw==
X-Forwarded-Encrypted: i=1; AJvYcCWYMMv3MkJwJhpNK3ATLYu2cAHz2rWq9miXa3FqBMpZPfIBeW1G4DPFWo1UuJp32WURaFMF9A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKoBwf3gVHoPaJGJgP0E94T0M7f4acS6fHAYRQtIj73XvIx4DO
	yNlOY2S/hTv/f/Dn8cd4GlagtzfGTMfybjyOzQpJ0hnSdt4ZsaNLDiMxkYB3o6rsI2iE6TT2t4x
	L8QDjs6D3eAwOBXcX/anEpwjj2G8+E0gPu6baLeeLCxhqOieSXQYO3xrh
X-Gm-Gg: ASbGncu9k5rrVWj1Hwyeh6nvTV+mRTgmVXeKbg2YtE4QN6ATxKyjZh+s/ejqMyREF0J
	GFA4i/ikBtCF2OMMso4BFOYHT4SERmEweeF8xoKe24av/1fYza8Y3qtyZdcz0qIbY0oM30xLh4R
	xS2Y0Nr8tNC/z/D+Z9M1ZXHVXIwitq5MkhBNokuN4aNe+rgc7zdg7GEQfODnIz2pSeVQzYKj07O
	Su0fJcskmNChAsRiEKceb2YJg63aLPHyKL2Y5l32A5JOSLvQSVDzsVXlS6TcvWv38Z6egdAg1/O
	ivVfJ1kMi06z3EBQe6D/2/5gaUieW8Dgbe6dYRQ5HTPaeyuZinRCSPFmtmhfPWPq01Ah9kaG+vC
	vZw==
X-Received: by 2002:a05:600c:828d:b0:471:a96:d1b6 with SMTP id 5b1f17b1804b1-4775cd9c4d2mr33793375e9.7.1762355140596;
        Wed, 05 Nov 2025 07:05:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjEwR/PnXsK8t1MyDx9ZQuCXSZ9DQYC5Zb6lPZHw/gIQoaugxtmZSuswTfwusI3lOUmKthTQ==
X-Received: by 2002:a05:600c:828d:b0:471:a96:d1b6 with SMTP id 5b1f17b1804b1-4775cd9c4d2mr33793065e9.7.1762355140137;
        Wed, 05 Nov 2025 07:05:40 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558b826bsm44427915e9.3.2025.11.05.07.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 07:05:39 -0800 (PST)
Message-ID: <f15ad419-1d47-4d96-a225-3861dd6ff700@redhat.com>
Date: Wed, 5 Nov 2025 16:05:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v8 4/4] mptcp: leverage the backlog for RX
 packet processing
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
References: <cover.1762271864.git.pabeni@redhat.com>
 <44e2efcff50d5c45c9a72b1efa15528e81166d34.1762271864.git.pabeni@redhat.com>
 <5da6be8c-76b6-4d65-88e7-f74a95557b65@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5da6be8c-76b6-4d65-88e7-f74a95557b65@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _4lSDX_Hlweon9YbC89J1mglC0DgNiZg3YRv5w9s1Wo_1762355141
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/5/25 11:43 AM, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 04/11/2025 16:59, Paolo Abeni wrote:
>> When the msk socket is owned or the msk receive buffer is full,
>> move the incoming skbs in a msk level backlog list. This avoid
>> traversing the joined subflows and acquiring the subflow level
>> socket lock at reception time, improving the RX performances.
>>
>> When processing the backlog, use the fwd alloc memory borrowed from
>> the incoming subflow. skbs exceeding the msk receive space are
>> not dropped; instead they are kept into the backlog until the receive
>> buffer is freed. Dropping packets already acked at the TCP level is
>> explicitly discouraged by the RFC and would corrupt the data stream
>> for fallback sockets.
>>
>> Special care is needed to avoid adding skbs to the backlog of a closed
>> msk and to avoid leaving dangling references into the backlog
>> at subflow closing time.
> 
> Thank you for the patches!
> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index d075db13bb72..01114456dec6 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -684,7 +684,7 @@ static void __mptcp_add_backlog(struct sock *sk,
>>  }
>>  
>>  static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>> -					   struct sock *ssk)
>> +					   struct sock *ssk, bool own_msk)
>>  {
>>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>>  	struct sock *sk = (struct sock *)msk;
>> @@ -700,9 +700,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>>  		struct sk_buff *skb;
>>  		bool fin;
>>  
>> -		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
> 
> I don't think that's important, but I prefer to report it just in case:
> 
> I see that you moved this condition from here ...
> 
>> -			break;
>> -
>>  		/* try to move as much data as available */
>>  		map_remaining = subflow->map_data_len -
>>  				mptcp_subflow_get_map_offset(subflow);
>> @@ -730,7 +727,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>>  
>>  			mptcp_init_skb(ssk, skb, offset, len);
>>  
>> -			if (true) {
>> +			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf) {
> 
> ... to here, but almost the opposite: '>' → '<'. Fine with '<', or
> should it be '<='?
> 
> But I guess we will not often hit just the exact number.

Actually the new test is more correct than the old one: if the rcvbuf is
full we should not add data to the backlog.

Arguably a better test would be alike tcp_can_ingest(), but that change
caused several regression and I would refrain/wait a bit before porting
it to mptcp.

/P

