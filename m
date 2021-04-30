Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDC971
	for <mptcp@lists.linux.dev>; Fri, 30 Apr 2021 01:25:46 +0000 (UTC)
IronPort-SDR: V+Yz2OEz+4ypio9L7At2FmPGQtJ2d0KbiLLy+YmnWY9q/m08gngEi9jemAZQ4SFHhW73jCbqgo
 vZ14+mgN+Ogw==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="184641928"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="184641928"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 18:25:45 -0700
IronPort-SDR: uOTIYTiHIW0GkwOJPd9qe+GxVbMMyIoevZjavlZbClh/244uqTnYrnukmobnT27CVdi1fI0oIO
 9VAULUA2aP8Q==
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="527404833"
Received: from rbidari-mobl1.amr.corp.intel.com ([10.254.72.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 18:25:42 -0700
Date: Thu, 29 Apr 2021 18:25:41 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v3 mptcp-next 2/4] mptcp: add allow_join_id0 in
 mptcp_out_options
In-Reply-To: <972a77ea8b999cd2e0f8e32912156d5ac4b9a17e.1619623735.git.geliangtang@gmail.com>
Message-ID: <cf96d576-edaf-d6e5-5a9a-2aacfa986bb1@linux.intel.com>
References: <cover.1619623735.git.geliangtang@gmail.com> <952b920c38ab98adfdb77a0e941ff43c05461a0d.1619623735.git.geliangtang@gmail.com> <972a77ea8b999cd2e0f8e32912156d5ac4b9a17e.1619623735.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 28 Apr 2021, Geliang Tang wrote:

> This patch defined a new flag MPTCP_CAP_DENY_JOIN_ID0 for the third bit,
> labeled "C" of the MP_CAPABLE option.
>
> Add a new flag allow_join_id0 in struct mptcp_out_options. If this flag is
> set, send out the MP_CAPABLE option with the flag MPTCP_CAP_DENY_JOIN_ID0.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> include/net/mptcp.h  |  3 ++-
> net/mptcp/options.c  | 10 ++++++++--
> net/mptcp/protocol.h |  6 ++++--
> net/mptcp/subflow.c  |  1 +
> 4 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 83f23774b908..d259796326ea 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -64,7 +64,8 @@ struct mptcp_out_options {
> 	u8 join_id;
> 	u8 backup;
> 	u8 reset_reason:4;
> -	u8 reset_transient:1;
> +	u8 reset_transient:1,
> +	   allow_join_id0:1;

The bitfield declarations should be consistent here, either:

 	u8 reset_reason:4;
 	u8 reset_transient:1;
 	u8 allow_join_id0:1;

or:

 	u8 reset_reason:4,
 	   reset_transient:1,
 	   allow_join_id0:1;


Thanks,
Mat

> 	u32 nonce;
> 	u64 thmac;
> 	u32 token;
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 99fc21406168..58ea22bf3d3d 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -381,6 +381,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
> 	subflow->snd_isn = TCP_SKB_CB(skb)->end_seq;
> 	if (subflow->request_mptcp) {
> 		opts->suboptions = OPTION_MPTCP_MPC_SYN;
> +		opts->allow_join_id0 = mptcp_is_allow_join_id0(sock_net(sk));
> 		*size = TCPOLEN_MPTCP_MPC_SYN;
> 		return true;
> 	} else if (subflow->request_join) {
> @@ -466,6 +467,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
> 		opts->suboptions = OPTION_MPTCP_MPC_ACK;
> 		opts->sndr_key = subflow->local_key;
> 		opts->rcvr_key = subflow->remote_key;
> +		opts->allow_join_id0 = mptcp_is_allow_join_id0(sock_net(sk));
>
> 		/* Section 3.1.
> 		 * The MP_CAPABLE option is carried on the SYN, SYN/ACK, and ACK
> @@ -790,6 +792,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
> 	if (subflow_req->mp_capable) {
> 		opts->suboptions = OPTION_MPTCP_MPC_SYNACK;
> 		opts->sndr_key = subflow_req->local_key;
> +		opts->allow_join_id0 = subflow_req->allow_join_id0;
> 		*size = TCPOLEN_MPTCP_MPC_SYNACK;
> 		pr_debug("subflow_req=%p, local_key=%llu",
> 			 subflow_req, subflow_req->local_key);
> @@ -1124,7 +1127,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> {
> 	if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
> 	     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
> -		u8 len;
> +		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
>
> 		if (OPTION_MPTCP_MPC_SYN & opts->suboptions)
> 			len = TCPOLEN_MPTCP_MPC_SYN;
> @@ -1135,9 +1138,12 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 		else
> 			len = TCPOLEN_MPTCP_MPC_ACK;
>
> +		if (!opts->allow_join_id0)
> +			flag |= MPTCP_CAP_DENY_JOIN_ID0;
> +
> 		*ptr++ = mptcp_option(MPTCPOPT_MP_CAPABLE, len,
> 				      MPTCP_SUPPORTED_VERSION,
> -				      MPTCP_CAP_HMAC_SHA256);
> +				      flag);
>
> 		if (!((OPTION_MPTCP_MPC_SYNACK | OPTION_MPTCP_MPC_ACK) &
> 		    opts->suboptions))
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index bb901435c2d4..fcbaf47ce3bc 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -77,8 +77,9 @@
> #define MPTCP_VERSION_MASK	(0x0F)
> #define MPTCP_CAP_CHECKSUM_REQD	BIT(7)
> #define MPTCP_CAP_EXTENSIBILITY	BIT(6)
> +#define MPTCP_CAP_DENY_JOIN_ID0	BIT(5)
> #define MPTCP_CAP_HMAC_SHA256	BIT(0)
> -#define MPTCP_CAP_FLAG_MASK	(0x3F)
> +#define MPTCP_CAP_FLAG_MASK	(0x1F)
>
> /* MPTCP DSS flags */
> #define MPTCP_DSS_DATA_FIN	BIT(4)
> @@ -338,7 +339,8 @@ struct mptcp_subflow_request_sock {
> 	struct	tcp_request_sock sk;
> 	u16	mp_capable : 1,
> 		mp_join : 1,
> -		backup : 1;
> +		backup : 1,
> +		allow_join_id0 : 1;
> 	u8	local_id;
> 	u8	remote_id;
> 	u64	local_key;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 15620bafc544..fb5b6eb5bec9 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -108,6 +108,7 @@ static void subflow_init_req(struct request_sock *req, const struct sock *sk_lis
>
> 	subflow_req->mp_capable = 0;
> 	subflow_req->mp_join = 0;
> +	subflow_req->allow_join_id0 = mptcp_is_allow_join_id0(sock_net(sk_listener));
> 	subflow_req->msk = NULL;
> 	mptcp_token_init_request(req);
> }
> -- 
> 2.30.2
>
>
>

--
Mat Martineau
Intel
