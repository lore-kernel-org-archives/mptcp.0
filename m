Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F997E
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1648140736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9LEdh/9lzBZ9ksbkPtihIQzrUqNztNRns+4eyyX48EA=;
	b=aWFWm/WFwWk7GRkjFK6Q2VM4/evWPDk0SWXc4xaAftrZ7ZBMZUlNgFy3zR9sOdG+Hsi5zS
	pvx3l5LeJ1HfGJ4HjN+LKL3ZWqVJne4Wmvj0asCN+okYNii1OhU1m+aBp5jfZb0HLCWmJb
	5U8HVEQyWX+5lZWpJgTGqrDat3iaTro=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-jCYD63H-Nze2DCI4sMyvAA-1; Thu, 24 Mar 2022 12:52:15 -0400
X-MC-Unique: jCYD63H-Nze2DCI4sMyvAA-1
Received: by mail-wm1-f72.google.com with SMTP id c62-20020a1c3541000000b003815245c642so4251438wma.6
        for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 09:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9LEdh/9lzBZ9ksbkPtihIQzrUqNztNRns+4eyyX48EA=;
        b=14l6Xjd+x4IZs9kXEMJ7n77oJXWRpzRVIMW+Y+8+BPuwLR25K6ZVyBFd3nNr0QJviA
         kAUkTOR6d4eSfdtu/ClMufhyi/RI20va4YdBu32eHDZfkYf1zKXkbcUjgO1R4Iz9OCnV
         sMw3wdgQrzZlk/sncIlX3GAa4OKkL5KYxoOZDXLbNth0SDAIZK30Lz1v3rNB/JA+Svng
         JedKAKq6ZfLeP+Ury/mNe7I+cIYy5YSdYX7uy1fRpjk2dHbEd4RTXj9INZEyYOCZswef
         cN2wEVMeQqE+IH8blARaTxqr3gbm6vPDmxWNszGrvpxKV7mwxT7FKwwNuZueN/gZuVEP
         GxCA==
X-Gm-Message-State: AOAM531UpZz0CtrpO1shB6bAF3O9X4B13KN5YTGcRDh4kI//tqvxaMI8
	peP6Q1h5Egg4A7vAFeQWm/3yT3kCOeAOmgrnVfeOGHtqOwu/QNxBoJqqjU8MCGcOQhtVvbigsaW
	oiN6XlO65iWNAAso=
X-Received: by 2002:a05:600c:4fd4:b0:38c:cc3f:ac01 with SMTP id o20-20020a05600c4fd400b0038ccc3fac01mr5646374wmq.206.1648140733856;
        Thu, 24 Mar 2022 09:52:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhSW4nucwkp0AiaQ896RD6HP0Bz+1Qu0620ywxMdvtuQunVxILg0/ygLp4gWdAIq1jiiotTA==
X-Received: by 2002:a05:600c:4fd4:b0:38c:cc3f:ac01 with SMTP id o20-20020a05600c4fd400b0038ccc3fac01mr5646358wmq.206.1648140733645;
        Thu, 24 Mar 2022 09:52:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id m2-20020a1c2602000000b0038ca9ffac53sm2518350wmm.11.2022.03.24.09.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:52:13 -0700 (PDT)
Message-ID: <4e72bdc521dd29c791a51b85700a54a03aba4c00.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 3/4] mptcp: listen diag dump support
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Thu, 24 Mar 2022 17:52:12 +0100
In-Reply-To: <20220324135753.25182-4-fw@strlen.de>
References: <20220324135753.25182-1-fw@strlen.de>
	 <20220324135753.25182-4-fw@strlen.de>
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35)
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

On Thu, 2022-03-24 at 14:57 +0100, Florian Westphal wrote:
> makes 'ss -Ml' show mptcp listen sockets.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  net/mptcp/mptcp_diag.c | 67 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
> index c4992eeb67d8..6a6dfc7eac33 100644
> --- a/net/mptcp/mptcp_diag.c
> +++ b/net/mptcp/mptcp_diag.c
> @@ -69,6 +69,8 @@ static int mptcp_diag_dump_one(struct netlink_callback *cb,
>  struct mptcp_diag_ctx {
>  	long s_slot;
>  	long s_num;
> +	unsigned int l_slot;
> +	unsigned int l_num;
>  };
>  
>  static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
> @@ -114,6 +116,71 @@ static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
>  		}
>  		cond_resched();
>  	}
> +
> +	if (r->idiag_states & TCPF_LISTEN) {
> +		int i;

perhaps here we need to add something alike:

		if (r->id.idiag_dport)
			return;

???

Also, what about moving the following chunk in separate helper -
mptcp_diag_dump_listener()?

Thanks!

Paolo

