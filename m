Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507052C9D
	for <mptcp@lists.linux.dev>; Wed,  8 Dec 2021 03:00:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="298539809"
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="298539809"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 19:00:13 -0800
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="606069650"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2) ([10.212.226.172])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 19:00:13 -0800
Date: Tue, 7 Dec 2021 19:00:12 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>, Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next v6 1/2] Squash to "mptcp: implement fastclose
 xmit path"
In-Reply-To: <9b7f1f42a7f25006e09e2484bee5643bbb13568b.1638762825.git.geliang.tang@suse.com>
Message-ID: <c487e4-2a79-6049-5dad-18cfceae3b0@linux.intel.com>
References: <cover.1638762825.git.geliang.tang@suse.com> <9b7f1f42a7f25006e09e2484bee5643bbb13568b.1638762825.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 6 Dec 2021, Geliang Tang wrote:

> MP_FAIL could be sent with RST or DSS, and FASTCLOSE could be sent with
> RST or DSS too. So we should use the same xmit logic for FASTCLOSE as
> MP_FAIL.
>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/options.c | 28 ++++++++++++++++------------
> 1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 8a1020e4285c..c5c0dd983ad6 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -828,9 +828,12 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> 		return false;
>
> 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
> -		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
> -		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
> -		    mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
> +		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
> +		    mptcp_established_options_fastclose(sk, &opt_size, remaining, opts)) {
> +			*size += opt_size;
> +			remaining -= opt_size;
> +		}
> +		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
> 			*size += opt_size;
> 			remaining -= opt_size;
> 		}
> @@ -842,7 +845,8 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> 		ret = true;
> 	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts)) {
> 		ret = true;
> -		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
> +		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
> +		    mptcp_established_options_fastclose(sk, &opt_size, remaining, opts)) {

Geliang -

Did you see a case where the stack attempted to send both DSS and 
FASTCLOSE? If so, was it just a DSS_ACK or was there a mapping and data 
payload?

From the RFC, it seems like FASTCLOSE is only expected on a TCP ACK or TCP 
RST. When the FASTCLOSE is sent on all subflows (like the only code path 
that sets send_fastclose does), it is only expected on a TCP RST. If 
FASTCLOSE is showing up on something other than a TCP RST packet I think 
that's a different bug that this patch doesn't address.


The patch has changed a lot since Paolo said "LGTM" so hopefully he can 
comment again!


-Mat

> 			*size += opt_size;
> 			remaining -= opt_size;
> 			return true;
> @@ -1269,9 +1273,16 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 				      0, 0);
> 		put_unaligned_be64(opts->fail_seq, ptr);
> 		ptr += 2;
> +	} else if (unlikely(OPTION_MPTCP_FASTCLOSE & opts->suboptions)) {
> +		/* FASTCLOSE is mutually exclusive with others except DSS and RST */
> +		*ptr++ = mptcp_option(MPTCPOPT_MP_FASTCLOSE,
> +				      TCPOLEN_MPTCP_FASTCLOSE,
> +				      0, 0);
> +		put_unaligned_be64(opts->rcvr_key, ptr);
> +		ptr += 2;
> 	}
>
> -	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
> +	/* DSS, MPC, MPJ, ADD_ADDR and RST are mutually exclusive,
> 	 * see mptcp_established_options*()
> 	 */
> 	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
> @@ -1465,13 +1476,6 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 				      opts->reset_transient,
> 				      opts->reset_reason);
> 		return;
> -	} else if (unlikely(OPTION_MPTCP_FASTCLOSE & opts->suboptions)) {
> -		/* FASTCLOSE is mutually exclusive with everything else */
> -		*ptr++ = mptcp_option(MPTCPOPT_MP_FASTCLOSE,
> -				      TCPOLEN_MPTCP_FASTCLOSE,
> -				      0, 0);
> -		put_unaligned_be64(opts->rcvr_key, ptr);
> -		return;
> 	}
>
> 	if (OPTION_MPTCP_PRIO & opts->suboptions) {
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
