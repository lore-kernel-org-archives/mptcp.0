Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F813483
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 11:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627557126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8Req4rniq6ogUqW/qHEr9v47DHiWJOsNPeyPpcKDCE=;
	b=MAQ7qmXaFWpKA9SmtpA/iBiv7JL3jmXzM/pA6BSCp1OB8Dz+hUvHC1LWybCDZFppeE2u8k
	ulABp1Pa8ZXc6xiQWNgSFPn56XGFTvTrzZDyFpvFXggJ4LzZ8hlfaKyOV/Jr4KQ1Jn5e3u
	siJDyHPjNGvMydzfzZRzhPG2lNfpAwg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-fhKWy-kjPli9Gbtpp-sK2g-1; Thu, 29 Jul 2021 07:12:04 -0400
X-MC-Unique: fhKWy-kjPli9Gbtpp-sK2g-1
Received: by mail-wr1-f70.google.com with SMTP id l12-20020a5d6d8c0000b029011a3b249b10so2106580wrs.3
        for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 04:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=k8Req4rniq6ogUqW/qHEr9v47DHiWJOsNPeyPpcKDCE=;
        b=l85Rsv22HErGX1P0L+zJQTk0bYb1Pq7H+l9UBc0S2Hcaocws+N/+FeqZhtK03vFGEB
         eUDnY19qkSFbcpnwI/4n6Gk36SMCOtJHPfbeXG4z4h7kojUk1mUqk1IAUaCKyvLpDy+A
         dFiLOQhKTnoDtVtBa/CPTpbQUbonS3+YWunUI2WSz52r8WeZFsV2suLA/6JXPEbULulz
         OFeBv1YKz2GXTJ45lkd4bun6OkrVH1fg9xuROme6Z3LmjhzQWicXvfZdBl8ia0mkeO2B
         wxQ0OKT7YrH1dQwP4+crJGqcd/dets3ZkuPfFmKSJ1o7+elU8LkWVF42v2OCB2sTHbsc
         rhjg==
X-Gm-Message-State: AOAM533PWnF6zyVjWLSYHux8fogMNjCJJAmp8S7ya6iiHxwnXpuWIa80
	pinxihGTatf+KpgzuDQH3mxvRQ3HgyVUSiD68uTKtHHM880vLUDdAJiiFYt9nM0iZsx80cL3xdC
	/NjzpVCiHENVTIAs=
X-Received: by 2002:a7b:c40c:: with SMTP id k12mr14366506wmi.166.1627557123194;
        Thu, 29 Jul 2021 04:12:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWa+RnhpHEtKbdZmWEflP/eXBaXWQwFW6wn27F9Ws6lRjdg0gAaVJ935I4FN5x+fFcVBH8ew==
X-Received: by 2002:a7b:c40c:: with SMTP id k12mr14366481wmi.166.1627557122957;
        Thu, 29 Jul 2021 04:12:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id 6sm8929861wmi.3.2021.07.29.04.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 04:12:02 -0700 (PDT)
Message-ID: <f7de86246eb6e6bbae3235f5d78307cc0015f23e.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v7 mptcp-next 1/6] mptcp: drop flags and ifindex
 arguments
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Thu, 29 Jul 2021 13:12:01 +0200
In-Reply-To: <1244ff06f1715f714ccc21bb164c6c082e8a26f5.1627543032.git.geliangtang@xiaomi.com>
References: <cover.1627543032.git.geliangtang@xiaomi.com>
	 <1244ff06f1715f714ccc21bb164c6c082e8a26f5.1627543032.git.geliangtang@xiaomi.com>
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

On Thu, 2021-07-29 at 15:20 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> This patch added a new helper mptcp_pm_get_flags_and_ifindex_by_id(),
> and used it in __mptcp_subflow_connect() to get the flags and ifindex
> values.
> 
> Then the two arguments flags and ifindex of __mptcp_subflow_connect()
> can be dropped.
> 
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  net/mptcp/pm_netlink.c | 25 ++++++++++++++++++++++---
>  net/mptcp/protocol.h   |  5 +++--
>  net/mptcp/subflow.c    |  7 +++++--
>  3 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index ba0e1d71504d..94c68d6093de 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -462,8 +462,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>  			check_work_pending(msk);
>  			remote_address((struct sock_common *)sk, &remote);
>  			spin_unlock_bh(&msk->pm.lock);
> -			__mptcp_subflow_connect(sk, &local->addr, &remote,
> -						local->flags, local->ifindex);
> +			__mptcp_subflow_connect(sk, &local->addr, &remote);
>  			spin_lock_bh(&msk->pm.lock);
>  			return;
>  		}
> @@ -518,7 +517,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>  	local.family = remote.family;
>  
>  	spin_unlock_bh(&msk->pm.lock);
> -	__mptcp_subflow_connect(sk, &local, &remote, 0, 0);
> +	__mptcp_subflow_connect(sk, &local, &remote);
>  	spin_lock_bh(&msk->pm.lock);
>  
>  add_addr_echo:
> @@ -1103,6 +1102,26 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
>  	return NULL;
>  }
>  
> +int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
> +					 u8 *flags, int *ifindex)
> +{
> +	struct mptcp_pm_addr_entry *entry;
> +
> +	rcu_read_lock();
> +	entry = __lookup_addr_by_id(net_generic(net, pm_nl_pernet_id), id);
> +	rcu_read_unlock();
> +
> +	if (entry) {
> +		*flags = entry->flags;
> +		*ifindex = entry->ifindex;
> +	} else {
> +		*flags = 0;
> +		*ifindex = 0;
> +	}

You need to extend the RCU section after the entry reference above, or
on preempt-enabled build, the entry could be deleted in between the rcu
 unlock and the later access.

I'm wondering if there are issues with the 0 id ?!?

/P

