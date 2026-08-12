Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81983AD518
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525821; cv=none; b=RuR4Yz7vxRPhXrUFry4pdtSsx8NDJ8OiM0vPUNXHUgUlVWGrtzZkns95BOmoeDviZKcVa3cu8YUZ/lHxcF8JNm2tFF0/jhzYbTkmgu4gE2M5FF3d3IIocQnKnohUC/MSntOXwvY1ZmZIdeZ1V7fkIgettGeev/bnM4cADkCxZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525821; c=relaxed/simple;
	bh=n44If2VGgkicSXz24CfwY0BK5nNHU0rFHpHcfylBKlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S68tmtS2a7iXUyaI+Y+Y2xOSbA2DV6p4cpLhFFK+2QkWY7ukLXOriP7XM8EHwaRe7rGrOJsWjhih/u1XlDBa47zgdDtWwpoLmIfuER6DqDlbGd9NJJW9TnjGzCC8oEp8JQh21k0cR8TVwIo0uY8lhCaNAaD6ppUz/rlebrvS0+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hhVM/Su1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhVM/Su1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786525813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ru/bYOZf21mSsFe8HqKCz16SSQHB5XbOO+335H7uls=;
	b=hhVM/Su1TnxNpjjifU9WKzdfBC8AJt/8jXQVZU1rVLwxe08UF/0XRCyKJ81sWHC3NMitSL
	T/dpkiAEva6jUGhs5xEaEKALgPlrek67G7Rwuk5mT2lAJWvH4hkZZmJ5Wv4jaJGaxHguRB
	mJh5HlxQJRVZKJG6pED+c9Hk/Z8MRls=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-KkOvjQ9CP0aYdFmHcyjR-Q-1; Wed, 12 Aug 2026 05:10:12 -0400
X-MC-Unique: KkOvjQ9CP0aYdFmHcyjR-Q-1
X-Mimecast-MFC-AGG-ID: KkOvjQ9CP0aYdFmHcyjR-Q_1786525811
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-496b61bd846so4883705e9.2
        for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 02:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786525811; x=1787130611;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ru/bYOZf21mSsFe8HqKCz16SSQHB5XbOO+335H7uls=;
        b=Rw/cuTSzJLL2sBcF7hVZvS0RPf7XnvIuqpMzX6pwsFcPUZttT4J6UirWWwHVOIWaXG
         1/yc8quihKTLISAr6CU8cAdO/dc/hhCwLEG01u2YwP1I05tnNUObwLLzGU6ScR2dvbhT
         QrAPBE8swiexbtEsRhJlMj6eBrz2msy7TQQzasoIDe8DqihduLiOsMiMg82XDm382zyY
         rVL9vc79OekjUR4lmBBQkjg2h6ODEpzXKDtlekGz6FLqtFJoys9uscuvMuGTXF5momAW
         PzqectTDcsdbs/RaMP4Hst/XdJm3bBOmItQW4qPDRKWKM9RF0hItn6ukK0F6vN76oAZ+
         dqug==
X-Gm-Message-State: AOJu0YxPv+av76uU4b9iTazFcCzbPY99sGjZX90tXCbk7RVc1JyuYQWq
	zivcSuUQVGqWHofJD7nsw0qshiwpx1/NDHfY/0gVQUZSAA6yc5b5KOuG+6YbM0KlYt3Kl/4Sk2q
	Q0udJeYT58j5iAyXrGfKxep/rGRPCrYaZLusV0P2rFdZW5M3xeRX/GnyC
X-Gm-Gg: AR+sD12VaV6HzpMyUr8Y7vusOwoENLreq0cvf4/5CwNt83JnDLac2bTFKODkqBEhmo9
	8XDSKMM+RnK/4Xs3t7OPo42SUDAZPvHAQ8NmreeDTHhIkrxl2G+ydr2U0iHsJKhLDRn9Low+5YP
	h/9zlAGczoiw9Ppu0OClFG+s2Tc/fcxhkG1gpruSiL8tg9AmYHvtmNAnC3v1kAokUtHL1nsDe6/
	3AThbHk9Gqcqc1SDj6RYT9Pk1xfIH73finv9IU+P9Ym0YrZr5ztLLGddXd2bKMkehTTKgzOj6GD
	jTNo8LrqRTw/YcZVyaizVt5JB5Lb4615oo0OjZdWx7EqtOPGaoxqo0j9NrvFzWEYxuqE2bnYx3A
	0KsLLIRZ83WaITKteJ6Cpi/G7ucHoSk8WHoykpFSkApYzPxQh86kT/9mU/vdXMQ8WT0G/QHaWnJ
	I=
X-Received: by 2002:a05:600c:5020:b0:496:bffb:fb7b with SMTP id 5b1f17b1804b1-4997c13420bmr47111575e9.10.1786525810734;
        Wed, 12 Aug 2026 02:10:10 -0700 (PDT)
X-Received: by 2002:a05:600c:5020:b0:496:bffb:fb7b with SMTP id 5b1f17b1804b1-4997c13420bmr47110615e9.10.1786525810309;
        Wed, 12 Aug 2026 02:10:10 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b34afe3sm42548405e9.2.2026.08.12.02.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 02:10:09 -0700 (PDT)
Message-ID: <d98287c8-0925-4e70-8cb7-c5703d8145fa@redhat.com>
Date: Wed, 12 Aug 2026 11:10:08 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp v2] mptcp: restore full join state in syncookie
 MP_JOIN reconstruction
To: Harshit Varu <harshitvaru666@gmail.com>, netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 security@kernel.org, stable@vger.kernel.org
References: <20260811215135.87756-1-harshitvaru666@gmail.com>
 <20260811222325.90426-1-harshitvaru666@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260811222325.90426-1-harshitvaru666@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jHXcFVPfTYV-dpNZYV87feCj2GSvK21nBsDlkgXVOrc_1786525811
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 12:23 AM, Harshit Varu wrote:
> mptcp_token_join_cookie_init_state() rebuilds the request socket for a
> MP_JOIN 4th-ACK that was handled under SYN cookies, but it only restores
> remote_nonce, local_nonce, backup, join_id, token and msk from the saved
> cookie entry. local_id, request_bkup and thmac are never restored, even
> though the SYN path saves local_id and computes the other two.
> 
> subflow_ulp_clone() then reads those three fields and copies them into the
> joined subflow context (local_id, request_bkup, thmac). Because the
> request-sock slab is SLAB_TYPESAFE_BY_RCU and not zeroed on allocation, the
> values are stale bytes of previously freed request sockets, which an
> off-path peer can influence by sending concurrent MP_JOIN SYNs. A corrupted
> local_id breaks id-based path-manager bookkeeping, and a corrupted
> request_bkup misclassifies the subflow in the packet scheduler's
> backup/active selection.
> 
> Save and restore request_bkup and thmac as well, completing the state
> restore.
> 
> Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in use")
> Cc: stable@vger.kernel.org
> Assisted-by: opencode:deepseek-v4-flash
> Signed-off-by: Harshit Varu <harshitvaru666@gmail.com>
> ---
>  net/mptcp/syncookies.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
> index 7f2252634..3c25ff627 100644
> --- a/net/mptcp/syncookies.c
> +++ b/net/mptcp/syncookies.c
> @@ -27,7 +27,9 @@ struct join_entry {
>  	u8 join_id;
>  	u8 local_id;
>  	u8 backup;
> +	u8 request_bkup;
>  	u8 valid;
> +	u64 thmac;

Is thmac used for passive flows after
mptcp_token_join_cookie_init_state()? I think it's not. If so just init
to 0 in mptcp_token_join_cookie_init_state (with a comment) and remove
remove the new field from here.

Same for request_bkup, AFAICS both are used in syn_ack only.

The bottom line is that we don't want to increase `struct join_entry`
size without good reasons.

/P

