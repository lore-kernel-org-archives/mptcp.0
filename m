Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C062D1A9F8D
	for <mptcp@lists.linux.dev>; Thu, 21 May 2026 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350657; cv=none; b=KxtbEgwLYG6uczA513StNwR84PPO3VU45DP9DNTCAgZ4xxgNrIudgJR09SlCiXavGRRD0TlWOWcs1mpgmw96aHkRYpKN0ZEPBETEFHaTr0M4PkDqhTOKfzlJ+fg98D8cQNxiRXxv2CTIOop009PeOq20uNDxb5bRYf0Y1uOHy5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350657; c=relaxed/simple;
	bh=HB9UTx3I+ed0oFWx1WxEKQj+YbyMG4hy/IasPUe6WHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K4k112fDjGBd0rRpPAYcIArhgNpddrqrJZ7VtHe6n0Zp9mkYA2fjsUa2k4aoTbG8NSwA7KR1oYVmlluzppgDBrkVfimKuNbxJVaC3+aqnHNM23g0D5PmG50n7XMDSo5ss0u6FjWxeWDXeu6ujoND2GkVt4+CLkEfLtpE/KImGQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGILpY3D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGILpY3D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779350654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJs68/iUnz8cuhVN9jLGbPsh7vZOdzQo0+jABWZXw74=;
	b=hGILpY3DTCU4QIALlz5xdG3o7NRfbvU9gUpBE0Rrev3wLBz7wAy3Xeyz7msOVf3Q7TgxNr
	OE5mLqY9a4ZqmWcccm5mvTdxXpY/N6A+PQkSnnlR3U6yGyYx6OrUbGNFE3FrbLWp29EEH0
	3UjDZrvTaqethxfvuoNvAXt3fRnAslc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-7t_tzQjENpqN3dCwMFGj7A-1; Thu, 21 May 2026 04:04:12 -0400
X-MC-Unique: 7t_tzQjENpqN3dCwMFGj7A-1
X-Mimecast-MFC-AGG-ID: 7t_tzQjENpqN3dCwMFGj7A_1779350652
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fe40b61a3so38415745e9.3
        for <mptcp@lists.linux.dev>; Thu, 21 May 2026 01:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350652; x=1779955452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJs68/iUnz8cuhVN9jLGbPsh7vZOdzQo0+jABWZXw74=;
        b=n6ztzVZknY6W+KsrTgbLk0WFfIm2sLJNixtHG0TiQhq5BNp51He1wuVk5sG1GQ5tXb
         smQ+L7PwNPYvUyiCmk6k9epvzdJW3iDk6HhO77F8drt+1/GJNnzgYSUhgs7IYnhO6+2d
         Oc61AODqc4osrbqoilYxY+tblVvPA0KuH/MigcXM4QdiS6YDmECIh/nuU7p5E6fbkmtY
         LW9KtY4nhxRG0LGS8XUo4hOIvwhdGXN5JXIve2pMmjdWjbs2WxwfBTPILLhp8mvqfAry
         3M451fxijOZjVip2UwdE/uvO72sJY08F3XTGQaMMhhs3cVarpY8NYGYkokUKeuiIuUSh
         kQFA==
X-Forwarded-Encrypted: i=1; AFNElJ+YNwl3A54mNIRj34wRiob7z9vGKpcNBND04z955FWHMaeEZx5himWj7Fpqhbu05iEd8CBJag==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhKXDYhibbhxAYeLxU3LOXiemVBHtuzYW1aOpyD1WTsNvvgKts
	gLv2HskipHZ0tYin4uByhrIbzPqSWe1aJ0kmd3N02LYr3LeYMyv6R6brRAJN5agOW/RdVdmHT6U
	q6xILQBBC7/FOfwMdWeP5FjwMxvsCEG9R7UVKgtNZNshQfDUwD0G3nATWZxQCHOA3
X-Gm-Gg: Acq92OGBwG2bhLmPhCxJB040HHkNNdx6fcoQjxFhV29xMazbjUUz40Sc+Ajlowvhb58
	7kbGhx9LSMDouI+ka6hnAto9aFxVfu17ruKufgAkXQY9bbr3XjC7mm74IWedn6j38doVvIMGbD9
	R4gtLeyNtsdil6kCKHsRWZvGXgn7fLAQ8IDFBMtAIhk+INGqQYZscv/M/fvWvjJXMhp51EevUak
	NB0ibqTLuMo7uOnokFcOxynBj2R2b1qJ19bLVAHJe1QarNue84XUOZ6JwiFkxATcy7OGMOiMkgA
	yMGf9OLhGpnazSNw1iJDkNdIL5U9e4Bo3GYRhHopzWKr1vbyI+GhNwg3VDJitna0Bs0zMBzJ14n
	XSLCrmg68EUoZIRKKNBPpmOMXDTp6TaAR0s5zUf1wcCAfhXulAMvXo+df4w==
X-Received: by 2002:a05:600c:8592:b0:48a:5970:1fe1 with SMTP id 5b1f17b1804b1-49036033339mr20839285e9.4.1779350651654;
        Thu, 21 May 2026 01:04:11 -0700 (PDT)
X-Received: by 2002:a05:600c:8592:b0:48a:5970:1fe1 with SMTP id 5b1f17b1804b1-49036033339mr20838725e9.4.1779350651151;
        Thu, 21 May 2026 01:04:11 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035e9fbadsm10510875e9.20.2026.05.21.01.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 01:04:10 -0700 (PDT)
Message-ID: <c39c2882-cdd5-4fd2-80c5-24b19594490c@redhat.com>
Date: Thu, 21 May 2026 10:04:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 mptcp-next 0/7] mptcp: address stall under memory
 pressure
To: gang.yan@linux.dev, Geliang Tang <geliang@kernel.org>,
 mptcp@lists.linux.dev
References: <cover.1779210016.git.pabeni@redhat.com>
 <da87a06afe83a817fefdb86882b6d68169ba121e.camel@kernel.org>
 <5b4149a2-fa05-4f72-bb8c-f3ee82f07d63@redhat.com>
 <6eedf75be575a1db987ad5b7b8226bf0f412f37d@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <6eedf75be575a1db987ad5b7b8226bf0f412f37d@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9jad7NHkePbwrl81r5vxE6Gg9hDTzOzBgdSu6J2UDfQ_1779350652
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/21/26 5:23 AM, gang.yan@linux.dev wrote:
> May 20, 2026 at 4:19 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@redhat.com?to=%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:
>> On 5/20/26 8:32 AM, Geliang Tang wrote:
>>>  # # RUN tls.12_aes_gcm_mptcp.multi_chunk_sendfile ...
>>>  # # multi_chunk_sendfile: Test terminated by timeout
>>>  # # FAIL tls.12_aes_gcm_mptcp.multi_chunk_sendfile
>>>  # not ok 3 tls.12_aes_gcm_mptcp.multi_chunk_sendfile
>>>
>> Without this series you should get some stall there, right?
>>
>> Note that the 'multi_chunk' test will require increasing the test-case timeout,
>> as mentioned in v3:
>>
>> ---
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_data.c b/tools/testing/selftests/net/mptcp/mptcp_data.c
>> index 39d092e7888d..127d8b47bd39 100644
>> --- a/tools/testing/selftests/net/mptcp/mptcp_data.c
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_data.c
>> @@ -166,7 +166,7 @@ static void chunked_sendfile(struct __test_metadata *_metadata,
>>  close(fd);
>>  }
>>  
>> -TEST_F(mptcp, multi_chunk_sendfile)
>> +TEST_F_TIMEOUT(mptcp, multi_chunk_sendfile, 240)
>>  {
>>  chunked_sendfile(_metadata, self, 4096, 4096);
>>  chunked_sendfile(_metadata, self, 4096, 0);
>>
>> ---
>>
> No offense intended at all— 

No offense taken at all :)

> Geliang and I just wanted to confirm
> whether this performance regression is expected, acceptable, or
> something we can optimize further.
> 
> We tested the performance of mptcp_data.sh (time per run) 15 times
> under the v7 patch and [1], and the results are as follows:
> 
> v7 results:
> 5.82 4.72 5.38 6.18 6.52 6.04 5.05 6.49 4.78 5.62 5.52 4.91 8.07 3.87 5.61
> 
>     Max: 8.07s, Min: 3.87s, Avg: 5.64s
> 
> [1] results:
> 2.98 3.44 3.11 3.06 3.78 3.23 3.28 2.88 3.52 3.33 2.89 3.33 3.91 3.20 3.45
> 
>     Max: 3.91s, Min: 2.88s, Avg: 3.29s
> 
> We’d appreciate your thoughts on whether this delta aligns with
> expectations, or if there are further optimizations we should explore.
> 
> 
> [1] https://patchwork.kernel.org/project/mptcp/cover/cover.1773735950.git.yangang@kylinos.cn/
It's a matter of trade offs. This series intentionally sacrifices
performances for hopefully very edge corner cases over the average/most
usual ones.

Note that when we hit the prune condition, the sender is really doing
something against performances (i.e. sending 1 byte payload packets).

If you break down the runtime you should observe that the delta should
visible mostily/only in the `multi_chunk_sendfile` and `multiproc*`
cases, none of them is very relevant performance wise
(`multi_chunk_sendfile` requires intensive pruning, and `multiproc*` is
doing I/O using multiple threads on the same socket, which is also
really bad for performances).

The change in [1] has a different trade-off: replacing the backlog list
with an RB-tree makes computational complexity for backlog processing
change from O(n) to O(n * log (n)), and that will affect every fastpath
user - in practice high speed transfer are more likely to use the
backlog than slow speed ones as the optimal CPU pinning is BHs on a set
of CPUs and user-space on a different one.

Negative delta (worse performances) are expected to be observed on top
of [1] in high performance setup (i.e. 2 BM hosts B2B connected doing a
single stream MPTCP bulk transfer over a couple of high speed links).

Yep, I suggested the RB tree backlog usage, but I did not see in advance
that drawback, I'm sorry.

/P

