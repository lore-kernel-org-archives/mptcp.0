Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FBD3932F7
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776237483; cv=none; b=AgXVo3UC3DQ3Mv8exrswNljUgbVnYEd7lVC1vLWVSfF1uiAOY+B0rTubhlXAzbfspvGTKTuV2VqGDSXwrVNVj8r0gRIS4fFKA1ug6wICUzfzakbmkAvAi+T+14FbEMx+14BSTBHyAx5kAawKe6ExsNnMOTzUAOii9JHvnqAQ6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776237483; c=relaxed/simple;
	bh=X1AevDDFFOCDFpJA/xnn7sTRGb7IJgzfgM9l69UDl+0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dq3quxf1xZ/zj6+XrNVYoRaajJ8Ca7Glxr74f3gfpuY+9WEBvQTkmMwsZGpGKzN5l+NWnKdaAb2qPhOxuJaeIcX8VTXKYOMz68kq9XQogkBMIPCIAwlBKM2dYfewr0bknd8GCNLTeT/R1Tu5RQUY8gEr5jqcTFdtNtfi3mm8j40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GhIBkEpC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhIBkEpC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776237480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0MdwZCL6ddSGH1KVYgu32J6iUnQ/16df0FBfG4Kr9Nc=;
	b=GhIBkEpCFTAS2E8CLM12c1yr1UTzvSxNmeYKHQgyQq+6GU9OhnC5Iy8hLnGV0sDLBrF1nT
	BfnmrcmnSjq2OjRCS2xSA4G/H60tAqp90tlcHoSNdZBQ4NYBMiK6nnzSjnRAiK4QsSBl9Z
	g1YeISL2OhDynBgS/Su4SbqR2qvkSgo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-vq5C-SIePS2CxwoAhI2-Wg-1; Wed, 15 Apr 2026 03:17:59 -0400
X-MC-Unique: vq5C-SIePS2CxwoAhI2-Wg-1
X-Mimecast-MFC-AGG-ID: vq5C-SIePS2CxwoAhI2-Wg_1776237478
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488cc31ea57so40369505e9.3
        for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 00:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776237478; x=1776842278;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MdwZCL6ddSGH1KVYgu32J6iUnQ/16df0FBfG4Kr9Nc=;
        b=O5WQ6KMxl6s5XkUu53rxVxkrSjSYeeWgHTrzTRBTfdnFJsSXEKIRMO0uNJXeJ4AMHR
         if6w+QS6G30v4hoasFR5s8qYQvJi61I9TV625F5POsPuDZw7L2/cd5xTuZ0LuF0Ut0gj
         /bGuIppmP0oQIquz3dGr5xctKNz1FejU477vRarxslD3fTYjDzoszLfuHxQDFsblNO4V
         kxil0gqMYuJlMBDfxDENBLNPcDTg/ND5zebZDWJiMPAiB4za/dMNps2zEKxzmBC2iqpr
         f5KiYjb/QCel8oImxG/ziBjbqRTA93YBcCRNAcCv56DbJZF6SeeLYb7PzNmktTxUrW2x
         FVKw==
X-Forwarded-Encrypted: i=1; AFNElJ8BRRikKtiQXXj65kx46ZSBo39x1JMqTxEu4XjEoCWgBAWMsTtDjHjxmr8DcLuKyZAzsGJtbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxSfVZYuFhJj3fLhnwi3sEy7PRNfxDPZPnlM7f5FE4kDCiYO2N
	BmSnl0rWIbURC4wD7WjoPRoaWkmyGu0+B44PZdetoHOw9obd5/zWPR8fLg7d2FG20XPV6uX1/0c
	yfhu6IWeTA2B4aP7XHfg6oH7CPhIsYq8KOWZZkWlDMa3idLAiA6Ox2Q4zMZQNDzMG
X-Gm-Gg: AeBDieuz0TbUF/Bo5423wqBQUg0GvBCIuuhaMhHq+goZr1ihIHWuzVeswEj9UJ2OGqA
	cvB9o4NbqmVSqqYH0Qv+4+StRwJchLKg422/Lz31mqdeNmcMM8IdWEbF27Z6XtXCmY+EGfJhDX0
	2CqdoBf9HY80S6zOMa/vZhSddoKfX9uDEUPWo0jmCKAKhhsvTN1+r6swbA4hxG9CbDNp0DuTp1o
	nNY5DuMgjSHNjmY+waYolT5kV8kplH90i09GnkAp/0y+YsQWtiRSZ7XoAq+xkdx3RrkHS5saPMw
	CaHDAsHBjfaWPYyZKX0aimPdwdtaLqrFIu0OpZpik7oFWSnPHKIz4xi5tA70m9KZp73c0qutlpC
	vVmcNq33Ap5yA3TYjcP3ooRk6PifPWRQ6CMq9I9IW1VDVFsK+AxiBJNdGuWGcCk8a5lM=
X-Received: by 2002:a05:600c:45cd:b0:488:9ed3:1492 with SMTP id 5b1f17b1804b1-488d67f0bb7mr260555025e9.10.1776237478032;
        Wed, 15 Apr 2026 00:17:58 -0700 (PDT)
X-Received: by 2002:a05:600c:45cd:b0:488:9ed3:1492 with SMTP id 5b1f17b1804b1-488d67f0bb7mr260554615e9.10.1776237477537;
        Wed, 15 Apr 2026 00:17:57 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.141])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee042e47sm108334235e9.13.2026.04.15.00.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 00:17:57 -0700 (PDT)
Message-ID: <d34641c0-01af-4273-83d7-5e7ed92e8da7@redhat.com>
Date: Wed, 15 Apr 2026 09:17:56 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v5 1/5] mptcp: replace backlog_list with
 backlog_queue
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>, Geliang Tang <geliang@kernel.org>
References: <cover.1775033340.git.yangang@kylinos.cn>
 <085a4d26a05fc6625e6e4e4c0e0225b38a01f178.1775033340.git.yangang@kylinos.cn>
 <d749b513-158d-4a3d-ad95-09bfc29c6648@redhat.com>
In-Reply-To: <d749b513-158d-4a3d-ad95-09bfc29c6648@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GyJ6ULqMQjDPx5HqBjEvttco2qMUaU9tFriEAiCRYgs_1776237478
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/26 10:12 PM, Paolo Abeni wrote:
> On 4/1/26 10:54 AM, Gang Yan wrote:
>> @@ -2210,12 +2260,12 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
>>  			       mem_cgroup_from_sk(sk));
>>  
>>  	/* Don't spool the backlog if the rcvbuf is full. */
>> -	if (list_empty(&msk->backlog_list) ||
>> +	if (RB_EMPTY_ROOT(&msk->backlog_queue) ||
>>  	    sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
>>  		return false;
>>  
>>  	INIT_LIST_HEAD(skbs);
>> -	list_splice_init(&msk->backlog_list, skbs);
>> +	mptcp_backlog_queue_to_list(msk, skbs);
> 
> This is under a spinlock with BH disabled, and N is potentially quite
> high. This code is problematic as it could cause stall and delay BH for
> a significant amount of time.
> 
> Note that there are more chunks later and in later patches with similar
> problem.
> 
> I don't have a good solution on top of my head, I'll try to go back to
> the design table.

I had some time to have a better look at the whole problem and how it
manifest itself in the included self-tests - comprising the initial one
using sendfile().

AFAICS the stall in the self-tests in patch 5/5 is caused by the sysctl
setting taking effect on the server side _after_ that the 3whs
negotiated the initial window; the rcvbuf suddenly shrinks from ~128K to
4K and almost every incoming packet is dropped.

The test itself is really an extreme condition; we should accept any
implementation able to complete the transfer - even at very low speed.

The initial test-case, the one using sendfile(), operates in a
significantly different way: it generates 1-bytes len DSS preventing
coalescing (I've not understood yet why coalescing does not happen),
which cause an extremely bad skb->truesize/skb->len ratio, which in turn
causes the initial window being way too "optimistic", extreme rcvbuf
squeeze at runtime and a behavior similar to the previous one.

In both cases simply dropping incoming packets early/in
mptcp_incoming_options() when the rcvbuf is full does not solve the
issue: if the rcvbuf is used (mostly) by the OoO queue, retransmissions
always hit the same rcvbuf condition and are also dropped.

The root cause of both scenario is that some very unlikely condition
calls to retract the announced rcv wnd, but mptcp can't do that.

Currently I start to think that we need a strategy similar to plain TCP
to deal with such scenario: when rcvbuf is full we need to condense and
eventually prune the OoO queue (see tcp_prune_queue(),
tcp_collapse_ofo_queue(), tcp_collapse()).

The above has some serious downsides, i.e. it could lead to large slice
of almost duplicate complex code, as is diff to abstract the MPTCP vs
TCP differences (CB, seq numbers, drop reasons). Still under investigation.

/P

