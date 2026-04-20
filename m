Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC337FF50
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677669; cv=none; b=Won+3uofojJQo9r26l9TFYALmjg3QO9kJ8icdsLeGeJOC0qANYqGq8MG8GXCgsZHsQUXJi2+SnMn5DAgVy84wvK3jzxPiA96jvF3sxGK0BCCH3yVEsto0qb+w4Kae8Qsayd9ddiOI9GYKkYmSVc/a1JaE+fTdWYfXUrETA0CJ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677669; c=relaxed/simple;
	bh=MnLVrdjf0fKkFyK3k5/63LsTdAd4JZHjfe2ABoDBoZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MMKHV+oS29d5Ar0a/+VqCyeuoM+4DHc7AB3Bkjjd5hN3s46uZChUiXWpr3zRJx5ConXkUUOovbpe7ci+ihhCTzfLot3D1bsbgClyzqzf2H8XFH0p3+lp+z+E0n+F5b/ZGNM/Kfh8SAthY/YoTjEiPfNK2WjZvh/yfce1TXqPbQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6dSP+X8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6dSP+X8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776677666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X10qDJVKbs+jO0qtcXGJmbL26Yp7AKSRayBfBeGGc0Q=;
	b=b6dSP+X8bszVgNC1+Q6poEOQfZhZnw8N2iPwnQA6E/1JDMgQgOGlmJLjvVmWiL3Gb4EONO
	/hZk++JwwcNRBDS54tgmP4C3K94A81hGYTG0wivyXeqIfbidt/B+WWy5TUUu6b60/Enl/6
	yzOm0+nYkogShYLXt4Ngp8kdCt1MMHg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-Vx6QeHdzMH2_OgApggptlQ-1; Mon, 20 Apr 2026 05:34:25 -0400
X-MC-Unique: Vx6QeHdzMH2_OgApggptlQ-1
X-Mimecast-MFC-AGG-ID: Vx6QeHdzMH2_OgApggptlQ_1776677664
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c0fcc6deso15571335e9.2
        for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 02:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776677664; x=1777282464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X10qDJVKbs+jO0qtcXGJmbL26Yp7AKSRayBfBeGGc0Q=;
        b=UPrm8FboWX5G4d8HTFoU7sYDy/9UVWbiFIV7hkQLagI/SIfuXhza4tPo8zDWN53uaN
         aNZMXjrMNxyMIXVbl8xaVQbUeaOrFDgN87BycyUTl2IzkiGkvIPqj/gGhPjfcLnlggZS
         nMZ+hALl48oR/8yAlU8i7TyMlftGMF9uiiz39+uCqKN8rnjBoGPVQf6LoqBXkj1ZCs7q
         QjDVlieu0mA/A3qZzm4/7cWGpRB5Q0iIpOAOUyHTydprOcl2/TFZIuH23zt6hxF7ZYxs
         r4PwbmHLJqLtyRULoXUnBg/3MnRqjoPLENbrJq1qy79/XPeELTRALpZ7aM6jILLWOnjR
         FWRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8g/rZcXY1qjGhc6L7GFK7O4kU2t7/zwo6K8RxWwGrwu2rhT2UH24UEg4RAcQT9LaqjYOIRWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXzVg9I/TYHIHJ46sKYeSCHDRmSVLvUjvctaU0ixjzgNmLc4cR
	uXsgckxUkpFhfOTabIdnfVmDC/EeB7XiMkzh3trxOWaZqOCbCS1zBlTtX0OQ44rpn0zN+KzFYy/
	hFcJtAqd+z7ZoJMcWia0OesaSDxqbtrfI7L6P6Bq5jFCMf218fZuJ3cqq
X-Gm-Gg: AeBDies0Kf52w7bSoevPHsFFbaFAa1wKPrtrunbs3X/cTUxxbT+wu8MuxZjh3AWwNWd
	p+jNvTEpjXO+7cF7iiMTOJ2FPDRa3omza6JtuFEFmfRqovv87usoDr5zhd7mimaNHCU8oNSPTMu
	LR17uicUgBrXsK6AgNNnMcDka6ws0cN+YVE7Zu1AhJFGtnjGKw0gtuoJmw0eSYWAcPgD9OCTdhc
	LpOtDxHL7ogLU5R8MI32D50/ISDRelYmI87+CLkbbCkF3c3DGvza64hzWYkNPR+I6YZrM3n5Rgr
	e0cUcbOgZ35UlTQDqLUNM9nJ4jcIv6U3d5XyWeeQM04N/Dz3WIRMMWy6cNVLDfHqWSLdOYXtdSA
	2J4u2XdNhONKSmRVzuWAEvAc4pVo1TCTdHLb7QvNUllOgvZCW+gpfyeSAAH7airHIfr0=
X-Received: by 2002:a05:600c:8115:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488fb77d7d3mr145972875e9.21.1776677664134;
        Mon, 20 Apr 2026 02:34:24 -0700 (PDT)
X-Received: by 2002:a05:600c:8115:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488fb77d7d3mr145972535e9.21.1776677663635;
        Mon, 20 Apr 2026 02:34:23 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1393f5sm257027645e9.9.2026.04.20.02.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 02:34:23 -0700 (PDT)
Message-ID: <e04bd2eb-0107-4011-97d5-a672d770767c@redhat.com>
Date: Mon, 20 Apr 2026 11:34:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v5 1/5] mptcp: replace backlog_list with
 backlog_queue
To: gang.yan@linux.dev, mptcp@lists.linux.dev
References: <cover.1775033340.git.yangang@kylinos.cn>
 <085a4d26a05fc6625e6e4e4c0e0225b38a01f178.1775033340.git.yangang@kylinos.cn>
 <d749b513-158d-4a3d-ad95-09bfc29c6648@redhat.com>
 <d34641c0-01af-4273-83d7-5e7ed92e8da7@redhat.com>
 <ef0ce8465f0b852d5e4dc5e54031a156f606b636@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ef0ce8465f0b852d5e4dc5e54031a156f606b636@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zDozgUBVwAFs8ZHUtJaNPhGNihvgxHX8E86MkltPhyw_1776677664
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/15/26 10:21 AM, gang.yan@linux.dev wrote:
> April 15, 2026 at 3:17 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@redhat.com?to=%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:
>> AFAICS the stall in the self-tests in patch 5/5 is caused by the sysctl
>> setting taking effect on the server side _after_ that the 3whs
>> negotiated the initial window; the rcvbuf suddenly shrinks from ~128K to
>> 4K and almost every incoming packet is dropped.
>>
>> The test itself is really an extreme condition; we should accept any
>> implementation able to complete the transfer - even at very low speed.
>>
>> The initial test-case, the one using sendfile(), operates in a
>> significantly different way: it generates 1-bytes len DSS preventing
>> coalescing (I've not understood yet why coalescing does not happen),
>> which cause an extremely bad skb->truesize/skb->len ratio, which in turn
>> causes the initial window being way too "optimistic", extreme rcvbuf
>> squeeze at runtime and a behavior similar to the previous one.
>>
>> In both cases simply dropping incoming packets early/in
>> mptcp_incoming_options() when the rcvbuf is full does not solve the
>> issue: if the rcvbuf is used (mostly) by the OoO queue, retransmissions
>> always hit the same rcvbuf condition and are also dropped.
>>
>> The root cause of both scenario is that some very unlikely condition
>> calls to retract the announced rcv wnd, but mptcp can't do that.
>>
>> Currently I start to think that we need a strategy similar to plain TCP
>> to deal with such scenario: when rcvbuf is full we need to condense and
>> eventually prune the OoO queue (see tcp_prune_queue(),
>> tcp_collapse_ofo_queue(), tcp_collapse()).
>>
>> The above has some serious downsides, i.e. it could lead to large slice
>> of almost duplicate complex code, as is diff to abstract the MPTCP vs
>> TCP differences (CB, seq numbers, drop reasons). Still under investigation.
>>
>> /P
>>
> Hi, Paolo
> Thanks a lot for your detailed and insightful analysis of this problem!
> 
> I fully agree with your points: MPTCP should allow the transfer to complete
> even under extremely slow or harsh conditions, just as you mentioned.

I was likely not clear in my previous message. IMHO the key point is
that in the mentioned scenario we should consider suitable any fix that
would allow completing the transfer, even at a extremely low average
bitrate - because the memory conditions are indeed extreme.

I.e. we can/should consider this case an extreme slow path.

> Regarding the TCP-style mechanisms like 'tcp_prune_queue' for handling full
> rcvbuf conditions — I have actually attempted similar implementations before.
> As you pointed out, this approach is indeed highly complex for MPTCP. There
> are far too many aspects that require careful modification and consideration,
> making it extremely challenging to implement correctly.

I agree duplicating the TCP pruning code inside MPTCP does not look a
viable solution.

I think we can instead share it (at least the most cumbersome helper),
with some caveat. I have a few very rough patches doing that. Let me add
some comments to at least somehow make the code readable and I'll share
them here.

/P

