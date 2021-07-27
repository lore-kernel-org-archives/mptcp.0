Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5251A70
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 09:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627379566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrNXODH1kfmRCXD/VFYWITQEOQZpJmJcXAWdXgZXGG8=;
	b=YYRfGXe3XuGifvohTndZdfb8CwG02YfrSvsPpzukdsxbVaqmr6FkR52tsPuV6U3LtwOp3g
	Idw6HxPvyLeFoQp1JgbwTq14l1ctKf5gnTSmYKoNqn5WLjpfxEsLeTsApgShXwf4QZJNen
	vdZSGDQd6cWy0PoXOf19X4vcxQmUwhM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-NTtBjbpcOuuuOB3ubIhK-Q-1; Tue, 27 Jul 2021 05:52:44 -0400
X-MC-Unique: NTtBjbpcOuuuOB3ubIhK-Q-1
Received: by mail-wr1-f69.google.com with SMTP id s22-20020adf97960000b02901535eae4100so3843538wrb.14
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 02:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ZrNXODH1kfmRCXD/VFYWITQEOQZpJmJcXAWdXgZXGG8=;
        b=XniTLkJhlN+DLNiwarksUmycnYPqI7H0B4sPSyzNS4jNqaPaWUuxCon2Sz+crTnKr0
         hqlcDhLLUcgfREu8SSLIh4DTwcgNLmL7UfXV+Puyl3m/1loKEbraayrme1+ze3tiFwXu
         4lLQ3IVCBuW6uwA5NWtRIKB8we2mVUrBH6deYaZcOe7oZSw8rU4S/76tYqR8PcogVAan
         nzKiffmRGaQj1R9mdErcyLl4HXgwRlARldN5nEtmZykNToXUtQGZqdrVNIcuOViUJj4u
         tU94fWeSogqWQypRUf+fPnxu+UJr0bEIscWvUaaPHcRh+sR4geBx3GyqYIq1zylCqgmh
         OFJw==
X-Gm-Message-State: AOAM531xeZojtaidLSSdZ0OrLgEVcamPd9NjDpMcd1s9jkQd+9sekU5i
	/jJqrZfO/w0zm0YSSW0F5SqWlUCDo0sft8NMKaqGm5agZrRyJb0C4wv6uPMCC1EBGt5VhShmiBZ
	LRpXfEW7b0CE5W0g=
X-Received: by 2002:a05:600c:4fca:: with SMTP id o10mr19382695wmq.189.1627379563102;
        Tue, 27 Jul 2021 02:52:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyypA3R6t5EPGO3ZUbve3omsa4YTjY4t20FylP8l4LSq7gkGE8YiHZAlpOq4DXXiw3WWYB1jw==
X-Received: by 2002:a05:600c:4fca:: with SMTP id o10mr19382680wmq.189.1627379562837;
        Tue, 27 Jul 2021 02:52:42 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id d203sm2477753wmd.38.2021.07.27.02.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 02:52:42 -0700 (PDT)
Message-ID: <a642a08ee7444cf6607946010a4eabadcdc12535.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v5 mptcp-next 2/5] mptcp: local addresses fullmesh
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Tue, 27 Jul 2021 11:52:41 +0200
In-Reply-To: <bde1048019780ecc5f2e553bbb4eb21213f76ba7.1627372396.git.geliangtang@xiaomi.com>
References: <cover.1627372396.git.geliangtang@xiaomi.com>
	 <b8af3a77da2fcd8e16e8b5d6b63c7c8386abcbac.1627372396.git.geliangtang@xiaomi.com>
	 <bde1048019780ecc5f2e553bbb4eb21213f76ba7.1627372396.git.geliangtang@xiaomi.com>
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

On Tue, 2021-07-27 at 15:58 +0800, Geliang Tang wrote:
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
>  net/mptcp/pm_netlink.c | 60 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 55 insertions(+), 5 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 2259c424485f..a85bac950f3b 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -554,13 +554,62 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
>  	mptcp_pm_create_subflow_or_signal_addr(msk);
>  }
>  
> +static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
> +					     struct mptcp_addr_info *remote,
> +					     struct mptcp_pm_addr_entry *entries)

Minor nit: some comments here before the function describing it would
be helpful, thanks!

Also 'remote' could be 'const', I think.

> +{
> +	struct mptcp_pm_addr_entry local, *entry;
> +	struct sock *sk = (struct sock *)msk;
> +	struct pm_nl_pernet *pernet;
> +	unsigned int subflows_max;
> +	int i = 0;
> +
> +	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
> +	subflows_max = mptcp_pm_get_subflows_max(msk);
> +
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
> +		if (!lookup_subflow_by_addrs(&msk->conn_list, &entry->addr, remote) &&
> +		    msk->pm.subflows < subflows_max) {
> +			msk->pm.subflows++;
> +			entries[i++] = *entry;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	if (!i) {
> +		memset(&local, 0, sizeof(local));
> +		local.addr.family = remote->family;
> +
> +		msk->pm.subflows++;
> +		entries[i++] = local;
> +	}
> +
> +	return i;
> +}
> +
>  static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>  {
> +	struct mptcp_pm_addr_entry entries[MPTCP_PM_ADDR_MAX];

mptcp_pm_addr_entry is quite larger than mptcp_addr_info (should be 64
bytes vs 24). 64 * 8 == 512 bytes could be a bit too much storage for
the stack. What about using instead:

struct mptcp_pm_addr_info addresses[MPTCP_PM_ADDR_MAX];
u8 flags[MPTCP_PM_ADDR_MAX];

?

And than pass the 2 arguments to fill_local_addresses_vec(), instead of
the single 'entries' arg.

Cheers,

Paolo

