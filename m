Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940371
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 00:38:08 +0000 (UTC)
IronPort-SDR: /YYI9oPzvIaKmgXoOQJbJfUF+L1GnQJZSEy0NJR919k6/MXOT6KdBZG69XC1P8q9uSP3NoDhun
 cLzUwRTDplzw==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="267427058"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="267427058"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 17:38:07 -0700
IronPort-SDR: 9xVmhzGO4YDyOYbPvMeML/vWLJ05RL2jv12ItR/UOn8YNOrIR+dvgpqbIJLI7elmKn/HEWSWzv
 /NI9q0T5RLxw==
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="421692178"
Received: from ndalili-mobl.amr.corp.intel.com ([10.209.105.124])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 17:38:07 -0700
Date: Wed, 16 Jun 2021 17:38:06 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: avoid race on msk state changes
In-Reply-To: <ad66de68b4a3abd765da48e0030b08bf852bf9e6.1623849715.git.pabeni@redhat.com>
Message-ID: <4b871869-969e-b732-86fb-e970beb4f0d6@linux.intel.com>
References: <ad66de68b4a3abd765da48e0030b08bf852bf9e6.1623849715.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 16 Jun 2021, Paolo Abeni wrote:

> The msk socket state is currently updated in a few spots without
> owning the msk socket lock itself.
>
> Some of such operations are safe, as they happens before exposing
> the msk socket to user-space and can't race with other changes.
>
> A couple of them, at connect time, can actually race with close()
> or shutdown(), leaving breaking the socket state machine.
>
> This change addresses the issue moving such update under the msk
> socket lock with the usual:
>
> <acquire spinlock>
> <check sk lock onwers>
> <ev defer to release_cb>
>
> scheme.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/56
> Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
> Fixes: c3c123d16c0e ("net: mptcp: don't hang in mptcp_sendmsg() after TCP fallbac")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c |  2 ++
> net/mptcp/protocol.h |  2 ++
> net/mptcp/subflow.c  | 30 ++++++++++++++++++++++--------
> 3 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 05c8382aafef..15c3b75516fb 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2906,6 +2906,8 @@ static void mptcp_release_cb(struct sock *sk)
> 		__mptcp_clean_una_wakeup(sk);
> 	if (test_and_clear_bit(MPTCP_ERROR_REPORT, &mptcp_sk(sk)->flags))
> 		__mptcp_error_report(sk);
> +	if (test_and_clear_bit(MPTCP_CONNECTED, &mptcp_sk(sk)->flags))
> +		__mptcp_set_connected(sk);

Is it worth it to move the MPTCP_CONNECTED handling to be first in 
mptcp_release_cb()? Some of the other handlers would expect to have the 
msk connection state set first - it doesn't look like the other flags are 
likely to be set so early in the connection but I haven't (yet?) convinced 
myself it's impossible.

>
> 	/* push_pending may touch wmem_reserved, ensure we do the cleanup
> 	 * later
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 2480db50cbd2..515bb1e6acec 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -112,6 +112,7 @@
> #define MPTCP_ERROR_REPORT	8
> #define MPTCP_RETRANSMIT	9
> #define MPTCP_WORK_SYNC_SETSOCKOPT 10
> +#define MPTCP_CONNECTED		11
>
> static inline bool before64(__u64 seq1, __u64 seq2)
> {
> @@ -600,6 +601,7 @@ void mptcp_get_options(const struct sock *sk,
> 		       struct mptcp_options_received *mp_opt);
>
> void mptcp_finish_connect(struct sock *sk);
> +void __mptcp_set_connected(struct sock *sk);
> static inline bool mptcp_is_fully_established(struct sock *sk)
> {
> 	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 6772802737e4..0b5d4a3eadcd 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -373,6 +373,24 @@ static bool subflow_use_different_dport(struct mptcp_sock *msk, const struct soc
> 	return inet_sk(sk)->inet_dport != inet_sk((struct sock *)msk)->inet_dport;
> }
>
> +void __mptcp_set_connected(struct sock *sk)
> +{
> +	if (sk->sk_state == TCP_SYN_SENT) {
> +		inet_sk_state_store(sk, TCP_ESTABLISHED);
> +		sk->sk_state_change(sk);
> +	}
> +}
> +
> +static void mptcp_set_connected(struct sock *sk)
> +{
> +	mptcp_data_lock(sk);
> +	if (!sock_owned_by_user(sk))
> +		__mptcp_set_connected(sk);
> +	else
> +		set_bit(MPTCP_CONNECTED, &mptcp_sk(sk)->flags);
> +	mptcp_data_unlock(sk);
> +}
> +
> static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> @@ -381,10 +399,6 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
>
> 	subflow->icsk_af_ops->sk_rx_dst_set(sk, skb);
>
> -	if (inet_sk_state_load(parent) == TCP_SYN_SENT) {
> -		inet_sk_state_store(parent, TCP_ESTABLISHED);
> -		parent->sk_state_change(parent);
> -	}
>

Minor: this leaves a double-newline in the code. Maybe Matthieu can touch 
it up, or if a v2 is needed for the mptcp_release_cb() change above you 
could fold this in.

> 	/* be sure no special action on any packet other than syn-ack */
> 	if (subflow->conn_finished)
> @@ -417,6 +431,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
> 			 subflow->remote_key);
> 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEACK);
> 		mptcp_finish_connect(sk);
> +		mptcp_set_connected(parent);
> 	} else if (subflow->request_join) {
> 		u8 hmac[SHA256_DIGEST_SIZE];
>
> @@ -457,6 +472,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
> 	} else if (mptcp_check_fallback(sk)) {
> fallback:
> 		mptcp_rcv_space_init(mptcp_sk(parent), sk);
> +		mptcp_set_connected(parent);
> 	}
> 	return;
>
> @@ -564,6 +580,7 @@ static void mptcp_sock_destruct(struct sock *sk)
>
> static void mptcp_force_close(struct sock *sk)
> {
> +	/* the msk is not yet exposed to user-space */
> 	inet_sk_state_store(sk, TCP_CLOSE);
> 	sk_common_release(sk);
> }
> @@ -1577,10 +1594,7 @@ static void subflow_state_change(struct sock *sk)
> 		mptcp_rcv_space_init(mptcp_sk(parent), sk);
> 		pr_fallback(mptcp_sk(parent));
> 		subflow->conn_finished = 1;
> -		if (inet_sk_state_load(parent) == TCP_SYN_SENT) {
> -			inet_sk_state_store(parent, TCP_ESTABLISHED);
> -			parent->sk_state_change(parent);
> -		}
> +		mptcp_set_connected(parent);
> 	}
>
> 	/* as recvmsg() does not acquire the subflow socket for ssk selection
> -- 
> 2.26.3

--
Mat Martineau
Intel
