Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00F13AA4E
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157898; cv=none; b=Hr50PTZkwQkEfCgvQr78iQSdhC6mRwm8VXdYKjrNBoWjcxQSH4lUapwz4jjNF9g5PNqAXfHaG/yIqXLtjStlNGSUvUi6Fm8/MhANlt8MdGGJHz0QLtKmyCUWE8n9NIW4PYhqvKgI2HTncn/0Q/87q1kNeTq9oOGnwyWEiK4tnmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157898; c=relaxed/simple;
	bh=zF4tlYSzhV49iAYiqMWyL+kNzTvpQP0zuQZlxWWL2bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lbbs94SQlq6ev5zdbAu0VFm5NjE71FOjb/jIKbwKOgEW6jpt5L9NDoItQCPilc/2aXm1cNwFcwLXlMfakmFT6IIcVg1KDhWBqarSIioQ+mt/wRYSPum3tp0wACnmilDvtBZIwJ/orzlFZYspnza5Ksskpd8aA3vrUEXBTNoT1dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1LCJSDG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1LCJSDG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729157896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I3uIwasKKAKdR+VuwueBXdbmrDNzV4ilyiCVPdql6qI=;
	b=I1LCJSDGBq9EbGyTzdivUSIwd5ddOzbkh2OG7cQBlVZrovF3hAubAC2mQ6gtVkcAKOW6jK
	xs1ftCyOB8meSKvXqguvsH78dqiIZafe6EYR+kq1Ncd7hKcmVMnda2ESKH7Dv5wlQ2GuF7
	NjGamXTYfJ07NXygxaSQvVgOQOLncbw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-WTw_TAFGP-Cw9TJKBwcbig-1; Thu, 17 Oct 2024 05:38:14 -0400
X-MC-Unique: WTw_TAFGP-Cw9TJKBwcbig-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5ca5bfc8so377896f8f.0
        for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 02:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729157893; x=1729762693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3uIwasKKAKdR+VuwueBXdbmrDNzV4ilyiCVPdql6qI=;
        b=A9QZPe1O13bFzjQZj6dILhDFx2K3mGWeQxzgJcw0LreNsjk+DLqFe8Hx9XsDGbZY4Z
         6uiS0HEplv2sY4BiYh6g/SCvhnst5LGWPwKbETbLJdzlozZlHpllZ5ulhxH/pkvzCrKT
         HMbaiakWr2wpOddbvtS8XdfqQNsPPMVp3SYktpSL2RHRZlXYbh7naBJHXmGDisDMcgCB
         hcDADiJu76IlNPkRYpr/QZbdhGkLRN44q19uR2LpacsZ0PW5I9KzJYIlAij162KcL4i2
         4UzC4rl9fWthv0lts8lYUAiJRC3Lgnq5xh62PvjYmeTeGDR7dJY6CpvbLynui9pcePlP
         bLHw==
X-Forwarded-Encrypted: i=1; AJvYcCXmBMtJonj/+GBOtlVT/4G/euebbtL7Y45bSh+Dnp5J5D4L6hTmaNRwasUBjmEpRehuk1WNUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwunE8lqAuS9A4AM0JSyCFV5qHJTE/PHP5ViVb2qBoLoeeZBnqi
	PMl+uwm9npwjVSe1j62o2z/gstjkAuf+hpNG3pg2mJYxpM10Xmv8s2FNo+j6d7Y4lHOC4tJFf6y
	bsDdD1RgYVgxchzUUD3F6Bnj3k11UnAESdmeZ/UhkFdHxIEB4pSrCBEIUezbzf4w=
X-Received: by 2002:adf:fe86:0:b0:37d:46e3:4e88 with SMTP id ffacd0b85a97d-37d55198857mr13932488f8f.9.1729157892925;
        Thu, 17 Oct 2024 02:38:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGih0N2+9M2Nj3XQ42bagU7J1zycn9EMbMYFKTvb8Op7Uku9+ZF/21X/a26N+J+nwwkG2msoQ==
X-Received: by 2002:adf:fe86:0:b0:37d:46e3:4e88 with SMTP id ffacd0b85a97d-37d55198857mr13932473f8f.9.1729157892534;
        Thu, 17 Oct 2024 02:38:12 -0700 (PDT)
Received: from [192.168.88.248] (146-241-63-201.dyn.eolo.it. [146.241.63.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc12023sm6659118f8f.91.2024.10.17.02.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 02:38:12 -0700 (PDT)
Message-ID: <fab2f100-afa1-4b15-b7d8-b8ca267e959f@redhat.com>
Date: Thu, 17 Oct 2024 11:38:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 0/2] mptcp: "fix suspicious RCU usage" warnings
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <20241016-mptcp-sched-find-rcu-v1-0-5e9af4fbce11@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241016-mptcp-sched-find-rcu-v1-0-5e9af4fbce11@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/16/24 21:05, Matthieu Baerts (NGI0) wrote:
> Enabling PROVE_RCU_LIST (and RCU_EXPERT) shows list_for_each_entry_rcu()
> from mptcp_sched_find() not being used with RCU read lock held.
> 
> The first patch is a fix for -net. The other one is for a commit that is
> only in our tree.
> 
> Link: https://lore.kernel.org/20241016011144.3058445-1-kuba@kernel.org
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (2):
>        mptcp: init: protect sched with rcu_read_lock
>        Squash to "bpf: Add bpf_mptcp_sched_ops"
> 
>   net/mptcp/bpf.c      | 10 +++++++---
>   net/mptcp/protocol.c |  2 ++
>   2 files changed, 9 insertions(+), 3 deletions(-)
> ---
> base-commit: baccd7675477b1db387aa71b48c3312b5fb67a5d
> change-id: 20241016-mptcp-sched-find-rcu-649ce3399334
> 
> Best regards,

Only slightly related, but mptcp_get_available_schedulers() currently 
acquires both the rcu and the sched_list lock. I think the latter is not 
needed and should be dropped.

Cheers,

Paolo

