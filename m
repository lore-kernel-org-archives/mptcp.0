Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5362A6AB4
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 19:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656532758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9IarLR/f5S+7PpjR6U8Mt3nQci1pbOiNfk7CBUXDDL4=;
	b=Ik3TVGfNsLEw8eKtITbTQMCtAdvX2sObkT07OpDL+Frt160WEmzNq7mRzIvaQIlbjAvDq+
	3y8fn9J6WFupdrwof0oFDZZwYbzERC4xzuwwqhIslzAbMWtbwSf1p0G6BVSLFz1OXMRydE
	fV0uvZHsRDT84AsIAsc6uW8skqb88dY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-vQkNpdOXOzm8lmaRQSG8Tg-1; Wed, 29 Jun 2022 15:59:17 -0400
X-MC-Unique: vQkNpdOXOzm8lmaRQSG8Tg-1
Received: by mail-wm1-f70.google.com with SMTP id h125-20020a1c2183000000b003a03a8475c6so6518056wmh.8
        for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 12:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9IarLR/f5S+7PpjR6U8Mt3nQci1pbOiNfk7CBUXDDL4=;
        b=HItd2zuif1lhQNJ9EjALVd2G/ZF2P+GgvshGnZFrMmZkGxnJagWm7+Ez6SnQCZ8WZb
         cS1v2jNY5sZFHBT0e9oJeu6z13GUQxPj9wGAmNRM4uuDadHXCfKDVoUaeFmbS5mC+dG9
         yN3wbrGbMGzz5KGuonAm9waebhbMadr2+gBxwQYwkodayS3gAl32dhLfX0ZW+Rlw+c8v
         NOWe1NNtp3LV3NtjWKO/dnQrhfKyfFsVLjoOCPjNSq3Aa9ROaA88huumBAS9RceJ4Fc2
         9z9+2fXPfWOmjVL27oRSCxMCfFXItx6gt4b01KqI5d04t/Bo+Dm+puoOS30FFo2IpmYS
         VUrA==
X-Gm-Message-State: AJIora/zRE2bj93Ffp9Gi7DQKtozuXletwnUhbZl7H8qjqgdqc9InkSo
	nfQLPYcm/j48Qf05H50fXcDDHSym+bWJm3deYf4j6HTzXC6MpWkbiN0ANp9LWqwhYS9i2/rWRzv
	VrX1A59KOskhTUlY=
X-Received: by 2002:a05:600c:4f42:b0:3a0:57ed:93a9 with SMTP id m2-20020a05600c4f4200b003a057ed93a9mr5549487wmq.143.1656532755539;
        Wed, 29 Jun 2022 12:59:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uIVsbe5fRzCH3Iy8QFfWsMDAs7pvBZfIzLEX71CCDmpSuypmF3Gby9yzqDpMDOaTWq8quVDA==
X-Received: by 2002:a05:600c:4f42:b0:3a0:57ed:93a9 with SMTP id m2-20020a05600c4f4200b003a057ed93a9mr5549474wmq.143.1656532755281;
        Wed, 29 Jun 2022 12:59:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-148.dyn.eolo.it. [146.241.106.148])
        by smtp.gmail.com with ESMTPSA id r13-20020adfe68d000000b0021018642ff8sm18661150wrm.76.2022.06.29.12.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:59:14 -0700 (PDT)
Message-ID: <0a3f73ff8a19509737147af305cc521abb1bca9b.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 3/3] mptcp: Acquire the subflow socket lock
 before modifying MP_PRIO flags
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Date: Wed, 29 Jun 2022 21:59:13 +0200
In-Reply-To: <20220628190356.326233-4-mathew.j.martineau@linux.intel.com>
References: <20220628190356.326233-1-mathew.j.martineau@linux.intel.com>
	 <20220628190356.326233-4-mathew.j.martineau@linux.intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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

On Tue, 2022-06-28 at 12:03 -0700, Mat Martineau wrote:
> When setting up a subflow's flags for sending MP_PRIO MPTCP options, the
> subflow socket lock was not held while reading and modifying several
> struct members that are also read and modified in mptcp_write_options().
> 
> Acquire the subflow socket lock earlier and send the MP_PRIO ACK with
> that lock already acquired.
> 
> Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  net/mptcp/pm_netlink.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d04b34fc9a8e..05c6a95e9c28 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -729,11 +729,13 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>  		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>  		struct sock *sk = (struct sock *)msk;
>  		struct mptcp_addr_info local;
> +		bool slow;
>  
>  		local_address((struct sock_common *)ssk, &local);
>  		if (!mptcp_addresses_equal(&local, addr, addr->port))
>  			continue;
>  
> +		slow = lock_sock_fast(ssk);
>  		if (subflow->backup != bkup)
>  			msk->last_snd = NULL;
>  		subflow->backup = bkup;
> @@ -742,7 +744,8 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>  		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);
>  
>  		pr_debug("send ack for mp_prio");
> -		mptcp_subflow_send_ack(ssk);
> +		__mptcp_subflow_send_ack(ssk);
> +		unlock_sock_fast(ssk, slow);

After this chunk, we can remove mptcp_subflow_send_ack() from
protocol.h and make it static. I think it's easier squashing this patch
into the previous one.

Thanks!

Paolo
>  
>  		return 0;
>  	}

