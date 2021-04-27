Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16752F80
	for <mptcp@lists.linux.dev>; Tue, 27 Apr 2021 23:50:30 +0000 (UTC)
IronPort-SDR: ooW4rpgA0jz/MiOM87knEGLtrfvgeLe7CwIIuzVRQ2CJ2LmA6Dh64Pc2b3v5Agoe7uPhzJ3Zr6
 9eqAJpHu7q2A==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="183755909"
X-IronPort-AV: E=Sophos;i="5.82,256,1613462400"; 
   d="scan'208";a="183755909"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 16:50:30 -0700
IronPort-SDR: 1iKC9HwZg7tmqKVOqLXVRnRI36wnqmMl6WfyF9DY7JXOBGbaSQH+Xn1Dk7XCKTjX6dLekqZjr1
 jFtSmklrFfsg==
X-IronPort-AV: E=Sophos;i="5.82,256,1613462400"; 
   d="scan'208";a="465671613"
Received: from wlhines-mobl.amr.corp.intel.com ([10.209.43.196])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 16:50:30 -0700
Date: Tue, 27 Apr 2021 16:50:29 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next 4/5] mptcp: add join_denied in
 mptcp_sock
In-Reply-To: <3afc2c7d715a21cf73d2573909be1e24fc89883e.1619517696.git.geliangtang@gmail.com>
Message-ID: <17db5bab-5c30-3394-7130-dc7898a3c53c@linux.intel.com>
References: <cover.1619517696.git.geliangtang@gmail.com> <b1aefbc214bea1e5cef3dcf3c1c0b5caf502734e.1619517696.git.geliangtang@gmail.com> <073e1b2e4f7d03b0302e8eacb235a728774b3104.1619517696.git.geliangtang@gmail.com>
 <945e6d874461b595c1a08916d87cb4fed219ac40.1619517696.git.geliangtang@gmail.com> <3afc2c7d715a21cf73d2573909be1e24fc89883e.1619517696.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 27 Apr 2021, Geliang Tang wrote:

> This patch added a new flag join_denied in struct mptcp_sock,
> initialized as false in __mptcp_init_sock.
>
> When MP_CAPABLE with the flag MPTCP_CAP_JOIN_DENIED is received, set the
> join_denied to true.
>
> In mptcp_syn_options, if the join_denied flag is set, and the remote
> address id is zero, stop sending the join.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/options.c  | 8 ++++++++
> net/mptcp/protocol.c | 1 +
> net/mptcp/protocol.h | 1 +
> 3 files changed, 10 insertions(+)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 7b354125f33b..068b104d8ca9 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -25,6 +25,8 @@ static void mptcp_parse_option(const struct sock *sk,
> 			       const unsigned char *ptr, int opsize,
> 			       struct mptcp_options_received *mp_opt)
> {
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> 	u8 subtype = *ptr >> 4;
> 	int expected_opsize;
> 	u8 version;
> @@ -78,6 +80,9 @@ static void mptcp_parse_option(const struct sock *sk,
> 		if (flags & MPTCP_CAP_CHECKSUM_REQD)
> 			break;
>
> +		if (flags & MPTCP_CAP_JOIN_DENIED)
> +			WRITE_ONCE(msk->join_denied, true);
> +

Rather than directly manipulate the mptcp_sock here, I think it would be 
better to add something to mptcp_options_received and set that here. Then 
that structure can be used to set up the mptcp_sock or path manager while 
the appropriate lock is held.

> 		mp_opt->mp_capable = 1;
> 		if (opsize >= TCPOLEN_MPTCP_MPC_SYNACK) {
> 			mp_opt->sndr_key = get_unaligned_be64(ptr);
> @@ -376,6 +381,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
> 		       unsigned int *size, struct mptcp_out_options *opts)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>
> 	/* we will use snd_isn to detect first pkt [re]transmission
> 	 * in mptcp_established_options_mp()
> @@ -389,6 +395,8 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
> 	} else if (subflow->request_join) {
> 		pr_debug("remote_token=%u, nonce=%u", subflow->remote_token,
> 			 subflow->local_nonce);
> +		if (!subflow->remote_id && READ_ONCE(msk->join_denied))
> +			return false;

I think this should be handled at a higher level, in the path manager. The 
PM should make the decision to create (or not create) a new subflow using 
the peer's subflow 0 address.

When everything is updated for userspace path management (not in scope for 
this patch set!), the userspace path manager will also need the 'C' flag. 
It's going to be simpler to make the best path management decisions in 
both userspace and in-kernel PMs if the 'C' flag is treated similarly in 
either case.

> 		opts->suboptions = OPTION_MPTCP_MPJ_SYN;
> 		opts->join_id = subflow->local_id;
> 		opts->token = subflow->remote_token;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index aec8e77b18e4..219455616f61 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2411,6 +2411,7 @@ static int __mptcp_init_sock(struct sock *sk)
> 	msk->ack_hint = NULL;
> 	msk->first = NULL;
> 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
> +	WRITE_ONCE(msk->join_denied, false);
>
> 	mptcp_pm_data_init(msk);
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 1d828668b15a..dc20b4d956ea 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -235,6 +235,7 @@ struct mptcp_sock {
> 	bool		snd_data_fin_enable;
> 	bool		rcv_fastclose;
> 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
> +	bool		join_denied;

As I mentioned in some comments above, this may belong in mptcp_pm_data in 
order to integrate with the PM better.

> 	spinlock_t	join_list_lock;
> 	struct sock	*ack_hint;
> 	struct work_struct work;
> -- 
> 2.30.2
>
>
>

--
Mat Martineau
Intel
