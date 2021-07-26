Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F54470
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 08:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627287853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KF9ZGGLW84SEsdJX71qZbWgIIzlZWV40oyV0aCREANo=;
	b=X2fDNvF1tq10vtPw3GW+fXm1NNZ5q56Kh/vT2TCw039DcFYAnoIk6nAaeF6wNjv7kR0R4h
	7RMB1dT7g3PqAahrq7QqcsBMxuehCcP1xtivSswdH3ovoAWhb2y53rXCyTamnGXyzDuLRF
	j2UOjllDorESAZ2RpVcHf8z1QTgbmOw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-V5zztQNTM7iWvQc0wquh_w-1; Mon, 26 Jul 2021 04:24:11 -0400
X-MC-Unique: V5zztQNTM7iWvQc0wquh_w-1
Received: by mail-wr1-f69.google.com with SMTP id v18-20020adfe2920000b029013bbfb19640so4392901wri.17
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 01:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KF9ZGGLW84SEsdJX71qZbWgIIzlZWV40oyV0aCREANo=;
        b=tG9KRbED+mLKYp9Fm/2+p6BibXKXG3P1Y0BPREwb8kEN27yRRez/6opIOh6B6pz5pu
         baBXpqaSA4pzy6GKh1IggvFkjoTSWu3o6CPFhk3/y/ccFm+jgKx2FVi0M55NhbYdG8tY
         Uu3urvy89DNkT7sjo25zNvQDMlsSeE/0UmUKFKCRMQ6Zys2ashEt6Ywuhs7ugswf5Da5
         jZ+CzWZR9VWSsoVbcHO8J2vm4mHChM0S1y/vrGTnbgaKPmO/0uORcISGvL69lR7QtIRR
         6qxacyA8+KFK7Nr+OfvJUBJ7JlrJwJKua6DzMoI2Pz5WLFqh+iaUsGzu5VaIGC25Gr0P
         gW+Q==
X-Gm-Message-State: AOAM530JUMgbFagJXce5zqKmxfupjVhGpPdNInsPxTcN2G6mMqoSgRt/
	Q2Y0gLOcm7ALoJ6jL363czjhFIgT4nRmp8OWu8syWeMn3/mC+dukGJSMttbW51aodKEuynzwfHx
	Vk4jqcV4FPDuX2TA=
X-Received: by 2002:a7b:c846:: with SMTP id c6mr15955921wml.92.1627287850681;
        Mon, 26 Jul 2021 01:24:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3voQA1GF4txagT+4FlHdqirbYomOWHnGKC4waHaYYN6U1jG3YaX0dm+U2GBtikaYJnwEeXw==
X-Received: by 2002:a7b:c846:: with SMTP id c6mr15955907wml.92.1627287850519;
        Mon, 26 Jul 2021 01:24:10 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id a9sm41681653wrv.37.2021.07.26.01.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:24:10 -0700 (PDT)
Message-ID: <e201da79ddf683eb0b2c6198e2b7a8c69b5a3c88.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v3 mptcp-next 2/5] mptcp: local addresses fullmesh
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Mon, 26 Jul 2021 10:24:09 +0200
In-Reply-To: <043ce3b46a70bd59ae7aaa53ed1afdf44b7f3ad2.1627272435.git.geliangtang@xiaomi.com>
References: <cover.1627272435.git.geliangtang@xiaomi.com>
	 <6f7aa2fec63dcaa337c7b78184a73a90d58b580f.1627272435.git.geliangtang@xiaomi.com>
	 <043ce3b46a70bd59ae7aaa53ed1afdf44b7f3ad2.1627272435.git.geliangtang@xiaomi.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Mon, 2021-07-26 at 12:12 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> In mptcp_pm_nl_add_addr_received(), fill a temporary allocate array of
> all local address corresponding to the fullmesh endpoint. If such array
> is empty, keep the current behavior.
> 
> Elsewhere loop on such array and create a subflow for each local address
> towards the given remote address
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  net/mptcp/pm_netlink.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index f57db5b9a50f..a03e8fd3a584 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -526,12 +526,17 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
>  
>  static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>  {
> +	struct mptcp_pm_addr_entry entries[MPTCP_PM_ADDR_MAX];
>  	struct sock *sk = (struct sock *)msk;
> +	struct mptcp_pm_addr_entry *entry;
>  	unsigned int add_addr_accept_max;
> +	struct mptcp_pm_addr_entry local;
>  	struct mptcp_addr_info remote;
> -	struct mptcp_addr_info local;
> +	struct pm_nl_pernet *pernet;
>  	unsigned int subflows_max;
> +	int i, n = 0;
>  
> +	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
>  	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
>  	subflows_max = mptcp_pm_get_subflows_max(msk);
>  
> @@ -555,10 +560,34 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>  	if (!remote.port)
>  		remote.port = sk->sk_dport;
>  	memset(&local, 0, sizeof(local));
> -	local.family = remote.family;
> +	local.addr.family = remote.family;
>  
> +	entries[n++] = local;

If I read correctly, I think this entry should be added only if the
full-mesh selection below find no other entries. Otherwise, e.g. in the
simple scenario with 2 locals address, 3 subflows will be created.

> +	rcu_read_lock();
> +	__mptcp_flush_join_list(msk);
> +	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
> +		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
> +			continue;
> +
> +		if (entry->addr.family != sk->sk_family) {
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +			if ((entry->addr.family == AF_INET &&
> +			     !ipv6_addr_v4mapped(&sk->sk_v6_daddr)) ||
> +			    (sk->sk_family == AF_INET &&
> +			     !ipv6_addr_v4mapped(&entry->addr.addr6)))
> +#endif
> +				continue;
> +		}
> +
> +		if (!lookup_subflow_by_addrs(&msk->conn_list, &entry->addr, &remote))
> +			entries[n++] = *entry;

I guess the loop should stop when:

 n + <number of already existing subflows> = mptcp_pm_get_subflows_max()

Even the previous patch need a similar check.

Additional minor nit, what about encapsualting the above chunk in a new
helper - fill_source_addresses_vec() or something similar? It gets the
current pm and net as input arguments, the address vector as an output
arg, and returns the number of addresses filled into the array
(enforcing the above constraint).

This also applies to the previous patch.

Cheers,

Paolo

