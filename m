Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431AD70
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 01:28:41 +0000 (UTC)
IronPort-SDR: 5DElR/6aVF7TuGm2akXRO4rZ/Y8cdeuMtLR4UVbx8w7cINKwMwCKkdP2/qfG1/yjfEqVB4S7TR
 DwHJoXXEgVHg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="269946956"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="269946956"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 18:28:40 -0700
IronPort-SDR: ef+keDTxCl44EvCbcxAXuVE1w7cPw6DMFPkiZbtWbuiIrkS4xLlejZtTAUrr3IjPejOH+Kkmbv
 NMwflzlWGI1Q==
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="421315604"
Received: from reschenk-mobl1.amr.corp.intel.com ([10.255.230.223])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 18:28:40 -0700
Date: Tue, 15 Jun 2021 18:28:39 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix 32 bit DSN expansion
In-Reply-To: <54a9e415d257a18f8996a9d54cf0c03500ed8aea.1623775386.git.pabeni@redhat.com>
Message-ID: <ba5a7a80-6cd3-d480-878f-62829afcdbea@linux.intel.com>
References: <54a9e415d257a18f8996a9d54cf0c03500ed8aea.1623775386.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 15 Jun 2021, Paolo Abeni wrote:

> The current implementation of 32 bit DNS expansion is buggy,

The "DNS" here (and below) puzzled me for a minute :)

> and the fix is quite similar to what we did for ack expansion.
>
> There is a small caveat: DNS can both increment and decrement
> (on MPTCP re-injection) so we need to use more care to catch
> wrap-around and we must additionally look for reverse wrap.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/120
> Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> @Christoph: sorry for the duplicate, I used a bad recipient
> list for the previous attempt
> ---
> net/mptcp/subflow.c | 21 +++++++++++++--------
> 1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d55f4ef736a5..004718126345 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -781,13 +781,19 @@ enum mapping_status {
> 	MAPPING_DUMMY
> };
>
> -static u64 expand_seq(u64 old_seq, u16 old_data_len, u64 seq)
> +static u64 expand_seq(u64 old_seq, u64 cur_seq)
> {
> -	if ((u32)seq == (u32)old_seq)
> -		return old_seq;
> +	u32 old_seq32 = (u32)old_seq;
> +	u32 cur_seq32 = (u32)cur_seq;
>
> -	/* Assume map covers data not mapped yet. */

This comment dates back to the original version of this function making 
single-subflow assumptions. The code did need to be revisited so thanks 
for working on this.

> -	return seq | ((old_seq + old_data_len + 1) & GENMASK_ULL(63, 32));
> +	cur_seq = (old_seq & GENMASK_ULL(63, 32)) + cur_seq32;
> +	if (unlikely(cur_seq32 < old_seq32 && before(old_seq32, cur_seq32)))
> +		return cur_seq + (1LL << 32);

The above should catch sequence numbers that look like they both "moved 
forward" and "wrapped around". Looks good.

If the adjustment is incorrect, then we're mistaking an old mapping for a 
new one - but only if it happens to be in-window.

> +
> +	/* on re-injection we can have wrap around towards bottom */
> +	if (unlikely(cur_seq32 > old_seq32 && after(old_seq32, cur_seq32)))
> +		return cur_seq - (1LL << 32);

And this logic looks ok for finding old or reinjected mappings that 
wrapped. The data will end up discarded, so if we guess wrong then the 
peer will send again if needed.

Looks good for the export branch, we can test some more there:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> +	return cur_seq;
> }
>
> static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
> @@ -996,9 +1002,8 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
> 	}
>
> 	if (!mpext->dsn64) {
> -		map_seq = expand_seq(subflow->map_seq, subflow->map_data_len,
> -				     mpext->data_seq);
> -		pr_debug("expanded seq=%llu", subflow->map_seq);
> +		map_seq = expand_seq(READ_ONCE(msk->ack_seq), mpext->data_seq);
> +		pr_debug("expanded seq=%llu->%llu", mpext->data_seq, map_seq);
> 	} else {
> 		map_seq = mpext->data_seq;
> 	}
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
