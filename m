Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B8C5C85
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 23:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664580329; x=1696116329;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8931elewq6MoO08H2xmOOWZaCa+MfYbaSlgvA8HFkuM=;
  b=YMMJ3RyPZxSuTUYY8xPEU9fQkA0dB7EHT1h8f4/tEpsbXRbo1sKk7rUo
   1bbgCRqtbblV84ZThgE3pPuoBcqxAwwtmtGz3NpFJwEDBySUK7JG4HzR3
   Bx6++YVxACADk5cSuuUYAMbbzznyEGxIV+a2Hwl9QP6g+RVAXI1e8Do91
   4D82WFIDs0wPvqWsplWF/euePHfuuwRjvtZ+j12gk+CPJLjhzLuhlxrIp
   rV3z4xumyZ0csjzDX8mhZ0FcwWfjsLF3X364KoHtWFELV69tlFSu2OsG0
   Atjx9lVDmrlaucWPkgll+4JWdCGLoX33Yl6lBH7WLgYrmyUfitxTXgJGJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="303797653"
X-IronPort-AV: E=Sophos;i="5.93,359,1654585200"; 
   d="scan'208";a="303797653"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 16:25:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="656119462"
X-IronPort-AV: E=Sophos;i="5.93,359,1654585200"; 
   d="scan'208";a="656119462"
Received: from gkaragat-mobl.amr.corp.intel.com ([10.252.141.75])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 16:25:28 -0700
Date: Fri, 30 Sep 2022 16:25:28 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: menglong8.dong@gmail.com
cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: add statistics for mptcp socket
 in use
In-Reply-To: <20220930024607.128202-3-imagedong@tencent.com>
Message-ID: <6ebd4a84-3be5-17fa-6e03-3ca69740512b@linux.intel.com>
References: <20220930024607.128202-1-imagedong@tencent.com> <20220930024607.128202-3-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 30 Sep 2022, menglong8.dong@gmail.com wrote:

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
> ---
> v2:
> - decrease the statistics for listening mptcp socket inuse with
>  mptcp_listen_inuse_dec()
> - add MPTCP_DESTROIED flags to store if mptcp_destroy_common() was
>  called on the msk. For fallback case, we need to decrease the
>  statistics only once, and mptcp_destroy_common() can be called
>  more than once.
> ---
> net/mptcp/protocol.c | 22 +++++++++++++++++++++-
> net/mptcp/protocol.h |  1 +
> net/mptcp/subflow.c  |  3 +++
> 3 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d817fdb2f6ef..e6d358027b7b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2913,6 +2913,16 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
> 	inet_sk(msk)->inet_rcv_saddr = inet_sk(ssk)->inet_rcv_saddr;
> }
>
> +static void mptcp_listen_inuse_dec(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct socket *ssock;
> +
> +	ssock = __mptcp_nmpc_socket(msk);
> +	if (ssock && inet_sk_state_load(ssock->sk) == TCP_LISTEN)
> +		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> +}
> +
> static int mptcp_disconnect(struct sock *sk, int flags)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> @@ -2925,6 +2935,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
> 	if (mptcp_sk(sk)->token)
> 		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
>
> +	mptcp_listen_inuse_dec(sk);
> 	/* msk->subflow is still intact, the following will not free the first
> 	 * subflow
> 	 */
> @@ -3096,6 +3107,11 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
> 	skb_rbtree_purge(&msk->out_of_order_queue);
> 	mptcp_data_unlock(sk);
>
> +	if ((__mptcp_check_fallback(msk) &&
> +	     !test_and_set_bit(MPTCP_DESTROIED, &msk->flags)) ||
> +	    !sk_unhashed(sk))
> +		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> +
> 	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
> 	 * inet_sock_destruct() will dispose it
> 	 */
> @@ -3110,6 +3126,7 @@ static void mptcp_destroy(struct sock *sk)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
>
> +	mptcp_listen_inuse_dec(sk);
> 	/* clears msk->subflow, allowing the following to close
> 	 * even the initial subflow
> 	 */
> @@ -3542,6 +3559,7 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> 	mptcp_token_destroy(msk);
> 	inet_sk_state_store(sock->sk, TCP_SYN_SENT);
> 	subflow = mptcp_subflow_ctx(ssock->sk);
> +	sock_prot_inuse_add(sock_net(sock->sk), sock->sk->sk_prot, 1);
> #ifdef CONFIG_TCP_MD5SIG
> 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
> 	 * TCP option space.
> @@ -3596,8 +3614,10 @@ static int mptcp_listen(struct socket *sock, int backlog)
>
> 	err = ssock->ops->listen(ssock, backlog);
> 	inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
> -	if (!err)
> +	if (!err) {
> +		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> 		mptcp_copy_inaddrs(sk, ssock->sk);
> +	}
>
> unlock:
> 	release_sock(sk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index c0b5b4628f65..675de024de10 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -116,6 +116,7 @@
> #define MPTCP_WORK_EOF		3
> #define MPTCP_FALLBACK_DONE	4
> #define MPTCP_WORK_CLOSE_SUBFLOW 5

Hi Menglong -

Overall, v3 is looking good. Thanks for adding the tests!

One thing that was requested in v2 review was to fix this spelling:

> +#define MPTCP_DESTROIED		6

to be MPTCP_DESTROYED. Can you fix that and post v4?


- Mat

>
> /* MPTCP socket release cb flags */
> #define MPTCP_PUSH_PENDING	1
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

--
Mat Martineau
Intel
