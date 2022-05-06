Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C998C62A
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 01:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651801051; x=1683337051;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PmsU1PmO5AoiMycVHPq3+XL8mRV1yK3OfGxUgSfdwaQ=;
  b=Zg233TCWtiOBhHKJ1dQnysLQqgXsCjGzAbM+MedyGcbhALHK89zM2IVj
   /+/+0/ZtfqX7rNtocqEoIglWuTUBQnVDf5gUEDmn8/bKDuBuJnR/i5OAn
   8XtPffVw2K72ymRczqwEZnpmEHC3FfVNQ857hmLWqpWNshv8qLRgRzmdt
   TjIPuuWXrNV8Byxzzg88+gPMtwlA572c/sSPOfw2wgZuXtWk20RRXt+LM
   Lun2rPKtgcY9wpXmzRx9w8TNl4xmdRZci0m4noWVN3zIoTdP3Bc6g9eQi
   qoRsD8fcO9x5turVFlqEZnOp/ynzyR8fvXBEYB/QytdMvuKnqR7PPOFCA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293519010"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="293519010"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:37:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="568869931"
Received: from barreola-mobl1.amr.corp.intel.com ([10.212.167.175])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:37:30 -0700
Date: Thu, 5 May 2022 18:37:30 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH MPTCP-next] mptcp: fix checksum byte order
In-Reply-To: <1a8201582e7fd63db7b5c9c4077af1ab1953c57e.1651763323.git.pabeni@redhat.com>
Message-ID: <33a3c3fe-36d9-985e-9b9e-2dab5f60b38a@linux.intel.com>
References: <1a8201582e7fd63db7b5c9c4077af1ab1953c57e.1651763323.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 5 May 2022, Paolo Abeni wrote:

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
> The change is not backward compatible, but I can't see any
> other option. MPTCP checksum is disabled by default, and there are
> no backward issues with csum disabled.
>

See my reply a few minutes ago on the "Re: apropos 
https://github.com/multipath-tcp/mptcp_net-next/issues/265" thread, maybe 
we do have some backward-compatibility-via-fallback options?


> Fixes: c5b39e26d003 ("mptcp: send out checksum for DSS")
> Fixes: 390b95a5fb84 ("mptcp: receive checksum for DSS")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/options.c | 35 ++++++++++++++++++++++-------------
> 1 file changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index ac3b7b8a02f6..5b5849d9fe60 100644
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
> @@ -1298,15 +1298,23 @@ u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
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
> +static void put_len_csum(u16 len, __sum16 csum, __be16 *ptr)

If ptr was a __be32, this code could do the casting inside this function 
and the callers would look a little cleaner. Not a big deal though - 
existing code ok if there's a good rationale for the __be16 that I'm 
missing.

Other than that, there is the warning from CI to fix and basing this on 
mptcp-net.

I haven't had a chance to try this in a mixed-endian setup yet but Maxim's 
tests looked promising.

- Mat

> +{
> +	put_unaligned_be16(len, ptr);
> +
> +	ptr += 1;
> +	put_unaligned(csum, ptr);
> +}
> +
> void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
> 			 struct mptcp_out_options *opts)
> {
> @@ -1385,9 +1393,9 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
> 				/* data_len == 0 is reserved for the infinite mapping,
> 				 * the checksum will also be set to 0.
> 				 */
> -				put_unaligned_be32(mpext->data_len << 16 |
> -						   (mpext->data_len ? mptcp_make_csum(mpext) : 0),
> -						   ptr);
> +				put_len_csum(mpext->data_len,
> +					     mpext->data_len ? mptcp_make_csum(mpext) : 0,
> +					     (__force __be16 *)ptr);
> 			} else {
> 				put_unaligned_be32(mpext->data_len << 16 |
> 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
> @@ -1438,11 +1446,12 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
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
> +				     (__force __be16 *)ptr);
> 		} else {
> 			put_unaligned_be32(opts->data_len << 16 |
> 					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
> -- 
> 2.35.1
>
>
>

--
Mat Martineau
Intel
