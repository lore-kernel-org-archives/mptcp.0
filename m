Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606E8258E
	for <mptcp@lists.linux.dev>; Mon, 23 May 2022 15:33:15 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id o9so1347365wmd.0
        for <mptcp@lists.linux.dev>; Mon, 23 May 2022 08:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=7adeKNg57M1LPVgwgZUncwHBz/pZxWbYTxneOXUMFvM=;
        b=Ih5c8OTKtsQ+s1LqoWywEAPyZIC5TYxRMES2HSkuM2fqprQvkgoax509+TjXMKOQX8
         WoTyAT7iSxHNQ+nh5Iv3fTHELm919ca9V6cPDh+RLGqLMklklGavZceBeQecnYQmMZZb
         8lqSU169w3Rhzwis9Nt+4eNzQG1un3G+RuoWyQaBLHu4WqgA8TcQMiRPCp+x8KzKqYSr
         b1wuuGXg8tGepvMA+NYP+DlwKmTLoucK822b5+Qz7g9ham7sGBffyQPEtFsEwCKFyNRI
         VbToFgidIGgiaMUSulMVLQAnb41Jp5u23P3sAK2t5SN5OlksKq/lNe8ZC2575vBhd0n+
         s8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=7adeKNg57M1LPVgwgZUncwHBz/pZxWbYTxneOXUMFvM=;
        b=Ct4J4zgoOoYQZ6FBTu0ul5z2704Ta2vjsOD4FSvksdRUsnqvLSzufjOV/cYrKbd4ji
         TzxmnJW1LKhyudMw2RAlf57P7SLVDjxSDuCKZ81G2Z27/0GzbxwDK5B+2Gq6vY4CYhPz
         jEYVZjec8IKiGhCUgMNY+g8A6W6HPHXSSPcnvhOZODRAw/lf7PIrSfSLK4B8tOmcrAyk
         aMArHKqmKa7w8/ZIrBpg9om6YiGIaWL1tsV/PpAPGS+70QAn++KF9kYXY1rRdHHtgLvY
         P0mly689goJdiQw9XZ9dQTfuEuupSU9mN+upalz4gO9b1RHjoAPIaaYlKJ0ivc7wi32l
         Hckw==
X-Gm-Message-State: AOAM530yJNp130dJD2AuMLNZo3MVaGftkDj219v/XszR+9LI+p6ca3ox
	rlWtYrdHEnIF/S2V8EHD15WXWwwHtYxkj++r
X-Google-Smtp-Source: ABdhPJx45ORa5y0AVZLrEP+kEX/jMWnE+oA+2BVreToWy/wGAmIgWGjpfNBG/w57mL1ayh8zjriBgA==
X-Received: by 2002:a05:600c:5120:b0:394:6480:d595 with SMTP id o32-20020a05600c512000b003946480d595mr21398790wms.204.1653319994109;
        Mon, 23 May 2022 08:33:14 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b0039726cd3ae5sm11727218wmq.3.2022.05.23.08.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 08:33:13 -0700 (PDT)
Message-ID: <4668b747-35fa-d6b0-8390-24c0f8f62a71@tessares.net>
Date: Mon, 23 May 2022 17:33:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Patch "mptcp: strict local address ID selection" has been added
 to the 5.17-stable tree
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20220523030625.741995-1-sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220523030625.741995-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Paolo,

(- stable list and netdev maintainers, + mptcp list)

On 23/05/2022 05:06, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     mptcp: strict local address ID selection
> 
> to the 5.17-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      mptcp-strict-local-address-id-selection.patch
> and it can be found in the queue-5.17 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.


Do we want the patch below to be backported to stable?

It think it is slightly changing the behaviour and we might not want it
there, no?

Cheers,
Matt


> commit dd874ab95a2df6fce00831bf16a06ed827639f6c
> Author: Paolo Abeni <pabeni@redhat.com>
> Date:   Mon Mar 7 12:44:37 2022 -0800
> 
>     mptcp: strict local address ID selection
>     
>     [ Upstream commit 4cf86ae84c718333928fd2d43168a1e359a28329 ]
>     
>     The address ID selection for MPJ subflows created in response
>     to incoming ADD_ADDR option is currently unreliable: it happens
>     at MPJ socket creation time, when the local address could be
>     unknown.
>     
>     Additionally, if the no local endpoint is available for the local
>     address, a new dummy endpoint is created, confusing the user-land.
>     
>     This change refactor the code to move the address ID selection inside
>     the rebuild_header() helper, when the local address eventually
>     selected by the route lookup is finally known. If the address used
>     is not mapped by any endpoint - and thus can't be advertised/removed
>     pick the id 0 instead of allocate a new endpoint.
>     
>     Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>     Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 4b5d795383cd..ec73bd4be0a8 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -83,16 +83,6 @@ static bool addresses_equal(const struct mptcp_addr_info *a,
>  	return a->port == b->port;
>  }
>  
> -static bool address_zero(const struct mptcp_addr_info *addr)
> -{
> -	struct mptcp_addr_info zero;
> -
> -	memset(&zero, 0, sizeof(zero));
> -	zero.family = addr->family;
> -
> -	return addresses_equal(addr, &zero, true);
> -}
> -
>  static void local_address(const struct sock_common *skc,
>  			  struct mptcp_addr_info *addr)
>  {
> @@ -1011,9 +1001,6 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>  	if (addresses_equal(&msk_local, &skc_local, false))
>  		return 0;
>  
> -	if (address_zero(&skc_local))
> -		return 0;
> -
>  	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
>  
>  	rcu_read_lock();
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 014c9d88f947..cb90941840b1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -117,6 +117,9 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
>  	list_add(&subflow->node, &msk->conn_list);
>  	sock_hold(ssock->sk);
>  	subflow->request_mptcp = 1;
> +
> +	/* This is the first subflow, always with id 0 */
> +	subflow->local_id_valid = 1;
>  	mptcp_sock_graft(msk->first, sk->sk_socket);
>  
>  	return 0;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index aec767ee047a..e4413b3e50c2 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -442,7 +442,8 @@ struct mptcp_subflow_context {
>  		rx_eof : 1,
>  		can_ack : 1,        /* only after processing the remote a key */
>  		disposable : 1,	    /* ctx can be free at ulp release time */
> -		stale : 1;	    /* unable to snd/rcv data, do not use for xmit */
> +		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
> +		local_id_valid : 1; /* local_id is correctly initialized */
>  	enum mptcp_data_avail data_avail;
>  	u32	remote_nonce;
>  	u64	thmac;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 651f01d13191..e27574e9f969 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -483,6 +483,51 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
>  	mptcp_subflow_reset(sk);
>  }
>  
> +static void subflow_set_local_id(struct mptcp_subflow_context *subflow, int local_id)
> +{
> +	subflow->local_id = local_id;
> +	subflow->local_id_valid = 1;
> +}
> +
> +static int subflow_chk_local_id(struct sock *sk)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> +	int err;
> +
> +	if (likely(subflow->local_id_valid))
> +		return 0;
> +
> +	err = mptcp_pm_get_local_id(msk, (struct sock_common *)sk);
> +	if (err < 0)
> +		return err;
> +
> +	subflow_set_local_id(subflow, err);
> +	return 0;
> +}
> +
> +static int subflow_rebuild_header(struct sock *sk)
> +{
> +	int err = subflow_chk_local_id(sk);
> +
> +	if (unlikely(err < 0))
> +		return err;
> +
> +	return inet_sk_rebuild_header(sk);
> +}
> +
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +static int subflow_v6_rebuild_header(struct sock *sk)
> +{
> +	int err = subflow_chk_local_id(sk);
> +
> +	if (unlikely(err < 0))
> +		return err;
> +
> +	return inet6_sk_rebuild_header(sk);
> +}
> +#endif
> +
>  struct request_sock_ops mptcp_subflow_request_sock_ops;
>  EXPORT_SYMBOL_GPL(mptcp_subflow_request_sock_ops);
>  static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops;
> @@ -1401,13 +1446,8 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
>  		get_random_bytes(&subflow->local_nonce, sizeof(u32));
>  	} while (!subflow->local_nonce);
>  
> -	if (!local_id) {
> -		err = mptcp_pm_get_local_id(msk, (struct sock_common *)ssk);
> -		if (err < 0)
> -			goto failed;
> -
> -		local_id = err;
> -	}
> +	if (local_id)
> +		subflow_set_local_id(subflow, local_id);
>  
>  	mptcp_pm_get_flags_and_ifindex_by_id(sock_net(sk), local_id,
>  					     &flags, &ifindex);
> @@ -1432,7 +1472,6 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
>  	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
>  		 remote_token, local_id, remote_id);
>  	subflow->remote_token = remote_token;
> -	subflow->local_id = local_id;
>  	subflow->remote_id = remote_id;
>  	subflow->request_join = 1;
>  	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> @@ -1737,15 +1776,22 @@ static void subflow_ulp_clone(const struct request_sock *req,
>  		new_ctx->token = subflow_req->token;
>  		new_ctx->ssn_offset = subflow_req->ssn_offset;
>  		new_ctx->idsn = subflow_req->idsn;
> +
> +		/* this is the first subflow, id is always 0 */
> +		new_ctx->local_id_valid = 1;
>  	} else if (subflow_req->mp_join) {
>  		new_ctx->ssn_offset = subflow_req->ssn_offset;
>  		new_ctx->mp_join = 1;
>  		new_ctx->fully_established = 1;
>  		new_ctx->backup = subflow_req->backup;
> -		new_ctx->local_id = subflow_req->local_id;
>  		new_ctx->remote_id = subflow_req->remote_id;
>  		new_ctx->token = subflow_req->token;
>  		new_ctx->thmac = subflow_req->thmac;
> +
> +		/* the subflow req id is valid, fetched via subflow_check_req()
> +		 * and subflow_token_join_request()
> +		 */
> +		subflow_set_local_id(new_ctx, subflow_req->local_id);
>  	}
>  }
>  
> @@ -1798,6 +1844,7 @@ void __init mptcp_subflow_init(void)
>  	subflow_specific.conn_request = subflow_v4_conn_request;
>  	subflow_specific.syn_recv_sock = subflow_syn_recv_sock;
>  	subflow_specific.sk_rx_dst_set = subflow_finish_connect;
> +	subflow_specific.rebuild_header = subflow_rebuild_header;
>  
>  	tcp_prot_override = tcp_prot;
>  	tcp_prot_override.release_cb = tcp_release_cb_override;
> @@ -1810,6 +1857,7 @@ void __init mptcp_subflow_init(void)
>  	subflow_v6_specific.conn_request = subflow_v6_conn_request;
>  	subflow_v6_specific.syn_recv_sock = subflow_syn_recv_sock;
>  	subflow_v6_specific.sk_rx_dst_set = subflow_finish_connect;
> +	subflow_v6_specific.rebuild_header = subflow_v6_rebuild_header;
>  
>  	subflow_v6m_specific = subflow_v6_specific;
>  	subflow_v6m_specific.queue_xmit = ipv4_specific.queue_xmit;
> @@ -1817,6 +1865,7 @@ void __init mptcp_subflow_init(void)
>  	subflow_v6m_specific.net_header_len = ipv4_specific.net_header_len;
>  	subflow_v6m_specific.mtu_reduced = ipv4_specific.mtu_reduced;
>  	subflow_v6m_specific.net_frag_header_len = 0;
> +	subflow_v6m_specific.rebuild_header = subflow_rebuild_header;
>  
>  	tcpv6_prot_override = tcpv6_prot;
>  	tcpv6_prot_override.release_cb = tcp_release_cb_override;

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
