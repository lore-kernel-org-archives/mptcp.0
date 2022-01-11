Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686422C9C
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 15:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1641915107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UsJcOhUmNc1/3AweRI4kiw2/Df5dMtsXyIEeiRhr+XM=;
	b=T67Kxb9s/ZQqTQ5E0uAtY2zgNKdT8Q6fQtSUo/SmCRL0PVf0RsuTcFzOY0FiWwdIEbTore
	NzPAaPOB6a7pAW/MCqYos0KYcfxD6RD5HnkGx90fRqLM0X0derBOW5CVPe0t9E3rB2WTf6
	kmtjFbhkh+EmnlSJeDgESZ1SW/uhIjk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-ZP-vz5_VPEamxE6UnRGpog-1; Tue, 11 Jan 2022 10:31:41 -0500
X-MC-Unique: ZP-vz5_VPEamxE6UnRGpog-1
Received: by mail-wm1-f72.google.com with SMTP id s17-20020a7bc0d1000000b00348737ba2a2so2003818wmh.2
        for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 07:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=UsJcOhUmNc1/3AweRI4kiw2/Df5dMtsXyIEeiRhr+XM=;
        b=DsnlB7w/xBCIKXztXP5T5+mYqpE/rF/kFVZauvWgQsSla/MSbLghGoA+z+onj659E5
         YJE5jepEW5dEqIXPZ/dNc9G9zq22J6TEqB0YK3X36iu0jQzaR5vryjDCKeGqEpy5eyrH
         EZDc/9JWiouR99dHFLcFS9KxSETAirGYzZ3cJUO+X7HLUVbt9r+nVmRB6wSHf+DqxvEn
         M4kwEMaigcrZ/AaEXueOy7XzKJkTSKnNXHigd1dHMsa0jA+xOFUu1lrGK0k7V7ikSnzG
         7/0eQsmTn3duU6ylYmNJUJRbSkzZjkUxztlTe8I/o9+3f46aiLB7mL1AzCLEO/O/oy4R
         uAUg==
X-Gm-Message-State: AOAM5328Y8gOOHck7tauHnaBWxPzogMwTuW6xePiAsA7PiPodUIiKpSr
	hY90u42umLfkaQNomIZJ8T2PBiq3aOYX6IStHZ7Q8KxLhIpAP9ByuaeNhv+VcS9Zrroxbewc3Rz
	Kwzt/TJdQfknSk+w=
X-Received: by 2002:a05:6000:16c4:: with SMTP id h4mr4180363wrf.312.1641915099847;
        Tue, 11 Jan 2022 07:31:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIENrJ0Z/YitgD4EXFhYSaU6M5BjdwkDvNobTKccdXrucKoLf8vISc06sZQwQNqrC18xv4Vg==
X-Received: by 2002:a05:6000:16c4:: with SMTP id h4mr4180347wrf.312.1641915099606;
        Tue, 11 Jan 2022 07:31:39 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id a8sm5189795wrx.57.2022.01.11.07.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 07:31:39 -0800 (PST)
Message-ID: <a150c86a658bbf22559272fef45507f481db4a56.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v3 1/3] mptcp: set fullmesh flag in pm_netlink
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Tue, 11 Jan 2022 16:31:38 +0100
In-Reply-To: <6b320b4a008759cc851dee72ceba693c8ff7bf52.1641913113.git.geliang.tang@suse.com>
References: <cover.1641913113.git.geliang.tang@suse.com>
	 <6b320b4a008759cc851dee72ceba693c8ff7bf52.1641913113.git.geliang.tang@suse.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
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

On Tue, 2022-01-11 at 23:06 +0800, Geliang Tang wrote:
> This patch added the fullmesh flag setting support in pm_netlink.
> 
> If the fullmesh flag of the address is changed, remove all the related
> subflows, update the fullmesh flag and create subflows again.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_netlink.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 4c06cd6381ef..ef1d58373ef2 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1722,7 +1722,18 @@ mptcp_nl_cmd_get_limits(struct sk_buff *skb, struct genl_info *info)
>  	return -EMSGSIZE;
>  }
>  
> -static int mptcp_nl_addr_backup(struct net *net,
> +static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
> +				 struct mptcp_addr_info *addr)
> +{
> +	struct mptcp_rm_list list = { .nr = 0 };
> +
> +	list.ids[list.nr++] = addr->id;
> +
> +	mptcp_pm_nl_rm_subflow_received(msk, &list);
> +	mptcp_pm_create_subflow_or_signal_addr(msk);
> +}
> +
> +static int mptcp_nl_addr_flags(struct net *net,
>  				struct mptcp_addr_info *addr,
>  				u8 bkup)
>  {
> @@ -1739,6 +1750,7 @@ static int mptcp_nl_addr_backup(struct net *net,
>  		lock_sock(sk);
>  		spin_lock_bh(&msk->pm.lock);
>  		ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
> +		mptcp_pm_nl_fullmesh(msk, addr);

I think it would be better moving the check for
MPTCP_PM_ADDR_FLAG_SIGNAL here (the following assumes
mptcp_nl_addr_flags() get a mptcp_pm_addr_entry argument, see below):

		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
			mptcp_pm_nl_fullmesh(msk, &entry->addr);

>  		spin_unlock_bh(&msk->pm.lock);
>  		release_sock(sk);
>  
> @@ -1757,6 +1769,7 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
>  	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
>  	struct net *net = sock_net(skb->sk);
>  	u8 bkup = 0, lookup_by_id = 0;
> +	u8 fullmesh = 0;
>  	int ret;
>  
>  	ret = mptcp_pm_parse_addr(attr, info, false, &addr);
> @@ -1765,6 +1778,8 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
>  
>  	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
>  		bkup = 1;
> +	else if (addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH)
> +		fullmesh = 1;
>  	if (addr.addr.family == AF_UNSPEC) {
>  		lookup_by_id = 1;
>  		if (!addr.addr.id)
> @@ -1778,14 +1793,25 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
>  		return -EINVAL;
>  	}
>  
> +	if (fullmesh && (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
> +		spin_unlock_bh(&pernet->lock);
> +		return -EINVAL;

With the change proposed above we can drop this chunk, and avoiding
returning an error.

> +	}
> +
>  	if (bkup)
>  		entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
>  	else
>  		entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
> +
> +	if (fullmesh)
> +		entry->flags |= MPTCP_PM_ADDR_FLAG_FULLMESH;
> +	else
> +		entry->flags &= ~MPTCP_PM_ADDR_FLAG_FULLMESH;
> +
>  	addr = *entry;
>  	spin_unlock_bh(&pernet->lock);
>  
> -	mptcp_nl_addr_backup(net, &addr.addr, bkup);
> +	mptcp_nl_addr_flags(net, &addr.addr, bkup);

If we change the 2# arguments of mptcp_nl_addr_flags() to
'mptcp_pm_addr_entry' and we pass '&addr' here, we can drop the 'bkup'
argument. It's a bit strange to provide 'bkup' but not 'fullmesh'.

I think all the mentioned changes could land in a squash-to patch, if
that fits others.

Thanks!

Paolo

