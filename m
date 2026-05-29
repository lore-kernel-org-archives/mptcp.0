Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1260261B71
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051101; cv=none; b=iMImg7eK33HTI6k0oetCv1CTe6mSreXGW3nAx4zk33C12rY+E1k8aGmuCa55J3b/O5BzLVCHFEGwWDnPngxNDKGAoVYUUB7Tuk4bF5CXVizS7sv/ygiM/BbUNDkK9ENdwRwJq14WxDXGYAcJPcuL4yWkhMR0/1m48OS6CQQAXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051101; c=relaxed/simple;
	bh=VeLPqUYl8BQGJk8wvNOrmida2pIYy49JMQnWxZrsuos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqQSm/b9KWE2+xDpxH/4tkjtmK1UI7gapmYGFndIAc/fo20FEGzsmarP4laFv1gmhjGHx2YJ4NuYYk7YzzCNjCrrbIVFCNYrJBjb3agjU+pLxm5cnH36K7A1+XqrWxE8DhtZBA3eoxtSayYsGO+smTQQq6p5u6ymEfec/n9jxT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HUXa9Oyn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUXa9Oyn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780051099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkqStagt+EKylJ29kcVEIIjdgTEbXc876Od24S0L+mA=;
	b=HUXa9Oynbm679AwzbZ5pmKNhu0aGMvjq6N4lEprKutGK+b4i80AWWqhOj71ZPHxnWCxeGI
	TLlSGJH5Y73BkmG5xtMj7XLndCttFsjXMFFUXSPaPbIVVx80dtXMRDuVrZZPKXvsF9YtNS
	VJ0TlIYbJViIJ8L/3hYOwoKCUu5BfuM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-uY2WWCXHMqGndfyAsdaefA-1; Fri, 29 May 2026 06:38:18 -0400
X-MC-Unique: uY2WWCXHMqGndfyAsdaefA-1
X-Mimecast-MFC-AGG-ID: uY2WWCXHMqGndfyAsdaefA_1780051097
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49081106196so25017865e9.1
        for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780051097; x=1780655897;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nkqStagt+EKylJ29kcVEIIjdgTEbXc876Od24S0L+mA=;
        b=EoYdlLY0UKmJSf54eRwvlzYmrq94hgr3ig4HwM2a99LcO4nqEchdZbClrdu6tYNMtz
         kHs8O6rfNiLbsbOFcb11LmBFwouf+1mBDpqIf9aGG6x2+1vv2wqGZTD+zJS0y7GgMFCj
         dtVR9/WFqJI4NjTlGODGYlZEeiN7/EKHaGSPI71NpzIOnTBC+otFJmk5FJF4hslV8H9B
         wA2TqrYbJOAeM0GF719a8Rt2aJrbJkZUlCG2bYEb7219dVhnwnnJHxHJQTqgVhSYvglR
         LBjkW6k7MYM+HGeI7aksEnyJM0E3lxAVe0lkcg6KSIjMY7SvFA9LDdGZLDJPlgfeXCTO
         OH/A==
X-Forwarded-Encrypted: i=1; AFNElJ/fNNRm+nPEyVe6xMtAaI+WxrZLSIkaxzkPWfOjsFYsWLiXMfYsd8pCnZ0Ka+VNzeTt/fnCmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5Il6bovfUh+GNL3S6YJPn5T81bG8yg1UhCJzpxWStbaPY3dX/
	crSa5aO1qPuLVeODqwQqrpuET6OqBbtwLDM6+wanIYUGRPmE+sR1j/P4FQP81V7NRWsTFeRUVOe
	sc0/Id1KpIfcnlgc16MEMWPjDSwKhA2koWl2v7/Jk6uyk2Pne8En0h9Wu
X-Gm-Gg: Acq92OFUc3F61xB5mcA7IwgpX24gRk85VS/JzqvGLx1IZw3A0tmfpVdqY6dQVWzYI9l
	Y/g/9VT1a36uJzearjIM5xuUt6fTVqkJ4h2LXTAUXZ01CSYM+m4Himwadxe296O4pEc7cQwVpHH
	ySKW9sdLb/SIXIMx2RP5XRgpDc14D76OCwsCDlDEwZK2Fs6UBMtbOucusB9+pWLeNeBi5HUeuGx
	Aq+bkrT4cPrBIrBB+WdOdc5p+JpliPnNpkQBIHPGrs8a7rouMUZBq6xMCna9nduOHTunXIJjSUs
	NCphCs0AnmgCwnIiZcznyKwVjTDV8IiTL4yY4NhkKLUPIFb08V10eWumUKk88rvpIjxCgR9ZytX
	750blyd/T98yB8Hez1VIY8ZoC3z7zkdU0ssp5igitfzyOu/I/r0/QO7+sv7UKXngCs6I=
X-Received: by 2002:a05:600c:897:b0:48e:6f39:f7be with SMTP id 5b1f17b1804b1-4909c07f9e7mr23847935e9.10.1780051097011;
        Fri, 29 May 2026 03:38:17 -0700 (PDT)
X-Received: by 2002:a05:600c:897:b0:48e:6f39:f7be with SMTP id 5b1f17b1804b1-4909c07f9e7mr23847535e9.10.1780051096508;
        Fri, 29 May 2026 03:38:16 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909caa7e17sm39434085e9.9.2026.05.29.03.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 03:38:16 -0700 (PDT)
Message-ID: <b95faee7-e32b-40ac-8010-eb57948a3fbb@redhat.com>
Date: Fri, 29 May 2026 12:38:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] mptcp: fix stale skb->sk reference on subflow
 close
To: Matthieu Baerts <matttbe@kernel.org>,
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>, mptcp <mptcp@lists.linux.dev>
Cc: "shardul.b" <shardul.b@mpiricsoftware.com>, janak <janak@mpiric.us>,
 kalpanjani009 <kalpanjani009@gmail.com>
References: <20260519092243.1242351-1-kalpan.jani@mpiricsoftware.com>
 <19e67fb067f.1c11e928628417.8560610860929896581@mpiricsoftware.com>
 <08d590f7-b825-47ce-bc68-c3ad2bd78bc2@redhat.com>
 <c3ae1aed-0ff6-4255-91c4-b0e18ea7dae7@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <c3ae1aed-0ff6-4255-91c4-b0e18ea7dae7@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 47YMdREWM7tQvqNUiz8tzAW14xMtbBXwo1dTlCajBfE_1780051097
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/27/26 1:31 PM, Matthieu Baerts wrote:
> Hi Paolo,
> 
> Thank you for your review!
> 
> On 27/05/2026 19:40, Paolo Abeni wrote:
>> On 5/27/26 7:49 AM, Kalpan Jani wrote:
>>> Gentle ping on this patch sent on 19 May 2026 — I haven't seen any review feedback yet. If anyone has had a chance to look, I'd appreciate comments; otherwise I'm happy to rebase or resend if it slipped through.
>>
>> Note that maintainers are under an ever increasing influx of AI
>> generated contents that make processing incoming patches more
>> challenging every day.
> 
> +1
> 
>> FTR this revision LGTM.
> 
> Just to be sure, does it mean that Sashiko was wrong?
> 
>  https://sashiko.dev/#/patchset/20260519092243.1242351-1-kalpan.jani%40mpiricsoftware.com

AFAICS, yes: the msk socket is set to TCP_CLOSE status before calling
mptcp_backlog_purge(): __mptcp_add_backlog() can't add anything to the
backlog.

> If yes, can I convert this "LGTM" as an Acked-by? :)

There is already my Suggested-by: tag, I think the latter would be
redundant?!?

/P

