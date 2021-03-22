Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC176E
	for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 23:11:00 +0000 (UTC)
IronPort-SDR: wIkX7j2oNYwTwpkEbOI0yQeuFbGZtmJfIkmq+a7aUZKvVp5Ud7ZJpXpj/Uw+hy7WGi4lqFXSQY
 MKfdSWDhGkGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="177935766"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="177935766"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:10:59 -0700
IronPort-SDR: 7pXpE2A2+UQbNKLEE4BeM0/cGG7gBil7D6FDXNTxqPZVV4mj+b2n0YpCQayMip1n5e1kkQ1fSn
 f7ObTcoQAlRQ==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="408021194"
Received: from shahinam-mobl2.amr.corp.intel.com ([10.252.128.161])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:10:55 -0700
Date: Mon, 22 Mar 2021 16:10:55 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.01.org, mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next 4/6] mptcp: add the DSS checksum
 sending
In-Reply-To: <643a31ae30f00dd0d1d49834f6e996b3fe637c47.1616412490.git.geliangtang@gmail.com>
Message-ID: <41604ba7-65b8-7675-3f12-bfb6c124c61d@linux.intel.com>
References: <cover.1616412490.git.geliangtang@gmail.com> <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com> <7ad133370d4bb939ba69e35203797494181873b0.1616412490.git.geliangtang@gmail.com>
 <33da8b854a7397e7ecc807b335a0c7e69e023ca6.1616412490.git.geliangtang@gmail.com> <643a31ae30f00dd0d1d49834f6e996b3fe637c47.1616412490.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 22 Mar 2021, Geliang Tang wrote:

> In mptcp_established_options_dss, use the new function
> mptcp_generate_dss_csum to generate the DSS checksum value.
>
> In mptcp_write_options, send out DSS with the checksum value.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> include/net/mptcp.h  |  1 +
> net/mptcp/options.c  | 41 ++++++++++++++++++++++++++++++++++++++---
> net/mptcp/protocol.h |  7 +++++++
> 3 files changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 36fb6907aa6f..869a6d98a72e 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -32,6 +32,7 @@ struct mptcp_ext {
> 			frozen:1,
> 			reset_transient:1;
> 	u8		reset_reason:4;
> +	u16		csum;
> };
>
> #define MPTCP_RM_IDS_MAX	8
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index bdced173edff..69eb15ef9385 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -521,6 +521,30 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
> 	}
> }
>
> +static u16 mptcp_generate_dss_csum(struct sk_buff *skb)
> +{
> +	struct csum_pseudo_header header;
> +	struct mptcp_ext *mpext;
> +	__wsum csum;
> +
> +	if (!skb)
> +		return 0;
> +
> +	mpext = mptcp_get_ext(skb);
> +	if (!mpext || !mpext->use_map)
> +		return 0;
> +
> +	header.data_seq = mpext->data_seq;
> +	header.subflow_seq = mpext->subflow_seq;
> +	header.data_len = mpext->data_len;
> +	header.csum = 0;
> +
> +	csum = skb_checksum(skb, 0, skb->len, 0);
> +	csum = csum_partial(&header, sizeof(header), csum);
> +
> +	return csum_fold(csum);
> +}
> +
> static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
> 					  bool snd_data_fin_enable,
> 					  unsigned int *size,
> @@ -544,8 +568,11 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>
> 		remaining -= map_size;
> 		dss_size = map_size;
> -		if (mpext)
> +		if (mpext) {
> +			if (msk->csum_reqd)
> +				mpext->csum = mptcp_generate_dss_csum(skb);
> 			opts->ext_copy = *mpext;
> +		}
>
> 		if (skb && snd_data_fin_enable)
> 			mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
> @@ -1304,6 +1331,9 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 			flags |= MPTCP_DSS_HAS_MAP | MPTCP_DSS_DSN64;
> 			if (mpext->data_fin)
> 				flags |= MPTCP_DSS_DATA_FIN;
> +
> +			if (mpext->csum)

Instead of relying on a non-zero mpext->csum, what about using 
opts->csum_enabled instead? (Would have to make sure that flag is set in 
mptcp_out_options for data packets too)

This would be more compatible with hardware offload if that gets added 
later.

> +				len += TCPOLEN_MPTCP_DSS_CHECKSUM;
> 		}
>
> 		*ptr++ = mptcp_option(MPTCPOPT_DSS, len, 0, flags);
> @@ -1323,8 +1353,13 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 			ptr += 2;
> 			put_unaligned_be32(mpext->subflow_seq, ptr);
> 			ptr += 1;
> -			put_unaligned_be32(mpext->data_len << 16 |
> -					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
> +			if (mpext->csum) {

Same as above, want to test the same opts->csum_enabled value.

> +				put_unaligned_be32(mpext->data_len << 16 |
> +						   mpext->csum, ptr);
> +			} else {
> +				put_unaligned_be32(mpext->data_len << 16 |
> +						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
> +			}
> 		}
> 	}
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 4fc4871595ef..f62cea8635f0 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -333,6 +333,13 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(const struct sock *sk)
> 	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, list);
> }
>
> +struct csum_pseudo_header {
> +	u64 data_seq;
> +	u32 subflow_seq;
> +	u16 data_len;
> +	u16 csum;
> +};
> +
> struct mptcp_subflow_request_sock {
> 	struct	tcp_request_sock sk;
> 	u16	mp_capable : 1,
> -- 
> 2.30.2

--
Mat Martineau
Intel
