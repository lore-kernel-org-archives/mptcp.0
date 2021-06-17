Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7F472
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 00:04:38 +0000 (UTC)
IronPort-SDR: nY5jsbXLyHRG84GYjNdTgPwuhs0w0Y7oh0KooE7U+SuWUMb1v7EKC72Jr5eGx8MA1L/cRFvVI/
 oG34d3c+fNUA==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="270126489"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="270126489"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 17:04:38 -0700
IronPort-SDR: VoUF2XEMM2uKXJDDXCQDxXwuPLH6erxJu7Lq0Jsn0KDVSsPd1lXI/VCyI9+t3ymfqeU/xsdc43
 nBKgysFD+hSg==
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="450817345"
Received: from ndalili-mobl.amr.corp.intel.com ([10.209.105.124])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 17:04:38 -0700
Date: Wed, 16 Jun 2021 17:04:37 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-net] mptcp: fix 32 bit DSN expansion
In-Reply-To: <b451ef55b7debb519f42202e75696a79954b32b6.1623831569.git.pabeni@redhat.com>
Message-ID: <65851c13-b41f-719a-587e-c1f87724ca30@linux.intel.com>
References: <b451ef55b7debb519f42202e75696a79954b32b6.1623831569.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 16 Jun 2021, Paolo Abeni wrote:

> The current implementation of 32 bit DSN expansion is buggy.
> After the previous patch, we can simply reuse the newly
> introduced helper to do the expansion safely.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/120
> Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
> - fix typo in the commit message
> - use the common helper

Thanks for the v2, looks good to me.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> net/mptcp/subflow.c | 17 +----------------
> 1 file changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d55f4ef736a5..6772802737e4 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -781,15 +781,6 @@ enum mapping_status {
> 	MAPPING_DUMMY
> };
>
> -static u64 expand_seq(u64 old_seq, u16 old_data_len, u64 seq)
> -{
> -	if ((u32)seq == (u32)old_seq)
> -		return old_seq;
> -
> -	/* Assume map covers data not mapped yet. */
> -	return seq | ((old_seq + old_data_len + 1) & GENMASK_ULL(63, 32));
> -}
> -
> static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
> {
> 	pr_debug("Bad mapping: ssn=%d map_seq=%d map_data_len=%d",
> @@ -995,13 +986,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
> 		data_len--;
> 	}
>
> -	if (!mpext->dsn64) {
> -		map_seq = expand_seq(subflow->map_seq, subflow->map_data_len,
> -				     mpext->data_seq);
> -		pr_debug("expanded seq=%llu", subflow->map_seq);
> -	} else {
> -		map_seq = mpext->data_seq;
> -	}
> +	map_seq = mptcp_expand_seq(READ_ONCE(msk->ack_seq), mpext->data_seq, mpext->dsn64);
> 	WRITE_ONCE(mptcp_sk(subflow->conn)->use_64bit_ack, !!mpext->dsn64);
>
> 	if (subflow->map_valid) {
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
