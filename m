Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1862D7DEF
	for <mptcp@lists.linux.dev>; Wed,  1 Apr 2026 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775073777; cv=none; b=TmQFt01aqjEzVsfg5MNQ+oS6wh0qGNJcE8xwaf3cfMWNMQabXS+LH5orATAMuSP5Oh6rc+lexHBa9lBqmF0pMwetA5NtbvjSMZ8MSsZbPFF7qGNHxTMUgTQ9tmjhFnCVd6Smc/ZoVC8hxvtjFJcqHHWo/Im1NY9E9hCKieCecg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775073777; c=relaxed/simple;
	bh=kN/7YKYjBxiodFU8jeoIBJpcNN2G8/NCgIRQw2wlA1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCyIksjjYS+oTzfBCyF/k9brvJSW8x7TwLIlnTZJnvxKXXO7ZbJbnLT2+ByNr9+iUy2rL4igrLhQb1/GZJbVI/oAI2/LUKDytb1mQ1gBYewf+mRRNMWBQ1LwB9XdM/F4WOBxD0x5NRlKSqcqW8+6BJt2nJ4GQTvjv8+4hW5IaTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GureRUl8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GureRUl8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775073775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1nGaw8WyTDH+Jx21aI8aiGoMoxLTMEwDBycJF8vYQc=;
	b=GureRUl8artoq8qSAckcDNvx6MMO0LQfMUThARo/619ycdgdAE5+YS0k6ADp7uejxyqtvb
	e9U3ZOIL2EeDGWgIFlp6uaj8pANWO2EO3k6HMJry4YaoS3sW3wDa7dKF6APpod4wXeS2yz
	Y3uEj4ROfbiAqD1wUYdVYRVwpyY/dYU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-Ta-UzHDXOZ23OoSZpmALfQ-1; Wed, 01 Apr 2026 16:02:53 -0400
X-MC-Unique: Ta-UzHDXOZ23OoSZpmALfQ-1
X-Mimecast-MFC-AGG-ID: Ta-UzHDXOZ23OoSZpmALfQ_1775073773
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48884e969f8so472455e9.1
        for <mptcp@lists.linux.dev>; Wed, 01 Apr 2026 13:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775073772; x=1775678572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1nGaw8WyTDH+Jx21aI8aiGoMoxLTMEwDBycJF8vYQc=;
        b=awhBYQnc/0BARRw3KUd6adf04nKysDzFyllgtLE7Uslti+eT/3i4xto+ptMKKKNcjq
         D/Fb4k3bmYfrNwz1uFTcZ5ejx7UN9dfChIaIEl6A7zXY73jn39dKoYCl72+MHQD0QFQc
         D35i/B+KlldBBY3TiL9WytXJMGLCarb1N0Icb5zVIMpHiVZOUv1Wh1/A11hknZTzxHy4
         A4nsVfAoMX36GY4f4Uf8XOxEYlcWUndhI/5gOYRgFQll/XKbQLYchIJWMgNZq65TVYDO
         0jwlK0egE36H5DECNTb4F0kLp6LlXWjdS7TERJ4gWq+84AGs2J0oOcSuH3/KZ5Iq2ikR
         ix7A==
X-Forwarded-Encrypted: i=1; AJvYcCW68+VqtVg/qtW64yC/t+JqtnPnI6PGnX7IcHKR2nzxfC0MQ2WAgsHteXVjp5dl3zc7Bwoz5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRHIsCuJcBN0m1jBiH9KIdNFCFrp4IY936NyvXTa/xr2qg17Vv
	v7K8RrrtppcFO9QPa7qms5nXTvEDWEZMn8dVuHt41W4HqzP91uaZDuTNLrT2wBQSYAVxOpEJhym
	ipzzvwj3+JLPl//F87vUYUUfXW+wTOfhoE22kVmfV6J0VrcHJz7gALulE
X-Gm-Gg: ATEYQzxmOHsCSJdXpsfqGxFwvcpGw+0dWSYENb4szB5zlIQJRb2ZdBF6UMvFt7XzkvC
	uxE4bDMKxXPZ9aAbBW1/R/ujWo9ZMn7rqjFLT21p37w+T7PCUl8ZV8kIgnOwJlOSA3V7sSwMV1W
	ZbvRFKgRaMv5LPxlL5GCi3HP8+870m9623wRtsywP7b2GYnQSYjNj0/0JKzqepp2cHGDy2+bExI
	XtUFYZp+pG7uAauLHasiJAYhJQ19Di4dQfzb9ovgp/+DNAtrZU9D6iTZ9boEfAS8ek9P0TbKw0k
	5SCoX3c3HSXWXFH3vdo/Y+YrcmWSj/RBETDSiHJwMVIEujA76vbV59oZlHMoMmHzZH5JzNosG9y
	L42R8SwgrJ1lhOjNQGP5fOuo6oLmqHwM96b9yI3chaROU/pwW16CoI09k7g==
X-Received: by 2002:a05:600c:1603:b0:488:8bdd:cfcc with SMTP id 5b1f17b1804b1-4888bddd0f7mr3911615e9.0.1775073772554;
        Wed, 01 Apr 2026 13:02:52 -0700 (PDT)
X-Received: by 2002:a05:600c:1603:b0:488:8bdd:cfcc with SMTP id 5b1f17b1804b1-4888bddd0f7mr3911235e9.0.1775073772059;
        Wed, 01 Apr 2026 13:02:52 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a616sm227344365e9.2.2026.04.01.13.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 13:02:51 -0700 (PDT)
Message-ID: <159f8b70-4ffa-4eef-a3ca-13de3f8bc191@redhat.com>
Date: Wed, 1 Apr 2026 22:02:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v5 4/5] mptcp: fix the dead_lock in
 mptcp_data_ready
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>, Geliang Tang <geliang@kernel.org>
References: <cover.1775033340.git.yangang@kylinos.cn>
 <8ed0aeb49f13410b25200d884c89ef3201d2c23b.1775033340.git.yangang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <8ed0aeb49f13410b25200d884c89ef3201d2c23b.1775033340.git.yangang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0sYbToLSEfB90HqAk-LvLWXXjWyCa1Q6IPG6o0lRrkI_1775073773
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/26 10:54 AM, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> This patch defers mptcp_check_data_fin from __mptcp_move_skbs to avoid
> deadlock.
> 
> When processing backlogged data in softirq context, __mptcp_move_skbs
> directly calls mptcp_check_data_fin, which can lead to a deadlock if
> the msk socket is in TCP_FIN_WAIT2 state. In that case,
> mptcp_check_data_fin calls mptcp_shutdown_subflows, which attempts to
> lock the subflow socket with lock_sock_fast() - a sleeping function
> that cannot be called in atomic context (softirq).

The fix for such issue should be squashed inside the patch generating
the issue itself.

> The correct pattern is already used in move_skbs_to_msk: if a data fin
> is pending, schedule the work to be processed later in process context
> rather than handling it directly.
> 
> Reported-by: Geliang Tang <geliang@kernel.org>
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
> Notes:
> 
> Hi Matt,Paolo:
> 
> Here is the response of AI review for this patch:
> 
> - Typo problem in subject line:
>     Already fixed in v5.
> 
> - Remove else branch:
>     It demonstrates a TOCTOU race, though the race window is extremely
>     narrow. The else branch is useless even without the race. So I
>     removed it in v5. WDYT?
> 
> Thanks,
> Gang
> 
> Changelog:
> v5:
>   - Fix typo in title.
>   - Remove the else branch.
> 
> ---
>  net/mptcp/protocol.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 326b5d4d79e7..88e19fa61b84 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2247,8 +2247,9 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
>  	}
>  
>  	__mptcp_ofo_queue(msk);
> -	if (moved)
> -		mptcp_check_data_fin((struct sock *)msk);
> +	if (moved && mptcp_pending_data_fin(sk, NULL))
> +		mptcp_schedule_work(sk);

Scheduling the worker when we are not in BH could introduce problematic
delays. Instead you could factor out a ____mptcp_move_skbs() helper (a
better name would be nice!) not including the mptcp_check_data_fin()
call, use the latter in mptcp_data_ready() and in such function
eventually schedule the mptcp work as needed.

/P

