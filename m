Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8061329AB1D
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938612; cv=none; b=NxnbSlVXyS4j7qB9PpPlE/CHbbycHI1BmKaMRpSdjTyYv+t2QTysMM/7liPYw3GpBZJ76D0En511vr1p/ExqcNSveyGQg3CQR/kHOZ8quWor7FrZfhFCinvW1V2DUt8YSo1VaOZ7uX5kWzFPZK6gYTbOcP8F/25etPmZjdnZFV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938612; c=relaxed/simple;
	bh=4ynGk/QBMJpOrcD5mn/TI6FhROCs88zctQUd9NvP4pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdAPMEZXPdX7qRiOmUw5eWpbCmpXihZPkzB/oKdRRByWnv0WWiEaI+cBD+f1ulj6d9yWzLjbyO0IULVLvdpNOgtZtT0qlAi5MtfmUPFhWzeK0m783kF67IbsnfFrz7I6JZDB5Oq6fWm05zJLm8I8R5WdxeL3zjDdnSezapy6bFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8kW0YFJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8kW0YFJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762938609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VU0u4QTdA4nkPlv+GVrqPX78pjHzY5AwPT1P9EEHzY=;
	b=J8kW0YFJr66DFbTq5/Z/h8rvwYs+8tlk3I4awqVR4r1Wge0Pg9iEnidO2NhUZ2VmmHbMlQ
	GpkTJRl+QlRr/foZMs3gHvJ4pxNavw6Cr36pwX3JyFhlE+Q6G9gx1bg07luCC7wdfXAtBe
	+pZTM/AhkJNUr1n4kqSqcdcB3dWMZz8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-mG9_nFxSNBuBAv6eeKuShw-1; Wed, 12 Nov 2025 04:10:07 -0500
X-MC-Unique: mG9_nFxSNBuBAv6eeKuShw-1
X-Mimecast-MFC-AGG-ID: mG9_nFxSNBuBAv6eeKuShw_1762938607
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso3635265e9.2
        for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 01:10:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762938606; x=1763543406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VU0u4QTdA4nkPlv+GVrqPX78pjHzY5AwPT1P9EEHzY=;
        b=DLKKdS+VgcebXKNKqmcAylZsODXzlAZjIH6sstiPBdKN5pWY3v+MxNoF+eS1ezaaF9
         ggX492xnek9Z5F2yb+eTORD3xxvmW66OwK85KB33aTJTDQIv/ZF4ICONgyWhGSVG/Tqj
         cZ5pVFOo41THpw85NP/3nzE9eiiIfmXYL/SVDIvdwxB3VL4Rq+bgO0/Ca4bzDjf83wal
         o2+S0bbId1QrjV+PsLwm6i1aQ7AHLWlQ4RV6C4Wg85EPPW0TBY6MNsZycV6GgMn7FvFM
         tn8zKd4w0cIYx6Jla25GaD440AFgF383Ia/nVSMf0Cn2rYQBnfBc4d+/0pwaFpBHfF2t
         Ut1A==
X-Gm-Message-State: AOJu0YygNosRhH2GFAUJURzmb5lp4Za7/VtwWZ7qoAltEDb8ryPgdoHT
	elT2c2AywdYOOJR1Xv5GMcxnor42XP23hXIy9Aw2JYk6RXCuvYf90Mu8prTjBbpozIN8cG56Rx1
	1XUVli8+bWBYizZncxsw5bTBXifx5U+vgKRhvw8rr77/Fhqan93E/7/VFi6QgQ7xt
X-Gm-Gg: ASbGncsPuyRqNvU6l4NzTZXXJARNeqGTWUzE5goim/0LSJna9wCzccPGrAvJcFuCplI
	4XdKq8LeurSTs3qkLQadBBT7mxEmvt/tV8sPANe3euizcUhDdGX9R8rR2QQ0LdJBFlkHUljY6WO
	txzUnMYVPoPODlud1tK6zudn2p/ew+Sv4FPby2i/VxXla1+i69tl3qVr5rDDUc2XoY00yoiLLgt
	IZb+2LT+FHJ5Ow/YUxHTZ8gSttGLmyL8updSMru/Gamat2HC40ouaZhLEyy/B8e/o24ooWfZ2B9
	ENl0EGgnEWTYwRJd71J3rvSuvwIsVpm95IoF6FPRFGNzn+ob1LzDULSP6wTZB1oPr2YTqqYdHmS
	gqw==
X-Received: by 2002:a05:600c:154c:b0:475:d952:342f with SMTP id 5b1f17b1804b1-477871e885dmr19373345e9.39.1762938606389;
        Wed, 12 Nov 2025 01:10:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4ONGxXE8sMgLlNjcR33+LkQWxt4Nb5INunpo3mpkzIcvewcdqg1qQ9Q9BTJcdtFcjjCv4xQ==
X-Received: by 2002:a05:600c:154c:b0:475:d952:342f with SMTP id 5b1f17b1804b1-477871e885dmr19373135e9.39.1762938605948;
        Wed, 12 Nov 2025 01:10:05 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e953e3sm24155475e9.14.2025.11.12.01.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:10:05 -0800 (PST)
Message-ID: <8554a209-9370-4582-8bab-817aac5af463@redhat.com>
Date: Wed, 12 Nov 2025 10:10:04 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 3/3] mptcp: fix memcg accounting for passive
 sockets
To: Matthieu Baerts <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1762551942.git.pabeni@redhat.com>
 <b78e4fb6552cc0b94aa9c1471590d7af1ec2a221.1762551942.git.pabeni@redhat.com>
 <7d43f35c26a94f22a8e7627f477560ba994efbe7.camel@kernel.org>
 <61dce5d9-0dac-4c42-af9f-231b537844c4@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <61dce5d9-0dac-4c42-af9f-231b537844c4@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4FSb8DEaUfG4YS34-Ndp-M4eZbMsZ_Snlcoy6D_e-Hc_1762938607
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/11/25 6:25 PM, Matthieu Baerts wrote:
> On 11/11/2025 09:37, Geliang Tang wrote:
>> Hi Paolo,
>>
>> Thanks for this fix.
>>
>> On Fri, 2025-11-07 at 22:55 +0100, Paolo Abeni wrote:
>>> The passive sockets never got proper memcg accounting: the msk
>>> socket is associated with the memcg at accept time, but the
>>> passive subflows never got it right.
>>>
>>> At accept time, traverse the subflows list and associate each of them
>>> with the msk memcg, and try to do the same at join completion time,
>>> if
>>> the msk has been already accepted.
>>>
>>> Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming
>>> connections")
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/298
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/597
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>>  net/mptcp/protocol.c | 36 ++++++++++++++++++++++++++----------
>>>  net/mptcp/protocol.h |  1 +
>>>  net/mptcp/subflow.c  | 10 ++++++++++
>>>  3 files changed, 37 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 34e6bc731085..5e9325c7ea9c 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -959,6 +959,8 @@ static bool __mptcp_finish_join(struct mptcp_sock
>>> *msk, struct sock *ssk)
>>>  	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
>>>  	mptcp_sockopt_sync_locked(msk, ssk);
>>>  	mptcp_stop_tout_timer(sk);
>>> +	__mptcp_inherit_cgrp_data(sk, ssk);
>>> +	__mptcp_inherit_memcg(sk, ssk, GFP_ATOMIC);
>>
>> In mptcp_graph_subflows(), these two lines already have the
>> mem_cgroup_from_sk() check (in the squash-to patch). It's unclear
>> whether mem_cgroup_from_sk() check needs to be added here too.
> 
> From what I understood, no need to check mem_cgroup_from_sk() here:
> 
> - __mptcp_inherit_cgrp_data() should not depend on that (I think)
> - __mptcp_inherit_memcg() is doing that via mem_cgroup_sockets_enabled()

The mem_cgroup_sockets_enabled() check is optional, mainly used a
performance optimization, as it will cut the `than` branch via static
branch.

To keep the code small I chose to avoid the optimization here, but still
kept it in mptcp_graph_subflows() because there is much more stuff to be
avoided (a whole loop with per subflow lock pair).

/P

