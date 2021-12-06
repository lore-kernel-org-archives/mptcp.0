Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19668
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 17:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1638813158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3jn+WOigTcMBLZF0bVU2x0Xby3ijakMW6CQ1X+Omfk=;
	b=FUNFY+06fx76QqpvOYQOgeUmPZXvakGkZ1VsdKxWQb1Ue9msnM27yRiWxmO11pn7qQfsI6
	2uUwWsGLp0U7SMTSNypw9ZTv8Iw2QT96wJs3jNN26e7hpoivZqphW/zU8VV8U20tN269p7
	f/xBsV1KzxAQf2S5qEsm8o0eJFXnZ5s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-0ztDfFelPGKCfaM2dvZTFQ-1; Mon, 06 Dec 2021 12:52:37 -0500
X-MC-Unique: 0ztDfFelPGKCfaM2dvZTFQ-1
Received: by mail-wm1-f72.google.com with SMTP id c8-20020a7bc848000000b0033bf856f0easo8240936wml.1
        for <mptcp@lists.linux.dev>; Mon, 06 Dec 2021 09:52:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=n3jn+WOigTcMBLZF0bVU2x0Xby3ijakMW6CQ1X+Omfk=;
        b=Lpeaus00xqWWHCnYpMIMjGdYOTcJatI1ca0lR5cNp0fAVRL46vZrFr52B60+tuv2QH
         jtX52X+71I6w5bH/A37M6UxP4ApJG2zLfx31XfNIQyROEcrmEUxgAkkV02USc+2+1mLO
         6HQrrlsh1GeBEVCozZIHzeDkSkMheJaSPUJTUrwBIrZtbNk6F3ZGGe+TiGYX7xpuw/4B
         HBzNfoWeFVDNVWluLwM9+qlL+lYPm/QC6WhGGElZTSYwDMNz+7tTk6e+VsAfuDkbZldV
         tw3R1co3UWA4FsE5m01Oun2u+ahlXUX+vXjF2ibtHHYXmMHH7AMZo7hKWzBxVAu7pumn
         je7g==
X-Gm-Message-State: AOAM531FpB7WHnV7kUg39FEwlsSdC2JtLyHHuUCSXZ1KWxVXRAGdxSTD
	lPH3Z1OI8h2nAzNjcXS22k1B8pnfc1wj4GVSULHcHzTcwcpls7x+NBwL20JBZvNRgWUrZCde3Z8
	BMDOe52pAphdwRA4=
X-Received: by 2002:a5d:55d1:: with SMTP id i17mr45289235wrw.618.1638813156232;
        Mon, 06 Dec 2021 09:52:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1ErLBwFwFGKXTGJtB/UYlNYNEBLXHQwL9NcC1Z2SUwkvgHLnKOhsreZ8LFGeNfatilH0wbw==
X-Received: by 2002:a5d:55d1:: with SMTP id i17mr45289218wrw.618.1638813156012;
        Mon, 06 Dec 2021 09:52:36 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-1.dyn.eolo.it. [146.241.252.1])
        by smtp.gmail.com with ESMTPSA id b14sm14277423wrd.24.2021.12.06.09.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:52:35 -0800 (PST)
Message-ID: <4e28df023bad9e9e844dbac86f38038c16acbe06.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 4/6] mptcp: Make kernel path manager check
 for userspace-managed sockets
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Date: Mon, 06 Dec 2021 18:52:35 +0100
In-Reply-To: <20211202005216.154787-5-mathew.j.martineau@linux.intel.com>
References: <20211202005216.154787-1-mathew.j.martineau@linux.intel.com>
	 <20211202005216.154787-5-mathew.j.martineau@linux.intel.com>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
Precedence: bulk
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

On Wed, 2021-12-01 at 16:52 -0800, Mat Martineau wrote:
> Userspace-managed sockets should not have their subflows or
> advertisements changed by the kernel path manager.
> 
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  net/mptcp/pm_netlink.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index a74eb0444cd2..2cd491229d23 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1122,7 +1122,8 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
>  	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
>  		struct sock *sk = (struct sock *)msk;
>  
> -		if (!READ_ONCE(msk->fully_established))
> +		if (!READ_ONCE(msk->fully_established) ||
> +		    (READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_KERNEL))

I'm ok with merging the series as is, but if you are considering
another version, what about replacing a 'READ_ONCE(msk->pm.pm_type) !=
MPTCP_PM_TYPE_KERNEL' with an helper, e.g. something alike
mptcp_pm_is_user_space(sk) ?

Cheers,

Paolo

