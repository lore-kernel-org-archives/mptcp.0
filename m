Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1192F3D9F
	for <mptcp@lists.linux.dev>; Tue, 10 May 2022 23:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652224242; x=1683760242;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Wuhv/x2FcH5+6pQxN+/kTDoYuuzyeVEMd93FID/zYK0=;
  b=d2VUObd+othZxDV6jFPlXfFf9iWCUKtqwU6C5tuIskW7fHWshmvo9WBh
   +db1M0SY6SVya+PrSiUKvJnqo1blJ/8R0+z5cNnvOzReBcaIoNdCQ6nv/
   xdU3MTf+we0cHOuIkuRHXjj1EMSEkftpwtNtlQg1MpID3aibzdJUICyXB
   24YENE2F0OKycvyY+W3FVKc2XxY0b6zzs6lfiKTzwwnjG5z5J/cTdR+wZ
   ESqqBiWlJSpcE510Jf4AYmny+54mmNXlkq806zrqyDnWV3jDNIUg6girC
   eGfVNBjlhmBAoy7oWSLsnEqxEp36EF28k03vFxjH5XSRDa2S+k/u1nejs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="249427982"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="249427982"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 16:10:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="553051930"
Received: from yperng-mobl1.amr.corp.intel.com ([10.209.50.90])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 16:10:41 -0700
Date: Tue, 10 May 2022 16:10:40 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2] mptcp: fix checksum byte order
In-Reply-To: <595f104803a212df58db6d20f84947325b33a9d6.1652196378.git.pabeni@redhat.com>
Message-ID: <331ef61b-19b7-ea0-6832-ebf3c97aa9c@linux.intel.com>
References: <595f104803a212df58db6d20f84947325b33a9d6.1652196378.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 10 May 2022, Paolo Abeni wrote:

> The MPTCP code typecasts the checksum value to u16 and
> then convert it to big endian while storing the value into
> the MPTCP option.
>
> As a result, the wire encoding for little endian host is
> wrong, and that causes interoperabilty interoperability
> issues with other implementation or host with different endianess.
>
> Address the issue writing in the packet the unmodified __sum16 value.
>
> MPTCP checksum is disabled by default, interoperating with systems
> with bad mptcp-level csum encodying should cause fallback to TCP.
>
> Fixes: c5b39e26d003 ("mptcp: send out checksum for DSS")
> Fixes: 390b95a5fb84 ("mptcp: receive checksum for DSS")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
> - move the typecast inside put_len_csum (Mat)
> - updated the commit message (Mat)
> - fix a few sparse issues

Hi Paolo, thanks for the v2:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

(for export-net)

Still ok with you to apply this to export-net? There are a couple of minor 
conflicts when rebasing to export-net, and it also creates a merge 
conflict with net-next. But I think it's worth it to be able to say "every 
5.18 and later kernel has the checksum fix".

Have you tried backporting this commit to 5.17-stable or 5.15-stable?


- Mat


> ---
> net/mptcp/options.c  | 37 ++++++++++++++++++++++++-------------
> net/mptcp/protocol.h |  2 +-
> net/mptcp/subflow.c  |  2 +-
> 3 files changed, 26 insertions(+), 15 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index ac3b7b8a02f6..6c90c78b52d1 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -107,7 +107,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 			ptr += 2;
> 		}
> 		if (opsize == TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM) {
> -			mp_opt->csum = (__force __sum16)get_unaligned_be16(ptr);
> +			mp_opt->csum = get_unaligned((__force __sum16 *)ptr);
> 			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
> 			ptr += 2;
> 		}
> @@ -221,7 +221,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>
> 			if (opsize == expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM) {
> 				mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
> -				mp_opt->csum = (__force __sum16)get_unaligned_be16(ptr);
> +				mp_opt->csum = get_unaligned((__force __sum16 *)ptr);
> 				ptr += 2;
> 			}
>
> @@ -1282,7 +1282,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
> 	}
> }
>
> -u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
> +__sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
> {
> 	struct csum_pseudo_header header;
> 	__wsum csum;
> @@ -1298,15 +1298,25 @@ u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
> 	header.csum = 0;
>
> 	csum = csum_partial(&header, sizeof(header), sum);
> -	return (__force u16)csum_fold(csum);
> +	return csum_fold(csum);
> }
>
> -static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
> +static __sum16 mptcp_make_csum(const struct mptcp_ext *mpext)
> {
> 	return __mptcp_make_csum(mpext->data_seq, mpext->subflow_seq, mpext->data_len,
> 				 ~csum_unfold(mpext->csum));
> }
>
> +static void put_len_csum(u16 len, __sum16 csum, void *data)
> +{
> +	__sum16 *sumptr = data + 2;
> +	__be16 *ptr = data;
> +
> +	put_unaligned_be16(len, ptr);
> +
> +	put_unaligned(csum, sumptr);
> +}
> +
> void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
> 			 struct mptcp_out_options *opts)
> {
> @@ -1385,9 +1395,9 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
> 				/* data_len == 0 is reserved for the infinite mapping,
> 				 * the checksum will also be set to 0.
> 				 */
> -				put_unaligned_be32(mpext->data_len << 16 |
> -						   (mpext->data_len ? mptcp_make_csum(mpext) : 0),
> -						   ptr);
> +				put_len_csum(mpext->data_len,
> +					     mpext->data_len ? mptcp_make_csum(mpext) : 0,
> +					     ptr);
> 			} else {
> 				put_unaligned_be32(mpext->data_len << 16 |
> 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
> @@ -1438,11 +1448,12 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
> 			goto mp_capable_done;
>
> 		if (opts->csum_reqd) {
> -			put_unaligned_be32(opts->data_len << 16 |
> -					   __mptcp_make_csum(opts->data_seq,
> -							     opts->subflow_seq,
> -							     opts->data_len,
> -							     ~csum_unfold(opts->csum)), ptr);
> +			put_len_csum(opts->data_len,
> +				     __mptcp_make_csum(opts->data_seq,
> +						       opts->subflow_seq,
> +						       opts->data_len,
> +						       ~csum_unfold(opts->csum)),
> +				     ptr);
> 		} else {
> 			put_unaligned_be32(opts->data_len << 16 |
> 					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 59a23838782f..f98c27300e60 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -763,7 +763,7 @@ void mptcp_token_destroy(struct mptcp_sock *msk);
> void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn);
>
> void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hmac);
> -u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum);
> +__sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum);
>
> void __init mptcp_pm_init(void);
> void mptcp_pm_data_init(struct mptcp_sock *msk);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 9842dab09c8b..b38a02db924b 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -891,7 +891,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> 	u32 offset, seq, delta;
> -	u16 csum;
> +	__sum16 csum;
> 	int len;
>
> 	if (!csum_reqd)
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
