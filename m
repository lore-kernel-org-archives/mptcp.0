Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7049CA31
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 22:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663627044; x=1695163044;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=usF1Gn1TymM6IAme2/i2HQ6KAY978I+8asUipGEueLc=;
  b=Xk8rkkq393CX5p4wbCqpPdBXTG09M7lrnZrlMukHzsj1g3rWwbDd61qQ
   zCAqEsBo3KdxRkRbGk2c5ZtYN9FbkmWyNGe+85bHv5Zr8v0mz4nNQDHy+
   tk7V6JpdmIDbeNsqYfEsBOZ33Uxa61yl5tStZSMmsrQuXJOcXhDXxjuNE
   G8XlRVIZAo/6MLrQBrevBczCGLETi+7sMTzXfEZ9FWH7k6/rh4NZ5uGlP
   3tp84ugJyNDMfaLXgyQEL3o0IYD+ktYWgalQP+WwlTi+Oh+20sPC0yDxG
   N5fe6V9YYM2EiYTbcCrV3CuKIagYCXl46R9BGfd8HWkrBH6cX4x6UlTxj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="279921304"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="279921304"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 15:37:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="794031795"
Received: from alyashev-mobl.amr.corp.intel.com ([10.209.121.123])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 15:37:23 -0700
Date: Mon, 19 Sep 2022 15:37:23 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: menglong8.dong@gmail.com
cc: pabeni@redhat.com, mptcp@lists.linux.dev, 
    Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH mptcp] net: mptcp: add statistics for mptcp socket in
 use
In-Reply-To: <20220919132156.3649522-1-imagedong@tencent.com>
Message-ID: <61ca3016-5f92-7779-9213-f8b75ff9ff55@linux.intel.com>
References: <20220919132156.3649522-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 19 Sep 2022, menglong8.dong@gmail.com wrote:

> From: Menglong Dong <imagedong@tencent.com>
>
> Do the statistics of mptcp socket in use with sock_prot_inuse_add().
> Therefore, we can get the count of used mptcp socket from
> /proc/net/protocols:
>
> & cat /proc/net/protocols
> protocol  size sockets  memory press maxhdr  slab module     cl co di ac io in de sh ss gs se re sp bi br ha uh gp em
> MPTCPv6   2048      0       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
> MPTCP     1896      1       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>

Hello Menglong -

Thanks for your patch.

One minor thing: please use the subject line tags listed in 
https://github.com/multipath-tcp/mptcp_net-next/wiki/Patch-prefixes : 
either "[PATCH mptcp-net]" or "[PATCH mptcp-next]", so it's clear which 
tree the patch is intended for.

> ---
> net/mptcp/protocol.c | 19 +++++++++++++------
> net/mptcp/subflow.c  |  3 +++
> 2 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 45ed50e9aec9..4da77aa8b070 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2311,6 +2311,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 			tcp_set_state(ssk, TCP_CLOSE);
> 			mptcp_subflow_queue_clean(ssk);
> 			inet_csk_listen_stop(ssk);
> +			sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);

The code in this function is for a closing subflow, not a closing MPTCP 
socket. I don't think this call belongs here.

> 		}
> 		__tcp_close(ssk, 0);
>
> @@ -3067,6 +3068,9 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
> 	skb_rbtree_purge(&msk->out_of_order_queue);
> 	mptcp_data_unlock(sk);
>
> +	if (!sk_unhashed(sk) || __mptcp_check_fallback(msk))
> +		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> +
> 	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
> 	 * inet_sock_destruct() will dispose it
> 	 */
> @@ -3513,6 +3517,7 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> 	mptcp_token_destroy(msk);
> 	inet_sk_state_store(sock->sk, TCP_SYN_SENT);
> 	subflow = mptcp_subflow_ctx(ssock->sk);
> +	sock_prot_inuse_add(sock_net(sock->sk), sock->sk->sk_prot, 1);
> #ifdef CONFIG_TCP_MD5SIG
> 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
> 	 * TCP option space.
> @@ -3547,12 +3552,13 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> static int mptcp_listen(struct socket *sock, int backlog)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
> +	struct sock *sk = sock->sk;

Changing all of the "sock->sk" text in this function to "sk" creates a lot 
of diffs that aren't related to maintaining the inuse statistics. If you'd 
like to do that refactoring change, please split that into a separate 
patch for mptcp-next.

-Mat

> 	struct socket *ssock;
> 	int err;
>
> 	pr_debug("msk=%p", msk);
>
> -	lock_sock(sock->sk);
> +	lock_sock(sk);
> 	ssock = __mptcp_nmpc_socket(msk);
> 	if (!ssock) {
> 		err = -EINVAL;
> @@ -3560,16 +3566,17 @@ static int mptcp_listen(struct socket *sock, int backlog)
> 	}
>
> 	mptcp_token_destroy(msk);
> -	inet_sk_state_store(sock->sk, TCP_LISTEN);
> -	sock_set_flag(sock->sk, SOCK_RCU_FREE);
> +	inet_sk_state_store(sk, TCP_LISTEN);
> +	sock_set_flag(sk, SOCK_RCU_FREE);
> +	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
>
> 	err = ssock->ops->listen(ssock, backlog);
> -	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
> +	inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
> 	if (!err)
> -		mptcp_copy_inaddrs(sock->sk, ssock->sk);
> +		mptcp_copy_inaddrs(sk, ssock->sk);
>
> unlock:
> -	release_sock(sock->sk);
> +	release_sock(sk);
> 	return err;
> }
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 07dd23d0fe04..da6cfa73a3bd 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -747,6 +747,9 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> 			mptcp_sk(new_msk)->setsockopt_seq = ctx->setsockopt_seq;
> 			mptcp_pm_new_connection(mptcp_sk(new_msk), child, 1);
> 			mptcp_token_accept(subflow_req, mptcp_sk(new_msk));
> +			sock_prot_inuse_add(sock_net(new_msk),
> +					    new_msk->sk_prot,
> +					    1);
> 			ctx->conn = new_msk;
> 			new_msk = NULL;
>
> -- 
> 2.37.2
>
>
>

--
Mat Martineau
Intel
