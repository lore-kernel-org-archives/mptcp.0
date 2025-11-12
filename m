Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538EB2D7DC2
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939745; cv=none; b=o5yXTxW3jDSk+v8T0BSd2dMG3QR7AokZtrqpz6n7r8PIT3Vl2G+c1uhYyWPGns5RcG6YehSF1MZxgxGHwALJmXghoL4/UzeqX9hsFgvzHmRUKcOJiay/PTeTkhIbbgkLwF62mSv4iQdEsea+fWusP+E43l0FulbUKow0TIq0/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939745; c=relaxed/simple;
	bh=+hAoVruGr3y7GneMZvJXN8dPeHKns/4qH6NNZODf760=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QyWcj4ZQNjVknkeZDOInibnB4wp5/gvHYONmDPavSbfR4Pvkb8DcvMWqWfXetpfWFoPyEXnd80dj8FDBZWEaVgdMMwcl1aHu5Jvps97Ts0H8r3vpk60XPH9qtbSd6ymO/TLj8gCU7Fg83UllDvooc0192awJRfVUyPCmN9N0tfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cQ8d7MFm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQ8d7MFm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762939742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ImH4BQe/vT63lCvybtazoFHSfsyEpFIXF75ZX5LbiSY=;
	b=cQ8d7MFm5maJdXkalC1Le3Tw31YAoW6Hre4m3l1SEckBveqceNn2OqscW0QnfeHZ8/3Day
	E7PioiTPbjpjAev6M22U+aHjfrhDXf05XJC48mW5ELjpW7QNnwSP3qaWgEgBjKMt/81UYg
	E1/dbOgig1pHAlz6sYTO8zycmoPRWmk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-4UxQM_cxMIWBIzgdDwgi4g-1; Wed, 12 Nov 2025 04:28:58 -0500
X-MC-Unique: 4UxQM_cxMIWBIzgdDwgi4g-1
X-Mimecast-MFC-AGG-ID: 4UxQM_cxMIWBIzgdDwgi4g_1762939738
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b2ad29140so277040f8f.0
        for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 01:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762939737; x=1763544537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImH4BQe/vT63lCvybtazoFHSfsyEpFIXF75ZX5LbiSY=;
        b=UMcqNFhxR9UWcTy5SR1l+h0pcc3Fcw44seFwA1ZkGhOr87Z3QRynjn8Zl+gJI5/2Dh
         jzDgB9nN7YsWyeGbOEefrqQPcTnwGTHFANXzCtOZof8xxs5EtgxwPiWkt35HZf+v93Zm
         83zQ7b/wmE2Epvkygve2LnqTziLk1+5o20Tzv4eptJRkaIuens3WgfaNccCVV5gACPBM
         o8AeAsMUSrCDqfDv3c7HaOVUyEweZs8HK4WQ/W3AJdLLT1/qqEg/tymp0Bs432jZ/pyr
         DjaC5+kuJ82xhaaYWcEaBgcjFGxsZuducOOy+oBTnbq46oLfDqCadyEoxSRUhJws/6ko
         Mqig==
X-Gm-Message-State: AOJu0Yy+Rye5E7yytBjFh3IPLZSLoxl/JAHWG2ieUwx2Cw2dntRLAgYl
	NULb+Ymc/4I5gbe1SQiVO/VN5E0ZttXt5fRZaFMn0jfzdO+nIXBMV998AYqERzJJuoVbVbPJadU
	9vycXsOOeCgQZAlD9hIhL5K9Ioax2YSUW4wvHHyKpl+cY+CoSSZI4ahOSpaClRKD4
X-Gm-Gg: ASbGnctCyEE/D/KsUYJOF+pHGc0NxuXzXAGhIOaqPswY67QqrKOcv3mcEneoW681mJC
	XwgFHCO8uVnqwErl55ltroA4SRV5htrXwODSzuqnD6WNSZ84jHBFbv2CxSqQLTyGPxj9pCcMCr2
	HR4DpxMUcoCumiIVVyTN7yFrtJc35foDiiCPQCcsJOABV9w9hZTlyuVQpO3ibEXhWasuThJMx2s
	jpSI1SdQjMW996mGZTuCtJwsOM1Lx+Cgb5iBePLNgmUrcPiA7xp5HQgfwawj/kWJv1Uq6zHLghU
	Yby0tXmCLeHRLpYWcNYV6/ZiC6plKroqNqz5LLHmAXn0LXEZiQeTTuPj07+YHziOsIqQoN5ROjF
	ZyQ==
X-Received: by 2002:a05:600c:3b8a:b0:477:7af8:c88b with SMTP id 5b1f17b1804b1-4778706e988mr19981785e9.11.1762939737247;
        Wed, 12 Nov 2025 01:28:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuM+8OiMeBw/68/VsGRPWW0Ig3sNdny2i6hLdaMQknqRiO9eOZDdRbGaYaPol9udh6qv3gZQ==
X-Received: by 2002:a05:600c:3b8a:b0:477:7af8:c88b with SMTP id 5b1f17b1804b1-4778706e988mr19981415e9.11.1762939736654;
        Wed, 12 Nov 2025 01:28:56 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47789ffea1esm5521915e9.13.2025.11.12.01.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:28:56 -0800 (PST)
Message-ID: <fe5a48a5-d329-42dc-876b-dc3db739e178@redhat.com>
Date: Wed, 12 Nov 2025 10:28:55 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 1/3] net: factor-out _sk_charge() helper
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1762551942.git.pabeni@redhat.com>
 <063e2bc8e98ce050286eb4309bf4bd47716cc3f8.1762551942.git.pabeni@redhat.com>
 <a2449ccf-69a5-4503-a687-074b4436223a@kernel.org>
 <63928360-2947-49d7-8e8e-9f83745f3556@redhat.com>
 <d557d65a-3b3c-484a-a5d3-d526b46317f7@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d557d65a-3b3c-484a-a5d3-d526b46317f7@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z-Uqzr2E7rgcoCO3pNNoG2hs1vbYbvhVrHXPcKDxw3s_1762939738
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/25 10:16 AM, Matthieu Baerts wrote:
> On 12/11/2025 10:04, Paolo Abeni wrote:
>>
>> On 11/11/25 6:38 PM, Matthieu Baerts wrote:
>>> On 07/11/2025 22:55, Paolo Abeni wrote:
>>>> Move out of __inet_accept() the code dealing charging newly
>>>> accepted socket to memcg. MPTCP will soon use it to on a per
>>>> subflow basis, in different contexts.
>>>>
>>>> No functional changes intended.
> 
> (...)
> 
>>>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>>>> index a31b94ce8968..08d811f11896 100644
>>>> --- a/net/ipv4/af_inet.c
>>>> +++ b/net/ipv4/af_inet.c
>>>> @@ -756,23 +756,8 @@ EXPORT_SYMBOL(inet_stream_connect);
>>>>  void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *newsk)
>>>>  {
>>>>  	if (mem_cgroup_sockets_enabled) {
>>>> -		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
>>>> -
>>>>  		mem_cgroup_sk_alloc(newsk);
>>>> -
>>>> -		if (mem_cgroup_from_sk(newsk)) {
>>>> -			int amt;
>>>> -
>>>> -			/* The socket has not been accepted yet, no need
>>>> -			 * to look at newsk->sk_wmem_queued.
>>>> -			 */
>>>> -			amt = sk_mem_pages(newsk->sk_forward_alloc +
>>>> -					   atomic_read(&newsk->sk_rmem_alloc));
>>>> -			if (amt)
>>>> -				mem_cgroup_sk_charge(newsk, amt, gfp);
>>>> -		}
>>>> -
>>>> -		kmem_cache_charge(newsk, gfp);
>>>
>>> Mmh, this code has been moved from inet_csk_accept() to __inet_accept()
>>> in net-next only, see commit 4a997d49d92a ("tcp: Save lock_sock() for
>>> memcg in inet_csk_accept()."):
>>>
>>>   https://lore.kernel.org/20251014235604.3057003-2-kuniyu@google.com
>>
>> Right you are!
>>
>>> Should we only apply these patches in our export branch, for net-next?
>>> If yes, then I guess we should remove the Fixes tag in patch 3/3.
>>
>> Technically is a fix. Even prior to the backlog introduction bad thing
>> could happen, as passive msk does not have memory by the subflow only
>> accounted.
>>
>> TCP-level OoO could potentially use a lot of system memory that will not
>> be memaccounted.
>>
>> Unfortunately it's not easy to have a clean net patch.
>>
>> I suppose with can have this as net-next fixes (including the fixes tag
>> in 3/3) as the change is invasive and the thing is broken since the
>> beginning.
>>
>> WDYT?
> 
> It sounds good to me. When these patches will be in Linus tree, we can
> ask to backport these 3 patches from this series, plus commit
> 4a997d49d92a ("tcp: Save lock_sock() for memcg in inet_csk_accept()."), no?
> 
> If yes, do you think I can add a "Cc: stable", and explaining in the
> comments that it is because it depends on a patch that is only in
> net-next, and the fix is not urgent?

You know I don't have all the fascination for stable;) My first take
would be to avoid such tag. If you are willing to do the extra mile I
guess that is a good plan. Alternatively you could just send the patch
to stable after merge, with pre-req included.

/P

