Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A53371
	for <mptcp@lists.linux.dev>; Sat,  8 May 2021 00:45:01 +0000 (UTC)
IronPort-SDR: UD3O39o/F+8ZECo/Xn7vP3hsUEwinBd6/sbqcGrvvd8GYPcU3/kCRz5oN+KNseFGKWOz3ZKQm9
 DIJO9jq3Etng==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="178406045"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="178406045"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 17:45:00 -0700
IronPort-SDR: o5cnX6Tsm0OR59G3F7du/ZfuL6PWClboOM7QzzYsBmBTp2ZbEB7oGyk1RnONmf/cuX5qKGLG7h
 1evkn2Z+623Q==
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="435149964"
Received: from magalleg-mobl.amr.corp.intel.com ([10.209.84.24])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 17:45:00 -0700
Date: Fri, 7 May 2021 17:44:59 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next 2/3] mptcp: MP_FAIL suboption
 receiving
In-Reply-To: <bbdc6ded86ae034f443853b6e207aea2b3b2c519.1620282929.git.geliangtang@gmail.com>
Message-ID: <f04b71cb-8983-fc3c-b1da-6dc990683f2a@linux.intel.com>
References: <cover.1620282929.git.geliangtang@gmail.com> <f158cbfcb748b9b6792d9b316b8fa810e5cb044a.1620282929.git.geliangtang@gmail.com> <bbdc6ded86ae034f443853b6e207aea2b3b2c519.1620282929.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 6 May 2021, Geliang Tang wrote:

> This patch added handling for receiving MP_FAIL suboption.
>
> Add a new members mp_fail and fail_seq in struct mptcp_options_received.
> When MP_FAIL suboption is received, set mp_fail to 1 and save the sequence
> number to fail_seq.
>
> Then invoke mptcp_pm_mp_fail_received to deal with the MP_FAIL suboption.
> In it, send MP_FAIL + RST and fallback.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/options.c  | 16 ++++++++++++++++
> net/mptcp/pm.c       | 17 +++++++++++++++++
> net/mptcp/protocol.h |  3 +++
> 3 files changed, 36 insertions(+)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 485c5a77e71b..9795e3ccf6cc 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -341,6 +341,16 @@ static void mptcp_parse_option(const struct sock *sk,
> 		mp_opt->reset_reason = *ptr;
> 		break;
>
> +	case MPTCPOPT_MP_FAIL:
> +		if (opsize != TCPOLEN_MPTCP_FAIL)
> +			break;
> +
> +		ptr += 2;
> +		mp_opt->mp_fail = 1;
> +		mp_opt->fail_seq = get_unaligned_be64(ptr);
> +		pr_debug("MP_FAIL: data_seq=%llu", mp_opt->fail_seq);
> +		break;
> +
> 	default:
> 		break;
> 	}
> @@ -367,6 +377,7 @@ void mptcp_get_options(const struct sock *sk,
> 	mp_opt->reset = 0;
> 	mp_opt->csum_reqd = 0;
> 	mp_opt->deny_join_id0 = 0;
> +	mp_opt->mp_fail = 0;
>
> 	length = (th->doff * 4) - sizeof(struct tcphdr);
> 	ptr = (const unsigned char *)(th + 1);
> @@ -1127,6 +1138,11 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> 		mp_opt.mp_prio = 0;
> 	}
>
> +	if (mp_opt.mp_fail) {
> +		mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
> +		mp_opt.mp_fail = 0;
> +	}
> +
> 	if (mp_opt.reset) {
> 		subflow->reset_seen = 1;
> 		subflow->reset_reason = mp_opt.reset_reason;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 639271e09604..87152a2bcbc4 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -247,6 +247,23 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
> 	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, mptcp_sk(subflow->conn), sk, GFP_ATOMIC);
> }
>
> +void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> +
> +	pr_debug("map_seq=%llu fail_seq=%llu %llu", subflow->map_seq, subflow->fail_seq, fail_seq);
> +
> +	if (subflow->fail_seq != fail_seq) {
> +		subflow->send_mp_fail = 1;
> +		subflow->fail_seq = fail_seq;
> +		mptcp_subflow_reset(sk);
> +	}
> +
> +	pr_fallback(msk);
> +	__mptcp_do_fallback(msk);

Note that RFC 8684 section 3.7 says that fallback is only required if 
there is a single active subflow.

The RFC also says that data following fail_seq should be discarded when 
there are multiple subflows open. It's similar to a forced checksum 
failure - the queued data that has already been received on the subflow 
that received the MP_FAIL is discarded and not DATA_ACKed.

-Mat


> +}
> +
> /* path manager helpers */
>
> bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index ff70b3e97dd0..fef6adef3c99 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -138,6 +138,7 @@ struct mptcp_options_received {
> 		add_addr : 1,
> 		rm_addr : 1,
> 		mp_prio : 1,
> +		mp_fail : 1,
> 		echo : 1,
> 		csum_reqd : 1,
> 		backup : 1,
> @@ -159,6 +160,7 @@ struct mptcp_options_received {
> 	u64	ahmac;
> 	u8	reset_reason:4;
> 	u8	reset_transient:1;
> +	u64	fail_seq;
> };
>
> static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
> @@ -697,6 +699,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
> int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> 				 struct mptcp_addr_info *addr,
> 				 u8 bkup);
> +void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
> void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
> bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
> struct mptcp_pm_add_entry *
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
