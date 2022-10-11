Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D0015AC
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 01:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665450684; x=1696986684;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Gr/kVMzPkPs9YklyWXgmfVUpi74ucQ/9aZwoOTiWwxQ=;
  b=c4xFnzF10YLR1ZFPmUYS9+WAAncxLZQcrc/KcdIqUXNoZTgOtamVsq91
   abZPax6HKWXTbt11qVVvyoSgOfytmfEAyu7a23YvUSwvu+U1FMIgSO6Gl
   YFk7qrD95G96OXhEVQcaKv6TZG+H/O4Vuqla+L3MTVe9mCvuY4XNIvUOh
   j05EXozmv1SpIkRG8P5HiA4fMZGWTAhhpxTdJwE6J01vYXqYPhn7vjYqH
   CmnZ/7SZQQWkxTrHG5Pxf1rFhORtotWBf/Mi/YKXQQ8NqcCeq7pecqVTf
   MRqmO61RQdHL7yE6VXB+FHCqDHTWyhnsot3cJ/vspOoXwHbsnv4SYaphi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="368540688"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="368540688"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 18:11:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="730771980"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="730771980"
Received: from pnle-mobl.amr.corp.intel.com ([10.212.235.19])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 18:11:24 -0700
Date: Mon, 10 Oct 2022 18:11:23 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: menglong8.dong@gmail.com
cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH mptcp-next v5 2/3] mptcp: add statistics for mptcp socket
 in use
In-Reply-To: <20221007092922.13169-3-imagedong@tencent.com>
Message-ID: <3b348f3f-5eb6-83a6-c1c8-6ad095b3d278@linux.intel.com>
References: <20221007092922.13169-1-imagedong@tencent.com> <20221007092922.13169-3-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 7 Oct 2022, menglong8.dong@gmail.com wrote:

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
> v5:
> - rebase to solve merge conflict
>
> v4:
> - rename MPTCP_DESTROIED to MPTCP_DESTROYED
>
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
> index 04d92dc0941f..3d1570a9d3e9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2974,6 +2974,16 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
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
> @@ -2986,6 +2996,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
> 	if (mptcp_sk(sk)->token)
> 		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
>
> +	mptcp_listen_inuse_dec(sk);
> 	/* msk->subflow is still intact, the following will not free the first
> 	 * subflow
> 	 */
> @@ -3160,6 +3171,11 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
> 	skb_rbtree_purge(&msk->out_of_order_queue);
> 	mptcp_data_unlock(sk);
>
> +	if ((__mptcp_check_fallback(msk) &&
> +	     !test_and_set_bit(MPTCP_DESTROYED, &msk->flags)) ||

Hi Menglong -

Sorry I didn't look at this more closely earlier, but did you find that 
mptcp_destroy_common() is only called multiple times with fallback 
sockets?

(This makes me wonder if we have a separate bug to look at, not 
necessarily related to your patch series)

- Mat

> +	    !sk_unhashed(sk))
> +		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> +
> 	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
> 	 * inet_sock_destruct() will dispose it
> 	 */
> @@ -3174,6 +3190,7 @@ static void mptcp_destroy(struct sock *sk)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
>
> +	mptcp_listen_inuse_dec(sk);
> 	/* clears msk->subflow, allowing the following to close
> 	 * even the initial subflow
> 	 */
> @@ -3529,6 +3546,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
>
> 	mptcp_token_destroy(msk);
> 	inet_sk_state_store(sk, TCP_SYN_SENT);
> +	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> 	subflow = mptcp_subflow_ctx(ssock->sk);
> #ifdef CONFIG_TCP_MD5SIG
> 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
> @@ -3661,8 +3679,10 @@ static int mptcp_listen(struct socket *sock, int backlog)
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
> index 18f866b1afda..374ef75e4bb9 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -116,6 +116,7 @@
> #define MPTCP_WORK_EOF		3
> #define MPTCP_FALLBACK_DONE	4
> #define MPTCP_WORK_CLOSE_SUBFLOW 5
> +#define MPTCP_DESTROYED		6
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
