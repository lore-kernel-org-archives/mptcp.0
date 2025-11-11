Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5254E23AE9A
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762850246; cv=none; b=faLJLb2YQ3p/e4v1ZPteanPyrHxTEZJ+6scpD8IiU3v2jU9pAf9gMmbn28sSvy2MDQbGL9IWZWqQ1geVQz5ff6e8L5aCeCscuzFAj3/SPO/92nFo0c4cveVBWdEzgYQvepIfwngH0kdtVCCgawbZQVfFYV9kcv9HtNhZ0wQEDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762850246; c=relaxed/simple;
	bh=wIKblSVDXtlkqpWAe9otfPlq/DPSNsVPRql6/M/yKDc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N/tURn4onOcZcLMvPAbvcbNtrpggJXUWXxC4yFNS9VRJSJyxk2Ux7tfZ/Qo1fMQYbOPXklssa2WCs0tlrsWjZA+r48+z1yWFTQ8Iva6iCBbB6z1RYDlvXr9wRBoMNlb2gcDR5I8UwHOoQKId9uKy1klwelq9OUJA4/xhoZQa7xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAnvYesD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAnvYesD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08927C19421;
	Tue, 11 Nov 2025 08:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762850245;
	bh=wIKblSVDXtlkqpWAe9otfPlq/DPSNsVPRql6/M/yKDc=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=EAnvYesDjR2GLmQeZhp1cQh3dGrmwrQlvMyUV6gWKucFt0hdLK9iUbVEOSkSL8noV
	 NBTQb+QR+Cc3tFe0QdIVNz8SftthHVXWSOuu2IY2AW8u6Jc+3K433D37PS2homXEyz
	 HBJN7gVKC2OGFA46RePiN80+beoiNH9fpOYL35USY3FuXImNR46hKzBA8XBEoAPZBo
	 G33is+3qfPRauMLANsRl76GjaTmhXMdpjYju4Y6dJh8sQkLDQeezKIC55Iwu/xWuZT
	 lnPsziRZ6bZw8nvsompK3KcGiNvHFnuhRNH02PLAt+ezDYWH0bMWfQeI1wBsTnSJLH
	 z5ybiyo+4U5CA==
Message-ID: <7d43f35c26a94f22a8e7627f477560ba994efbe7.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 3/3] mptcp: fix memcg accounting for passive
 sockets
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Tue, 11 Nov 2025 16:37:22 +0800
In-Reply-To: <b78e4fb6552cc0b94aa9c1471590d7af1ec2a221.1762551942.git.pabeni@redhat.com>
References: <cover.1762551942.git.pabeni@redhat.com>
	 <b78e4fb6552cc0b94aa9c1471590d7af1ec2a221.1762551942.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thanks for this fix.

On Fri, 2025-11-07 at 22:55 +0100, Paolo Abeni wrote:
> The passive sockets never got proper memcg accounting: the msk
> socket is associated with the memcg at accept time, but the
> passive subflows never got it right.
> 
> At accept time, traverse the subflows list and associate each of them
> with the msk memcg, and try to do the same at join completion time,
> if
> the msk has been already accepted.
> 
> Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming
> connections")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/298
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/597
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 36 ++++++++++++++++++++++++++----------
>  net/mptcp/protocol.h |  1 +
>  net/mptcp/subflow.c  | 10 ++++++++++
>  3 files changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 34e6bc731085..5e9325c7ea9c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -959,6 +959,8 @@ static bool __mptcp_finish_join(struct mptcp_sock
> *msk, struct sock *ssk)
>  	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
>  	mptcp_sockopt_sync_locked(msk, ssk);
>  	mptcp_stop_tout_timer(sk);
> +	__mptcp_inherit_cgrp_data(sk, ssk);
> +	__mptcp_inherit_memcg(sk, ssk, GFP_ATOMIC);

In mptcp_graph_subflows(), these two lines already have the
mem_cgroup_from_sk() check (in the squash-to patch). It's unclear
whether mem_cgroup_from_sk() check needs to be added here too.

Thanks,
-Geliang

>  	__mptcp_propagate_sndbuf(sk, ssk);
>  	__mptcp_propagate_rcvspace(sk, ssk);
>  	return true;
> @@ -4076,6 +4078,29 @@ static int mptcp_listen(struct socket *sock,
> int backlog)
>  	return err;
>  }
>  
> +static void mptcp_graph_subflows(struct sock *sk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		bool slow;
> +
> +		slow = lock_sock_fast(ssk);
> +
> +		/* set ssk->sk_socket of accept()ed flows to mptcp
> socket.
> +		 * This is needed so NOSPACE flag can be set from
> tcp stack.
> +		 */
> +		if (!ssk->sk_socket)
> +			mptcp_sock_graft(ssk, sk->sk_socket);
> +
> +		__mptcp_inherit_cgrp_data(sk, ssk);
> +		__mptcp_inherit_memcg(sk, ssk, GFP_KERNEL);
> +		unlock_sock_fast(ssk, slow);
> +	}
> +}
> +
>  static int mptcp_stream_accept(struct socket *sock, struct socket
> *newsock,
>  			       struct proto_accept_arg *arg)
>  {
> @@ -4123,16 +4148,7 @@ static int mptcp_stream_accept(struct socket
> *sock, struct socket *newsock,
>  		msk = mptcp_sk(newsk);
>  		msk->in_accept_queue = 0;
>  
> -		/* set ssk->sk_socket of accept()ed flows to mptcp
> socket.
> -		 * This is needed so NOSPACE flag can be set from
> tcp stack.
> -		 */
> -		mptcp_for_each_subflow(msk, subflow) {
> -			struct sock *ssk =
> mptcp_subflow_tcp_sock(subflow);
> -
> -			if (!ssk->sk_socket)
> -				mptcp_sock_graft(ssk, newsock);
> -		}
> -
> +		mptcp_graph_subflows(newsk);
>  		mptcp_rps_record_subflows(msk);
>  
>  		/* Do late cleanup for the first subflow as
> necessary. Also
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 300ac7030958..60bfe50530dc 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -755,6 +755,7 @@ mptcp_subflow_delegated_next(struct
> mptcp_delegated_action *delegated)
>  	return ret;
>  }
>  
> +void __mptcp_inherit_memcg(struct sock *sk, struct sock *ssk, gfp_t
> gfp);
>  void __mptcp_inherit_cgrp_data(struct sock *sk, struct sock *ssk);
>  
>  int mptcp_is_enabled(const struct net *net);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 599a21d92590..39bf69e73975 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1721,6 +1721,16 @@ int __mptcp_subflow_connect(struct sock *sk,
> const struct mptcp_pm_local *local,
>  	return err;
>  }
>  
> +void __mptcp_inherit_memcg(struct sock *sk, struct sock *ssk, gfp_t
> gfp)
> +{
> +	/* Only if the msk has been accepted already (and not
> orphaned).*/
> +	if (!mem_cgroup_sockets_enabled || !sk->sk_socket)
> +		return;
> +
> +	mem_cgroup_sk_inherit(sk, ssk);
> +	__sk_charge(ssk, gfp);
> +}
> +
>  void __mptcp_inherit_cgrp_data(struct sock *sk, struct sock *ssk)
>  {
>  #ifdef CONFIG_SOCK_CGROUP_DATA

