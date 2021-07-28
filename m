Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D43481
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 23:31:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="209656311"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="209656311"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 16:31:49 -0700
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="663887103"
Received: from sghoshal-mobl.amr.corp.intel.com ([10.212.197.34])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 16:31:48 -0700
Date: Wed, 28 Jul 2021 16:31:48 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [MPTCP][PATCH v6 mptcp-next 3/5] mptcp: send out MP_FAIL when
 data checksum fails
In-Reply-To: <19469d95c33169d6e4dd553394ab4466756ff001.1627464017.git.geliangtang@xiaomi.com>
Message-ID: <4dfb9a58-6cdf-c432-ed9-4245a1c57bbd@linux.intel.com>
References: <cover.1627464017.git.geliangtang@xiaomi.com> <277ac1e6d1fde4c180eba3f1bb1846ea58679915.1627464017.git.geliangtang@xiaomi.com> <a39b8f2a49c2798d4ff80ed527cd8990e64f8def.1627464017.git.geliangtang@xiaomi.com>
 <19469d95c33169d6e4dd553394ab4466756ff001.1627464017.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 28 Jul 2021, Geliang Tang wrote:

> From: Geliang Tang <geliangtang@xiaomi.com>
>
> When a bad checksum is detected, set the send_mp_fail flag to send out
> the MP_FAIL option.
>
> Add a new function mptcp_has_another_subflow() to check whether there's
> only a single subflow.
>
> When multiple subflows are in use, close the affected subflow with a RST
> that includes an MP_FAIL option and discard the data with the bad
> checksum.
>

Thanks for the test code! I do see in wireshark that the multiple subflow 
case sends a TCP RST with both MP_FAIL and MP_TCPRST options when the 
checksum fails on one subflow.

> Set the sk_state of the subsocket to TCP_CLOSE, then the flag
> MPTCP_WORK_CLOSE_SUBFLOW will be set in subflow_sched_work_if_closed,
> and the subflow will be closed.
>
> When a single subfow is in use, send back an MP_FAIL option on the
> subflow-level ACK. And the receiver of this MP_FAIL respond with an
> MP_FAIL in the reverse direction.
>

The single subflow case has some unexpected behavior:

1. The checksum failure is detected, a packet is sent with MP_FAIL. 
However, the packet also has data payload and no DSS option.

2. The peer receives MP_FAIL, and echoes back. But it sends two TCP RST + 
MP_FAIL packets back-to-back.

I'll upload a pcap to 
https://github.com/multipath-tcp/mptcp_net-next/issues/52

I think the right temporary behavior (before implementing infinite 
mappings) for single subflow checksum failure is to do what the RFC says 
for non-contiguous data: "In the rare case that the data is not contiguous 
(which could happen when there is only one subflow but it is 
retransmitting data from a subflow that has recently been uncleanly 
closed), the receiver MUST close the subflow with a RST with MP_FAIL." So, 
in step 1 above the peer that detected the bad checksum would still send 
MP_FAIL but with the RST flag. And then the echo would not be needed 
because the path would already be disconnected by the RST.

What do you think?


Mat


> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
> net/mptcp/pm.c       | 14 ++++++++++++++
> net/mptcp/protocol.h | 14 ++++++++++++++
> net/mptcp/subflow.c  | 17 +++++++++++++++++
> 3 files changed, 45 insertions(+)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 6ab386ff3294..c2df5cc28ba1 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -251,7 +251,21 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
>
> void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> {
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +
> 	pr_debug("fail_seq=%llu", fail_seq);
> +
> +	if (!mptcp_has_another_subflow(sk)) {
> +		if (!subflow->mp_fail_expect_echo) {
> +			subflow->send_mp_fail = 1;
> +		} else {
> +			subflow->mp_fail_expect_echo = 0;
> +			/* TODO the single-subflow case is temporarily
> +			 * handled by reset.
> +			 */
> +			mptcp_subflow_reset(sk);
> +		}
> +	}
> }
>
> /* path manager helpers */
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 09d0e9406ea9..c46011318f65 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -434,6 +434,7 @@ struct mptcp_subflow_context {
> 		backup : 1,
> 		send_mp_prio : 1,
> 		send_mp_fail : 1,
> +		mp_fail_expect_echo : 1,
> 		rx_eof : 1,
> 		can_ack : 1,        /* only after processing the remote a key */
> 		disposable : 1,	    /* ctx can be free at ulp release time */
> @@ -615,6 +616,19 @@ static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
> 	inet_csk(sk)->icsk_af_ops = ctx->icsk_af_ops;
> }
>
> +static inline bool mptcp_has_another_subflow(struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk), *tmp;
> +	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> +
> +	mptcp_for_each_subflow(msk, tmp) {
> +		if (tmp != subflow)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> void __init mptcp_proto_init(void);
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> int __init mptcp_proto_v6_init(void);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 1151926d335b..a69839520472 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -910,6 +910,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
> 	csum = csum_partial(&header, sizeof(header), subflow->map_data_csum);
> 	if (unlikely(csum_fold(csum))) {
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
> +		subflow->send_mp_fail = 1;
> 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
> 	}
>
> @@ -1157,6 +1158,22 @@ static bool subflow_check_data_avail(struct sock *ssk)
>
> fallback:
> 	/* RFC 8684 section 3.7. */
> +	if (subflow->send_mp_fail) {
> +		if (mptcp_has_another_subflow(ssk)) {
> +			ssk->sk_err = EBADMSG;
> +			tcp_set_state(ssk, TCP_CLOSE);
> +			subflow->reset_transient = 0;
> +			subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
> +			tcp_send_active_reset(ssk, GFP_ATOMIC);
> +			while ((skb = skb_peek(&ssk->sk_receive_queue)))
> +				sk_eat_skb(ssk, skb);
> +		} else {
> +			subflow->mp_fail_expect_echo = 1;
> +		}
> +		WRITE_ONCE(subflow->data_avail, 0);
> +		return true;
> +	}
> +
> 	if (subflow->mp_join || subflow->fully_established) {
> 		/* fatal protocol error, close the socket.
> 		 * subflow_error_report() will introduce the appropriate barriers
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
