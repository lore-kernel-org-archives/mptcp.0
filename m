Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5862F80
	for <mptcp@lists.linux.dev>; Wed,  9 Jun 2021 17:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623258082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5dd2KQhhkg/GabXEwyWmsgQ747lZh/JV/Dt1XuY16oE=;
	b=QcQo8II5FjJYZgY5AphkftRHVCWFIJ8naRL2hNrR6M9M3VkhL3gs9jRj7i5yHLTN4NdJwB
	WbYQ/ZJQJpxcYt0tKBN6dIOL87X+zCf393thVyREU3e6F/stvN7H0JoHh+YNfDPSI7loau
	1HuiAxReE7RqBB640IHXYdN205mPy4E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-ptVMVlmvMGCR7-y0RAcxyg-1; Wed, 09 Jun 2021 13:01:21 -0400
X-MC-Unique: ptVMVlmvMGCR7-y0RAcxyg-1
Received: by mail-wr1-f69.google.com with SMTP id d5-20020a0560001865b0290119bba6e1c7so7058770wri.20
        for <mptcp@lists.linux.dev>; Wed, 09 Jun 2021 10:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5dd2KQhhkg/GabXEwyWmsgQ747lZh/JV/Dt1XuY16oE=;
        b=ObS0CJ5YXtrcdeeGQDJBZvRt1LvLCmrUPayDG9PpN4Iwau+m+/j+6wbonC8D78swu8
         6A5ds/EJnMNdpX70MSbXUyuelJBE5CBv2++649y3PoJFq2xRHcbWjQnsdhGU6L+SRs09
         XsW/1gxNfOn6dyBbHOmKZLj6D8p8N520TGZeRJ0hSRmmU1YcDFJWpMNuDGuaLxbonbCJ
         wGQb6rM71NVz4FhDXuvWHMDYAVkTCPkCjaZAbSBkislihg0X6h6KWpCoCi95M33UY71F
         AZYYImAl3vx8NuRqVNtuBM/1ImLkJc46MQjaXEToa5kq2IPa5hewWeMXgpvpla9/qX/y
         fH0g==
X-Gm-Message-State: AOAM533NdF7fZ1/KwY4NCXX4CqGdXIZ5hb7TxLQgBH9MipTQ19nCYJ+N
	9ig3XqlAVJfr483Dlqyh1/EqvCRl47TWW3eLgILHEfPD0mi47bRoHgXxab19euVFHc9buvl3n7c
	7OH/elFXIWMAEIVU=
X-Received: by 2002:a5d:540a:: with SMTP id g10mr864472wrv.254.1623258079933;
        Wed, 09 Jun 2021 10:01:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNl5MBrhkfzd7YxzVN0qygBazPpwuvy9RpXb4Xutz/tO8HthJ6rB5s9X2H348VAtS4rICYlQ==
X-Received: by 2002:a5d:540a:: with SMTP id g10mr864450wrv.254.1623258079708;
        Wed, 09 Jun 2021 10:01:19 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id v15sm6666126wmj.39.2021.06.09.10.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 10:01:19 -0700 (PDT)
Message-ID: <a0903efe53d0fdf34379cd7313a4a6bec647cff1.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v8 mptcp-next 3/4] mptcp: add deny_join_id0 in
 mptcp_options_received
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Date: Wed, 09 Jun 2021 19:01:18 +0200
In-Reply-To: <5111dfce361c87c83e5355e78e55b6f593bac55b.1621933974.git.geliangtang@gmail.com>
References: <cover.1621933974.git.geliangtang@gmail.com>
	 <b7f8df04d7b08026ee10cf2a784afda85e8cf6df.1621933974.git.geliangtang@gmail.com>
	 <57e35b700b797c875966ae26252ae07316853837.1621933974.git.geliangtang@gmail.com>
	 <5111dfce361c87c83e5355e78e55b6f593bac55b.1621933974.git.geliangtang@gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,

On Tue, 2021-05-25 at 17:17 +0800, Geliang Tang wrote:
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 1e921b5103bf..0d30008f0313 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -83,6 +83,9 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>  		if (flags & MPTCP_CAP_CHECKSUM_REQD)
>  			mp_opt->csum_reqd = 1;
>  
> +		if (flags & MPTCP_CAP_DENY_JOIN_ID0)
> +			mp_opt->deny_join_id0 = 1;
> +
>  		mp_opt->mp_capable = 1;
>  		if (opsize >= TCPOLEN_MPTCP_MPC_SYNACK) {
>  			mp_opt->sndr_key = get_unaligned_be64(ptr);
> @@ -360,6 +363,7 @@ void mptcp_get_options(const struct sock *sk,
>  	mp_opt->mp_prio = 0;
>  	mp_opt->reset = 0;
>  	mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
> +	mp_opt->deny_join_id0 = 0;
>  
>  	length = (th->doff * 4) - sizeof(struct tcphdr);
>  	ptr = (const unsigned char *)(th + 1);
> @@ -1047,6 +1051,8 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  	}
>  
>  	mptcp_get_options(sk, skb, &mp_opt);
> +	if (mp_opt.deny_join_id0)
> +		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);

I'm sorry for the long delay. Overall LGTM. The only thing I see worth
mentioning is the above test: is done for each incoming packet, but we
really need to check it for MPC ACK packet, right? if so the test
should be probably moved into the suitable section of
check_fully_established() - e.g. after the 'if (!mp_opt->mp_capable) {'
block.

No need for a resend, a squash-to patch will suffice  - if my above
assumption is correct.

BTW it looks like there are no check for the C bit being unmodified
between MPC syn and MPC ack, and AFAICS the RFC don't mention that
case. I think/guess we can simply fetch the MPC ack value.

Cheers,

Paolo

p.s. this really means acked-by ;)

