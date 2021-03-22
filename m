Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800CD6E
	for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 23:40:49 +0000 (UTC)
IronPort-SDR: wM5bIfgigAlnzv28gGn0tV07SLpco2aeND5cp862ZA1PNRvzjvcaLRJTZmse1/fw+oj61QtDZZ
 l8sK4DlR128g==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="251722612"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="251722612"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:40:48 -0700
IronPort-SDR: MJBzu7KFcwuYpl2yHssUU3FZ9Do3sFzQFmZJKWTl1jdo2BavtiRhmBqT2kGF8OwYFchmeo66MM
 CdQxc7knUhYQ==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="607518590"
Received: from shahinam-mobl2.amr.corp.intel.com ([10.252.128.161])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:40:48 -0700
Date: Mon, 22 Mar 2021 16:40:47 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.01.org, mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next 5/6] mptcp: add the DSS checksum
 receiving
In-Reply-To: <7762b80e2310ae0f1a09ec5a4324293d8e9943eb.1616412490.git.geliangtang@gmail.com>
Message-ID: <5cff4d79-a754-c99d-976f-ea2a89541781@linux.intel.com>
References: <cover.1616412490.git.geliangtang@gmail.com> <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com> <7ad133370d4bb939ba69e35203797494181873b0.1616412490.git.geliangtang@gmail.com>
 <33da8b854a7397e7ecc807b335a0c7e69e023ca6.1616412490.git.geliangtang@gmail.com> <643a31ae30f00dd0d1d49834f6e996b3fe637c47.1616412490.git.geliangtang@gmail.com> <7762b80e2310ae0f1a09ec5a4324293d8e9943eb.1616412490.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 22 Mar 2021, Geliang Tang wrote:

> This patch added a new member csum in struct mptcp_options_received. In
> mptcp_parse_option, parse the checksum value from the receiving DSS, and
> save it in mp_opt->csum. In mptcp_incoming_options, pass it to
> mpext->csum.
>
> In validate_mapping, use the new function validate_dss_csum to validata
> the DSS checksum.
>
> In validate_dss_csum, if the data has been split in different packets,
> skip validating.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/options.c  | 13 +++++++++++--
> net/mptcp/protocol.h |  1 +
> net/mptcp/subflow.c  | 37 +++++++++++++++++++++++++++++++++++++
> 3 files changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 69eb15ef9385..ed89f6c2ed49 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -206,9 +206,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 			mp_opt->data_len = get_unaligned_be16(ptr);
> 			ptr += 2;
>
> -			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u",
> +			if (opsize == expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM) {

Now that more of the checksum code has been added, I think that 
expected_opsize should be set to the exact value that is needed - either 
expect the checksum, or don't expect the checksum.

RFC 6824 said: "If a checksum is present, but its use had not been 
negotiated in the MP_CAPABLE handshake, the checksum field MUST be 
ignored."

RFC 8684 says: "If a checksum is present but its use had
not been negotiated in the MP_CAPABLE handshake, the receiver MUST
close the subflow with a RST, as it is not behaving as negotiated.
If a checksum is not present when its use has been negotiated, the
receiver MUST close the subflow with a RST, as it is considered
broken."

There's some old RFC 6824-based code earlier in the function:

 		if (opsize != expected_opsize &&
 		    opsize != expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM)
 			break;

That needs to be changed to:

 		if (opsize != expected_opsize)
 			break;

and expected_opsize should include TCPOLEN_MPTCP_DSS_CHECKSUM only if the 
checksum is enabled.

> +				mp_opt->csum = get_unaligned_be16(ptr);
> +				ptr += 2;
> +			}
> +
> +			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%u",
> 				 mp_opt->data_seq, mp_opt->subflow_seq,
> -				 mp_opt->data_len);
> +				 mp_opt->data_len, mp_opt->csum);
> 		}
>
> 		break;
> @@ -339,6 +344,7 @@ void mptcp_get_options(const struct sk_buff *skb,
> 	mp_opt->mp_prio = 0;
> 	mp_opt->reset = 0;
> 	mp_opt->csum_reqd = 0;
> +	mp_opt->csum = 0;
>
> 	length = (th->doff * 4) - sizeof(struct tcphdr);
> 	ptr = (const unsigned char *)(th + 1);
> @@ -1124,6 +1130,9 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> 		}
> 		mpext->data_len = mp_opt.data_len;
> 		mpext->use_map = 1;
> +
> +		if (READ_ONCE(msk->csum_reqd))
> +			mpext->csum = mp_opt.csum;
> 	}
> }
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f62cea8635f0..51ef3173a2e5 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -123,6 +123,7 @@ struct mptcp_options_received {
> 	u64	data_seq;
> 	u32	subflow_seq;
> 	u16	data_len;
> +	u16	csum;
> 	u16	mp_capable : 1,
> 		mp_join : 1,
> 		fastclose : 1,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 9fec1a273100..2eeea7d527f0 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -799,10 +799,45 @@ static bool skb_is_fully_mapped(struct sock *ssk, struct sk_buff *skb)
> 					  mptcp_subflow_get_map_offset(subflow);
> }
>
> +static bool validate_dss_csum(struct sock *ssk, struct sk_buff *skb)
> +{
> +	struct csum_pseudo_header header;
> +	struct mptcp_ext *mpext;
> +	__wsum csum;
> +
> +	if (!skb)
> +		goto out;
> +
> +	mpext = mptcp_get_ext(skb);
> +	if (!mpext || !mpext->use_map || !mpext->csum ||
> +	    mpext->data_len != skb->len)
> +		goto out;
> +
> +	header.data_seq = mpext->data_seq;
> +	header.subflow_seq = mpext->subflow_seq;
> +	header.data_len = mpext->data_len;
> +	header.csum = mpext->csum;
> +
> +	csum = skb_checksum(skb, 0, skb->len, 0);

The checksum isn't calculated using the data from a single skb, it 
requires the complete reassembled data for the current mapping. If we're 
lucky, GRO has placed everything in one skb. But that can't be assumed.

The checksum can be calculated incrementally as skbs arrive, but checksum 
verification will require changes to data reassembly and MPTCP-level 
acknowledgements, and will delay movement of data to the msk until the 
checksum is verified. Also review my comments on the MP_FAIL RFC patch:

https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/message/KSEEB5Q4ND3GKOW7S3FZ32PHCWWON5QC/


Thanks for the patch set!

Mat


> +	csum = csum_partial(&header, sizeof(header), csum);
> +
> +	if (csum_fold(csum)) {
> +		pr_err("DSS checksum error! data_seq=%llu subflow_seq=%u data_len=%u csum=%u %u",
> +		       header.data_seq, header.subflow_seq, header.data_len,
> +		       header.csum, csum_fold(csum));
> +
> +		return false;
> +	}
> +
> +out:
> +	return true;
> +}
> +
> static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> 	u32 ssn = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
> +	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>
> 	if (unlikely(before(ssn, subflow->map_subflow_seq))) {
> 		/* Mapping covers data later in the subflow stream,
> @@ -817,6 +852,8 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
> 		warn_bad_map(subflow, ssn + skb->len);
> 		return false;
> 	}
> +	if (READ_ONCE(msk->csum_reqd))
> +		validate_dss_csum(ssk, skb);
> 	return true;
> }
>
> -- 
> 2.30.2

--
Mat Martineau
Intel
